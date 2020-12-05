% SpatialSparrow_Settings


% Define or load default settings for protocol
% General settings.
DefaultSettings.SubjectName = 'Dummy';
DefaultSettings.RewardedModality = 'AudioVisual'; % modality that is rewarded - 'Vision' for flashes, 'Audio' for beeps, 'AudioVisual' for multisensory
DefaultSettings.leftRewardVolume = 2;  % ul
DefaultSettings.rightRewardVolume = 2; % ul
DefaultSettings.UseAntiBias = false; % Spout correction | Do not use during experiments
DefaultSettings.AutoReward = 0; % automaticunt of self-performed trials with audio stimulation. Default is 1 (fully self-performed).
DefaultSettings.fractionTrainingVision = 1; % Amount of self-performed trials with visual stimulation. Default is 1 (fully self-performed).
DefaultSettings.fractionTrainingPiezo = 1; % Amount of self-performed trials with somatosensory stimulation. Default is 1 (fully self-performed).
DefaultSettings.fractionTrainingAudio = 1; % Amount of self-performed trials with auditory stimulation. Default is 1 (fully self-performed).
DefaultSettings.fractionTrainingMixed = 1; % Amount of self-performed trials with mixed stimulation. Default is 1 (fully self-performed).
DefaultSettings.SaveSettings = false; % Allows to save current settings to file
DefaultSettings.PerformanceSwitch = 'Performed'; % Switch to show performance over all trials (including trials that were not self-performed)
DefaultSettings.DoFit = false; % flag to do curve fitting in the performance window
DefaultSettings.modSelect = 'Combined'; % selector which part of the data show in the performance curve window
DefaultSettings.StartTime = '1'; %start time of current session.
DefaultSettings.cTrial = 1; %Nr of current trial.
DefaultSettings.LeverSound = true; %play indicator sound when animal is touching levers correctly
DefaultSettings.RegularStim = false; %produce regular stimulus sequence
DefaultSettings.biasSeqLength = 3; %nr of trials on one side after which the oder side is switched with 50% probability

          
if isunix
    DefaultSettings.widefieldPath = ''; %path to widefield data on server
    %DefaultSettings.videoDrive = '/home/anne/data'; %path to where the system saves video data
    DefaultSettings.serverPath = ''; %path to data on server
    DefaultSettings.bonsaiEXE = ''; %path to bonsai .exe
    DefaultSettings.bonsaiParadim = ''; %path to bonsai workflow
    DefaultSettings.labcamsAddress = 'localhost:9999';  
else
    DefaultSettings.widefieldPath = '\\grid-hs\churchland_nlsas_data\data\'; %path to widefield data on server
    %DefaultSettings.videoDrive = 'C:'; %path to where the system saves video data
    DefaultSettings.serverPath = '\\grid-hs\churchland_nlsas_data\data\'; %path to data on server
    DefaultSettings.bonsaiEXE = 'C:\Users\Anne\Dropbox\Users\Richard\Bonsai_2_4\Bonsai\Bonsai64.exe'; %path to bonsai .exe
    DefaultSettings.bonsaiParadim = 'C:\Users\Anne\Dropbox\Users\Richard\Bonsai_workflow\WorkflowTwoCamera_v07.bonsai'; %path to bonsai workflow
    DefaultSettings.labcamsAddress = '127.0.0.1:9999';
end
DefaultSettings.wavePort = 'COM18'; %com port for analog module
DefaultSettings.i2cPort = 'COM12'; %com port for analog module
DefaultSettings.TrainingMode = false; %flag if training is being used

DefaultSettings.labcamsWidefield = '';%'peanutbread.cshl.edu:9998'
DefaultSettings.triggerWidefield = 0; 

% Spout settings
DefaultSettings.SpoutSpeed = 25; % Duration of spout movement from start to endpoint when moving in or out (value in ms)
DefaultSettings.rInnerLim = 1.5; % Servo position to move right spoute close the animal (value between 0 and 100)
DefaultSettings.lInnerLim = 1.5; % Servo position to move left spoute close the animal (value between 0 and 100)
DefaultSettings.rOuterLim = 3.5; % Servo position to move right spoute more distant from the animal (value between 0 and 100)
DefaultSettings.lOuterLim = 3.5; % Servo position to move left spoute more distant from the animal (value between 0 and 100)
DefaultSettings.LeverSpeed = 150; % Duration of lever movement from start to endpoint when moving in or out (value in ms)
DefaultSettings.TouchThresh = 5; % Threshold for touch lines (SDUs)
DefaultSettings.LeverIn = 20; % Servo position to move lever close to the animal
DefaultSettings.LeverOut = 0; % Servo position to move lever away from the animal
DefaultSettings.lMaxSpoutIn = 30; % maximal inner position for left spout
DefaultSettings.rMaxSpoutIn = 30; % maximal inner position for right spout
DefaultSettings.spoutOffset = 10; %distance from inner spout position when moved out

