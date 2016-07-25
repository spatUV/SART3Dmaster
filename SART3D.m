%% SART3D 3D Spatial Audio Rendering Toolbox

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

close all;
clear all;
clc;

% Add folders to path if SART3D has not been initialized:
clear all;
SART3Dini;

%%
% ========================================================================
% CHECK CONFIGURATION
% ========================================================================

% Run configuration script
gConfig;

% Note: Alternatively, you can save in a .mat file the structures conf, 
% scene and setup and load them here as needed.
load twochannel.mat;

% Also, you may want to load a configuration or a scene as a .mat file.
load test_scene.mat;

% Check configuration
[conf, scene, setup, method] = gCheckConfig(conf, scene, setup);


%%
% ========================================================================
% GUI INITIALIZATION
% ========================================================================

% Get GUI object dimension structure to construct the GUI
guidim = gSizes();

% Initialize main GUI and get handles
data.f = GUIstart(guidim);

% Initialize plan view GUI and get handles
data.fplan = Planstart(conf,setup,guidim);
% pixel to meter factor
xyscale = guidim.bounds_axes_plan(3)/(2*conf.rmax); 

% Initialize profile view GUI (if enabled)
if strcmp(conf.profile,'on')
    data.fprofile = Profilestart(conf,setup,guidim);
    zyscale = guidim.bounds_axes_profile(3)/(2*conf.rmax);
end

% Create virtual source objects
VS = cell(scene.NVS,1);
for ii = 1:scene.NVS    
    VS{ii} = VSource(ii,scene.VSnames{ii},scene.VScoord{ii},scene.VSfilenames{ii});
end

% Create text boxes for user interaction
for ii = scene.NVS:-1:1
    
    % Edit-box indicating the virtual source to interact with user:
    aux = GVS(data.fplan, num2str(ii),...
        'textsVS', guidim.bounds_text_vs, ii, scene.VScoord{ii}, 'plan');
    
    % Box is included as a property of virtual source object
    createBox(VS{ii}, aux, 'plan', xyscale);
    
    % (same for profile view)
    if strcmp(conf.profile,'on')
        aux = GVS(data.fprofile, num2str(ii),...
        'textsVSProfile', guidim.bounds_text_vs, ii, scene.VScoord{ii}, 'profile');    
        createBox(VS{ii}, aux, 'profile', zyscale);
    end
    
    % Update position of virtual source
    updatePos(VS{ii}, scene.VScoord{ii});    
end

% Create GUI components
Compstart(data.f,conf,setup,guidim, method, VS);

%%
% ========================================================================
% DRAG & DROP INITIALIZATION
% ========================================================================

% Drag and drop data structure
datahit.handles = guihandles(data.f);
datahit.handles_plan = guihandles(data.fplan);
datahit.LScar = setup.LScar;
datahit.sres = conf.sres;
datahit.lastp = [0;0;0];
datahit.boundsaxesplan = guidim.bounds_axes_plan;
if strcmp(conf.profile,'on')
    datahit.handles_profile = guihandles(data.fprofile);
    datahit.boundsaxesprofile = guidim.bounds_axes_profile;
    datahit.profileon = 1;
else
    datahit.profileon = 0;
end


% Relate mouse motion to Drag And Drop custom function:
set(data.fplan, 'WindowButtonMotionFcn', @(hobj,eventdata) gDnDplan(hobj, eventdata, datahit, VS));
if strcmp(conf.profile,'on')
   set(data.fprofile, 'WindowButtonMotionFcn', @(hobj,eventdata) gDnDprofile(hobj, eventdata, datahit, VS));
end


%% 
% ========================================================================
% AUDIO FILTERING OBJECTS INITIALIZATION
% ========================================================================

for ii = 1:scene.NVS
    % By default, all sources are rendered using the setup method
    selmethod = findcellstr(conf.methods,setup.Renderer);
    setMethod(VS{ii}, method{selmethod});
    
    % Create filter objects for each source
    createRenderer(VS{ii}, conf.SamplesPerFrame, setup.NLS);
    
    % Update filters
    updateRenderer(VS{ii});   
end


%% 
% ========================================================================
% AUDIO PLAYBACK
% ========================================================================

% Playback data structure
playback.handles = guihandles(data.f);
playback.fs = conf.fs;
playback.buffersize = conf.bufferSize;
playback.channelmapping =  setup.ChannelMapping;
playback.queue = conf.QueueDuration;
playback.NLS = setup.NLS;
playback.samplesperframe = conf.SamplesPerFrame;
playback.NVS = scene.NVS;
playback.fadebuffers = conf.fadeBuffers;
if strcmp(conf.subwoofer.active, 'on')
    playback.subwactive = 1;
    playback.subwchannel = setup.subwchannel;
else
    playback.subwactive = 0;
end

% Playback toolbar
toolBar = uitoolbar(data.f); 
% ToggleButton - play 
uitoggletool('Parent', toolBar,...
    'CData', imread('play.png'),...
    'OnCallback', @(hobj,eventdata) tbPlayOnCallback(hobj, eventdata, playback, VS),...
    'OffCallback', @tbPlayOffCallback,...
    'TooltipString', 'Press to start/stop playback');