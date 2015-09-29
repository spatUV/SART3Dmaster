function [gs, I] = gVBAP(pc, rs)
%GVBAP computes VBAP gains for a source location
%
% Usage:
%   [gs, I] = gVBAP(pc, rs)
%
% Input paramteres:
%   gs - loudspeaker gains
%   I - selected loudspeakers
%
% Output paramters:
%   pc - desired virtual source location in Cartesian coordinates
%   rs - minimum source distance in the set-up
%
% See also: gVBAPini, VBAPstart

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

Ntriang = size(conf.VBAP.Triplets,1);
TriDim = size(conf.VBAP.Triplets,2);

GS = zeros(TriDim,Ntriang);

for n=1:Ntriang
    GS(:,n) = conf.VBAP.iLc(:,:,n)*pc;
end

% candidate_tri = find(sum(GS>=0)==3);
% min_gains = min(GS(:,candidate_tri));

candidate_tri = find(sum(GS>=0)==TriDim);
min_gains = min(GS(:,candidate_tri));
[~, select] = max(min_gains);

if isempty(select)
    gs = zeros(TriDim,1);
    %I  = 1:TriDim;
    I = [];
    warning('Non-reachable source location');
else
gs = GS(:,candidate_tri(select));
I  = conf.VBAP.Triplets(candidate_tri(select),:).';

% Normalized gains
gs = gs./sqrt(sum(gs.^2));

% Attenuation factor (normalized with respect to closest loudspeaker):
r = max(rs, conf.rMin);
att = conf.rMin/r;

% Apply distance correction
gs = gs*att;
end

end


