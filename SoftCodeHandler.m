function SoftCodeHandler(StimID)
%soft code to handle playing stimulus
switch (StimID)
    case 11 %play visual stimulus     
        disp('Hello!')
    case 1 %play visual stimulus   
        PsychToolboxDisplayServer('play',StimID)        
    case 254 %clear screen
        PsychToolboxDisplayServer('stop')
    case 255 %stop everything        
        PsychToolboxDisplayServer('stop')
    otherwise %play auditory stimuli
        disp('Boo')
end