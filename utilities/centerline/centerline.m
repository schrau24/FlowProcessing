% The function produces a centerline representation by labeling skeleton
% points as either,
% 1. end points = 1
% 2. middle/branch points = 2
% 3. junction points = 3
%
% The function initially labels all points according to the list above, and
% then remove spurs shorter than a specified length.
%
% The labels are stored both in matrix form (res*res*res), and in list
% form, List(x,y,z,label).
%
% The function then proceeds iteratively with a new labeling, followed by
% removal of additional spurs until no change longer occur in the skeleton.
%
% INPUT
% 1. Y is centerline in binary form
% 2. VMEAN.
% 3. spurLength is the length of spurs to be removed
% 4. sortingCriteria is criteria for branch sorting
%
% OUTPUT
% 1. CL is centerline with spurs removed and points classified
% 2. branchMat is branch indices & labels in matrix form
% 3. branchList is branch indices & labels in list form
% 4. branchTextList is accompaning text (number labels)
% 5. junctionMat is junction indices & labels in matrix form
% 6. junctionList is junction indices & labels in list form
%
% Author: Erik Spaak

function [CL, branchMat, branchList, branchTextList, junctionMat, junctionList] = centerline(Y, vMean, spurLength, sortingCriteria)

res = size(Y);
modified = 1;
Niter = 0;

% dilate & erode to "delete" big junctions
if 1
    se = ones(3,3,3);
    %se(1) = 0; se(3) = 0; se(7) = 0; se(9) = 0; se(19) = 0; se(21) = 0; se(25) = 0; se(27) = 0;
    X = imdilate(Y,se);
    %X2 = imdilate(X,se);
    %X3 = imdilate(X2,se);
    %Y3 = imerode(X3,se);
    %Y2 = imerode(Y3,se);
    Y = imerode(X,se);
    
%     disp('calculated dilated/eroded skeleton')
    
    Y = thinning(Y);
end

CL = 2*Y;

while modified > 0  && Niter < 20       % do until convergence
    
    Niter = Niter + 1;
    
%     disp(['CL-summa ' num2str(sum(sum(sum(CL))))])
    
    % deletion of branches
    if Niter > 1    % do after first iteration
        
        modified = 0;
        
        uniqueBranchLabels = unique(branchList(:,4));
        for i = 1:length(uniqueBranchLabels)

            currentBranchLabel = uniqueBranchLabels(i);
            currentBranchIndices = find(branchList(:,4) == currentBranchLabel);
            currentBranchLength = length(currentBranchIndices);
            
            connectedToJunctions = 0;
            
            for j = currentBranchIndices'
                x0 = branchList(j,1); y0 = branchList(j,2); z0 = branchList(j,3);
                connectedToJunctions = [connectedToJunctions; unique(junctionMat(x0-1:x0+1, y0-1:y0+1, z0-1:z0+1))];
            end

            connectedToJunctions = unique(connectedToJunctions);
            
            % delete branch if too short and not between two differently labeled junction points
            if (currentBranchLength) < spurLength && (length(connectedToJunctions) < 3)

                for j = currentBranchIndices'
                    CL(branchList(j,1), branchList(j,2), branchList(j,3)) = 0;
                end

                modified = modified + 1;

            end
        end

    end
    
    % classify skeleton points
    CL = 2*logical(CL);
    CLindices = find(CL);

    for i = 1:length(CLindices)

        [x0, y0, z0] = ind2sub(res, CLindices(i));

        % 26-neighborhood sum
        neighSum = sum(sum(sum(logical(CL(x0-1:x0+1, y0-1:y0+1, z0-1:z0+1)))));

        % mark junction points
        if neighSum > 3
            CL(CLindices(i)) = sortingCriteria;
        end

