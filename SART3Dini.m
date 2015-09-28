function SART3Dini()
%%SART3DINI initializes the 3D Spatial Audio Rendering Toolbox
%
% Usage:
%   SART3Dini;
%
% This function adds the required folders to Matlab's path.
%
% See also: SART3D, gConfig


rootfolder = which('SART3Dini');
rootfolder = rootfolder(1:end-12);

addpath(rootfolder);
addpath(genpath([rootfolder,'\audioscenes']));
addpath([rootfolder,'\configurations']);
addpath(genpath([rootfolder,'\functions']));
addpath([rootfolder,'\gui_elements']);
addpath([rootfolder,'\images']);
addpath([rootfolder,'\objects']);
addpath([rootfolder,'\setups']);
