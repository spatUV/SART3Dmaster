function [H,I] = gStTL(sph)
%GSTTL Stereo Tangent Panning Law Rendering
%
% Usage:
%   [H,I] = gStTL(sph)
%
% Input parameters:
%   sph - Spherical coordinates of the virtual source [r,Az,El].
%
% Output paramters:
%   H - Gains for left and right loudspeakers
%   I - Selected loudspeakers (always 1 and 2)
%
% See also: StTLstart, gStSL

global conf;

theta = -sph(2);
if abs(theta)<conf.StTL.Base    
    auxb = tand(theta)/tand(conf.StTL.Base);
    R = (auxb + 1)/(sqrt(2*auxb+2)); % gain for right loudspeaker
    L = sqrt(1-R^2);              % gain for left loudspeaker
    I = [1; 2];
else
    R = 0;
    L = 0;
    I = [];
    warning('Non-reachable source location');
end

if conf.LS.sph(2,1)>0   % if loudspeaker 1 is Left
    H = [L, R];
else                    % if loudspeaker 1 is Right
    H = [R, L];
end



% Attenuation factor (normalized with respect to closest loudspeaker):
r = max(sph(1), conf.rMin);
att = conf.rMin/r;

% Apply distance correction
H = H*att;
