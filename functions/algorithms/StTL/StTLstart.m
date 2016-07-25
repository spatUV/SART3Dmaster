function [StTLdata, enabled] = StTL(LSsph)

%=========================================
% StSL (Stereo Sine Law) Initialization
%=========================================

StTLdata.rNLS = 2;

NLS = size(LSsph,2);

if NLS ~= 2
     warning('StSL: There should be only 2 loudspeakers for stereo reproduction.');
     enabled = 0;
     return     
end

% Only a gain (L=1)
StTLdata.L = 1;

% Loudspeaker Base Angle
StTLdata.Base = abs(LSsph(2,1)); 

% Loudspeaker positions
StTLdata.LSsph = LSsph;

% Minimum loudspeaker distance
StTLdata.rmin = min(LSsph(1,:));

enabled = 1;