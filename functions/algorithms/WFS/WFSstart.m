function [WFSdata, enabled] = WFSstart(LSsph)


%=====================
% WFS Initialization
%=====================

WFSdata.rNLS = [];

WFSdata.L = 128;

% Minimum loudspeaker distance
WFSdata.rmin = min(LSsph(1,:));


% ==============================================
% Use SFS-Toolbox format and functions
% ==============================================

% Check that SFS Toolbox is installed
if isempty(which('SFS_start'));
    warning('WFS: SFS Toolbox not found. Please, install it and add it to path.');
    enabled = 0;
    return;
end

NLS = size(LSsph,2);
LScar = gSph2Car(LSsph);

% Check that setup corresponds to a circular array
if range(LSsph(1,:))~=0 || range(LSsph(3,:))~=0 || range(diff(sort(wrapTo360(LSsph(2,:)))))
    warning('WFS: The loudspeaker configuration does not match a circular array');
    enabled = 0;
    return;
end

    

% Secondary source positions
WFSdata.x0 = zeros(NLS,7);
WFSdata.x0(:,1:3) = LScar';

% Get direction of secondary sources
for n1 = 1:NLS
    WFSdata.x0(n1,4:6) = -WFSdata.x0(n1,1:3)/norm(WFSdata.x0(n1,1:3));
end

% Set weights
WFSdata.x0(:,7) = ones(NLS,1);

% Sound Field Synthesis General Configuration
WFSdata.src = 'ps';                                % Source Type
WFSdata.usetapwin = 1;                             % Use tapping window
WFSdata.tapwinlen = 0.3;                           % Tap Winlength
WFSdata.secondary_sources.geometry = 'circle';     % Secondary Source Geometry
WFSdata.c = 343;                                   % Speed of sound
WFSdata.xref = [0 0 0];                            % Amplitude Compensation Reference Point
WFSdata.fs = 44100;                                % Sampling Frequency
WFSdata.dimension = '2.5D';                        % Rendering dimension
WFSdata.driving_functions = 'default';             % Driving function
WFSdata.N = WFSdata.L;                             % IR length
WFSdata.secondary_sources.center = [0 0 0];        % Center of geometry
WFSdata.usefracdelay = 0;                          % Use fractional delay

% WFS Parameters
WFSdata.wfs.usehpre = 0;
WFSdata.wfs.hpretype = 'FIR';
WFSdata.wfs.hpreflow = 50;
WFSdata.wfs.hprefhigh = 1200;
WFSdata.wfs.hpreBandwidth_in_Oct = 2;
WFSdata.wfs.hpreIIRorder = 4;


enabled = 1;