%=====================
% NFCHOA Initialization
%=====================

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

% Check that SFS Toolbox is installed
if isempty(which('SFS_start'));
    h = msgbox('SFS Toolbox not found. Please, install it and add it to path.' ...
            ,'NFCHOA Rendering','custom',imread('spaticon.png'));
        return;
end

h = msgbox('Be sure that you are using a circular loudspeaker array.' ...
            ,'NFCHOA Rendering','custom',imread('spaticon.png'));

conf.nCoeffs = 128;

% ==============================================
% Use SFS-Toolbox format and functions
% ==============================================

% Secondary source positions
conf.sfs.x0 = zeros(conf.nLS,7);
conf.sfs.x0(:,1:3) = conf.LS.car.';

% Get direction of secondary sources
for n1 = 1:conf.nLS
    conf.sfs.x0(n1,4:6) = -conf.sfs.x0(n1,1:3)/norm(conf.sfs.x0(n1,1:3));
end

% Set weights
conf.sfs.x0(:,7) = ones(conf.nLS,1);

% Sound Field Synthesis General Configuration
conf.sfs.src = 'ps';                                % Source Type
conf.sfs.usetapwin = 1;                             % Use tapping window
conf.sfs.tapwinlen = 0.3;                           % Tap Winlength
conf.sfs.secondary_sources.geometry = 'circle';     % Secondary Source Geometry
conf.sfs.c = 343;                                   % Speed of sound
conf.sfs.xref = [0 0 0];                            % Amplitude Compensation Reference Point
conf.sfs.fs = conf.fs;                              % Sampling Frequency
conf.sfs.dimension = '2.5D';                        % Rendering dimension
conf.sfs.driving_functions = 'default';             % Driving function
conf.sfs.N = conf.nCoeffs;                          % IR length
conf.sfs.secondary_sources.center = [0 0 0];        % Center of geometry
conf.sfs.usefracdelay = 0;                          % Use fractional delay

% Near-Field Compensated Higher Order Ambisonics Parameters
conf.sfs.nfchoa.order = [];

