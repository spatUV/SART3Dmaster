function [H,I] = gStTL_new(sph, StTLdata)
%GSTSL Stereo Sine Panning Law Rendering
%
% Usage:
%   [H,I] = gStSL(sph)
%
% Input parameters:
%   sph - Spherical coordinates of the virtual source [r,Az,El].
%
% Output paramters:
%   H - Gains for left and right loudspeakers
%   I - Selected loudspeakers (always 1 and 2)
%
% See also: StSLstart, gStTL



theta = -sph(2); 
if abs(theta)<StTLdata.Base    
    auxb = sind(theta)/sind(StTLdata.Base);
    R = (auxb + 1)/(sqrt(2*auxb+2)); % gain for right loudspeaker
    L = sqrt(1-R^2);                 % gain for left loudspeaker
else
    R = 0;
    L = 0;
    warning('Non-reachable source location');
end

if StTLdata.LSsph(2,1)>0   % if loudspeaker 1 is Left
    H = [L, R];
else                       % if loudspeaker 1 is Right
    H = [R, L];
end

I = [1; 2];

% Attenuation factor (normalized with respect to closest loudspeaker):
r = max(sph(1), StTLdata.rmin);
att = StTLdata.rmin/r;

% Apply distance correction
H = H*att;
