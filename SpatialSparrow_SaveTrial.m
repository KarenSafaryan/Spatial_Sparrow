%SpatialSparrow_SaveTrial
% Save events and data
if length(fieldnames(RawEvents)) > 1

    BpodSystem.Data = AddTrialEvents(BpodSystem.Data,RawEvents); %collect trialdata
    BpodSystem.Data.Rewarded(iTrials) = ~isnan(BpodSystem.Data.RawEvents.Trial{1,iTrials}.States.Reward(1)); %Correct choice
    BpodSystem.Data.Punished(iTrials) = ~isnan(BpodSystem.Data.RawEvents.Trial{1,iTrials}.States.HardPunish(1)); %False choice
    BpodSystem.Data.DidNotChoose(iTrials) = ~isnan(BpodSystem.Data.RawEvents.Trial{1,iTrials}.States.DidNotChoose(1)); %No choice
    BpodSystem.Data.DidNotLever(iTrials) = ~isnan(BpodSystem.Data.RawEvents.Trial{1,iTrials}.States.DidNotLever(1)); %No choice
    BpodSystem.Data.TargStim(iTrials) = TargStim; %Pulsecount for target side
    BpodSystem.Data.DistStim(iTrials) = DistStim; %Pulsecount for distractor side
    BpodSystem.Data.ITIjitter(iTrials) = ITIjitter; %duration of jitter between trials
    BpodSystem.Data.CorrectSide(iTrials) = correctSide; % 1 means left, 2 means right side
    BpodSystem.Data.StimType(iTrials) = StimType; % 1 means vision is rewarded, 2 means audio is rewarded
    BpodSystem.Data.stimEvents{iTrials} = stimEvents; % timestamps for individual events on each channel. Order is AL,AR,VL,VR, timestamps are in s, relative to stimulus onset (use stimOn to be more precise).
    BpodSystem.Data.TrialSettings(iTrials) = S; % Adds the settings used for the current trial to the Data struct (to be saved after the trial ends)
    BpodSystem.Data = BpodNotebook('sync', BpodSystem.Data); % Sync with Bpod notebook plugin
    BpodSystem.Data.TrialStartTime(iTrials) = RawEvents.TrialStartTimestamp(end); %keep absolute start time of each trial
    BpodSystem.Data.stimDur(iTrials) = stimDur; %stimulus duration of current trial
    BpodSystem.Data.decisionGap(iTrials) = cDecisionGap; %duration of gap between stimulus and decision in current trial
    BpodSystem.Data.stimOn(iTrials) = cStimOn; %variability in stim onset relative to lever grab. Creates an additional baseline before stimulus events.
    BpodSystem.Data.optoSide(iTrials) = optoSide; %side to which an optogenetic stimulus gets presented. 1 = left, 2 = right.
    BpodSystem.Data.optoType(iTrials) = optoType; %%time of optogenetic stimulus (1 = Stimulus, 2 = Delay')
    BpodSystem.Data.optoDur(iTrials) = optoDur; %%duration of optogenetic stimulus (s)

    if BpodSystem.Data.Punished(iTrials)
        pause(S.TimeOut); %punishment pause
    end

    % collect performance in OutcomeRecord variable (used for performance plot)
    if BpodSystem.Data.DidNotChoose(iTrials)
        OutcomeRecord(iTrials) = 3;
    elseif BpodSystem.Data.DidNotLever(iTrials)
        OutcomeRecord(iTrials) = 4;
    else
        OutcomeRecord(iTrials) = BpodSystem.Data.Rewarded(iTrials);
    end
    AssistRecord(iTrials) = ~any([GiveReward SingleSpout S.AutoReward]); %identify fully animal-performed trials.
    BpodSystem.Data.Assisted(iTrials) = AssistRecord(iTrials);
    BpodSystem.Data.SingleSpout(iTrials) = SingleSpout;
    BpodSystem.Data.AutoReward(iTrials) = any([GiveReward S.AutoReward]);
    BpodSystem.Data.Modality(iTrials) = TrialType; % 1 means detection trial, 2 means discrimination trial, 3 means delayed detection trial

    if OutcomeRecord(iTrials) < 3 %if the subject responded
        if (correctSide==1 && BpodSystem.Data.Rewarded(iTrials)) || (correctSide==2 && ~BpodSystem.Data.Rewarded(iTrials))
            BpodSystem.Data.ResponseSide(iTrials) = 1; %left side
        elseif ((correctSide==1) && ~BpodSystem.Data.Rewarded(iTrials)) || ((correctSide==2) && BpodSystem.Data.Rewarded(iTrials))
            BpodSystem.Data.ResponseSide(iTrials) = 2; %right side
        end
    else
        BpodSystem.Data.ResponseSide(iTrials) = NaN; %no response
    end

    % move spouts and lever out
    try BpodSystem.StartModuleRelay('TouchShaker1'); java.lang.Thread.sleep(10); end % Relay bytes from Teensy
    teensyWrite([71 1 '0' 1 '0']); % Move spouts to zero position
    teensyWrite([72 1 '0']); % Move handles to zero position

    %print things to screen
    fprintf('Nr. of trials initiated: %d\n', iTrials)
    fprintf('Nr. of completed trials: %d\n', nansum(OutcomeRecord==0|OutcomeRecord==1))
    fprintf('Nr. of rewards: %d\n', nansum(OutcomeRecord==1))
    fprintf('Amount of water in ul (est.): %d\n',  nansum(OutcomeRecord==1) * (mean([S.leftRewardVolume S.rightRewardVolume])))

end
SaveBpodSessionData % Saves the field BpodSystem.Data to the current data file

if S.SaveSettings %if current settings should be saved to file
    S.SaveSettings = false; %set variable back to false before saving
    ProtocolSettings = BpodSystem.ProtocolSettings;
    save(BpodSystem.GUIData.SettingsFileName, 'ProtocolSettings'); % save protocol settings file to directory
    set(BpodSystem.GUIHandles.SpatialSparrow_Control.SaveSettings,'Value',false); %set GUI back to false after saving
end

% show elapsed time and check if code still runs