% connect to bpod
Bpod('COM13')
%%
global BpodSystem
BpodSystem.StartModuleRelay('TouchShaker1');
%%
% lever steppers:
cVal = '0'; teensyWrite([72 length(cVal) cVal]);
%%
cVal = '25'; teensyWrite([72 length(cVal) cVal]);
%% 
teensyWrite([71 1 '0' 1 '0']); % Move spouts to zero position
%%
teensyWrite([71 2 '10' 2 '10']); % Move spouts to zero position