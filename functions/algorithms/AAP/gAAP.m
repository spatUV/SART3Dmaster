function [d, I] = gAAP(alphas)
%GAAP Ambisonics Amplitude Panning Rendering
%
% Usage:
% [d, I] = gAAP(alphas)
%
% Input parameters:
%   alphas - azimuth angles of the loudspeakers
%
% Output parameters:
%   d - gains for the selected loudspeakers
%   I - indices of the selected loudspeakers
%
% See also: AAPstart

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

M = conf.AAP.Order;             % Order

I = 1:conf.nLS;                 % Contributing loudspeakers (all)
alpha0 = conf.LS.sph(2,:);      % Loudspeaker azimuth angles

d = sind(0.5*(2*M +1)*(alpha0-alphas))./((2*M + 1)*sind(0.5*(alpha0-alphas)));

end


