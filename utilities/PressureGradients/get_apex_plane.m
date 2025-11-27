function [apex_plane, apex_normal, centroid_coords_apex] = get_apex_plane(ventricle_segment, boundary_normal, TP_centroid, PV_centroid)
    %% GET_APEX_PLANE - 
    % ToDo
    % 
    %
    %% Input Arguments:
    % - ventricle_segment (3D logical array) -
    %    the binary mask of the region of interest
    %
    % - boundary_normal (array) - 
    %   ToDo 
    %
    % - TP_centroid (array) -
    %   ToDo
    %   
    % - PV_centroid (array) -
    %   ToDo
    %
    %% Output Arguments:
    % - apex_plane (3D logical array) - 
    %   ToDo
    %
    % - apex_normal (array) - 
    %   ToDo
    %
    %% NB: current code is working for the right ventricle
    %



    voxels_apex = regionprops3(ventricle_segment, "VoxelList");
    voxels_apex = voxels_apex{1,1}{1,1};

    apex_x = max(voxels_apex(:,2)); % away from both TPx and PVx
    apex_y = round(mean([min(voxels_apex(:,1)), min(PV_centroid(2), TP_centroid(2))])); % somewhere between the most anterior voxel of RV and the centroid of PV or TV
    apex_z = round(mean([min(voxels_apex(:,3)), min(PV_centroid(3), TP_centroid(3))])); % somewhere between the most left voxel of the RV and the centroid location of the most left valve
    apex_centroid = [apex_x, apex_y, apex_z];

    apex_im = zeros(size(ventricle_segment));
    apex_im(apex_centroid(1), apex_centroid(2), apex_centroid(3)) = 1;
    
    search_radius = 3; 
    while ~ismember(1, unique((apex_im & ventricle_segment)))
        se = strel("sphere", search_radius); 
        apex_im = imdilate(apex_im, se);
        search_radius = search_radius + 1;
    end

    apex_Ventr = zeros(size(ventricle_segment));
    apex_Ventr(apex_im & ventricle_segment) = 1;

    centroid_apex = regionprops3(apex_Ventr, "Centroid");
    centroid_apex = int32(centroid_apex.Centroid);
    centroid_coords_apex = [centroid_apex(2), centroid_apex(1), centroid_apex(3)];

    apex_plane = get_binary_plane_from_coords(centroid_coords_apex, boundary_normal, ventricle_segment);
    apex_normal = boundary_normal;
end