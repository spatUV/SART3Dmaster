classdef GEdit < GUicontrol
    %GEdit is a customized text uicontrol.
 
    properties
        N % Number of virtual source.
        Magnitude % Coordinate type (radius, azimuth, elevation, x, y, z).
        GVS % Related virtual source object (in plan view).
        GVSProfile % Related virtual source object (in profile view).
    end
    
    methods
        function obj = GEdit(parent, string, tag, bounds, n, magnitude, gVS, gVSProfile)
            % Constructor.
            % parent - Parent figure.
            % string - Text with value.
            % tag - Label (to be used with guihandles).
            % bounds - Uicontrol dimensions.
            % n - Number of virtual source.
            % Magnitude - Coordinate type.
            % gVS - Related virtual source object (plan view).
            % gVSProfile - Related virtual source object (profile view).
         
            % SuperClass constructor:
            obj = obj@GUicontrol(parent, 'edit', string, tag, bounds);
  
            % Load properties:
            obj.N = n;
            obj.Magnitude = magnitude;
            obj.GVS = gVS;
            obj.GVSProfile = gVSProfile;
                        
            % Graphical aspects:
            setBackgroundColor(obj, 'w'); % Default white
        end
        
        function callback(hObject, ~, ~)
            % Actions to performed when interacting with the object
            % hObject - Object reference
            
            % Load global variables needed:
            global conf handles 
            
            % Value in the EditText:
            value = str2double(getString(hObject));
            
            if isnumeric(value) % Numeric values
                if hObject.Magnitude == 1 % (1 corresponds to radius value edit)
                    
                    value = roundn(value, -3); % Round to 3 digits:
                    setString(hObject, num2str(value));
                    
                    if value < 0 || value > 2*conf.rMin % Permitted range
                        errordlg(['The value must be between 0 and ' num2str(2*conf.rMin) '.'], 'Error');
                        return;
                    end
                elseif hObject.Magnitude == 2 % (2 corresponds to azimuth)
                    
                    value = roundn(value, -1); % Round to 1 digit
                    setString(hObject, num2str(value));
                    
                    if value < -180 || value >= 360 % Check in range
                        errordlg('The value must be between -180 and 180 (or 0 and 360).', 'Error');
                        return;
                    end
                    
                elseif hObject.Magnitude == 3 % (3 corresponds to elevation)
                   
                    value = roundn(value, -1); % Round to 1 digit
                    setString(hObject, num2str(value));
                    
                    if value < -90 || value > 90 % Check in range
                        errordlg('The value must be between -90 and 90.', 'Error');
                        return;
                    end
                    
                else % hObject.Magnitude == 4,5 o 6 % Cartesian coords edits
                     
                    value = roundn(value, -2); % Rount to 2 decimal digits
                    setString(hObject, num2str(value));
                    
                    if value < -2*conf.rMin || value > 2*conf.rMin % Check in range
                        errordlg(['The value must be between -' num2str(2*conf.rMin) ' and ' num2str(2*conf.rMin) '.'], 'Error');
                        return;
                    end
                end
                
                % Once the values have been checked, we access data and
                % graphical objects in the GUI
                data = guidata(getParent(hObject));

                % GEdit (spherical coordinates):
                if hObject.Magnitude < 4
                    % Insert coordinate value in data
                    data.vSSph(hObject.Magnitude, hObject.N) = value;
                    
                    % Coordinates of the source:
                    r = data.vSSph(1, hObject.N);
                    theta = data.vSSph(2, hObject.N);
                    elevation = data.vSSph(3, hObject.N);
                    
                    % Update Cartesian coordinates edits (x,y,z)
                    vSCar = gSph2Car([r; theta; elevation]);
                    set(handles.editsVSCar_1(hObject.N), 'String', num2str(vSCar(1), 3));
                    set(handles.editsVSCar_2(hObject.N), 'String', num2str(vSCar(2), 3));
                    set(handles.editsVSCar_3(hObject.N), 'String', num2str(vSCar(3), 3));
                
                % GEdit (cartesian coordinates):
                else
                    % Coordinates of the source:
                    X = str2double(get(handles.editsVSCar_1(hObject.N), 'String'));
                    Y = str2double(get(handles.editsVSCar_2(hObject.N), 'String'));
                    Z = str2double(get(handles.editsVSCar_3(hObject.N), 'String'));

                    % Insert coordinates in GUI data (in spherical):
                    data.vSSph(:, hObject.N) = gCar2Sph([X, Y, Z]);
                    
                    % Coordinates in spherical:
                    r = data.vSSph(1, hObject.N);
                    theta = data.vSSph(2, hObject.N);
                    elevation = data.vSSph(3, hObject.N);

                    % Update Spherical coordinate edits
                    if strcmp(conf.viewSphEdits, 'on')
                        set(handles.editsVSSph_1(hObject.N), 'String', num2str(r, 3));
                        set(handles.editsVSSph_2(hObject.N), 'String', num2str(theta, 3));
                        set(handles.editsVSSph_3(hObject.N), 'String', num2str(elevation, 2));
                    end
                end
                
                % Load new coordinates into virtual source object
                % in plan view and profile view:
                setCoord(hObject.GVS, [r, theta, elevation]);
                setCoord(hObject.GVSProfile, [r, theta, elevation]);
                gSetSourcePos(handles.axes_plan, handles.axes_profile,...
                hObject.GVS, hObject.GVSProfile);

                % Set new virtual source object bounds
                % (for detecting pointer on virtual source object)
                vSPos = get(handles.textsVS(hObject.N), 'Position');
                vSPosProfile = get(handles.textsVSProfile(hObject.N), 'Position');
                data.VSxy(1,hObject.N) = vSPos(1) + vSPos(3)/2;
                data.VSxy(2,hObject.N) = vSPos(2) + vSPos(4)/2;
                data.VSyz(1,hObject.N) = vSPosProfile(1) + vSPosProfile(3)/2;
                data.VSyz(2,hObject.N) = vSPosProfile(2) + vSPosProfile(4)/2;
            
            
                % Save GUI data:
                guidata(getParent(hObject), data);
                
                % Update rendering filters:
                gRefreshH(getParent(hObject), hObject.N);
                                
            else % Not a numeric value
                errordlg('Introduce a numeric value.', 'Error');
            end
        end
    end
end