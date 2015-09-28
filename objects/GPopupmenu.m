classdef GPopupmenu < GUicontrol
    %GImage is a customized pop-up menu uicontrol.
    %   It is used to select options from pop-up menus.
    
    properties
        Tag; % Uicontrol tag.
    end
    
    methods
        function obj = GPopupmenu(parent, string, value, tag, bounds)
            % Constructor.
            % parent - Parent figure.
            % string - Text with value.
            % value - Selected item.
            % tag - Tag (to be used with guihandles).
            % bounds - Uicontrol dimensions.
         
            % SuperClass constructor:
            obj = obj@GUicontrol(parent, 'popupmenu', string, tag, bounds);
            
            % Load properties:
            obj.Tag = tag;
                        
            % Set background color to white:
            setBackgroundColor(obj, 'w');
            
            % Set selected item:
            setValue(obj, value);
            

            
        end
        
        function callback(hObject, ~, ~)
            % Actions to performed when the object is selected.
            % hObject - Reference to selected object.

            % If the rendering method changes, we automatically reset
            % the filters to change instantly to the new method.
            if strcmp(hObject.Tag, 'pmMethod')
                global conf handles;
                
                % load GUI data
                data = guidata(getParent(hObject));
                guidata(getParent(hObject), data);
                
                % Set normal listener image
                GImage(gcf, '', get(handles.axes_plan,'Position'), (['guy_plan.png']));
                GImage(gcf, '', get(handles.axes_profile,'Position'), (['guy_profile.png']));
                
                switch conf.methods.names{get(handles.pmMethod, 'Value')}
                    case 'VBAP'
                        conf.nCoeffs = 1;
                        if isfield(conf,'VBAP')==0
                            VBAPstart;
                        end
                    case 'AAP'
                        conf.nCoeffs = 1;
                        if isfield(conf,'AAP')==0
                            AAPstart;
                        end
                    case 'HRTF'
                        conf.nCoeffs = 128;
                        % Set listener with headphones image
                        GImage(gcf, '', get(handles.axes_plan,'Position'), (['guy_plan_hp.png']));
                        GImage(gcf, '', get(handles.axes_profile,'Position'), (['guy_profile_hp.png']));
                        if isfield(conf,'HRIR')==0
                            HRTFstart;
                        end
                    case  'StTL'
                        conf.nCoeffs = 1;
                        if isfield(conf,'StTL')==0
                            StTLstart;
                        end                        
                    case  'StSL'
                        conf.nCoeffs = 1;
                        if isfield(conf,'StSL')==0
                            StSLstart;
                        end                        
                    case  'WFS'
                        conf.nCoeffs = 128;
                        if isfield(conf,'WFS')==0
                            WFSstart;
                        end                        
                    case  'NFCHOA'
                        conf.nCoeffs = 128;
                        if isfield(conf,'NFCHOA')==0
                            NFCHOAstart;
                        end 
                    otherwise
                        h = msgbox('Reproduction method not found' ...
                        ,'Error','custom',imread('spaticon.png'));
                        error('The selected reproduction method has not been defined.');
                        return;
                end            
                
                if exist('data')
                    if isfield(data,'H');
                        data.H = zeros(conf.nVS, conf.nLS, conf.nCoeffs);
                    end
                end
                
                % reset filtering objects
                data.Ho = cell(size(data.H));
                guidata(getParent(hObject), data);
                % initialize rendering objects
                for ii = 1:size(data.H,1)
                    gRefreshH(getParent(hObject), ii);
                end
            end            
        end
    end
end