% Initialization of Bpod modules and VIDEO AQUISITION
% BPod Init
global BpodSystem
BpodSystem.Data.byteLoss = 0; %counter for cases when the teensy didn't send a response byte
global LeftPortValveState
global RightPortValveState

LeftPortValveState = 1;%2^0;
RightPortValveState = 2;%2^1; % ports are numbered 0-7. Need to convert to 8bit values for bpod

%% Load default settings and update with pre-defined settings if required
defaultFieldParamVals = struct2cell(DefaultSettings);defaultFieldNames = fieldnames(DefaultSettings);
BpodSystem.ProtocolSettings.ServoPos = [0 0];
S = BpodSystem.ProtocolSettings; % Load settings chosen in launch manager into current workspace as a struct S
currentFieldNames = fieldnames(S);

if isempty(fieldnames(S)) % If settings file was an empty struct, populate struct with default settings
    S = DefaultSettings;
elseif any(~ismember(defaultFieldNames,currentFieldNames))  %an addition to default settings, update
    differentI = find(~ismember(defaultFieldNames,currentFieldNames)); %find the index
    for ii = 1:numel(differentI)
        thisnewfield = defaultFieldNames{differentI(ii)};
        S.(thisnewfield)=defaultFieldParamVals{differentI(ii)};
    end
end
BpodSystem.ProtocolSettings = S; % Adds the currently used settings to the Bpod struct
BpodSystem.ProtocolSettings.SubjectName = BpodSystem.GUIData.SubjectName; %update subject name
serverPath = [S.serverPath filesep BpodSystem.ProtocolSettings.SubjectName filesep ...
    BpodSystem.GUIData.ProtocolName ]; %path to data server


%% ensure teensy, I2C, and analog modules are present and set up communication
if ~isempty(find(contains(BpodSystem.Modules.Name,'I2C1'))) % check to see if this system has an I2C
    if isfield(BpodSystem.ModuleUSB, 'I2C1')
        i2c= I2CMessenger(BpodSystem.ModuleUSB.I2C1);
    else
        error('Error: Please pair the I2C module with its USB port in the Bpod Console');
    end
    if isempty(i2c)
        warning('Could not connect to I2C Messager. Session aborted.');
        BpodSystem.Status.BeingUsed = 0;
    else
        i2c.SlaveAddress = 1; % Slave ID must match scanimage!!!
        i2c.Mode = 'Message';
    end
end

%% connect to analog output module
try
    W = BpodWavePlayer(S.wavePort); %check if analog module com port is correct
catch
    % check for analog module by finding a serial device that can create a waveplayer object
    W = [];
    if isunix
        Ports = {'/dev/ttyACM1','/dev/ttyACM2','/dev/ttyACM0'};
    else
        Ports = FindSerialPorts; % get available serial com ports
    end
    for i = 1 : length(Ports)
        try
            W = BpodWavePlayer(Ports{i});
            S.wavePort = Ports{i};
            break
        end
    end
end
if isempty(W)
    warning('No analog output module found. Session aborted.');
    BpodSystem.Status.BeingUsed = 0;
else
    clear W %clear waveplayer object to make sure it uses default values
    W = BpodWavePlayer(S.wavePort);
end
W.OutputRange = '-5V:5V'; % make sure output range is correct
W.TriggerProfileEnable = 'On'; % use trigger profiles to produce different waveforms across channels
W.TriggerProfiles(1, :) = 1:8; %when triggering first row, ch1-8 will play waveforms 1-8
W.TriggerMode = 'Master'; %output can be interrupted by new stimulus triggers
W.LoopDuration(1:8) = 0; %keep on for a up to 10 minutes
W.SamplingRate = BpodSystem.ProtocolSettings.sRate; %adjust sampling rate

%% check for teensy module
checker = true;
for i = 1 : length(BpodSystem.Modules.Name)
    if strcmpi(BpodSystem.Modules.Name{i},'TouchShaker1')
        checker = false;
    end
end
if checker
    warning('No teensy module found. Session aborted.');
    BpodSystem.Status.BeingUsed = 0;
end

