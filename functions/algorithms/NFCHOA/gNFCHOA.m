function [H, I] = gNFCHOA(sph)
%GNFCHOA Near-Field Compensated Higher Order Ambisonics Rendering using SFS Toolbox.
%
% Usage:
%   [H, I] = gNFCHOA(sph)
%
% Input parameters:
%   sph - Spherical coordinates of virtual source
%
% Output paratmers:
%   H - NFCHOA Rendering filters
%   I - Selected loudspeakers corresponding to the rendering (all)
%
% See also: NFCHOAstart, driving_function_imp_nfchoa

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

% Warning:
% There is a 90º offset that might come from SFS Toolbo
sph(2) = wrapTo180(sph(2)-90);

% Postion of virtual source
xs = gSph2Car(sph).';

% All loudspeakers contribute to the rendering
I = 1:conf.nLS;

% Get driving signals
H = driving_function_imp_nfchoa(conf.sfs.x0,xs,conf.sfs.src,conf.sfs);


if max(abs(H(:)))>1
    H = H./max(abs(H(:)));
end








