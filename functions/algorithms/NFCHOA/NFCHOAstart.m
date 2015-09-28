%=====================
% NFCHOA Initialization
%=====================

% Check that SFS Toolbox is installed
if isempty(which('SFS_start'));
    h = msgbox('SFS Toolbox not found. Please, install it and add it to path.' ...
            ,'NFCHOA Rendering','custom',imread('spaticon.png'));
        return;
end

h = msgbox('Be sure that you are using a circular loudspeaker array.' ...
            ,'NFCHOA Rendering','custom',imread('spaticon.png'));

conf.nCoeffs = 128;

% ==============================================
% Use SFS-Toolbox format and functions
% ==============================================

% Secondary source positions
conf.sfs.x0 = zeros(conf.nLS,7);
conf.sfs.x0(:,1:3) = conf.LS.car.';

% Get direction of secondary sources
for n1 = 1:conf.nLS
    conf.sfs.x0(n1,4:6) = -conf.sfs.x0(n1,1:3)/norm(conf.sfs.x0(n1,1:3));
end

% Set weights
conf.sfs.x0(:,7) = ones(conf.nLS,1);

% Sound Field Synthesis General Configuration
conf.sfs.src = 'ps';                                % Source Type
conf.sfs.usetapwin = 1;                             % Use tapping window
conf.sfs.tapwinlen = 0.3;                           % Tap Winlength
conf.sfs.secondary_sources.geometry = 'circle';     % Secondary Source Geometry
conf.sfs.c = 343;                                   % Speed of sound
conf.sfs.xref = [0 0 0];                            % Amplitude Compensation Reference Point
conf.sfs.fs = conf.fs;                              % Sampling Frequency
conf.sfs.dimension = '2.5D';                        % Rendering dimension
conf.sfs.driving_functions = 'default';             % Driving function
conf.sfs.N = conf.nCoeffs;                          % IR length
conf.sfs.secondary_sources.center = [0 0 0];        % Center of geometry
conf.sfs.usefracdelay = 0;                          % Use fractional delay

% Near-Field Compensated Higher Order Ambisonics Parameters
conf.sfs.nfchoa.order = [];

