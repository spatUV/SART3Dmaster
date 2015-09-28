
function conf = gCheckConfig(conf)
%% GCHECKCONFIG - Check Initial Configuration Structure
%
%This function checks the main configuration structure created with
%*gConfig* and adds extra information needed for the GUI.
%
%See also: gConfig 

%% Virtual Source Check
% These lines check that the number of specified virtual source locations
% agrees with the number of specified WAV files.

if isequal(length(conf.VS.fileNames), length(conf.VS.coord)) == 0
    error(['Error: The number of specified source locations does ' ...
        'not match the number of introduced source files.']);
else
    conf.nVS = length(conf.VS.fileNames);
end

%%
% Force virtual source coordinate angles to be in the range -180 to 180.
for ii = 1:conf.nVS
    conf.VS.coord{ii} = [conf.VS.coord{ii}(1), ... 
        wrapTo180(conf.VS.coord{ii}(2)), wrapTo180(conf.VS.coord{ii}(3))];
end



%%
% If the structure containing the virtual source names is empty, we set the
% names from the original WAV files.

if (isfield(conf.VS,'names')==0)
    for ii = 1:conf.nVS
        conf.VS.names{ii} = conf.VS.fileNames{ii}(1:length(conf.VS.fileNames{ii})-4);
    end
end

%%
% Add dots for very long names:
maxLengthName = 15; % Number of chars
for ii = 1:conf.nVS
    if (length(conf.VS.names{ii}) > maxLengthName)
        conf.VS.names{ii} = ([conf.VS.names{ii}(1:maxLengthName-3), '...']);
    end    
end


%% Loudspeaker Check
% The number of loudspeakers is directly obtained from the number of
% specified loudspeaker locations.
conf.nLS = length(conf.LS.coord);

%% 
% Force loudspeaker coordinate angles to be in the range -180 to 180.
for ii = 1:conf.nLS
    conf.LS.coord{ii} = [conf.LS.coord{ii}(1), ... 
        wrapTo180(conf.LS.coord{ii}(2)), wrapTo180(conf.LS.coord{ii}(3))];
end

%%
% Get coordinates both in spherical and Cartesian coordinates.
% We use matrices instead of cell arrays.
conf.LS.sph = reshape(cell2mat(conf.LS.coord),3,[]);
conf.LS.car = gSph2Car(conf.LS.sph);

%%
% The minimum loudspeaker distance is stored as the minimum distance to the
% listener (in order not to saturate the output audio under very small
% distances when applying distance attenuation).
conf.rMin = min(conf.LS.sph(1,:));  


%% Check Sound Scene Dimensionality
% These lines check if all the virtual source locations are at zero
% elevation when the scene dimensionality is '2D'.

if strcmp(conf.sceneDim, '2D')  
    aux = reshape(cell2mat(conf.VS.coord),3,[]);
    if sum(aux(3,:))~=0
        error(['Error: In a 2D scene, all the virtual sources must have '...
               'zero elevation. Revise the configuration.']);
    end
    clear aux;
end

%% Check Reproduction Setup Dimensionality
% Check that loudspeakers are all at the same height if 2D reproduction

if strcmp(conf.setupDim, '2D')
    aux = reshape(cell2mat(conf.LS.coord),3,[]);
    if sum(aux(3,:))~=0
        error(['Error: In a 2D setup, all the loudspeakers must have '...
               'zero elevation. Revise the configuration.']);
    end
    clear aux;
end

%% Check DSP Audio Driver
% The audio driver info is obtained as follows:

%%
% Device Names:
info = dspAudioDeviceInfo;

%%
% Load device names into configuration structure
if isfield(conf.driver,'deviceNames')==0
conf.driver.deviceNames = {length(info)};
for ii = 1:length(info)
    conf.driver.deviceNames{ii} = info(ii).name(1:length(info(ii).name)-7); % Eliminate 7 char: ' (ASIO)'
end
end

%% Check loudspeaker distance
% Check that loudspeakers are at the same distance from listening position
% (Note: This is only required for some reproduction methods)

% If the range of values in the radius of the coordinates is not zero
if range(cellfun(@(x) x(1), conf.LS.coord)) ~= 0
    warning('Loudspeakers are not at the same distance.');
end

%% Initial Configuration Plot
% A separate figure from the GUI is generated to let the user check that
% its setup is correct, having the ability to rotate the axes and explore
% the initial configuration from different views.

figure
% Loudspeakers
plot3(conf.LS.car(1,:),conf.LS.car(2,:),conf.LS.car(3,:),'sq',...
    'MarkerSize',10,'MarkerFaceColor','black','MarkerEdgeColor',...
    'blue');
hold on;
% Head
plot3(0,0,0,'or','MarkerSize',20,'MarkerFaceColor','r');
% Ears
plot3(0,0.14,0,'ok','MarkerSize',3,'MarkerFaceColor','r');
plot3(0.14,0,0,'ok','MarkerSize',6);
% Nose
plot3(-0.14,0,0,'ok','MarkerSize',6);
% Virtual Sources
vscoor = reshape(cell2mat(conf.VS.coord),3,[]);
vscoor = gSph2Car(vscoor);
plot3(vscoor(1,:),vscoor(2,:),vscoor(3,:),'o',...
    'MarkerSize',10,'MarkerFaceColor','green','MarkerEdgeColor',...
    'black');
axis([-3,3,-3,3,-3,3]), grid on;
xlabel('x [m]'), ylabel('y [m]'), zlabel('z [z]');
title('Initial Configuration Set-Up');


%% Rendering method Initialization
% Each rendering method needs to call its initialization routine.
% Every rendering method must first initialize the variable 'conf.nCoeffs',
% that specifies the number of filtering coefficients needed when
% performing the synthesis. For amplitude panning methods, conf.nCoeffs =
% 1, but other methods may require a longer impulse response.

switch conf.methods.selected
    case 'VBAP' % VBAP
        % ----------------------------------------------------------------
        % Initialization routine
        % ----------------------------------------------------------------
        VBAPstart;
            
    case 'AAP' % AAP
        % ----------------------------------------------------------------
        % Initialization routine
        % ----------------------------------------------------------------
        AAPstart;

    case 'HRTF' % HRTF
        % ----------------------------------------------------------------
        % Initialization routine
        % ----------------------------------------------------------------      
       HRTFstart;
            
    case 'StTL' % StTL - STEREO TANGENT LAW
        % ----------------------------------------------------------------
        % Initialization routine
        % ----------------------------------------------------------------          
        StTLstart;
     
    case 'StSL' % StSL - STEREO SINE LAW
        % ----------------------------------------------------------------
        % Initialization routine
        % ----------------------------------------------------------------       
        StSLstart;
             
    case 'WFS' % WFS - Wave Field Synthesis
        % ----------------------------------------------------------------
        % Initialization routine
        % ----------------------------------------------------------------
        WFSstart;
        
    case 'NFCHOA' % NFCHOA - Near Field Compensated Higher Order Ambisonics
        % ----------------------------------------------------------------
        % Initialization routine
        % ----------------------------------------------------------------
        NFCHOAstart;
        
    otherwise
        h = msgbox('Reproduction method not found' ...
            ,'Error','custom',imread('spaticon.png'));
        error('The selected reproduction method has not been defined.');
end



end