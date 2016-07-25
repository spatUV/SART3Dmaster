function [methoddata, enabled] = methodInit(method, LSsph)
%%METHODINIT SART3D Rendering method initialization. This function calls
%%the initialization routines needed for a given rendering method.
%
% Input paramteres:
%   mehod      -   Rendering method name.
%   LSsph      -   Loudspeaker spherical coordinates
%
% Output parameter:
%   methoddata -  Data structure needed for the method.  
%   enabled    -  "1" if the method is enabled, "0" else.
%
% See also: gCheckConfig, RMethod, gRefreshH.

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

switch method    
    case 'HRTF'
        [methoddata,enabled] = HRTFstart(LSsph);
    case 'VBAP'
        [methoddata,enabled] = VBAPstart(LSsph);
    case 'AAP'
        [methoddata,enabled] = AAPstart(LSsph);
    case 'StSL'
        [methoddata,enabled] = StSLstart(LSsph);
    case 'StTL'
        [methoddata,enabled] = StTLstart(LSsph);
    case 'WFS'
        [methoddata,enabled] = WFSstart(LSsph);        
    case 'NFCHOA'
        [methoddata,enabled] = NFCHOAstart(LSsph);
    case 'CLOSEST'
        [methoddata,enabled] = CLOSESTstart(LSsph);
    otherwise
        methoddata = struct([]);
        enabled = 0;
end