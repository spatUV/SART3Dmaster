classdef VSource < handle
    % VSource SART3D Virtual Source Class
    %   This object stores all the important properties and handles related
    %   to a given virtual source in the scene.
    properties
        index           % Index of the virtual source
        name            % Name
        coord           % Coordinates (in spherical)
        filename        % Filename
        method          % Handles to rendering method data
        renderer        % Structure with corresponding active loudspeakers and filtering objects
        boxplan         % Handles to GVS object (user box interaction) in plan view
        boxprofile      % Handles to GVS object (user box interaction) in profile view
        xyscale         % pixel to meter scaling factor in plan view
        zyscale         % pixel to meter scaling factor in profile view
        editssph        % Handles to corresponding Cartesian coordiates edit text boxes in main GUI 
        editscar        % Handles to corresponding spherical coordiates edit text boxes in main GUI 
        change          % Indicates "1" when the renderer has has been updated.
    end

    methods
        function obj = VSource(sindex, sname, scoord, sfilename)
            % Constructor (source index, source name, spherical coordinates, filename)
            obj.index = sindex;
            obj.name  = sname;
            obj.coord = scoord;
            obj.filename = sfilename;
        end
        function setCoord(obj, scoord)
            % Changes the virtual source coordinate property
            % obj - Reference to object.
            % scoord - New source coordinates (overwrite the previous ones)
            obj.coord = scoord;
        end
        
        function coord = getCoord(obj)
            % Returns the source coordinates.
            % obj - Reference to object.
            coord = obj.coord;
        end
        
        function n = getIndex(obj)
            % Returns the corresponding source index.
            % obj - Reference to object.            
            n = obj.index;
        end
        
        function setMethod(obj, method)
            % Stores a handle to a rendering method object
            % obj    - Reference to object.
            % method - Handle to rendering method object.
            obj.method = method;            
        end                
                
        function createRenderer(obj, SamplesPerFrame, NLS)
            % Creates filter objects for virtual source
            % obj              - Reference to object.
            % SamplesPerFrame  - Samples per Frame
            % NLS              - Number of loudspeakers 
            
            obj.renderer.Filters = cell(NLS,1);
            for n = 1:NLS
                obj.renderer.Filters{n} = GfftFIRm(SamplesPerFrame,zeros(obj.method.data.L,1));
                obj.renderer.Iactive = [];
            end
        end
        
        function updateRenderer(obj)
            % Updates the rendering filters for the object
            % obj - Reference to object
            
            % Get new filters and active loudspeakers
            [H,I] = gRefreshH(obj);
            for n = 1:length(I)
                UpdateFilter(obj.renderer.Filters{I(n)},H(:,n));
                obj.renderer.Iactive = I;
                obj.renderer.change  = 1;
            end
        end

        function createBox(obj, sGVS, view, scale)
            % Stores a handle to a GVS object (interaction uicontrol) in
            % plan or profile view.
            % obj    - Reference to object
            % sGVS   - Handle to GVS object
            % view   - view 'plan' or 'profile'
            % scale  - pixel to meter scaling
            if strcmp(view,'plan')
                obj.boxplan = sGVS;
                obj.xyscale = scale;
            elseif strcmp(view,'profile')
                obj.boxprofile = sGVS;
                obj.zyscale = scale;
            end  
        end
        
        function coordEdits(obj, sEdits, system)
            % Stores a handle to a coordinate edit box in GUI
            % obj    - Reference to object.
            % sEdits - Handle to edit box
            % system - 'car' or 'sph', depending wheter it is a Cartesian
            % or spherical edit.
           
            if strcmp(system, 'car')
                obj.editscar = sEdits;
            elseif strcmp(system, 'sph')
                obj.editssph = sEdits;
            end
        end
        
        function updatePos(obj, newpos)
            % Updates the position of the virtual source, setting new
            % coordinates and changing the interaction boxes accordingly.
            % obj    - Reference to object.
            % newpos - New position.
            setCoord(obj,newpos);            
            setCoord(obj.boxplan,newpos);            
            gSetSourcePos(obj.xyscale, obj.boxplan,'plan');
            if isempty(obj.boxprofile)==0
                setCoord(obj.boxprofile,newpos);            
                gSetSourcePos(obj.zyscale, obj.boxprofile,'profile');
            end    
        end
        
    end
end