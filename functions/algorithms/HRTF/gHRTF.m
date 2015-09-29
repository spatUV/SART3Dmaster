function [H, I] = gHRTF(sph)
%GHRTF - Head-Related Impulse Response Rendering
%
% Usage:
% [H, I] = hHRTF(sph)
%
% Input paramters:
%   sph - Spherical coordinates of the source
%
% Output paramters:
%   H - Rendering filters for each channel (left and right)
%   I - Selected channels (always 1 and 2)
%
% See also: HRTFstart

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

global conf

r = sph(1); %radius
theta = sph(2); % azimuth
phi = sph(3); %elevation

% Choose closest available position from dataset
% Checks if it is needed to rotate L-R
[bestPos, rotate] = gChooseBestHRIRPos(theta, phi, conf.HRIR.posCar);

H = zeros(conf.nCoeffs,2);

if rotate
    H(:,1) = conf.iR{bestPos}(:,1);
    H(:,2) = conf.iR{bestPos}(:,2);
else
    H(:,1) = conf.iR{bestPos}(:,2);
    H(:,2) = conf.iR{bestPos}(:,1);
end

% Normalize distance
r = max([r, conf.rMin]);

% Attenuation factor:
att = conf.rMin/r;

H = att*H;

I = [1; 2]; % Always L and R channels

end