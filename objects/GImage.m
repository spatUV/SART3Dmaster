classdef GImage < GUicontrol
    %GImage is a customized pushbutton uicontrol.
    %   It places a given image in the GUI on a given location
    
    properties
        Image; % Image to show
    end
    
    methods
        function obj = GImage(parent, tag, bounds, res)
            % Constructor.
            % parent - Parent figure.
            % tag - Tag (to be used with guihandles).
            % bounds - Uicontrol dimensions.
            % res - Resource (image) to include.
                       
            % Get height and width of image:
            image = imread(res); %
            [h, w, ~] = size(image); % height, width ()

            x = bounds(1)+bounds(3)/2-w/2; % Calculate x
            y = bounds(2)+bounds(4)/2-h/2; % Calculate y

            % Set bounds to place the image in the center:
            bounds = [x, y, w, h];
            
            % SuperClass constructor:
            obj = obj@GUicontrol(parent, 'pushbutton', '', tag, bounds);

            % Place image:
            setImage(obj, image);
            
            % Avoid that it could be selected:
            setHitTest(obj, 'off');
            
            % Set inactive:
            setEnabled(obj, 'inactive');
            
            % Load property:
            obj.Image = image;
        end
    end 
end