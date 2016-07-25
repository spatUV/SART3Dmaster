classdef GEdit < GUicontrol 
    %GEdit is a customized text uicontrol used in edit coordinate textboxes
 
    properties
        N               % Number of virtual source.
        Magnitude       % Coordinate type (radius, azimuth, elevation, x, y, z).
        VS              % Related VSource virtual source object.
        rmax            % Maximum radius value in GUI
        edithandles;    % Other GEdit edit textboxes handles
    end
    
    methods
        function obj = GEdit(parent, string, tag, bounds, n, magnitude, gVS, rmax)
            % Constructor.
            % parent        - Parent figure.
            % string        - Text with value.
            % tag           - Label (to be used with guihandles).
            % bounds        - Uicontrol dimensions.
            % n             - Number of virtual source.
            % Magnitude     - Coordinate type.
            % gVS           - Related virtual source object (plan view).
            % rmax          - Maximum radius value in GUI

         
            % SuperClass constructor:
            obj = obj@GUicontrol(parent, 'edit', string, tag, bounds, []);
  
            % Load properties:
            obj.N = n;
            obj.Magnitude = magnitude;
            obj.VS = gVS;
            obj.rmax = rmax;
                        
            % Graphical aspects:
            setBackgroundColor(obj, 'w'); % Default white
        end
        
        function saveHandles(hObject,fig)
            % Stores handles to other GEdit textboxes
            handles = guihandles(fig);
            hObject.edithandles.car1 = handles.editsVSCar_1;
            hObject.edithandles.car2 = handles.editsVSCar_2;
            hObject.edithandles.car3 = handles.editsVSCar_3;
            hObject.edithandles.sph1 = handles.editsVSSph_1;
            hObject.edithandles.sph2 = handles.editsVSSph_2;
            hObject.edithandles.sph3 = handles.editsVSSph_3;
        end
        
        function updateEdits(hObject,coords,system)
            % This is a very important function, the one that updates all
            % the required objects (coordinate edit boxes) and virtual
            % source location.
            % hObject - Reference object.
            % coords  - Coordinate vector.
            % system  - 'car' (Cartesian coordinates) or 'sph' (spherical)
            
            if strcmp(system,'car')
                set(hObject.edithandles.car1(hObject.N), 'String', num2str(coords(1), 3));
                set(hObject.edithandles.car2(hObject.N), 'String', num2str(coords(2), 3));
                set(hObject.edithandles.car3(hObject.N), 'String', num2str(coords(3), 3));
                coords = gCar2Sph(coords);
                set(hObject.edithandles.sph1(hObject.N), 'String', num2str(coords(1), 3));
                set(hObject.edithandles.sph2(hObject.N), 'String', num2str(coords(2), 3));
                set(hObject.edithandles.sph3(hObject.N), 'String', num2str(coords(3), 3));
                
                % Update Virtual Source Location in GUI
                updatePos(hObject.VS, coords.');
            elseif strcmp(system,'sph')
                set(hObject.edithandles.sph1(hObject.N), 'String', num2str(coords(1), 3));
                set(hObject.edithandles.sph2(hObject.N), 'String', num2str(coords(2), 3));
                set(hObject.edithandles.sph3(hObject.N), 'String', num2str(coords(3), 3));
                
                % Update Virtual Source Location in GUI
                updatePos(hObject.VS, coords.');
                coords = gSph2Car(coords); 
                set(hObject.edithandles.car1(hObject.N), 'String', num2str(coords(1), 3));
                set(hObject.edithandles.car2(hObject.N), 'String', num2str(coords(2), 3));
                set(hObject.edithandles.car3(hObject.N), 'String', num2str(coords(3), 3));
            end  
            % Update Renderer Filters
            updateRenderer(hObject.VS);   
        end
        
        function callback(hObject, ~, ~)
            % Actions to performed when interacting with the object
            % Checks the input 
            % hObject - Object reference
            
            % Value in the EditText:
            value = str2double(getString(hObject));
            
            if isnumeric(value) % Numeric values
                if hObject.Magnitude == 1 % (1 corresponds to radius value edit)
                    
                    value = roundn(value, -3); % Round to 3 digits:
                    setString(hObject, num2str(value));
                    
                    if value < 0 || value > hObject.rmax % Permitted range
                        errordlg(['The value must be between 0 and ' num2str(hObject.rmax) '.'], 'Error');
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
                    
                    if value < -hObject.rmax || value > hObject.rmax % Check in range
                        errordlg(['The value must be between -' num2str(hObject.rmax) ' and ' num2str(hObject.rmax) '.'], 'Error');
                        return;
                    end
                end
                
                % GEdit (spherical coordinates):
                if hObject.Magnitude < 4
                    % Insert coordinate value in object data
                    hObject.VS.coord(hObject.Magnitude) = value;
                    hObject.updateEdits(hObject.VS.coord.','sph')
                    
                % GEdit (cartesian coordinates):
                else
                    % Coordinates of the source:
                    X = str2double(get(hObject.edithandles.car1(hObject.N), 'String'));
                    Y = str2double(get(hObject.edithandles.car2(hObject.N), 'String'));
                    Z = str2double(get(hObject.edithandles.car3(hObject.N), 'String'));
                    
                    hObject.updateEdits([X Y Z].','car')              
                end
                                              
            else % Not a numeric value
                errordlg('Introduce a numeric value.', 'Error');
            end
        end
    end
end