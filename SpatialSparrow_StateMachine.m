%SpatialSparrow_StateMachine

%% Build state matrix
sma = NewStateMatrix();

trialstart_stateout = {'BNCState',1}; % ,'SoftCode',1};
if exist('i2c','var')
    trialstart_stateout = [trialstart_stateout,'I2C1', [1 34]];
end

if S.TrialStartCue
    trialstart_stateout = [trialstart_stateout,'WavePlayer1',['P' 8]]; 
    % this will play the trial start cue
end
if S.MoveLever
    trialstart_cond = {'Tup','MoveLever'};
else
    trialstart_cond = {'Tup','StimulusCue'};
end

sma = AddState(sma, 'Name', 'TrialStart', ... %trigger to signal trialstart to attached hardware. Only works when using 'WaitForCam'.
    'Timer', 0.1, ...
    'StateChangeConditions', trialstart_cond,... %wait for imager before producing barcode sequence
    'OutputActions', trialstart_stateout); % BNC 1 is high, all others are low, sends message to scan image

%% Check if the handles are being used

if S.MoveLever
    if S.LeverWait
        movelever_cond = {'Tup','WaitForLever','TouchShaker1_14','WaitForLever'};
    else
        movelever_cond = {'Tup','StimulusCue','TouchShaker1_14','StimulusCue'};
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
    waitforanimal_cond =  [waitforanimal_cond,'Tup','StimulusCue'];
    outaction = {};
    if S.LeverSound
        outaction = {'WavePlayer1',['P' leverSoundID]};
    end
    sma = AddState(sma, 'Name', 'WaitForAnimal', ... %hold both handles for a baseline duration before stimulus presentation
        'Timer', S.handleHoldDelay, ...
        'StateChangeConditions', waitforanimal_cond,... %restart waiting period if animal releases any of the handles prematurely
        'OutputActions', outaction); % play lever sound on ch 1+2
end
if S.UseStimStartCue
    
    sma = AddState(sma, 'Name', 'StimulusCue', ... %present stimulus  cue (auditory)
        'Timer', S.preStimDelay, ... 
        'StateChangeConditions', {'Tup','PlayStimulus'},...
        'OutputActions', {'WavePlayer1',['P' 12]}); 
else
        sma = AddState(sma, 'Name', 'StimulusCue', ... %present stimulus  cue (auditory)
        'Timer', S.preStimDelay, ... 
        'StateChangeConditions', {'Tup','PlayStimulus'},...
        'OutputActions', {}); 
end

outact = {'WavePlayer1',['P' 0], 'TouchShaker1', 77};

if ismember(StimType,[1,3,5,7])
    outact = [outact,'SoftCode', 1];
end


if exist('i2c','var') % does this have I2C communication to scanimage?
    outact = [outact,'I2C1',[1,35]];
end
    sma = AddState(sma, 'Name', 'PlayStimulus', ... %present stimulus for the set stimulus duration.
        'Timer', waitDur, ... %waitDur is the duration the animal has to wait before moving to next state
        'StateChangeConditions', {'Tup','DelayPeriod'},...
        'OutputActions', outact); %start stimulus presentation + stimulus trigger

sma = AddState(sma, 'Name', 'DelayPeriod', ... %Add gap after stimulus presentation
    'Timer', cDecisionGap, ...
    'StateChangeConditions', {'Tup','MoveSpout'},...
    'OutputActions', {});


if (S.AutoReward || GiveReward) && SingleSpout % then give the reward right away
    movespout_cond =  {'Tup','Reward','TouchShaker1_14','Reward'};
else % check the animal response
    movespout_cond = {'Tup','WaitForResponse','TouchShaker1_14','WaitForResponse'};
end
sma = AddState(sma, 'Name', 'MoveSpout', ... %move spouts towards the animal so it can report its choice
    'Timer', 0.1, ...
    'StateChangeConditions', movespout_cond,...
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

outaction = {'TouchShaker1', movePunishOut};
if S.PunishSoundDur > 0
    outaction = [outaction,'WavePlayer1',['P' 11]];
end

sma = AddState(sma, 'Name', 'HardPunish', ... %punish for incorrect response - timeout + punish sound
    'Timer', S.TimeOut,...
    'StateChangeConditions', {'Tup','TrialEnd'},...% 'TouchShaker1_14','TrialEnd'},...
    'OutputActions', outaction); %play punish sound

sma = AddState(sma, 'Name', 'DidNotLever', ... %if animal did not touch the lever move on to next trial
    'Timer', 0.01, ...
    'StateChangeConditions', {'Tup', 'TrialEnd'}, ...
    'OutputActions', {});

sma = AddState(sma, 'Name', 'DidNotChoose', ... %if animal did not respond move on to next trial
    'Timer', 0.01, ...
    'StateChangeConditions', {'Tup', 'TrialEnd'}, ...
    'OutputActions', {});

if exist('i2c','var') % does this have I2C communication to scanimage?
    sma = AddState(sma, 'Name', 'TrialEnd', ... %move to next trials after a randomly varying waiting period.
        'Timer', 0, ...
        'StateChangeConditions', {'Tup', 'exit', 'TouchShaker1_14','exit'}, ...
        'OutputActions', {'WavePlayer1','X', 'TouchShaker1', 105,'I2C1', [1 36]});  %make sure all stimuli are off and move handles out
else
    sma = AddState(sma, 'Name', 'TrialEnd', ... %move to next trials after a randomly varying waiting period.
        'Timer', 0, ...
        'StateChangeConditions', {'Tup', 'exit', 'TouchShaker1_14','exit'}, ...
        'OutputActions', {'WavePlayer1','X', 'TouchShaker1', 105});  %make sure all stimuli are off and move handles out
end


%% send state machine to bpod
SendStateMachine(sma);
pause(0.1); %This prevents issue with overflow of touch bytes from teensy between trials