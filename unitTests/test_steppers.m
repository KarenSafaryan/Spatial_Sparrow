% connect to bpod
Bpod('COM3')
%%
global BpodSystem
BpodSystem.StartModuleRelay('TouchShaker1');
%%
% lever steppers:
cVal = '0'; teensyWrite([72 length(cVal) cVal]);
%%
cVal = '100'; teensyWrite([72 length(cVal) cVal]);
%% 
teensyWrite([71 1 '0' 1 '0']); % Move spouts to zero position
%%
teensyWrite([71 2 '95' 2 '95']); % Move spouts to zero position