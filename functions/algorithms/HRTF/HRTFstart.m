%=====================
% HRTF Initialization
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

if conf.nLS > 2
    error('There should be only 2 loudspeakers for HRTF-based reproduction.');
end

% load scripts for HRTF reproduction:
hrir_fileNames;                         % Database wavefile names
hrir_posSph;                            % Corresponding directions (spherical)
hrir_posCar;                            % Corresponding directions (Cartesian)

% Read impulse responses
% Since conf.HRIR.fileNames is a cell array, we cast to char
conf.iR = {1, length(conf.HRIR.fileNames)};
for ii = 1:length(conf.HRIR.fileNames)
    conf.iR{ii} = audioread(char(conf.HRIR.fileNames(ii)));
end

% Number of coefficients:
conf.nCoeffs = length(conf.iR{ii});

% Set listener with headphones image
%GImage(gcf, '', get(handles.axes_plan,'Position'), (['guy_plan_hp.png']));
%GImage(gcf, '', get(handles.axes_profile,'Position'), (['guy_profile_hp.png']));
