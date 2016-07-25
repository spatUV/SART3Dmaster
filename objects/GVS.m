classdef GVS < GUicontrol
    %GVS is a cutomized edit (text) uicontrol.
    %   It is used to depict a virtual source object. The user can interact
    %   with this uicontrol to move virtual sources in the scene.
    
    properties
        N;             % Corresonding virtual source index
        Coord;         % Spherical coordinates of the source.
                       % radius [m], azimuth [º], elevation [º].
        axes;          % handle to axes where the uicontrol is located
    end
    
    methods
        function obj = GVS(parent, string, tag, bounds, n, coord, view)
            % Constructor.
            % parent        - Parent figure.
            % string        - Text with value.
            % tag           - Label (to be used with guihandles).
            % bounds        - Uicontrol dimensions.
            % n             - Virtual source index.
            % coord         - Spherical coordinates of the source.
            
            % Call the SuperClass constructor:
            obj = obj@GUicontrol(parent, 'edit', string, tag, bounds, n);
            
            % Assign virtual source index and coordinates:
            obj.N = n;
            obj.Coord = coord;
            aux = guihandles(parent); 
            if strcmp(view,'plan')
                obj.axes = aux.axes_plan;
            end
            if strcmp(view,'profile')
                obj.axes = aux.axes_profile;
            end
            
            % Graphical aspects:
            color = [0.7 0.9 0.7];
            setBackgroundColor(obj, color);
            setForegroundColor(obj,'b');    % Blue foreground default
            setFontSize(obj, 12);           % Font size
        end
        
        function setCoord(obj, coord)
            % Changes the virtual source coordinates
            % obj - Reference to object.
            % coord - New source coordinates (overwrite the previous ones)

            obj.Coord = coord;
        end
        
        function coord = getCoord(obj)
            % Returns the source coordinates.
            % obj - Reference to object.
            
            coord = obj.Coord;
        end
        
        function n = getN(obj)
            % Returns the corresponding source index.
            % obj - Reference to object.
            
            n = obj.N;
        end
        
    end
end
    