%         % mark endpoints
%         if neighSum < 3
%             CL(CLindices(i)) = 1;
%         end
    end

    % list junction points
    junctionIndices = find(CL == 3);
    [x0, y0, z0] = ind2sub(res, junctionIndices);
    junctionMat = zeros(res);    % label matrix
    junctionList = [x0 y0 z0 zeros(length(x0), 1)];    % label vector

    % label junctions

    label = 0;
    for i = 1:length(x0)
        
        if junctionList(i,4) == 0
            label = label + 1;
            junctionMat(x0(i), y0(i), z0(i)) = label;
            junctionList(i,4) = label;

            investigatePointsList = [x0(i) y0(i) z0(i)];

            labeled = 1;

            while labeled > 0   % while still collecting points under this label
                
                labeled = 0;
                newInvestigativePointsList = [];
                
                for j = 1:length(investigatePointsList(:,1))

                    x1 = investigatePointsList(j,1);
                    y1 = investigatePointsList(j,2);
                    z1 = investigatePointsList(j,3);

                    % collect 26-neighborhoods
                    label26 = junctionMat(x1-1:x1+1, y1-1:y1+1, z1-1:z1+1);
                    antiLabel26 = logical((logical(label26) - 1));
                    CL26 = CL(x1-1:x1+1, y1-1:y1+1, z1-1:z1+1);

                    neigh = find(CL26.*antiLabel26 == 3);   % find neighboring middle points not labeled
                    [x2, y2, z2] = ind2sub([3 3 3], neigh);

                    x3 = x1 + x2 - 2;
                    y3 = y1 + y2 - 2;
                    z3 = z1 + z2 - 2;

                    for k = 1:length(x3)
                        
                        junctionMat(x3(k), y3(k), z3(k)) = label;
                        
                        a = find(junctionList(:,1) == x3(k));
                        b = find(junctionList(:,2) == y3(k));
                        c = find(junctionList(:,3) == z3(k));
                        d = intersect(a,b);
                        e = intersect(c,d);

                        junctionList(e,4) = label;
                        
                        labeled = labeled + 1;  % count how many points collected under current label
                        
                    end
                    
                    newInvestigativePointsList = [newInvestigativePointsList; x3 y3 z3];
                    
                end

                investigatePointsList = newInvestigativePointsList;
                
            end
            
        end
        
    end

    % list middle points
    branchIndices = find(CL == 2);
    [x0, y0, z0] = ind2sub(res, branchIndices);
    branchMat = zeros(res);    % label matrix
    branchList = [x0 y0 z0 zeros(length(x0), 2)];    % label vector

    % label branches

    branchTextList = zeros(0,4);
    label = 0;
    for i = 1:length(x0)
        
        if branchList(i,4) == 0
            
            label = label + 1;
            branchMat(x0(i), y0(i), z0(i)) = label;
            branchList(i,4) = label;
            
            branchTextList = [branchTextList; x0(i) y0(i) z0(i) label]; % create a textlist
            
            investigatePointsList = [x0(i) y0(i) z0(i)];

            labeled = 1;
                 incrementer = 0;    
            while labeled > 0   % while still collecting points under this label
                
                labeled = 0;
                newInvestigativePointsList = [];

           
                for j = 1:length(investigatePointsList(:,1))

                    x1 = investigatePointsList(j,1);
                    y1 = investigatePointsList(j,2);
                    z1 = investigatePointsList(j,3);

                    % collect 26-neighborhoods
                    label26 = branchMat(x1-1:x1+1, y1-1:y1+1, z1-1:z1+1);
                    antiLabel26 = logical((logical(label26) - 1));
                    CL26 = CL(x1-1:x1+1, y1-1:y1+1, z1-1:z1+1);

                    neigh = find(CL26.*antiLabel26 == 2);   % find neighboring middle points not labeled
                    [x2, y2, z2] = ind2sub([3 3 3], neigh);
                    
                    x3 = x1 + x2 - 2;
                    y3 = y1 + y2 - 2;
                    z3 = z1 + z2 - 2;

                    incrementer = incrementer + 1;
                    
                    for k = 1:length(x3)
                        
                        branchMat(x3(k), y3(k), z3(k)) = label;
                        
                        a = find(branchList(:,1) == x3(k));
                        b = find(branchList(:,2) == y3(k));
                        c = find(branchList(:,3) == z3(k));
                        d = intersect(a,b);
                        e = intersect(c,d);

                        branchList(e,4) = label;
                        
                        % sorting
                        aa = find(branchList(:,1) == x1);
                        bb = find(branchList(:,2) == y1);
                        cc = find(branchList(:,3) == z1);
                        dd = intersect(aa,bb);
                        ee = intersect(cc,dd);

                        if branchList(ee,5) == 0 && k == 1
                            
                            branchList(e,5) = 1;
                            
                        elseif branchList(ee,5) == 0 && k == 2
                            
                            branchList(e,5) = -1;  
                            
                        elseif branchList(ee,5) > 0
                            
                            branchList(e,5) = branchList(ee,5) + 1;
                            
                        elseif branchList(ee,5) < 0
                            
                            branchList(e,5) = branchList(ee,5) - 1;
                        end


                        labeled = labeled + 1;  % count how many points collected under current label
                        
                    end
                    
                    newInvestigativePointsList = [newInvestigativePointsList; x3 y3 z3];
                    
                end
                
                investigatePointsList = newInvestigativePointsList;
                
            end
   
        end
        
    end
   