%% check teensy module - this does not work if not connected to the computer
%teensyReset()
%pause(1)
%disp('Teensy was reset; setting thresholds')
% send trialstart info and check response
% teensyWrite([70 ones(1,6) '550050']); %set high touch threshold to avoid confusing bytes

%% TODO: Move the handles and the spouts to the zero position before doing this.
setMotorsToZero;
% setting thresholds
% move to outer
ls = num2str(BpodSystem.ProtocolSettings.lOuterLim);
rs = num2str(BpodSystem.ProtocolSettings.rOuterLim);
teensyWrite([71 length(ls)  ls length(rs)  rs]);
lo = num2str(BpodSystem.ProtocolSettings.LeverOut);
teensyWrite([72 length(lo)  lo]);
%set touch threshold
cVal = num2str(BpodSystem.ProtocolSettings.TouchThresh);
teensyWrite([75 length(cVal) cVal]);
pause(2); %give some time for calibration
disp('Done setting thresholds')

%% Stimulus parameters - Create trial types list (single vs double stimuli)
maxTrials = 5000;
TrialSidesList = double(rand(1,maxTrials) < S.ProbRight); % ONE MEANS RIGHT TRIAL
PrevProbRight = S.ProbRight;
BpodSystem.Data.cTrial = 1; BpodSystem.Data.Rewarded = logical([]); %needed for cam streamer to work in first trial
  [dataPath, bhvFile] = fileparts(BpodSystem.Path.CurrentDataFile); %behavioral file and data path

if ~exist(dataPath,'dir')
    try
        mkdir(dataPath);
    catch
        disp(['Could not create ',dataPath])
        dataPath = uigetdir(pwd,'Specify the data folder');
    end
end
if isfield(BpodSystem.GUIHandles,"spatialsparrow")
    try
        close(BpodSystem.GUIHandles.spatialsparrow)
    end
