function gDnDprofile(hObject, eventdata, datahit, VS, ~)
%GDNDPROFILE Drag and Drop callback used by the profile view GUI
%
% This function manages the user interaction in the profile view. 
%
% Input:
%    hObject   - Reference object (figure)
%    eventdata - (Reserved)
%    datahit   - Data structure needed by drag and drop, with fields
%        datahit.handles_plan      - handles to plan view figure  
%        datahit.boundsaxesplan    - bounds of axes in plan view 
%        datahit.LScar             - loudspeaker coordinates (in spherical)
%        datahit.handles_profile   - handles to profile view figure
%        datahit.boundsaxesprofile - bounds of axes in profile view 
%    VS        - Cell array of virtual source handles.
%
% See also: SART3D, gDnDplan, VSource

%*****************************************************************************
% Copyright (c) 2013-2016 Signal Processing and Acoustic Technology Group    *
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


handles = datahit.handles;
handles_plan = datahit.handles_plan;
handles_profile = datahit.handles_profile;
bounds_axes_profile = datahit.boundsaxesprofile;

LScar = datahit.LScar;
NLS = size(datahit.LScar,2);
activels = get(handles.checkBoxActive,'Value');

% ========================================================================
% Listen if pointer is on any virtual source object
% ========================================================================

hitsource = 0;
cObj = hittest(hObject);
if (isempty(get(cObj,'Tag'))==0)
    if strcmp(get(cObj,'Tag'),'textsVSProfile')
        hitsource = 1;
    end
end

if hitsource == 1
      ntouch = get(cObj,'value');
      set(handles_profile.textsVSProfile(ntouch), 'Enable', 'off'); % Deactivate text
      set(handles_profile.textsVSProfile(ntouch), 'ButtonDownFcn', @grab);
      setfigptr('hand', hObject);
      color = get(handles_profile.textsVSProfile(ntouch),'BackgroundColor'); 
else
      set(handles_profile.textsVSProfile(:), 'Enable', 'on'); %  Activate text
      setfigptr('arrow', hObject); % Set pointer to arrow
end

% ========================================================================
% Grab virtual source
% ========================================================================

function grab(~, ~)

    setfigptr('closedhand', hObject); % Closed-hand mouse pointer
    
    % Change color
    set(handles_plan.textsVS(ntouch), 'BackgroundColor', 'g');
    set(handles_profile.textsVSProfile(ntouch), 'BackgroundColor', 'g');
 
    set(handles.textsVSNumber(ntouch), 'BackgroundColor', [0.8 0.8 0.9]);
           
    % Virtual source object bounds 
    vSPosProfile = get(handles_profile.textsVSProfile(ntouch), 'Position');   
     
    % Synchronize movement
    mousePos = get(hObject, 'currentpoint'); % Mouse position
    
    % Mouse-Object Relative position :
    mouse_dx = mousePos(1)-vSPosProfile(1);
    mouse_dy = mousePos(2)-vSPosProfile(2);
    dtw = vSPosProfile(3)-mouse_dx;
    dth = vSPosProfile(4)-mouse_dy;
    
    % Save X position (will not change)
    X = str2double(get(handles.editsVSCar_1(ntouch), 'String'));
    
    % Drag & Release functions:
    set(hObject, 'WindowButtonMotionFcn', @drag);   
    set(hObject, 'WindowButtonUpFcn', @release);
    
    
    % Plot active loudspeakers in GUI
    if activels == 1
        rectarray = zeros(NLS,1);
        rectarrayprofile = zeros(NLS,1);
        lsize = 10/VS{1}.xyscale;
        for n = 1:NLS
            rectarray(n) = patch([LScar(1,n)-lsize LScar(1,n)-lsize LScar(1,n)-lsize+2*lsize LScar(1,n)-lsize+2*lsize],[LScar(2,n)-lsize LScar(2,n)-lsize+2*lsize LScar(2,n)-lsize LScar(2,n)-lsize+2*lsize ],'red','FaceColor','none','EdgeColor',[1 0 0],'Parent',handles_plan.axes_plan,'Visible', 'off');         
            rectarrayprofile(n) = patch([0 0 0 0],[LScar(2,n)-lsize LScar(2,n)-lsize LScar(2,n)-lsize+2*lsize LScar(2,n)-lsize+2*lsize],[LScar(3,n)-lsize LScar(3,n)-0.125+2*lsize LScar(3,n)-lsize LScar(3,n)-lsize+2*lsize ],'red','FaceColor','none','EdgeColor',[1 0 0],'Parent',handles_profile.axes_profile,'Visible','off');
        end
    end  

    function drag(hObject, ~)
           
            mousePos = get(hObject, 'currentpoint');
            mouse_x = mousePos(1); mouse_y = mousePos(2);
                          
            % Limit mouse to move within axes limits:
            if mouse_x <= (bounds_axes_profile(1) +mouse_dx)
                mouse_x = (bounds_axes_profile(1) +mouse_dx);
            elseif mouse_x >= (bounds_axes_profile(1) + bounds_axes_profile(3) -dtw)
                mouse_x = (bounds_axes_profile(1) + bounds_axes_profile(3)-dtw);
            end
            if mouse_y <= (bounds_axes_profile(2)+mouse_dy)
                mouse_y = (bounds_axes_profile(2)+mouse_dy);
            elseif mouse_y >= (bounds_axes_profile(2) + bounds_axes_profile(4)-dth)
                mouse_y = (bounds_axes_profile(2) + bounds_axes_profile(4)-dth);
            end
                       
            % Current coordinates:
            [Y, Z] = gCoords(mouse_x, mouse_y, bounds_axes_profile, VS{ntouch}.zyscale, 'profile');            
            
            % This "if" is used to limit processing (resolut. in movement)
            if norm([X;Y;Z]-datahit.lastp)>datahit.sres %spatial resolution in meters
                            
            datahit.lastp = [X;Y;Z];
            
            % This updates positions and refreshes rendering filters
            updateEdits(VS{ntouch}.editssph,[X,Y,Z].','car');
            

           %Plot active loudspeakers            
                if get(handles.checkBoxActive,'Value')                            
                  for n=1:NLS
                      if any(n == VS{ntouch}.renderer.Iactive)
                        set(rectarray(n),'Visible','on');
                        set(rectarrayprofile(n),'Visible','on');
                      else
                        set(rectarray(n),'Visible','off');
                        set(rectarrayprofile(n),'Visible','off');
                      end
                  end
                end
                       
           end    
    end
    
     %**** Release: ************************************
        function release(hObject, ~)
            setfigptr('hand', hObject); % Set open hand pointer
            
            % Change colors:
            set(handles_profile.textsVSProfile(ntouch), 'BackgroundColor', color);
            set(handles_plan.textsVS(ntouch), 'BackgroundColor', color);
            set(handles.textsVSNumber(ntouch), 'BackgroundColor', [0.94 0.94 0.94]);

            
            % Release circles of active loudspeakers
            if activels == 1;
                for n = 1:NLS
                    set(rectarray(n),'Visible','off');
                    set(rectarrayprofile(n),'Visible','off');
                end
            end
            
            set(hObject, 'WindowButtonMotionFcn',  @(hobj,eventdata) gDnDprofile(hobj, eventdata, datahit, VS)); % Give control to main function
            set(hObject, 'WindowButtonUpFcn', ''); % Do nothing when release button            
        end
        
end

end
    