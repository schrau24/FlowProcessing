function status = recoverData(t, y, flag)
    persistent tempTraj % Keeps data between solver steps
    
    switch flag
        case 'init'
            tempTraj = []; % Clear for a new run
        case '' % Standard successful step
            % Append current time and position
            % y is typically a column vector; t can be a scalar or vector
            tempTraj = [tempTraj; t(:), y']; 
        case 'done'
            % Save to a global or base workspace variable when finished
            assignin('base', 'last_successful_path', tempTraj);
    end
    status = 0; % Required: 0 continues, 1 stops solver
end