% Trial timing
DefaultSettings.preStimDelay = 1; % (s) animal should sit still before a new stimulus is presented
DefaultSettings.minITI = 1; % (s) min additional time between trial end and next trial
DefaultSettings.maxITI = 2; % (s) max additional time between trial end and next trial
DefaultSettings.ITIlambda = 10; % defines the jitter between the min and maxITI. Higher lambda will constrain times closer to minITI.
DefaultSettings.WaitingTime = 1; % (s) minimum waiting time before a response can be made. Earlier licks are being ignored.
DefaultSettings.TimeToChoose = 3; % (s) wait for a decision
DefaultSettings.TimeToConfirm = 0.5; % (s) wait for a decision
DefaultSettings.TimeOut = 3; % (s) timeout punish for false response
DefaultSettings.LeverWait = 10; % (s) time to wait for lever grasp. Trial is counted as not responded if no touch is detected.
DefaultSettings.MoveLever = true; % Flag to decide whether lever should be moved or not.
DefaultSettings.UseBothLevers = false; % Flag to decide whether both levers have to be touched to trigger stimulus presentation
DefaultSettings.WaitBeforeLever = 1; % Waiting time before lever is moved in after trial onset
DefaultSettings.StimDuration = 1; % (s) Duration of a stimulus sequence
DefaultSettings.runTime = 0; % (h) Duration of the current session
DefaultSettings.varStimDur = 0; % (s) Variable duration of the stimulus sequence. Stim will be StimDuration + (0 to varStimDur)
DefaultSettings.optoDur = 0.5; % (s) Duration of the optogenetic stimulus.
DefaultSettings.optoRamp = 0.2; % (s) Time where optogenetic stimulus is ramping down. Example: optoDur = 0.5 and optoRamp = 0.2 makes a 500ms stimulus that ramps down after 300ms.
DefaultSettings.happyTime = 0.5; % (s) Time of the last bpod state. This is to give the animal some time to collect the water.

%Stimulus settings
DefaultSettings.BeepDuration = 20; % Beep duration in ms.
DefaultSettings.FlashDuration = 20; % Flash duration in ms.
DefaultSettings.BuzzDuration = 20; % Buzz duration in ms.
DefaultSettings.varStimOn = [0 0.125 0.25]; % Variable onset time for stimulus after lever grab in s. This can be a vector of values. Have to be 0 and higher.
DefaultSettings.StimBrightness = 20; %Brightness of flashes. Multiplier of base frequency (default is 100Hz).
DefaultSettings.StimLoudness = 0.5; %Loudness of tones
DefaultSettings.BuzzStrength = 1; %Strength of buzzes
DefaultSettings.WaitForCam = false; % Any positive value will make each trial wait for a trigger signal from the camera. After CamWait seconds without trigger, protocol will continue.
DefaultSettings.TargRate = 20; % Rate of target sequence. Can be either a single scalar or a vector.
DefaultSettings.DistFractions = 0; % Nr of distractor pulses is a fraction of target pulses. Can be either a single number between 0-1 or a vector.
DefaultSettings.DistProb = 0; % Probability of a presenting a distractor trial. Only has an effect if DistFractions > 0.
DefaultSettings.BinSize = 50; % Refractory period after stimulus presentation after which no stimulus can be presented (value in ms).
DefaultSettings.StimCoherence = 1; % Flag to determine if multisensory stimuli on the same side should be correlated (1) or not (0).
DefaultSettings.UseNoise = false; % Probability to produce a noise burst as auditory stimulus (1). Otherwise a convolved click is produced (0).
DefaultSettings.ProbAudio = 0; % Probability of presenting an audio only trial when modality setting allows it. Has no function otherwise.
DefaultSettings.ProbVision = 0; % Probability of presenting an vision only trial when modality setting allows it. Has no function otherwise.
DefaultSettings.ProbPiezo = 0; % Probability of presenting a somatosensory only trial when modality setting allows it. Has no function otherwise.
DefaultSettings.StimGap = 0; % Duration of a gap in the middle of stimulus presentation in s. When this value is used each stimulus is of stimDuration*2 + stimGap long.
DefaultSettings.DecisionGap = [0.3 1.5]; % Range of a gap between stimulus and decision period in s.
DefaultSettings.TestModality = 0; % Define a modality to be used with discrimination (1=vis,2=aud,4=ss), inactive if set to 0. All others will be detection only.
DefaultSettings.optoProb = 0; % Probability to present an optogenetic stimulus. Ranges from 0 (no optogenetics) to 1 (all trials).
DefaultSettings.optoTimes = 'Stimulus/Delay'; % Part of the trial where optogenetic stimulus should be presented.
DefaultSettings.optoRight = 0.5; %Probability for occurence of an optogenetic stimulus on the right.
DefaultSettings.optoBoth = 1; %Probability for occurence of an optogenetic stimulus on both sides. This comes after determining a single HS target.
DefaultSettings.optoPower = 5; %Power of optogenetic light on the brain surface. This is just an indicator.
DefaultSettings.sRate = 20000; % This is the sampling rate of the analog output module. Max rates: 2ch = 100kHz, 4ch = 50kHz, 8ch = 20kHz
DefaultSettings.PunishSoundDur = 0; % (s) Duration of white noise punish sound when the animal makes a mistake.

% Stimulus presentation settings
DefaultSettings.ProbRight = 0.5; %Probability for occurence of a target presentation on the right.
DefaultSettings.ServoPos = zeros(1,2); % position of left and right spout, relative to their inner limit. these values will be changed by anti-bias correction to correct spout position.
DefaultSettings.maxServoPos = zeros(1,2)+3;
