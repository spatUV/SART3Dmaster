function [H,I] = gRefreshH(VS)
%%GREFRESHH calculates the filtering coefficients and active loudspeakers
%%for a given source VS
%
% Input paramteres:
%   VS -  Virtual source object.
%
% Output parameter:
%   H  -  Matrix of filters [L x length(I)].
%   I  -  Vector of indices corresponding to active loudspeakers.
%
% See also: Vsource, RMethod 

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

coord = getCoord(VS);

switch VS.method.type
    case 'HRTF'
        [H, I] = gHRTF(coord,VS.method.data);
    case 'VBAP'
        [H, I] = gVBAP(coord,VS.method.data);
    case 'AAP'
        [H, I] = gAAP(coord(2),VS.method.data);
    case 'StSL'
        [H, I] = gStSL(coord,VS.method.data);
    case 'StTL'
        [H, I] = gStTL(coord,VS.method.data);
    case 'WFS'
        [H, I] = gWFS(coord,VS.method.data);
    case 'NFCHOA'
        [H, I] = gNFCHOA(coord,VS.method.data);
    case 'CLOSEST'
       [H, I] = gCLOSEST(coord,VS.method.data);
    otherwise
        error('Refreshing function not defined for method %s',VS.method.type);
        return;
end
       