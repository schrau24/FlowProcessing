function v_vwerp = v_to_vwerp_struct(v, dt, dx)
    %% v_to_vwerp_struct - 
    % ToDo
    % 
    %
    %% Input Arguments:
    % - v (4D array) - 
    %   the 4D velocity field data array, [v] = mm/s
    %
    % - dt (double) - 
    %   ToDo
    %
    % - dx (double) - 
    %   ToDo
    %
    %% Output Arguments:
    % - v_vwerp (struct) -
    %   ToDo, [v_vwerp] = m/s
    %


    v = pagemtimes(v, 0.001); % v from mm/s to m/s (app.v is in mm/s!!!! currV is in cm/s)
    v_vwerp = {struct, struct, struct};
    for i= 1:size(v_vwerp,2)
        v_vwerp{1,i}.im = squeeze(v(:,:,:,i,:));
        v_vwerp{1,i}.dt = dt/1000.;
        v_vwerp{1,i}.dx = dx/1000.;
        v_vwerp{1,i}.res = size(v_vwerp{1,i}.im);
    end
end