end
%%
% sort the branchList so that
% 1. all the same labels are connected along the rows
% 2. low -> high row index is in the same direction as the flow
labels = unique(branchList(:,4));
branchListSorted = zeros(0,5);

beginSegment = 8;

for i = 1:length(labels)

    % find branch
    branchActual = branchList(branchList(:,4) == labels(i), :);
    branchActual = sortrows(branchActual, 5);

    % check if a -> b is in the direction of the flow...
    if size(branchActual,1) < beginSegment
        
        v0x = 0; v0y = 0; v0z = 0;
        for j = 1:size(branchActual, 1)
            v0x = v0x + vMean(branchActual(j,1), branchActual(j,2), branchActual(j,3), 1);
            v0y = v0y + vMean(branchActual(j,1), branchActual(j,2), branchActual(j,3), 2);
            v0z = v0z + vMean(branchActual(j,1), branchActual(j,2), branchActual(j,3), 3);
        end
        
        isReverse = dot(double(branchActual(end, 1:3) - branchActual(1, 1:3)), double([v0x v0y v0z]));
    else
        
        v0x = 0; v0y = 0; v0z = 0;
        for j = 1:beginSegment%size(branchActual, 1)
            v0x = v0x + vMean(branchActual(j,1), branchActual(j,2), branchActual(j,3), 1);
            v0y = v0y + vMean(branchActual(j,1), branchActual(j,2), branchActual(j,3), 2);
            v0z = v0z + vMean(branchActual(j,1), branchActual(j,2), branchActual(j,3), 3);
        end
        
        isReverse = dot(double(branchActual(beginSegment, 1:3) - branchActual(1, 1:3)), double([v0x v0y v0z]));
    end

    % ...if not, reverse
    if isReverse < 0
        branchActual = flipud(branchActual);
    end

    branchListSorted = [branchListSorted; branchActual];

end

branchList = branchListSorted;

for n = 1:max(branchList(:,4));
    branchActual = branchList(branchList(:,4)==n,:);
    if size(branchActual,1)<9 % Could be Spurlength
        branchList(branchList(:,4)==n,:) = [];
    else
    end
end

%Adjust brachList to be increasing numerically 

LabBL = branchList(:,4);
[~,c,~]=unique(LabBL,'last');
bORDER = LabBL(sort(c));

bListtemp = [];
for n = 1:numel(bORDER)
    branchActual = branchList(branchList(:,4)==bORDER(n),:);
    branchActual(:,4) = n;
    bListtemp = [bListtemp;branchActual];
end
branchList = bListtemp;
