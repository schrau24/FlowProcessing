function [binary_plane] = get_binary_plane_from_coords(centroid_coords, normal, segment)
    %% GET_BINARY_PLANE_FROM_COORDS - 
    % ToDo
    % 
    %
    %% Input Arguments:
    % - centroid_coords (ToDo) -
    %       ToDo
    %
    % - normal (array) - 
    %       ToDo
    %
    % - segment (3D logical array) - 
    %       number of timeframes in the velocity_vector input
    %
    %% Output Arguments:
    % - binary_plane (3D logical array) - 
    %       ToDo
    %

    centroid_coords = double(centroid_coords);
    [X, Y] = ndgrid((1:size(segment,1)),(1:size(segment,2)));

    Z = centroid_coords(3) - ((normal(1)*(X-centroid_coords(1)) + normal(2)*(Y-centroid_coords(2)))/normal(3));
    Z = round(Z);

    temp_plane = zeros(size(segment));
        for x = 1:size(segment,1)
            for y = 1:size(segment,2)
                for z = 1:size(segment,3)
                    if Z(x,y)==z
                        temp_plane(x,y,z)=1;
                    end
                end
            end
        end

    stats = regionprops3(temp_plane, "ConvexImage");
    ConIm = stats.ConvexImage{1,1};
    ConShape = size(ConIm);
    SegmentShape = size(segment);

    stats = regionprops3(temp_plane, "BoundingBox");
    BoundBox = stats.BoundingBox;    

    Xcoord = BoundBox(2) + 0.5;
    Ycoord = BoundBox(1) + 0.5;
    Zcoord = BoundBox(3) + 0.5;

    if Xcoord ~= 1
        Xcoord = Xcoord -1;
        ResizingGrid = ndgrid(1:Xcoord, 1:ConShape(2), 1:ConShape(3));
        ResizingIm = zeros(size(ResizingGrid));
        ConIm = cat(1, ResizingIm, ConIm);
        ConShape = size(ConIm);
    end
    if ConShape(1) ~= SegmentShape(1)
        ResizeLength = SegmentShape(1)-ConShape(1);
        ResizingGrid = ndgrid(1:ResizeLength, 1:ConShape(2), 1:ConShape(3));
        ResizingIm = zeros(size(ResizingGrid));
        ConIm = cat(1, ConIm, ResizingIm);
        ConShape = size(ConIm);
    end
    if Ycoord ~= 1
        Ycoord = Ycoord -1;
        ResizingGrid = ndgrid(1:ConShape(1), 1:Ycoord, 1:ConShape(3));
        ResizingIm = zeros(size(ResizingGrid));
        ConIm = cat(2, ResizingIm, ConIm);
        ConShape = size(ConIm);
    end
    if ConShape(2) ~= SegmentShape(2)
        ResizeLength = SegmentShape(2)-ConShape(2);
        ResizingGrid = ndgrid(1:ConShape(1), 1:ResizeLength, 1:ConShape(3));
        ResizingIm = zeros(size(ResizingGrid));
        ConIm = cat(2, ConIm, ResizingIm);
        ConShape = size(ConIm);
    end
    if Zcoord ~= 1
        Zcoord = Zcoord -1;
        ResizingGrid = ndgrid(1:ConShape(1), 1:ConShape(2), 1:Zcoord);
        ResizingIm = zeros(size(ResizingGrid));
        ConIm = cat(3, ResizingIm, ConIm);
        ConShape = size(ConIm);
    end
    if ConShape(3) ~= SegmentShape(3)
        ResizeLength = SegmentShape(3)-ConShape(3);
        ResizingGrid = ndgrid(1:ConShape(1), 1:ConShape(2), 1:ResizeLength);
        ResizingIm = zeros(size(ResizingGrid));
        ConIm = cat(3, ConIm, ResizingIm);
        ConShape = size(ConIm);
    end
    
    temp_plane = zeros(size(segment));
    temp_plane = temp_plane + ConIm;

    temp_plane2 = zeros(size(segment));
    temp_plane2(temp_plane & segment) = 1;
    binary_plane = temp_plane2; 
end