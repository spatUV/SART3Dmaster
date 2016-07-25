function devicenames = getdevices()
%%GETDEVICES returns the names of available audio devices
%
%
% Output parameters:
%   devicenames  - Names of found audio devices.
%
% See also: gConfig, SART3D.
%
%*****************************************************************************
% Copyright (c) 2013-2016 Signal Processing and Acoustic Technology Group    *
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

    % Device Names:
    info = dspAudioDeviceInfo;

    % Load device names into configuration structure
    devicenames = {length(info)};
    for ii = 1:length(info)
        if ispc
            devicenames{ii} = info(ii).name(1:length(info(ii).name)-7); % Eliminate 7 char: ' (ASIO)'
        elseif ismac
            devicenames{ii} = info(ii).name(1:length(info(ii).name)-13); % Eliminate 13 char: ' (CoreAudio)'
        end
    end
end