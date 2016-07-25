function [NFCHOAdata, enabled] = NFCHOAstart(LSsph)

%=====================
% NFCHOA Initialization
%=====================

NFCHOAdata.rNLS = [];

NFCHOAdata.L = 128;

% Minimum loudspeaker distance
NFCHOAdata.rmin = min(LSsph(1,:));

% ==============================================
% Use SFS-Toolbox format and functions
% ==============================================

% Check that SFS Toolbox is installed
if isempty(which('SFS_start'));
    warning('NFCHOA: SFS Toolbox not found. Please, install it and add it to path.');
    enabled = 0;
    return;
end

% Check that setup corresponds to a circular array
if range(LSsph(1,:))~=0 || range(LSsph(3,:))~=0 || range(diff(sort(wrapTo360(LSsph(2,:)))))
    warning('NFCHOA: The loudspeaker configuration does not match a circular array');
    enabled = 0;
    return;
end

NLS = size(LSsph,2);
LScar = gSph2Car(LSsph);

% Secondary source positions
NFCHOAdata.x0 = zeros(NLS,7);
NFCHOAdata.x0(:,1:3) = LScar.';

% Get direction of secondary sources
for n1 = 1:NLS
    NFCHOAdata.x0(n1,4:6) = -NFCHOAdata.x0(n1,1:3)/norm(NFCHOAdata.x0(n1,1:3));
end

% Set weights
NFCHOAdata.x0(:,7) = ones(NLS,1);

% Sound Field Synthesis General Configuration
NFCHOAdata.src = 'ps';                                % Source Type
NFCHOAdata.usetapwin = 1;                             % Use tapping window
NFCHOAdata.tapwinlen = 0.3;                           % Tap Winlength
NFCHOAdata.secondary_sources.geometry = 'circle';     % Secondary Source Geometry
NFCHOAdata.c = 343;                                   % Speed of sound
NFCHOAdata.xref = [0 0 0];                            % Amplitude Compensation Reference Point
NFCHOAdata.fs = 44100;                                % Sampling Frequency
NFCHOAdata.dimension = '2.5D';                        % Rendering dimension
NFCHOAdata.driving_functions = 'default';             % Driving function
NFCHOAdata.N = NFCHOAdata.L;                          % IR length
NFCHOAdata.secondary_sources.center = [0 0 0];        % Center of geometry
NFCHOAdata.usefracdelay = 0;                          % Use fractional delay

% Near-Field Compensated Higher Order Ambisonics Parameters
NFCHOAdata.nfchoa.order = [];

enabled = 1;
