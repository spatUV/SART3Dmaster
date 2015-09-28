%=====================
% HRTF Initialization
%=====================

if conf.nLS > 2
    error('There should be only 2 loudspeakers for HRTF-based reproduction.');
end

% load scripts for HRTF reproduction:
hrir_fileNames;                         % Database wavefile names
hrir_posSph;                            % Corresponding directions (spherical)
hrir_posCar;                            % Corresponding directions (Cartesian)

% Read impulse responses
% Since conf.HRIR.fileNames is a cell array, we cast to char
conf.iR = {1, length(conf.HRIR.fileNames)};
for ii = 1:length(conf.HRIR.fileNames)
    conf.iR{ii} = audioread(char(conf.HRIR.fileNames(ii)));
end

% Number of coefficients:
conf.nCoeffs = length(conf.iR{ii});

% Set listener with headphones image
%GImage(gcf, '', get(handles.axes_plan,'Position'), (['guy_plan_hp.png']));
%GImage(gcf, '', get(handles.axes_profile,'Position'), (['guy_profile_hp.png']));
