classdef GCheckbox < GUicontrol
    %GCheckbox cutomized checkbox uicontrol.
    %   Controls whether are source is active or not.
    
%     properties
%         Value; % Uicontrol tag.
%     end
    
    methods
        function obj = GCheckbox(parent, tag, bounds)  
            % Constructor.
            % parent - Parent figure.
            % tag - Uicontrol tag.
            % bounds - Uicontrol dimensions.
            
            % We call the superClass constructor:
            obj = obj@GUicontrol(parent, 'checkbox', '', tag, bounds);            
        end
    end
end