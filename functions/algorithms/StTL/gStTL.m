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

%*****************************************************************************
% Copyright (c) 2013-2015 Signal Processing and Acoustic Technology Group    *
%                         SPAT, ETSE, Universitat de València                *
%                         46100, Burjassot, Valencia, Spain                  *
%                                                                            *
% This file is part of the SART3D: 3D Spatial Audio Rendering Toolbox.       *
%                                                                            *
% SART3D is free software:  you can redistribute it and/or modify it  under  *
% the terms of the  GNU  General  Public  License  as published by the  Free *
% Software Foundation, either version 3 of the License,  or (at your option) *
% any later version.                                                         *
%                                                                            *
% SART3D is distributed in the hope that it will be useful, but WITHOUT ANY  *
% WARRANTY;  without even the implied warranty of MERCHANTABILITY or FITNESS *
% FOR A PARTICULAR PURPOSE.                                                  *
% See the GNU General Public License for more details.                       *
%                                                                            *
% You should  have received a copy  of the GNU General Public License  along *
% with this program.  If not, see <http://www.gnu.org/licenses/>.            *
%                                                                            *
% SART3D is a toolbox for real-time spatial audio prototyping that lets you  *
% move in real time virtual audio sources from a set of WAV files using      *
% multiple spatial audio rendering methods.                                  *
%                                                                            *
% https://github.com/spatUV/SART3Dmaster                  maximo.cobos@uv.es *
%*****************************************************************************

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
