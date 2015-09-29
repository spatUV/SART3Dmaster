function [bestPos, rotate] = gChooseBestHRIRPos(theta, phi, posmatrix)
%GCHOOSEBESTHRIRPOS chooses the closest impulse responses to the input
%direction
%
% Usage:
%   [bestPos, rotate] = gChooseBestHRIRPos(theta,phi,posmatrix)
%
% Input paramters:
%   theta - Azimuth angle ([º])
%   phi - Elevation angle ([º])
%   posmatrix - Matrix of direction vectors of available responses.
%
% Output parameters:
%   bestPos - Index of best matching position
%   rotate - '1' if direction requires interchanging left and right
%   responses
%
% See also: gHRTF, HRTFstart

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

r = 1;
posSph = [r; theta; phi];

% Binaural symmetry.
% Rotate if azimuth is greater than 180
% if (posSph(2) > 180)
%     posSph(2) = 360-posSph(2);
%     rotate = 1;
% else
%     rotate = 0;
% end

if (posSph(2) <0)
    posSph(2) = abs(posSph(2));
    rotate = 1;
else
    rotate = 0;
end

posCar = gSph2Car(posSph); % Cartesian

% Closest position:
cx = lsqnonneg(posmatrix, posCar);
bestPos = find(cx == max(cx));
end