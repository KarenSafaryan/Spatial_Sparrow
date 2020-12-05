%SpatialSparrow_CloseSession

if S.SaveSettings %if current settings should be saved to file
    S.SaveSettings = false; %set variable back to false before saving
    ProtocolSettings = BpodSystem.ProtocolSettings;
    save(BpodSystem.GUIData.SettingsFileName, 'ProtocolSettings'); % save protocol settings file to directory
    set(BpodSystem.GUIHandles.SpatialSparrow_Control.SaveSettings,'Value',false); %set GUI back to false after saving
else
    % check if settings should be saved when ending current session
    button = questdlg('Save current settings?','Save settings','Yes','No','Yes'); %creates a question dialog box with two push buttons labeled 'str1' and 'str2'. default specifies the default button selection and must be 'str1' or 'str2'.
    if strcmp(button,'Yes')
        ProtocolSettings = BpodSystem.ProtocolSettings;
        save(BpodSystem.GUIData.SettingsFileName, 'ProtocolSettings'); % save protocol settings file to directory
    end
end
% Move spouts to reset position.
try BpodSystem.StartModuleRelay('TouchShaker1'); java.lang.Thread.sleep(10); end % Relay bytes from Teensy
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
% check for path to server and save behavior + graph
if exist(BpodSystem.ProtocolSettings.serverPath, 'dir') %if server responds
    serverPath = [serverPath filesep bhvFile];
    try
        if ~exist(serverPath,'dir')
            mkdir(serverPath)
        end
        SessionData = BpodSystem.Data; %current session data
        if ~isempty(SessionData) & (iTrials > 10)
            disp(['Writing to server: ',[serverPath filesep bhvFile '.mat']])
            save([serverPath filesep bhvFile],'SessionData'); %save datafile

            %save session graph
            sPath = strrep(serverPath,filesep,'session_plots');
            if ~exist(sPath,'dir')
                mkdir(sPath)
            end
            set(BpodSystem.GUIHandles.SpatialSparrow_Control.SpatialSparrow_Control,'PaperOrientation','portrait','PaperPositionMode','auto');
            saveas(BpodSystem.GUIHandles.SpatialSparrow_Control.SpatialSparrow_Control, [sPath filesep bhvFile '.jpg']);
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
                                    filesep,filestocp(f).name],serverPath);
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

% check for BpodImager imager folder on the server and save data there if a matching destination is found
if exist(BpodSystem.ProtocolSettings.widefieldPath,'dir')
    wfPath = [S.widefieldPath filesep BpodSystem.ProtocolSettings.SubjectName filesep ...
        BpodSystem.GUIData.ProtocolName filesep]; %path to data server
    check = dir([wfPath '*' date '*_open']); %check for open folder (created by BpodImager)
    if ~isempty(check)
        SessionData = BpodSystem.Data; %current session data
        save([wfPath check.name filesep bhvFile],'SessionData'); %save datafile
    end
end
