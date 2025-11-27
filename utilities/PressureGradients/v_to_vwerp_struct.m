function v_vwerp = v_to_vwerp_struct(v, dt, dx)
    %% v_to_vwerp_struct - requires data to be cell format
    % Input Arguments:
    % - v (4D array) - 
    %   the 4D velocity field data array, [v] = mm/s
    % - dt (double) - in ms
    % - dx (double) - in mm

    % Output Arguments:
    % - v_vwerp (struct) - all converted (to m/s, s, and m)
    v = v*0.001; % v from mm/s to m/s
    v_vwerp = {struct, struct, struct};
    for i= 1:size(v_vwerp,2)
        v_vwerp{1,i}.im = squeeze(v(:,:,:,i,:));
        v_vwerp{1,i}.dt = dt/1000.; % in s
        v_vwerp{1,i}.dx = dx/1000.; % in m
        v_vwerp{1,i}.res = size(v_vwerp{1,i}.im);
    end
end