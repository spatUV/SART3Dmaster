function gDnD(hObject, ~)
%GDND Main drag and drop source positioning function used by the GUI
%
% This function manages the user interaction both in the plan and profile
% views. 

%*****************************************************************************
% Copyright (c) 2013-2015 Signal Processing and Acoustic Technology Group    *
%                         SPAT, ETSE, Universitat de València                *
%                         46100, Burjassot, Valencia, Spain                  *
%                                                                            *
% This file is part of the SART3D: 3D Spatial Audio Rendering Toolbox.       *
%                                                                            *
% SART3D is free software:  you can redistribute it and/or modify it  under  *
% the terms of the  GNU  General  Public  License  as published by the  Free *
% Software Foundation, either version 3 of the License,  or (at your option) *
% any later version.                                                         *
%                                                                            *
% SART3D is distributed in the hope that it will be useful, but WITHOUT ANY  *
% WARRANTY;  without even the implied warranty of MERCHANTABILITY or FITNESS *
% FOR A PARTICULAR PURPOSE.                                                  *
% See the GNU General Public License for more details.                       *
%                                                                            *
% You should  have received a copy  of the GNU General Public License  along *
% with this program.  If not, see <http://www.gnu.org/licenses/>.            *
%                                                                            *
% SART3D is a toolbox for real-time spatial audio prototyping that lets you  *
% move in real time virtual audio sources from a set of WAV files using      *
% multiple spatial audio rendering methods.                                  *
%                                                                            *
% https://github.com/spatUV/SART3Dmaster                  maximo.cobos@uv.es *
%*****************************************************************************

global conf v handles ntouch lastp hplot_plan hplot_profile

% Load data from GUI
data = guidata(hObject);

bounds_axes = [v.axes_plan_x, v.axes_plan_y, v.axes_plan_w, v.axes_plan_h];
bounds_axes_profile = [v.axes_profile_x, v.axes_profile_y, v.axes_profile_w, v.axes_profile_h];

%% Listen if pointer is on any virtual source object

% Get mouse position
pos = get(hObject, 'currentpoint');  

