% S needs to be the BpodSystem.ProtocolSettings
global BpodSystem
S = BpodSystem.ProtocolSettings;
LeftIn = round(S.lInnerLim,2) - S.ServoPos(1); %left inner position - bias offset
RightIn = round(S.rInnerLim,2) - S.ServoPos(2); %right inner position - bias offset
LeftOut = LeftIn - S.spoutOffset; %left outer position
RightOut = RightIn - S.spoutOffset; %right outer position
if exist('SingleSpout','var')
    if SingleSpout
        if correctSide == 1 %correct side is left
            RightIn = RightOut; %- abs(RightIn - RightOut); %move right spout in opposite direction
        else
            LeftIn = LeftOut; %- abs(LeftIn - LeftOut); %move left spout in opposite direction
        end
    end
end
% convert to strings and combine as teensy output
LeftIn = num2str(LeftIn); RightIn = num2str(RightIn);
LeftOut = num2str(LeftOut); RightOut = num2str(RightOut);
LeverIn = num2str(S.LeverIn);
LeverOut = num2str(S.LeverOut);

% sl = @(x)num2str(strlength(x))
% cVal = [sl(LeftIn) sl(RightIn) sl(LeftOut) sl(RightOut) sl(LeverIn) sl(LeverOut) ...
%     LeftIn RightIn LeftOut RightOut LeverIn LeverOut];

cVal = [length(LeftIn) length(RightIn) length(LeftOut) length(RightOut) length(LeverIn) length(LeverOut) ...
    LeftIn RightIn LeftOut RightOut LeverIn LeverOut];

% send trial information to teensy and move spouts/lever to outer position

% teensyWrite([70 cVal])% send spout/lever information to teensy at trial start
teensyWrite([70 uint8(cVal)]);% send spout/lever information to teensy at trial start
teensyWrite(102); % Move left spout to outer position
teensyWrite(103); % Move right spout to outer position
teensyWrite(105); % Move handles to outer position

% this needs to wait for everything to move before releasing the function.
done = false;
while ~teensyWrite(88) % wait for movement to finish
end
return
