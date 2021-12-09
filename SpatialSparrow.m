function SpatialSparrow
global BpodSystem
BpodSystem.ProtocolSettings.triggerScanbox = false;
SpatialSparrow_Settings
SpatialSparrow_Init
disp('HERE')
%% Initialize some arrays
OutcomeRecord = NaN(1,maxTrials);
AssistRecord = false(1,maxTrials);
LastBias = 1; %last trial were bias correction was used
PrevStimLoudness = S.StimLoudness; %variable to check if loudness has changed
singleSpoutBias = false; %flag to indicate if single spout was presented to counter bias
global BpodSystem
BpodSystem.Status.SpatialSparrowPause = true;
while BpodSystem.Status.SpatialSparrowPause
    drawnow; pause(0.03);
end
if BpodSystem.ProtocolSettings.triggerWidefield
    if isfield(BpodSystem.ProtocolSettings,'labcamsWidefield')
        if ~isempty(BpodSystem.ProtocolSettings.labcamsWidefield)
            tmp = strsplit(BpodSystem.ProtocolSettings.labcamsWidefield,':');
            udpAddress = tmp{1};
            udpPort = str2num(tmp{2});
            udpWF = udp(udpAddress,udpPort);
            fopen(udpWF);
            % check if labcams WIDEFIELD is connected already.
            fwrite(udpWF,'ping');
            fgetl(udpWF);
            fwrite(udpWF,'manualsave=0')
            fgetl(udpWF)
            fwrite(udpWF,'softtrigger=0')
            fgetl(udpWF)
            
            [dataPath, bhvFile] = fileparts(BpodSystem.Path.CurrentDataFile); %behavioral file and data path
            tmp = strsplit(bhvFile,'_');
            session_folder = fullfile(BpodSystem.GUIData.SubjectName,...
            [tmp{end-1} '_' tmp{end}],'onephoton',bhvFile);            
            fwrite(udpWF,['expname=' session_folder]); 
            fgetl(udpWF)
            disp(' -> WIDEFIELD labcams connected.');
            
        else
            disp(' -> WIDEFIELD labcams not connected.');
            clear udpWF
        end
    end
