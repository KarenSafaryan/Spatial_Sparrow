%SpatialSparrow_StateMachine

%% Build state matrix
sma = NewStateMatrix();

trialstart_stateout = {'BNCState',1};
if exist('i2c','var')
    trialstart_stateout = [trialstart_stateout,'I2C1', [1 34]];
end

if S.MoveLever
    trialstart_cond = {'Tup','MoveLever'};
elseif (S.AutoReward || GiveReward) && S.TrainingMode
    
    trialstart_cond = {'Tup','AutoReward'};
else
    trialstart_cond = {'Tup','PlayStimulus'};
end

sma = AddState(sma, 'Name', 'TrialStart', ... %trigger to signal trialstart to attached hardware. Only works when using 'WaitForCam'.
    'Timer', 0.1, ...
    'StateChangeConditions', trialstart_cond,... %wait for imager before producing barcode sequence
    'OutputActions', trialstart_stateout); % BNC 1 is high, all others are low, sends message to scan image


% generate barcode to identify trialNr on adjacent hardware
% No need to send codes, not used anywhere, better to send a rise
% when trial starts
%         sma = AddState(sma, 'Name', 'TriggerDowntime', ... %give a 50ms downtime of the trigger before sending the barcode. Might help with to ensure that data is correctly recorded.
%             'Timer', 0.05, ...
%             'StateChangeConditions', {'Tup','trialCode1'},...
%             'OutputActions', {'TouchShaker1', 78}); % all outpouts are low but make teensy send a trial-onset trigger
%         Cnt = 0;
%
%         code = encode2of5(iTrials);
%         codeModuleDurs = [0.0025 0.0055]; %Durations for each module of the trial code sent over the TTL line
%
%         for iCode = 1:size(code,2)
%             Cnt = Cnt+1;
%             stateName = ['trialCode' num2str(Cnt)];
%             nextState = [stateName 'Low'];
%
%             sma = AddState(sma, 'Name', stateName, ... %produce high state
%                 'Timer', codeModuleDurs(code(1,iCode)), ...
%                 'StateChangeConditions', {'Tup',nextState},... %move to next low state
%                 'OutputActions',{'BNCState',1}); %send output to BNC1 to send barcode to adjacent hardware
%
%             stateName = nextState;
%             if iCode == size(code,2)
%                 nextState = 'CheckForLever';
%             else
%                 nextState = ['trialCode' num2str(Cnt + 1)];
%             end
%
%             sma = AddState(sma, 'Name', stateName, ... %produce low state
%                 'Timer', codeModuleDurs(code(2, iCode)), ...
%                 'StateChangeConditions', {'Tup',nextState},... %move to next low state
%                 'OutputActions',{});
%         end



%
% sma = AddState(sma, 'Name', 'CheckForLever', ... %check if lever is part of the paradigm
%     'Timer', 0, ...
%     'StateChangeConditions', {'Tup',LeverState},... %skip WaitBeforeLever if not required
%     'OutputActions', {});
%

%% Auto-reward
if (S.AutoReward || GiveReward) && S.TrainingMode
    sma = AddState(sma, 'Name', 'AutoReward', ... %always give a reward if AutoReward is on
        'Timer', autoValve, ...
        'StateChangeConditions', {'Tup', 'PlayStimulus'},...  %do a short break before moving to response state
        'OutputActions', {'ValveState', RewardValve}); %open reward valve
end

%% Check if the handles are being used and check if there is autoreward

if S.MoveLever
%     sma = AddState(sma, 'Name', 'WaitBeforeLever', ... %wait duration before the lever is moved in
%         'Timer', S.WaitBeforeLever, ...
%         'StateChangeConditions', {'Tup','MoveLever'},...
%         'OutputActions', {});
    if S.LeverWait
        movelever_cond = {'Tup','WaitForLever','TouchShaker1_14','WaitForLever'};
    elseif sum(strcmp(sma.StateNames,'AutoReward'))
        movelever_cond = {'Tup','AutoReward','TouchShaker1_14','AutoReward'};
    else
        movelever_cond = {'Tup','PlayStimulus','TouchShaker1_14','PlayStimulus'};
    end
    sma = AddState(sma, 'Name', 'MoveLever', ... %state to move handles
        'Timer', 1, ...
        'StateChangeConditions',movelever_cond,...
        'OutputActions', {'TouchShaker1', 104}); % move handles in
    
    
    sma = AddState(sma, 'Name', 'WaitForLever', ... %wait for any levertouch
        'Timer', LeverWait, ...
        'StateChangeConditions', {'TouchShaker1_5', 'WaitForAnimal', 'TouchShaker1_6', 'WaitForAnimal', 'TouchShaker1_7', 'WaitForAnimal', 'Tup', LeverMiss},... %in lever case, any touch is required. Otherwise will move on immediately. Goes to 'DidNotLever' if no touch appears until S.Leverwait.
        'OutputActions', {'TouchShaker1', 76}); % request lever states from teensy
    
    sma = AddState(sma, 'Name', 'WaitForBothLevers', ... %wait for both levertouches
        'Timer', LeverWait, ...
        'StateChangeConditions', {'TouchShaker1_7', 'WaitForAnimal', 'Tup', LeverMiss},... %in lever case, any touch is required. Otherwise will move on immediately. Goes to 'DidNotLever' if no touch appears until S.Leverwait.
        'OutputActions', {'TouchShaker1', 76}); % request lever states from teensy
    
    waitforanimal_cond = {'TouchShaker1_8', LeverWaitState, 'TouchShaker1_9', LeverWaitState};
    if (S.AutoReward || GiveReward) && S.TrainingMode
        waitforanimal_cond =  [waitforanimal_cond,'Tup','AutoReward'];
    else
        waitforanimal_cond =  [waitforanimal_cond,'Tup','PlayStimulus'];
    end
    sma = AddState(sma, 'Name', 'WaitForAnimal', ... %hold both handles for a baseline duration before stimulus presentation
        'Timer', S.preStimDelay, ...
        'StateChangeConditions', waitforanimal_cond,... %restart waiting period if animal releases any of the handles prematurely
        'OutputActions', {'WavePlayer1',['P' leverSoundID]}); % play lever sound on ch 1+2