end
%% Initialize camera, control GUI and feedback plots
if BpodSystem.Status.BeingUsed %only run this code if protocol is still active
    %%
    BpodNotebook('init');
  
    BpodSystem.GUIHandles.spatialsparrow = SpatialSparrow_GUI;
    BpodSystem.GUIHandles.spatialsparrow.getSettingsFromBpod();
    BpodSystem.GUIHandles.spatialsparrow.init_plots();
    %BpodSystem.GUIHandles.SpatialSparrow_Control = SpatialSparrow_Control; %get handle for control GUI
    %BpodSystem.GUIHandles.SpatialSparrow_Control.SpatialSparrow_Control.UserData.update({'init',TrialSidesList,60'}); %initiate control GUI and show outcome plot for the next 60 trials
    %BpodSystem.Data.animalWeight = str2double(newid('Enter animal weight (in grams)')); %ask for animal weight and save
    BpodSystem.Data.animalWeight = nan;
    %start bonsai
    if ~isunix && ~isempty(BpodSystem.ProtocolSettings.bonsaiParadim)
        % start camera
        % Create a string for the arguments to apss to Bonsai during starting
        WorkflowArg1 = sprintf('-p:VideoFileName0="%s"', [dataPath filesep bhvFile filesep bhvFile '_' 'video1.mp4']);
        WorkflowArg2 = sprintf('-p:VideoFileName1="%s"', [dataPath filesep bhvFile filesep bhvFile '_' 'video2.mp4']);
        WorkflowArg3 = sprintf('-p:CsvFileName1="%s"', [dataPath filesep bhvFile filesep bhvFile '_' 'frameTimes.csv']);
        WorkflowArg4 = sprintf('-p:CsvFileName2="%s"', [dataPath filesep bhvFile filesep bhvFile '_' 'data_stream.csv']);
        WorkflowArg5 = sprintf('-p:CsvFileName3="%s"', [dataPath filesep bhvFile filesep bhvFile '_' 'data_times.csv']);
        WorkflowArgs = [WorkflowArg1 ' ' WorkflowArg2 ' ' WorkflowArg3 ' ' WorkflowArg4 ' ' WorkflowArg5];
        
        cPath = pwd;
        cd(fileparts(BpodSystem.ProtocolSettings.bonsaiParadim));
        vidStatus = startBonsai(BpodSystem.ProtocolSettings.bonsaiEXE, BpodSystem.ProtocolSettings.bonsaiParadim, WorkflowArgs);
        cd(cPath);
        
        % Use UDP to trigger both cameras to start recording
        pause(2);
        udpAddress = '127.0.0.1'; % configure Bonsai OSC "ReceiveMessage" object using these parameters
        udpPort = 7111; % configure Bonsai OSC "ReceiveMessage" object using these parameters
        udpPath = '/x'; % configure Bonsai OSC "ReceiveMessage" object using these parameters
        udpObj = udp(udpAddress,udpPort);
        fopen(udpObj);
        oscsend(udpObj,udpPath,'i',0) % this uses UDP as a software trigger to start video aquisition by sending the integer 0, which is programmed in the Bonsai OSC ReceiveMessage object as the state triggering video capture
        
        if strcmpi(vidStatus, 'Error')
            disp('An error occured while trying to start Bonsai! Stopping paradigm.');
            BpodSystem.Status.BeingUsed = false;
        end
        
    elseif isfield(BpodSystem.ProtocolSettings,'labcamsAddress')
        if ~isempty(BpodSystem.ProtocolSettings.labcamsAddress)
            tmp = strsplit(BpodSystem.ProtocolSettings.labcamsAddress,':');
            udpAddress = tmp{1};
            udpPort = str2num(tmp{2});
            udplabcams = udp(udpAddress,udpPort);
            fopen(udplabcams);
            % check if labcams is connected already.
            fwrite(udplabcams,'ping');
            if udplabcams.BytesAvailable
                fgetl(udplabcams);
                disp(' -> labcams connected.');
            else
                %%
                disp(' -> starting labcams');
                if ~isunix
                    labcamsproc=System.Diagnostics.Process.Start('labcams.exe','-w');
                    while true
                        fwrite(udplabcams,'ping')
                        tmp = fgetl(udplabcams);
                        if labcamsproc.HasExited
                            disp('Labcams has exited?')
                            clear udplabcams
                            break
                        end
                        if ~isempty(tmp)
                            break
                        end
                    end
                else
                    % labcams needs to be installed to use system python
                    % for this to work
                    system('LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH export LD_LIBRARY_PATH;gnome-terminal -- labcams -w')
                    for i =  1:100
                        fwrite(udplabcams,'ping')
                        tmp = fgetl(udplabcams);
                        pause(0.1)
                        if ~isempty(tmp)
                            break
                        end
                    end
                    if isempty(tmp)
                        clear udplabcams
                    end
                end
            end
            if exist('udplabcams','var')
                fwrite(udplabcams,['expname=' dataPath filesep bhvFile])
                fgetl(udplabcams);
                fwrite(udplabcams,'manualsave=0') % Dont save while adjusting
                fgetl(udplabcams);
                fwrite(udplabcams,'softtrigger=1')
                fgetl(udplabcams);
            end
        end
    end
end


%BpodSystem.GUIHandles.SpatialSparrow_SpoutControl.figure1 = []; %handle needs to exist so code does not crash when trying to close all figures
%if BpodSystem.Status.BeingUsed %only run this code if protocol is still active
    % start spout adjustment
%    disp('Waiting for spout adjustment - hit OK in the SpoutControl window to continue')
%    SpatialSparrow_SpoutControl; %call spout control gui
%    movegui(BpodSystem.GUIHandles.SpatialSparrow_SpoutControl.figure1,'northwest');
%    uiwait(BpodSystem.GUIHandles.SpatialSparrow_SpoutControl.figure1); %wait for spout control and clear handle afterwards
%    set(BpodSystem.GUIHandles.SpatialSparrow_Control.AdjustSpoutes,'Value',0); %set GUI back to false
%    set(BpodSystem.GUIHandles.SpatialSparrow_Control.ServoPos,'String',['L:' num2str(BpodSystem.ProtocolSettings.ServoPos(1)) '; R:' num2str(BpodSystem.ProtocolSettings.ServoPos(2))]); %set indicator for current servo position
%end