end
if BpodSystem.ProtocolSettings.triggerScanbox
    if isfield(BpodSystem.ProtocolSettings,'scanboxAddress')
            tmp = strsplit(BpodSystem.ProtocolSettings.scanboxAddress,':');
            udpAddress = tmp{1};
            udpPort = str2num(tmp{2});
            udpsbox = udp(udpAddress,'RemotePort',udpPort);
            fopen(udpsbox);
            
            [dataPath, bhvFile] = fileparts(BpodSystem.Path.CurrentDataFile); %behavioral file and data path
            tmp = strsplit(bhvFile,'_');
            session_folder = fullfile(BpodSystem.GUIData.SubjectName,...
            [tmp{end-1} '_' tmp{end}],'two_photon',bhvFile);            
            
            tmp = strsplit(session_folder,'\')
            fprintf(udpsbox,['D' 'd:\data\' tmp{1} '\' tmp{2}]); 
            fprintf(udpsbox,['A'  tmp{3}]); 
            fprintf(udpsbox,['U0'  ]);
            fprintf(udpsbox,['E0'  ])
            disp(' -> scanbox connected.');            
            fprintf(udpsbox,'G');  
    end
end
pause(1)
%% Start saving labcams if connected
if exist('udplabcams','var')
    fwrite(udplabcams,'softtrigger=0')
    fgetl(udplabcams);
    fwrite(udplabcams,'manualsave=1')
    fgetl(udplabcams);
    fwrite(udplabcams,'softtrigger=1')
    fgetl(udplabcams);
end                

%% Start WF if connected
if exist('udpWF', 'var')
    pause(1)
    fwrite(udpWF,'softtrigger=0')
    fgetl(udpWF)
    fwrite(udpWF,'manualsave=1')
    fgetl(udpWF)
    fwrite(udpWF,'softtrigger=1')
    fgetl(udpWF)
end
BpodSystem.Status.SpatialSparrowExit = false;
%% Main loop for single trials
for iTrials = 1:maxTrials
    % look at the pause button
    if BpodSystem.Status.SpatialSparrowPause
        disp('Spatial Sparrow paused')
        while BpodSystem.Status.SpatialSparrowPause 
            drawnow; pause(0.03); 
            if ~BpodSystem.Status.BeingUsed || BpodSystem.Status.SpatialSparrowExit
                break
            end
        end
    end
    
    % only run this code if protocol is still active
    if BpodSystem.Status.BeingUsed && ~BpodSystem.Status.SpatialSparrowExit
        tic % single trial timer
        %BpodSystem.GUIHandles.SpatialSparrow_Control.SpatialSparrow_Control.UserData.update({'Update','Settings'});  %Get inputs from GUIs
        SpatialSparrow_TrialInit
        SpatialSparrow_StimulusInit
        SpatialSparrow_OptoInit
        SpatialSparrow_AutoReward
        SpatialSparrow_BpodTrialInit
        SpatialSparrow_DisplayTrialData
        
        %% Visual Stimuli
        % Pick this trial type and speed
        refSpeed = S.RefSpeed; %deg/s
        refContrast = selectRandomIndex(S.RefContrast);
        speedList = S.SpeedList;
        testSpeed = selectRandomIndex(speedList);
        testContrast = selectRandomIndex(S.TestContrast);
        thisTrialSpeeds = [testSpeed refSpeed];
        thisTrialSide = TrialSidesList(iTrials);
        Contrasts = nan(1,2);
        
        if thisTrialSide == 1 % Reward on Left-hand port, i.e. present fastest of the two gratings on left side
%             LeftPortAction = 'Reward';
%             RightPortAction = 'SoftPunish';
%             RewardValve = LeftPort; %left-hand port represents port#0, therefore valve value is 2^0
%             rewardValveTime = LeftValveTime;
            correctSide = 1;
            LRSpeeds = [max(thisTrialSpeeds) min(thisTrialSpeeds)];
        
        else % Reward on Right-hand port, i.e. present fastest of the two gratings on right side
%             LeftPortAction = 'SoftPunish';
%             RightPortAction = 'Reward';
%             RewardValve = RightPort; %right-hand port represents port#2, therefore valve value is 2^2
%             rewardValveTime = RightValveTime;
            correctSide = 2;
            LRSpeeds = [min(thisTrialSpeeds) max(thisTrialSpeeds)];
        end
        
        disp(['Left Speed: ' num2str(LRSpeeds(1)) ' degrees/s'])
        disp(['Right Speed: ' num2str(LRSpeeds(2)) ' degrees/s'])
        
        Contrasts(LRSpeeds == refSpeed) = refContrast;
        Contrasts(LRSpeeds ~= refSpeed) = testContrast;
        
        %create visual speed matrix
        sFreqList = S.SFreqList; %cycles/deg
        tFreqList = S.TFreqList; %cycles/sec
        
        [sf,tf] = meshgrid(sFreqList,tFreqList);
        speedMatrix = tf./sf;
        
        leftSFreq = selectRandomIndex(unique(sf(speedMatrix == LRSpeeds(1))));
        rightSFreq = selectRandomIndex(unique(sf(speedMatrix == LRSpeeds(2))));
        
        leftTFreq = selectRandomIndex(unique(tf(speedMatrix==LRSpeeds(1))));
        rightTFreq = selectRandomIndex(unique(tf(speedMatrix == LRSpeeds(2))));
        
        %store and load parameters to PsychtoolboxDisplayServer
        stimParameters.PlayStimulus = 1;
        stimParameters.StimSize = selectRandomIndex(S.StimSize); %in degrees, need to be converted into pixels
        
        stimParameters.Speeds = LRSpeeds;
        stimParameters.SFreqs = [leftSFreq rightSFreq];
        stimParameters.TFreqs = [leftTFreq rightTFreq];
        stimParameters.StimContrasts = Contrasts;
        
        stimParameters.Orientation = selectRandomIndex(S.Orientation); %degrees
        stimParameters.Elevation = S.Elevation;%degrees
        stimParameters.Azimuth = S.Azimuth;%degrees
        stimParameters.StimDuration = S.minWaitTime;
        
        %add random delay to post stimulus
        postStimWaitTime = (S.minWaitTime - S.StimulusDuration); % + generate_random_delay(S.lambdaDelay, S.preStimDelayMin, S.preStimDelayMax);
        
        if postStimWaitTime < 0
            postStimWaitTime = 0;
        else
            stimParameters.StimDuration = S.StimulusDuration;
        end
        
        if ~S.PlayStimulus
            stimParameters.PlayStimulus = 0;
            Modality = '-';
        end
        
        PsychToolboxDisplayServer('Make','DG',stimParameters);
        
        %% create ITI jitter
        trialPrep = toc; %check how much time was used to prepare trial and subtract from ITI
        if (ITIjitter - trialPrep - 0.1)*1000  > 0 % removing the 0.1 because there is a delay in sending the state machine
            %disp(['ITI ' , num2str(ITIjitter), 's'])
            java.lang.Thread.sleep((ITIjitter - trialPrep - 0.1)*1000); %wait a moment to get to determined ITI
        end
%         disp(BpodSystem.SerialPort.bytesAvailable)
        BpodSystem.SerialPort.read(BpodSystem.SerialPort.bytesAvailable, 'uint8'); %remove all bytes from serial port
        setMotorPositions;
        while BpodSystem.SerialPort.bytesAvailable > 0 %clear excess bytes from bpod that aquired from ITI
            disp('!!! Something really weird is going on with the serial communication to Bpod !!!');
            disp(BpodSystem.SerialPort.bytesAvailable);
            BpodSystem.SerialPort.read(BpodSystem.SerialPort.bytesAvailable, 'uint8'); %remove all bytes from serial port
            pause(0.01);
            BpodSystem.Data.weirdBytes = true;
        end
        % set the frame number just before starting
        if exist('udplabcams','var')
                fwrite(udplabcams,sprintf('log=trial_start:%d',iTrials));
        end
        if exist('udpWF','var')
            fwrite(udpWF,sprintf('log=trial_start:%d',iTrials));
        end
        %% run bpod and save data after trial is finished
        SpatialSparrow_StateMachine;
        RawEvents = RunStateMachine; % Send and run state matrix
        % set the frame number just after starting
        if exist('udplabcams','var')
            fwrite(udplabcams,sprintf('log=trial_end:%d',iTrials));
        end
        if exist('udpWF','var')
            fwrite(udpWF,sprintf('log=trial_end:%d',iTrials));
        end
        SpatialSparrow_SaveTrial
        try
            BpodSystem.GUIHandles.spatialsparrow.update_performance_plots();
        catch
            disp('Could not update performance plots.')
        end
        toc;disp('==============================================')
        % send the motors to zero before starting another trial
        
        setMotorsToZero;
        HandlePauseCondition; % Checks to see if the protocol is paused. If so, waits until user resumes.
        if BpodSystem.Status.SpatialSparrowExit
            RunProtocol('Stop')
        end
    else  %stop code if stop button is pressed and close figures
        SpatialSparrow_CloseSession
        break;
    end
end

%% close figures
% try;close(BpodSystem.GUIHandles.SpatialSparrow_Control.SpatialSparrow_Control);end
% try;close(BpodSystem.GUIHandles.SpatialSparrow_SpoutControl.figure1);end
% try;close(BpodSystem.GUIHandles.ParamFig);end
end
