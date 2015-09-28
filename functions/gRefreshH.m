function gRefreshH(hObject, ii)
%GREFRESHH Updates the filter corresponding to a selected source.
%
% This function is very important, since it is the one that calls a specific
% rendering method and obtains the filter coefficients and contributing
% loudspeakers for achieving the rendering of a virtual source.
%
% The function is called initially by SART3D and is modified whenever a 
% virtual source is moving (called by gDnD).
%
% The input parameters are:
%   hObject - Handle of the GUI to load the corresponding data.
%
%   ii - Index of the source that is being updated.
%
% See also: gDnD, SART3D

global conf handles

% Load data from GUI
data = guidata(hObject);

%*************************************************************************
% CALL TO RENDERING METHOD
%*************************************************************************
% Methods should return a matrix H [nCoeffs x length(I)] with
% the filtering coefficients for each of the loudspeakers contributing
% to the rendering and specified in vector I.
switch conf.methods.names{get(handles.pmMethod, 'Value')}
    case 'VBAP'
        pc = gSph2Car(data.vSSph(:,ii));
        [H, I] = gVBAP(pc, data.vSSph(1,ii));
       
    case 'HRTF'
        [H, I] = gHRTF(data.vSSph(:,ii));
        
    case 'AAP'
        [H, I] = gAAP(data.vSSph(2,ii));
        
    case 'StTL'
        [H,I] = gStTL(data.vSSph(:,ii));
    
    case 'StSL'
        [H,I] = gStSL(data.vSSph(:,ii));
    
    case 'WFS'
        [H,I] = gWFS(data.vSSph(:,ii));
    
    case 'NFCHOA'
        [H,I] = gNFCHOA(data.vSSph(:,ii));
    % INCLUDE HERE MORE CASES FOR NEW RENDERING METHODS!    
    otherwise
    h = msgbox('Reproduction method not found' ...
            ,'Error','custom',imread('spaticon.png'));
    error('The selected reproduction method has not been defined.');
end

if isempty(I)
    setfigptr('forbidden');
else
    setfigptr('closedhand');
end

% Loudspeakers that will change their rendering
data.I(ii,I) = 1;
Ichange = find(data.I(ii,:)==1);
% Set active loudspeakers for source ii
data.I(ii,:) = 0;
data.I(ii,I) = 1;

% Update filter matrix
data.H(ii,:,:) = zeros(1,conf.nLS,conf.nCoeffs);
if isempty(I)==0
data.H(ii,I,:) = reshape(H.',1,length(I),conf.nCoeffs);
end

% Update filtering for each of the changing loudspeakers
for jj = 1:length(Ichange)
    % When objects are created for the first time
    if isempty(data.Ho{ii,Ichange(jj)})        
        data.Ho{ii,Ichange(jj)} = GfftFIRm(conf.SamplesPerFrame,squeeze(data.H(ii,Ichange(jj),:)));
    end
    UpdateFilter(data.Ho{ii,Ichange(jj)},squeeze(data.H(ii,Ichange(jj),:)));
end

% Save GUI data
guidata(hObject, data); 



end