end
if exist('i2c','var') % does this have I2C communication to scanimage?
    sma = AddState(sma, 'Name', 'PlayStimulus', ... %present stimulus for the set stimulus duration.
        'Timer', waitDur, ... %waitDur is the duration the animal has to wait before moving to next state
        'StateChangeConditions', {'Tup','DelayPeriod'},...
        'OutputActions', {'WavePlayer1',['P' 0], 'TouchShaker1', 77, 'I2C1',[1,35]}); %start stimulus presentation + stimulus trigger, sends I2C message to scanimage
else
    sma = AddState(sma, 'Name', 'PlayStimulus', ... %present stimulus for the set stimulus duration.
        'Timer', waitDur, ... %waitDur is the duration the animal has to wait before moving to next state
        'StateChangeConditions', {'Tup','DelayPeriod'},...
        'OutputActions', {'WavePlayer1',['P' 0], 'TouchShaker1', 77}); %start stimulus presentation + stimulus trigger
end

sma = AddState(sma, 'Name', 'DelayPeriod', ... %Add gap after stimulus presentation
    'Timer', cDecisionGap, ...
    'StateChangeConditions', {'Tup','MoveSpout'},...
    'OutputActions', {});

sma = AddState(sma, 'Name', 'MoveSpout', ... %move spouts towards the animal so it can report its choice
    'Timer', 0.1, ...
    'StateChangeConditions', {'Tup','WaitForResponse','TouchShaker1_14','WaitForResponse'},...
    'OutputActions', {'TouchShaker1', 101}); % trigger to moves spouts in

sma = AddState(sma, 'Name', 'WaitForResponse', ... %wait for animal response after stimulus was presented
    'Timer', S.TimeToChoose, ...
    'StateChangeConditions', {'TouchShaker1_1', LeftPortAction, 'TouchShaker1_2', RightPortAction, 'Tup', 'DidNotChoose'},...
    'OutputActions',{});

sma = AddState(sma, 'Name', 'CheckReward', ... %wait for second lick to confirm decision.
    'Timer', S.TimeToConfirm, ...
    'StateChangeConditions', {'TouchShaker1_1', cLeftPortAction, 'TouchShaker1_2', cRightPortAction, 'Tup', 'WaitForResponse'},...
    'OutputActions',{});

sma = AddState(sma, 'Name', 'CheckPunish', ... %wait for second lick to confirm decision.
    'Timer', S.TimeToConfirm, ...
    'StateChangeConditions', {'TouchShaker1_1', pLeftPortAction, 'TouchShaker1_2', pRightPortAction, 'Tup', 'WaitForResponse'},...
    'OutputActions',{});

sma = AddState(sma, 'Name', 'Reward', ... %reward for correct response
    'Timer', rewardValveTime,...
    'StateChangeConditions', {'Tup','HappyTime'},...
    'OutputActions', {'ValveState', RewardValve, 'WavePlayer1',['P' 10], 'TouchShaker1', moveNRewardOut}); %open reward valve and play reward click (don't act if reward was given already)

sma = AddState(sma, 'Name', 'HappyTime', ... %wait for a moment to collect water
    'Timer', S.happyTime, ...
    'StateChangeConditions', {'Tup', 'TrialEnd'}, ...
    'OutputActions', {});

sma = AddState(sma, 'Name', 'HardPunish', ... %punish for incorrect response - timeout + punish sound
    'Timer', S.PunishSoundDur,...
    'StateChangeConditions', {'Tup','TrialEnd'},...% 'TouchShaker1_14','TrialEnd'},...
    'OutputActions', {'WavePlayer1',['P' 11],'TouchShaker1', movePunishOut});% 'TouchShaker1', WirePunishOut}); %play punish sound

sma = AddState(sma, 'Name', 'DidNotLever', ... %if animal did not touch the lever move on to next trial
    'Timer', 0.01, ...
    'StateChangeConditions', {'Tup', 'TrialEnd'}, ...
    'OutputActions', {'BNCState', 2});

sma = AddState(sma, 'Name', 'DidNotChoose', ... %if animal did not respond move on to next trial
    'Timer', 0.01, ...
    'StateChangeConditions', {'Tup', 'TrialEnd'}, ...
    'OutputActions', {'BNCState', 2});

if exist('i2c','var') % does this have I2C communication to scanimage?
    sma = AddState(sma, 'Name', 'TrialEnd', ... %move to next trials after a randomly varying waiting period.
        'Timer', 0, ...
        'StateChangeConditions', {'Tup', 'exit', 'TouchShaker1_14','exit'}, ...
        'OutputActions', {'WavePlayer1','X', 'TouchShaker1', 105,'BNCState',0,'I2C1', [1 36]});  %make sure all stimuli are off and move handles out
else
    sma = AddState(sma, 'Name', 'TrialEnd', ... %move to next trials after a randomly varying waiting period.
        'Timer', 0, ...
        'StateChangeConditions', {'Tup', 'exit', 'TouchShaker1_14','exit'}, ...
        'OutputActions', {'WavePlayer1','X', 'TouchShaker1', 105, 'BNCState',0});  %make sure all stimuli are off and move handles out
end


%% send state machine to bpod
SendStateMachine(sma);
pause(0.1); %This prevents issue with overflow of touch bytes from teensy between trials