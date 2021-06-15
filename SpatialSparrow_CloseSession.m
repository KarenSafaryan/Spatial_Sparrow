%SpatialSparrow_CloseSession
global BpodSystem

if S.SaveSettings %if current settings should be saved to file
    S.SaveSettings = false; %set variable back to false before saving
    ProtocolSettings = BpodSystem.ProtocolSettings;
end
% Move spouts to reset position.
teensyWrite([71 1 '0' 1 '0']); % Move spouts to zero position
teensyWrite([72 1 '0']); % Move handles to zero position

% stop video
try
    if ~isempty(BpodSystem.ProtocolSettings.bonsaiParadim)
        oscsend(udpObj,udpPath,'i',1000) % stop video capture
        stopBonsai(); %shut down bonsai
        hasvideo = 1;

    end

    if exist('udplabcams','var')
        fwrite(udplabcams,sprintf('log=end'));fgetl(udplabcams);
        fwrite(udplabcams,sprintf('softtrigger=0'));fgetl(udplabcams);
        fwrite(udplabcams,sprintf('manualsave=0'));fgetl(udplabcams);
        fwrite(udplabcams,sprintf('quit=1'))
        fclose(udplabcams);
        clear udplabcams
        hasvideo = 1;
    end
    disp("Done stopping video.")

catch err
    disp("Error stopping video.")
    disp(err.message)
end
if exist('udpWF', 'var')
    fwrite(udpWF,'softtrigger=0');fgetl(udpWF);
    fwrite(udpWF,'manualsave=0');
    fclose(udpWF);
end

if exist('udpsbox', 'var')
    fprintf(udpsbox,'G');  
    fclose(udpsbox)
end
   
% check for path to server and save behavior + graph
if exist(BpodSystem.ProtocolSettings.serverPath, 'dir') %if server responds
    try
        set(BpodSystem.GUIHandles.spatialsparrow.StopButton,'Text','Copying data')
        set(BpodSystem.GUIHandles.spatialsparrow.StopButton,'FontColor',[100,255,100])
        drawnow;
    end
    if ~BpodSystem.ProtocolSettings.serverPath(end) == filesep
        BpodSystem.ProtocolSettings.serverPath = [BpodSystem.ProtocolSettings.serverPath filesep];
    end
    serverPath = strrep(BpodSystem.Path.CurrentDataFile,...
        BpodSystem.Path.DataFolder,...
        BpodSystem.ProtocolSettings.serverPath);
    [serverdir,tmp] = fileparts(serverPath);
    try
        if ~exist(serverdir,'dir')
            mkdir(serverdir)
        end
        SessionData = BpodSystem.Data; %current session data
        if ~isempty(SessionData) && (iTrials > 10)
            disp(['Writing to: ',serverPath])
            [SUCCESS,MESSAGE,MESSAGEID] = copyfile(BpodSystem.Path.CurrentDataFile,serverPath);
            try
                if exist('hasvideo','var')
                    if hasvideo
                        videoPaths = [dataPath filesep bhvFile];
                        disp('Copying video data')
                        filestocp = [dir([videoPaths,'*.avi']);dir([videoPaths,'*.camlog']); ...
                            dir([videoPaths,'*.csv'])];
                        if ~isempty(filestocp)
                            for f = 1:length(filestocp)
                                [SUCCESS,MESSAGE,MESSAGEID] = copyfile([filestocp(f).folder,...
                                    filesep,filestocp(f).name],serverdir);
                                if ~SUCCESS
                                    disp(['ERRROR - Copy ',videoPaths,filesep,filestocp(f).name,' failed'])
                                else
                                    disp(['Copied ',videoPaths,filesep,filestocp(f).name])
                                end
                            end
                        end
                    end
                end
            end
        end
        disp('Done.')
    catch
        warning('!!! Error while writing to server. Make sure local data got copied correctly. !!!');
    end
end
try
    set(BpodSystem.GUIHandles.spatialsparrow.StopButton,'Text','Start')
    set(BpodSystem.GUIHandles.spatialsparrow.StopButton,'FontColor',[0,0,0])
    drawnow;
end

