function [in_or_out_plane, normal_vector_plane, centroid, time_peak] = get_inlet_outlet_plane(segment, neighbour_segment, velocity_vector, n_timeframes)
    %% GET_INLET_OUTLET_PLANE - 
    % determines the plane at the intersection of two neighbouring 
    % segmentation masks
    %
    %% Input Arguments:
    % - segment (3D logical array) -
    %   the binary mask of the main region of interest
    %
    % - neighbour_segment (3D logical array)- 
    %   the binary mask of the neigbouring segment of the ROI
    %
    % - velocity_vector (4D array)- 
    %   the 4D velocity field data array 
    %
    % - n_timeframes (int): 
    %   number of timeframes in the velocity_vector input
    %
    %% Output Arguments:
    % - in_or_out_plane (3D logical array): 
    %   ToDo
    % 
    % - normal_vector_plane (array): 
    %   ToDo
    % 
    % - centroid (array): 
    %   ToDo
    % 
    % -time_peak (int): 
    %   ToDo
    %


    SE = ones(3); 
    DilatedNeighbour = imdilate(neighbour_segment, SE);

    plane = zeros(size(segment));
    plane(segment & DilatedNeighbour) = 1;

    slicepoint = regionprops3(plane, "Centroid");
    slicepoint = int32(slicepoint.Centroid);
    plane_centroid = [slicepoint(2), slicepoint(1), slicepoint(3)];

    time_peak_plane = find_time_peak_current_segment(plane, velocity_vector, n_timeframes);

    peakVx = velocity_vector(plane_centroid(1), plane_centroid(2), plane_centroid(3),1,time_peak_plane);
    peakVy = velocity_vector(plane_centroid(1), plane_centroid(2), plane_centroid(3),2,time_peak_plane);
    peakVz = velocity_vector(plane_centroid(1), plane_centroid(2), plane_centroid(3),3,time_peak_plane);

    plane_centroid = double(plane_centroid);

    plane_normal = [peakVx, peakVy, peakVz]/(sqrt(peakVx.^2 + peakVy.^2 + peakVz.^2));
    
    [X, Y] = ndgrid((1:size(plane,1)),(1:size(plane,2)));

    Z = plane_centroid(3) - ((plane_normal(1)*(X-plane_centroid(1)) + plane_normal(2)*(Y-plane_centroid(2)))/plane_normal(3));
    Z = round(Z);

    temp_plane = zeros(size(plane));
        for x = 1:size(plane,1)
            for y = 1:size(plane,2)
                for z = 1:size(plane,3)
                    if Z(x,y)==z
                        temp_plane(x,y,z)=1;
                    end
                end
            end
        end
    
    %% following code results in a smooth plane without gaps and holes
    stats = regionprops3(temp_plane, "ConvexImage");
    ConIm = stats.ConvexImage{1,1};

    stats = regionprops3(temp_plane, "BoundingBox");
    BoundBox = stats.BoundingBox; 

    ConShape = size(ConIm);
    SegmentShape = size(segment);

    Xcoord = BoundBox(2) + 0.5;
    Ycoord = BoundBox(1) + 0.5;
    Zcoord = BoundBox(3) + 0.5;


    %% ToDo: clean up the following if statements -> add a function for these operations (and same in get_apex_plane.m)
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
    temp_plane(ConIm & segment) = 1;

    in_or_out_plane = temp_plane; 
    normal_vector_plane = plane_normal;
    centroid = plane_centroid;
    time_peak = time_peak_plane;

end

