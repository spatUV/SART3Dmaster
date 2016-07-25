function [conf,scene,setup,method] = gCheckConfig(conf,scene,setup)
%%GCHECKCONFIG - Check Initial Configuration Structures
%
% This function checks the main configuration structure created with
% *gConfig* and adds extra information needed for the GUI.
%
% Usage:
%   [conf, scene, setup, method] = gCheckConfig(conf,scene,setup)
%
% Input parameters:
%   conf  - SART3D configuration structure, as created by gConfig.
%   scene - SART3D audio scene structure, as created by gConfig.
%   setup - SART3D reproduction setup structure, as created by gConfig.
%
% Output parameters:
%   conf  - SART3D configuration structure (verified).
%   scene - SART3D configuration structure (verified).
%   setup - SART3D configuration structure (verified).
%
% See also: gConfig 


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

%% Virtual Source Check
% These lines check that the number of specified virtual source locations
% agrees with the number of specified WAV files.

if isequal(size(scene.VSfilenames,2), size(scene.VScoord,2)) == 0
    error(['Error: The number of specified source locations does ' ...
        'not match the number of introduced source files.']);
else
    scene.NVS = size(scene.VSfilenames,2);
end

%%
% Force virtual source coordinate angles to be in the range -180 to 180.
for ii = 1:scene.NVS
    scene.VScoord{ii} = [scene.VScoord{ii}(1), ... 
        wrapTo180(scene.VScoord{ii}(2)), wrapTo180(scene.VScoord{ii}(3))];
end

%%
% If the structure containing the virtual source names is empty, we set the
% names from the original WAV files.

if (isfield(scene,'VSnames')==0  || isempty(scene.VSnames) )
    for ii = 1:scene.NVS
        scene.VSnames{ii} = scene.VSfilenames{ii}(1:length(scene.VSfilenames{ii})-4);
    end
elseif (size(scene.VSnames,2)~= scene.NVS)
    error(['Error: The number of provided source names does not match the number of sources']);
end


%%
% Add dots for very long names:
maxLengthName = 15; % Number of chars
for ii = 1:scene.NVS
    if (length(scene.VSnames{ii}) > maxLengthName)
        scene.VSnames{ii} = ([scene.VSnames{ii}(1:maxLengthName-3), '...']);
    end    
end

%% Check loudspeaker positions and channelmapping:

setup.NLS = size(setup.LScoord,2);
% Force loudspeaker coordinate angles to be in the range -180 to 180.
for ii = 1:setup.NLS
    setup.LScoord{ii} = [setup.LScoord{ii}(1), ... 
    wrapTo180(setup.LScoord{ii}(2)), wrapTo180(setup.LScoord{ii}(3))];
end
setup.LSsph = cell2mat(setup.LScoord.').';
setup.LScar = gSph2Car(setup.LSsph);

% Check number of channels
if length(setup.ChannelMapping)~= setup.NLS
    error(['Error: The number of channels must match the number of specified loudspeaker locations']);
end


%% Check Sound Scene Dimensionality (Not currently used)
% These lines check if all the virtual source locations are at zero
% elevation when the scene dimensionality is '2D'.

% if strcmp(conf.sceneDim, '2D')  
%     aux = reshape(cell2mat(scene.VScoord),3,[]);
%     if sum(aux(3,:))~=0
%         error(['Error: In a 2D scene, all the virtual sources must have '...
%                'zero elevation. Revise the configuration.']);
%     end
%     clear aux;
% end

%% Check Reproduction Setup Dimensionality (Not currently used)
% Check that loudspeakers are all at the same height if 2D reproduction

% if strcmp(conf.setupDim, '2D')
%     if sum(setup.LSsph(3,:))~=0
%         error(['Error: In a 2D setup, all the loudspeakers must have '...
%                'zero elevation. Revise the configuration.']);
%     end
% end


%% Check loudspeaker distance (Not currently used)
% Check that loudspeakers are at the same distance from listening position
% (Note: This is only required for some reproduction methods)

% % If the range of values in the radius of the coordinates is not zero
% if range(cellfun(@(x) x(1), setup.LScoord)) ~= 0
%     warning('Loudspeakers are not at the same distance.');
% end

%% Check subwoofer
if strcmp(conf.subwoofer.active,'on')
    if (isfield(setup,'subwchannel')==0) || isempty(setup.subwchannel) 
        error('Subwoofer channel not specified in setup.')
    end
end

%% Check Reproduction Setup and Method

% ========================================================================
% RENDERING METHOD INITIALIZATION
% IMPORTANT: Edit "methodInit.m" to define initialization routines for new
% reproduction methods.
% ========================================================================

% Initialize rendering method objects
Nmethods = size(conf.methods,1);
method = cell(Nmethods,1);
for n = 1:Nmethods
    method{n} = RMethod(conf.methods{n},setup.LSsph);
end

% Remove non-enabled methods
enabledmethods = cellfun(@(x) x.enabled, method);
method(enabledmethods==0) = [];
conf.methods(enabledmethods==0) = [];

selmethod = findcellstr(conf.methods,setup.Renderer);
if isempty(selmethod)
    setup.Renderer = conf.methods{1};
else
    setup.Renderer = conf.methods{selmethod};
end

end