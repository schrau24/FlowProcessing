function [time_peak] = find_time_peak_current_segment(plane, velocity_vector, n_timeframes)
    %% FIND_TIME_PEAK_CURRENT_SEGMENT - 
    % ToDo
    % 
    %
    %% Input Arguments:
    % - plane (3D logical array) -
    %   the binary mask of the region of interest
    %
    % - velocity_vector (4D array)- 
    %   the 4D velocity field data array 
    %
    % - n_timeframes (int): 
    %   number of timeframes in the velocity_vector input
    %
    %% Output Arguments:
    % - time_peak (int): 
    %   ToDo
    %


    Vmag = repmat(plane,[1 1 1 n_timeframes]).*squeeze(sqrt(sum(velocity_vector.^2,4)));
    idx = find(sum(plane,4));
    mean_velo = zeros(size(n_timeframes));
    for t = 1:n_timeframes
        tmp = Vmag(:,:,:,t);
        mean_velo(t) = mean(tmp(idx));
    end
    time_peak = find(mean_velo==max(mean_velo));
end