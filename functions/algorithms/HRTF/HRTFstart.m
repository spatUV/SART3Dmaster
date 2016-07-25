function [HRTFdata,enabled] = HRTFstart(LSsph)

%=====================
% HRTF Initialization
%=====================

% Required number of loudspeakers
HRTFdata.rNLS = 2;

% Check if the number of required loudspeakers (headphones) is two
NLS = size(LSsph,2);

if NLS ~= HRTFdata.rNLS
    warning('HRTF: There should be only 2 loudspeakers for HRTF reproduction.');
    enabled = 0;
    return;
end
   
% Load HRIR filenames and directions
load ('HRIRdata.mat');
HRTFdata.dir = HRIRdir;
HRTFdata.dirc = gSph2Car(HRIRdir);

% Load into method data (head-related impulse responses)
Ndir = size(HRIRdir,2);
HRTFdata.IR = cell(Ndir,1);
for n = 1:Ndir
    HRTFdata.IR{n} =  audioread(HRIRfilenames{n});
end

% Minimum rendered distance
HRTFdata.rmin = 1;

% Save filter length
HRTFdata.L = length(HRTFdata.IR{1});

% Set method enabled
enabled = 1;