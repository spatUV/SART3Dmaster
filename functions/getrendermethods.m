function methodnames = getrendermethods()
%%GETRENDERMETHODS finds the name of available methods in the \algorithms
%%folder of SART3D.
%
%
% Output parameters:
%   methodnames  - Names of the methods found in the algorithms folder.
%
% See also: SART3D, gConfig.
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
    
    methods = dir([getrootfolder(), '/functions/algorithms']);
    methods = methods(3:end);
    Nmethods = length(methods);

    conf.methods.names = cell(Nmethods,1);
    methodnames = cell(Nmethods,1);
    for ii = 1:Nmethods
        methodnames{ii} = methods(ii).name;
    end
    
end