% Perform hit test on plan view
DistVS = data.VSxy - repmat(pos.',1,conf.nVS);
DistVS = sqrt(DistVS(1,:).^2 + DistVS(2,:).^2);
HitVS  = (DistVS<10);

% Perform hit test on profile view
DistVS_profile = data.VSyz - repmat(pos.',1,conf.nVS);
DistVS_profile = sqrt(DistVS_profile(1,:).^2 + DistVS_profile(2,:).^2);
HitVS_profile  = (DistVS_profile<10);

planv = 0;
profv = 0;
if sum(HitVS>0) % Pointer touching a source in plan view
    planv = 1;
elseif sum(HitVS_profile>0) % Pointer touching a source in profile view
    profv = 1;
end

if planv == 1
      ntouch = find(HitVS==1,1); 
      set(handles.textsVS(ntouch), 'Enable', 'off'); % Deactivate text
      set(handles.textsVS(ntouch), 'ButtonDownFcn', @grab);
      setfigptr('hand', hObject);
      color = get(handles.textsVS(ntouch),'BackgroundColor'); 
else
      set(handles.textsVS(:), 'Enable', 'on'); %  Activate text
end

if profv == 1
    ntouch = find(HitVS_profile==1,1);
    set(handles.textsVSProfile(ntouch), 'Enable', 'off'); % Deactivate text
    set(handles.textsVSProfile(ntouch), 'ButtonDownFcn', @grabProfile);
    setfigptr('hand', hObject);
    color = get(handles.textsVS(ntouch),'BackgroundColor'); 
else
    set(handles.textsVSProfile(:), 'Enable', 'on'); %  Activate text
end

if planv == 0 && profv ==0
    setfigptr('arrow', hObject); % Set pointer to arrow
end

%% Grab virtual source
     
function grab(vSHandle, ~)

    setfigptr('closedhand', hObject); % Closed-hand mouse pointer
    
    % Change color
    set(handles.textsVS(ntouch), 'BackgroundColor', 'g');
    set(handles.textsVSProfile(ntouch), 'BackgroundColor', 'g');
    set(handles.textsVSNumber(ntouch), 'BackgroundColor', [0.8 0.8 0.9]);
           
    % Virtual source object bounds 
    vSPos = get(handles.textsVS(ntouch), 'Position');
    vSPosProfile = get(handles.textsVSProfile(ntouch), 'Position');
        
    % Synchronize movement
    mousePos = get(hObject, 'currentpoint'); % Mouse position
    
    % Coordinate center ir profile view axes:
    y_0_profile = v.axes_profile_x+v.axes_profile_w/2-vSPosProfile(3)/2;
    z_0_profile = v.axes_profile_y+v.axes_profile_h/2-vSPosProfile(4)/2;
        
    % Mouse-Object Relative position :
    mouse_dx = mousePos(1)-vSPos(1);
    mouse_dy = mousePos(2)-vSPos(2);
    dtw = vSPos(3)-mouse_dx;
    dth = vSPos(4)-mouse_dy;
    
    % Save Z position (will not change)
    Z = str2double(get(handles.editsVSCar_3(ntouch), 'String'));
    
    % Drag & Release functions:
    set(hObject, 'WindowButtonMotionFcn', @drag);   
    set(hObject, 'WindowButtonUpFcn', @release);
        
    function drag(hObject, ~)
           
            mousePos = get(hObject, 'currentpoint');
            mouse_x = mousePos(1); mouse_y = mousePos(2);
                          
            % Limit mouse to move within axes limits:
            if mouse_x <= (v.axes_plan_x+mouse_dx)
                mouse_x = (v.axes_plan_x+mouse_dx);
            elseif mouse_x >= (v.axes_plan_x+v.axes_plan_w-dtw)
                mouse_x = (v.axes_plan_x+v.axes_plan_w-dtw);
            end
            if mouse_y <= (v.axes_plan_y+mouse_dy)
                mouse_y = (v.axes_plan_y+mouse_dy);
            elseif mouse_y >= (v.axes_plan_y+v.axes_plan_h-dth)
                mouse_y = (v.axes_plan_y+v.axes_plan_h-dth);
            end
                       
            % Current coordinates:
            [X, Y] = gCoords(mouse_x, mouse_y, bounds_axes, conf.axes.xy_scale, 'plan');
            
            
            % This "if" is used to limit processing (resolut. in movement)
            if norm([X;Y;Z]-lastp)>conf.sres %spatial resolution in meters
                            
            % Correct and set object to new position:
            vSPos = [mouse_x-mouse_dx, mouse_y-mouse_dy, vSPos(3), vSPos(4)];
            set(handles.textsVS(ntouch), 'Position', vSPos); 
            
            lastp = [X;Y;Z];
                                                
            % Set virtual source object in profile view:
            vSPosProfile = [y_0_profile+Y*conf.axes.xy_scale,...
                 z_0_profile+Z*conf.axes.xy_scale,...
                 vSPosProfile(3), vSPosProfile(4)];
            set(handles.textsVSProfile(ntouch), 'Position', vSPosProfile);
             
            % Update positions
            data.vSSph(:,ntouch) = gCar2Sph([X,Y,Z]);
           
            % Update text boxes with spherical positions;
            if strcmp(conf.viewSphEdits, 'on')
                % Radius
                set(handles.editsVSSph_1(ntouch),...
                'String', num2str(data.vSSph(1, ntouch), 3));
                % Azimuth
                set(handles.editsVSSph_2(ntouch),...
                'String', num2str(data.vSSph(2, ntouch), 3));
            end
           
            % Note: Elevation is not modified in this view
               
            % Modify text boxes with new position
            set(handles.editsVSCar_1(ntouch), 'String', num2str(X, 2));
            set(handles.editsVSCar_2(ntouch), 'String', num2str(Y, 2));
                    
            %============== RENDERING ALGORITHM CALL ======================
            % Refresh gains: (gRefresh also saves GUI data) 
            guidata(hObject, data);
            gRefreshH(hObject, ntouch);
            data = guidata(hObject);
            %guidata(hObject, data); % Save GUI data 
            
            % Plot active loudspeakers            
            if get(handles.checkBoxActive,'Value')
             axes(handles.axes_plan);  
             delete(hplot_plan);
             active = conf.LS.car(1:3,logical(data.I(ntouch,:)));
             hplot_plan = plot(active(1,:),active(2,:),'or','MarkerSize',20);
             axes(handles.axes_profile);
             delete(hplot_profile')            
             hplot_profile = plot3(active(1,:),active(2,:),active(3,:),'or','MarkerSize',20);
            end
                       
            end
             
    end    
    
    %**** Release: ************************************
        function release(hObject, ~)
            setfigptr('hand', hObject); % Set open hand pointer
            
            % Change colors:
            set(handles.textsVS(ntouch), 'BackgroundColor', color);
            set(handles.textsVSProfile(ntouch), 'BackgroundColor', color);
            set(handles.textsVSNumber(ntouch), 'BackgroundColor', v.bgColor);

            % Set new virtual source object bounds            
            data.VSxy(1,ntouch) = vSPos(1) + vSPos(3)/2;
            data.VSxy(2,ntouch) = vSPos(2) + vSPos(4)/2;
            data.VSyz(1,ntouch) = vSPosProfile(1) + vSPosProfile(3)/2;
            data.VSyz(2,ntouch) = vSPosProfile(2) + vSPosProfile(4)/2;

            % Save GUI data
            guidata(hObject, data); 
            
            % Release circles of active loudspeakers
            if conf.plot.activels == 1;
             delete(hplot_plan);
             delete(hplot_profile);
            end
            
            set(hObject, 'WindowButtonMotionFcn', @gDnD); % Give control to main function
            set(hObject, 'WindowButtonUpFcn', ''); % Do nothing when release button            
        end
        
end

 %% Profile View Movements:
    % Grab in Profile View:
    function grabProfile(vSHandle, ~)
       
        setfigptr('closedhand', hObject); % Set closed hand pointer
        
        % Change colors:        
        set(handles.textsVS(ntouch), 'BackgroundColor', 'g');
        set(handles.textsVSProfile(ntouch), 'BackgroundColor', 'g');
        set(handles.textsVSNumber(ntouch), 'BackgroundColor', [0.8 0.8 0.9]);
        
        % Synchronize movement
        mousePos = get(hObject, 'currentpoint'); % Mouse position
        
        % Virtual source objects bounds
        vSPos = get(handles.textsVS(ntouch), 'Position');
        vSPosProfile = get(handles.textsVSProfile(ntouch), 'Position');
        
        % Axes centers:
        x_0 = v.axes_plan_x+v.axes_plan_w/2-vSPos(3)/2;
        y_0 = v.axes_plan_y+v.axes_plan_h/2-vSPos(4)/2;
        
        % Mouse-Object Relative positions:
        mouse_dxProfile = mousePos(1)-vSPosProfile(1);
        mouse_dyProfile = mousePos(2)-vSPosProfile(2);
        dtwProfile = vSPosProfile(3)-mouse_dxProfile;
        dthProfile = vSPosProfile(4)-mouse_dyProfile;
        
        % Save X position (will not change)
        X = str2double(get(handles.editsVSCar_1(ntouch), 'String'));

        % Drag & Release:
        set(hObject, 'WindowButtonMotionFcn', @dragProfile);   
        set(hObject, 'WindowButtonUpFcn', @releaseProfile);
        
        %Drag:
        function dragProfile(hObject, ~)

            mousePos = get(hObject, 'currentpoint'); 
            mouse_x = mousePos(1); mouse_y = mousePos(2);
            
            % Limit pointer within axes:
            if mouse_x <= (v.axes_profile_x+mouse_dxProfile)
                mouse_x = (v.axes_profile_x+mouse_dxProfile);
            elseif mouse_x >= (v.axes_profile_x+v.axes_profile_w-dtwProfile)
                mouse_x = (v.axes_profile_x+v.axes_profile_w-dtwProfile);
            end
            if mouse_y <= (v.axes_profile_y+mouse_dyProfile)
                mouse_y = (v.axes_profile_y+mouse_dyProfile);
            elseif mouse_y >= (v.axes_profile_y+v.axes_profile_h-dthProfile)
                mouse_y = (v.axes_profile_y+v.axes_profile_h-dthProfile);
            end
            
            % Get current coordinates:
            [Y, Z] = gCoords(mouse_x, mouse_y, bounds_axes_profile,...
                conf.axes.xy_scale, 'profile');
            
            % This "if" is used to limit processing (resolut. in movement)
            if norm([X;Y;Z]-lastp)>conf.sres %spatial resolution in meters
            
            % Correct and set object to new position:
            vSPosProfile = [mouse_x-mouse_dxProfile, mouse_y-mouse_dyProfile, vSPosProfile(3), vSPosProfile(4)];
            set(handles.textsVSProfile(ntouch), 'Position', vSPosProfile); 
                      
            lastp = [X;Y;Z];
            
            % Position the source in plan view:
            vSPos = [x_0+X*conf.axes.xy_scale,...
                 y_0+Y*conf.axes.xy_scale,...
                 vSPos(3), vSPos(4)];
            set(handles.textsVS(ntouch), 'Position', vSPos); 
                                    
             % Update positions
             data.vSSph(:,ntouch) = gCar2Sph([X,Y,Z]);
           
             if strcmp(conf.viewSphEdits, 'on')
                % radius
                set(handles.editsVSSph_1(ntouch),...
                'String', num2str(data.vSSph(1, ntouch), 3));
                % azimuth
                set(handles.editsVSSph_2(ntouch),...
                'String', num2str(data.vSSph(2, ntouch), 3));
                % elevation
                set(handles.editsVSSph_3(ntouch),...
                'String', num2str(data.vSSph(3, ntouch), 3));
             end
        

             % Modify text boxes with new positions
             set(handles.editsVSCar_2(ntouch), 'String', num2str(Y, 2));
             set(handles.editsVSCar_3(ntouch), 'String', num2str(Z, 2));
             
            %============== RENDERING ALGORITHM CALL ====================== 
            % Refresh gains: (gRefresh also saves GUI data) 
            guidata(hObject, data);
            gRefreshH(hObject, ntouch);
            data = guidata(hObject);
            %guidata(hObject, data); % Save GUI data            
                      
             % Plot active loudspeakers
             if conf.plot.activels == 1;
             axes(handles.axes_plan);  
             delete(hplot_plan);
             active = conf.LS.car(1:3,logical(data.I(ntouch,:)));
             hplot_plan = plot(active(1,:),active(2,:),'or','MarkerSize',20);
             axes(handles.axes_profile);
             delete(hplot_profile')
             hplot_profile = plot3(active(1,:),active(2,:),active(3,:),'or','MarkerSize',20);
             end

            end
                        
        end
        
     %**** Release: ************************************
        function releaseProfile(hObject, ~)
            
            setfigptr('hand', hObject); % Open hand pointer
            
            % Change colors:
            set(handles.textsVS(ntouch), 'BackgroundColor', color);
            set(handles.textsVSProfile(ntouch), 'BackgroundColor', color);
            set(handles.textsVSNumber(ntouch), 'BackgroundColor', v.bgColor);

             % Set new virtual source object bounds            
            data.VSxy(1,ntouch) = vSPos(1) + vSPos(3)/2;
            data.VSxy(2,ntouch) = vSPos(2) + vSPos(4)/2;
            data.VSyz(1,ntouch) = vSPosProfile(1) + vSPosProfile(3)/2;
            data.VSyz(2,ntouch) = vSPosProfile(2) + vSPosProfile(4)/2;
                               
            
            % Save GUI data
            guidata(hObject, data); 
            
            % Release circles of active loudspeakers
            if conf.plot.activels == 1;
            delete(hplot_plan);
            delete(hplot_profile);
            end
            
            set(hObject, 'WindowButtonMotionFcn', @gDnD); % Give control to main function
            set(hObject, 'WindowButtonUpFcn', ''); % Do nothing when release button            
            
            
            
        end
        
    end

end

