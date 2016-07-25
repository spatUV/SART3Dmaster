function [StSLdata, enabled] = StSL(LSsph)

%=========================================
% StSL (Stereo Sine Law) Initialization
%=========================================

StSLdata.rNLS = 2;

NLS = size(LSsph,2);

if NLS ~= 2
     warning('StSL: There should be only 2 loudspeakers for stereo reproduction.');
     enabled = 0;
     return     
end

% Only a gain (L=1)
StSLdata.L = 1;

% Loudspeaker Base Angle
StSLdata.Base = abs(LSsph(2,1)); 

% Loudspeaker positions
StSLdata.LSsph = LSsph;

% Minimum loudspeaker distance
StSLdata.rmin = min(LSsph(1,:));

enabled = 1;