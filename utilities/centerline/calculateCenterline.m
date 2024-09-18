function path = calculateCenterline(binaryVolume, startPoint, endPoint, originalCenterline)
    % Initialize path with the starting point
    path = startPoint;
    currentPoint = startPoint;
    previousPoint = [];
    originalCenterlineStart = round(originalCenterline(1, :));
    originalCenterlineEnd = round(originalCenterline(end, :));
    
    % Approach the original start point
    while ~isequal(currentPoint, originalCenterlineStart)
        % Get the neighboring points of the current point within the binary volume
        neighbors = getNeighbors(currentPoint);
        validNeighbors = isPointInsideVolume(neighbors, binaryVolume);
        
        % Exclude already chosen points and bias selection towards the direction of the previous point
        if ~isempty(previousPoint)
            validNeighbors = validNeighbors & ~ismember(neighbors, path, 'rows');
            directionVector = originalCenterlineStart - previousPoint;
            directionVector = directionVector / norm(directionVector);
            directionCosine = (neighbors - currentPoint) * directionVector';
            validNeighbors(directionCosine < 0) = false;  % Exclude points opposite to the direction
        end
        
        % Check if the endPoint is among the valid neighbors
        if any(ismember(neighbors, originalCenterlineStart, 'rows'))
            % If the endPoint is a valid neighbor, set nextPoint to be endPoint
            nextPoint = originalCenterlineStart;
        else
            % Find the neighbor with the smallest Euclidean distance to the ending point among valid neighbors
            minDistance = inf;
            nextPoint = [];
            for i = 1:size(neighbors, 1)
                if validNeighbors(i)
                    neighbor = neighbors(i, :);
                    distance = norm(neighbor - originalCenterlineStart);
                    if distance < minDistance
                        minDistance = distance;
                        nextPoint = neighbor;
                    end
                end
            end
        end
        
        % Add the next point to the path
        path = [path; nextPoint];
        
        % plotting help
        % create a new figure, half-screen
        fig = figure(199); clf
        fig.Units = 'normalized';
        fig.Position = [0.0005    0.0380    0.4990    0.8833];
        
        hpatch = patch(isosurface(binaryVolume,0.05),'FaceAlpha',0.25);
        set(hpatch, 'FaceColor', 'k', 'EdgeColor', 'none');
        
        lighting( 'gouraud');
        lightangle( 0,0);
        axis('off','tight')
        view( [0 0 -1]);
        daspect([1 1 1]);
        % % overlay current centerline
        hline2 = line(path(:,2), path(:,1), path(:,3),...
            'Color','g','Marker','.','MarkerSize',12,'LineStyle','none','PickableParts','none');
        pause
        
        % Update current and previous points
        previousPoint = currentPoint;
        currentPoint = nextPoint;
    end
    
    % add in original centerline
    path = [path; originalCenterline];
    currentPoint = originalCenterlineEnd;
    
%     % plotting help
%     % create a new figure, half-screen
%     fig = figure(199); clf
%     fig.Units = 'normalized';
%     fig.Position = [0.0005    0.0380    0.4990    0.8833];
%     
%     hpatch = patch(isosurface(binaryVolume,0.05),'FaceAlpha',0.25);
%     set(hpatch, 'FaceColor', 'k', 'EdgeColor', 'none');
%     
%     lighting( 'gouraud');
%     lightangle( 0,0);
%     axis('off','tight')
%     view( [0 0 -1]);
%     daspect([1 1 1]);
%     % % overlay current centerline
%     hline2 = line(path(:,2), path(:,1), path(:,3),...
%         'Color','g','Marker','.','MarkerSize',12,'LineStyle','none','PickableParts','none');
%     pause
            
    % Perform region growing until reaching the ending point
    while ~isequal(currentPoint, endPoint)
        % Get the neighboring points of the current point within the binary volume
        neighbors = getNeighbors(currentPoint);
        validNeighbors = isPointInsideVolume(neighbors, binaryVolume);
        
        % Exclude already chosen points and bias selection towards the direction of the previous point
        if ~isempty(previousPoint)
            validNeighbors = validNeighbors & ~ismember(neighbors, path, 'rows');
            directionVector = endPoint - previousPoint;
            directionVector = directionVector / norm(directionVector);
            directionCosine = (neighbors - currentPoint) * directionVector';
            validNeighbors(directionCosine < 0) = false;  % Exclude points opposite to the direction
        end
        
        % Check if the endPoint is among the valid neighbors
        if any(ismember(neighbors, endPoint, 'rows'))
            % If the endPoint is a valid neighbor, set nextPoint to be endPoint
            nextPoint = endPoint;
        else
            % Otherwise, find the neighbor with the smallest Euclidean distance to the ending point
            minDistance = inf;
            for i = 1:size(neighbors, 1)
                if validNeighbors(i)
                    neighbor = neighbors(i, :);
                    distance = norm(neighbor - endPoint);
                    if distance < minDistance
                        minDistance = distance;
                        nextPoint = neighbor;
                    end
                end
            end
        end
        
        % Add the next point to the path
        path = [path; nextPoint];
        
%         % plotting help
%         % create a new figure, half-screen
%         fig = figure(199); clf
%         fig.Units = 'normalized';
%         fig.Position = [0.0005    0.0380    0.4990    0.8833];
%         
%         hpatch = patch(isosurface(binaryVolume,0.05),'FaceAlpha',0.25);
%         set(hpatch, 'FaceColor', 'k', 'EdgeColor', 'none');
%         
%         lighting( 'gouraud');
%         lightangle( 0,0);
%         axis('off','tight')
%         view( [0 0 -1]);
%         daspect([1 1 1]);
%         % % overlay current centerline
%         hline2 = line(path(:,2), path(:,1), path(:,3),...
%             'Color','g','Marker','.','MarkerSize',12,'LineStyle','none','PickableParts','none');
%         pause
        
        % Update current and previous points
        previousPoint = currentPoint;
        currentPoint = nextPoint;
    end
    
    % Remove duplicate points from the path
    path = unique(path, 'rows', 'stable');
end

function neighbors = getNeighbors(point)
% Define the 26-connected neighborhood in 3D
    offsets = [-1, -1, -1; -1, -1, 0; -1, -1, 1; -1, 0, -1; -1, 0, 0; -1, 0, 1; -1, 1, -1; -1, 1, 0; -1, 1, 1;
                0, -1, -1; 0, -1, 0; 0, -1, 1; 0, 0, -1; 0, 0, 1; 0, 1, -1; 0, 1, 0; 0, 1, 1;
                1, -1, -1; 1, -1, 0; 1, -1, 1; 1, 0, -1; 1, 0, 0; 1, 0, 1; 1, 1, -1; 1, 1, 0; 1, 1, 1];
    
    % Compute neighbors' coordinates
    neighbors = repmat(point, size(offsets, 1), 1) + offsets;
end

function valid = isPointInsideVolume(point, binaryVolume)
    % Check if each point is inside the binary volume
    valid = false(size(point, 1), 1);
    for i = 1:size(point, 1)
        x = point(i, 1);
        y = point(i, 2);
        z = point(i, 3);
        if x >= 1 && x <= size(binaryVolume, 1) && ...
           y >= 1 && y <= size(binaryVolume, 2) && ...
           z >= 1 && z <= size(binaryVolume, 3) && ...
           binaryVolume(x, y, z)
            valid(i) = true;
        end
    end
end
