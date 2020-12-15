function SpatialSparrow
global BpodSystem

SpatialSparrow_Settings
SpatialSparrow_Init

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

%% Main loop for single trials
for iTrials = 1:maxTrials
    % look at the pause button
    if BpodSystem.Status.SpatialSparrowPause
        disp('Spatial Sparrow paused')
        while BpodSystem.Status.SpatialSparrowPause
            drawnow; pause(0.03); 
            if ~BpodSystem.Status.BeingUsed 
                break
            end
        end
    end
    
    % only run this code if protocol is still active
    if BpodSystem.Status.BeingUsed
        tic % single trial timer
        %BpodSystem.GUIHandles.SpatialSparrow_Control.SpatialSparrow_Control.UserData.update({'Update','Settings'});  %Get inputs from GUIs
        SpatialSparrow_TrialInit
        SpatialSparrow_StimulusInit
        SpatialSparrow_OptoInit
        SpatialSparrow_AutoReward
        SpatialSparrow_BpodTrialInit
        SpatialSparrow_DisplayTrialData
        BpodSystem.GUIHandles.spatialsparrow.prepareTrial(TrialSidesList)
        
        SpatialSparrow_StateMachine
        %% create ITI jitter
        trialPrep = toc; %check how much time was used to prepare trial and subtract from ITI
        if trialPrep > ITIjitter
            if (ITIjitter - trialPrep)*1000 > 0
                disp(['sleep' , num2str(ITIjitter)])
                java.lang.Thread.sleep((ITIjitter - trialPrep)*1000); %wait a moment to get to determined ITI
            end
        end
%         disp(BpodSystem.SerialPort.bytesAvailable)
        BpodSystem.SerialPort.read(BpodSystem.SerialPort.bytesAvailable, 'uint8'); %remove all bytes from serial port
        
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
        
        RawEvents = RunStateMachine; % Send and run state matrix
        % set the frame number just after starting
        if exist('udplabcams','var')
            fwrite(udplabcams,sprintf('log=trial_end:%d',iTrials));
        end
        if exist('udpWF','var')
            fwrite(udpWF,sprintf('log=trial_end:%d',iTrials));
        end
        SpatialSparrow_SaveTrial
        toc;disp('==============================================')
        % send the motors to zero before starting another trial
        setMotorsToZero;
        
        HandlePauseCondition; % Checks to see if the protocol is paused. If so, waits until user resumes.
        
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
