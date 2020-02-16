%% connect to ao
W = BpodWavePlayer('COM18');
%%
W.OutputRange = '-5V:5V'; % make sure output range is correct
W.TriggerProfileEnable = 'Off'; % use trigger profiles to produce different waveforms across channels
% W.TriggerProfiles(1, :) = 1:8; %when triggering first row, ch1-8 will play waveforms 1-8
% W.TriggerMode = 'Master'; %output can be interrupted by new stimulus triggers
% W.LoopDuration(1:8) = 0; %keep on for a up to 10 minutes
W.SamplingRate = 20000; %adjust sampling rate
%%
% addpath('Bpod_Gen2\Functions\Internal Functions\GenerateSineWave.m')
sound = GenerateSineWave(W.SamplingRate, 2000, 1) / 1;
% W.TriggerProfiles(10, 1:2) = 10;
%
W.loadWaveform(10,sound); % load signal to waveform object
W.play([2],10)