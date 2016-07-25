classdef RMethod < handle
    % RMethod SART3D Rendering method object
    %   This object stores all the important properties needed by a
    %   rendering method
    properties
        type        % Type (name) of rendering method
        data        % Data needed by the method
        enabled     % "1" if the method is available, else "0"
    end
    methods
        function obj = RMethod(mtype, LSsph)
            % Constructor
            obj.type = mtype;
            [obj.data, obj.enabled] = methodInit(mtype, LSsph);
        end
    end
end