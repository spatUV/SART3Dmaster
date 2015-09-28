classdef GSimpleText < GUicontrol
    %GSimpleText is a customized text uicontrol.
    %   It is useful to show a text within the figure.
    
    methods
        function obj = GSimpleText(parent, string, tag, bounds)    
            % Constructor.
            % parent - Parent figure.
            % string - Text to include.
            % tag - Uicontrol tag.
            % bounds - Uicontrol dimension.
            
            % Call to SuperClass constructor:
            obj = obj@GUicontrol(parent, 'text', string, tag, bounds);
        end
    end 
end