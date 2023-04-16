% This function executes the thinning algorithm described in Palagyi paper.
% It produces a topology conserving skeleton of an object.

% INPUT:
% X is the binary array which should be thinned
%
% OUTPUT:
% Y is the binary array with the thinned result
%
% Author: Erik Spaak

function Y = thinning(Binary)

Y = Binary;

U = [0 0 0  0 1 0  0 0 0  0 0 0  0 0  0 0 0  0 0 0  0 0 0  0 0 0];
D = [0 0 0  0 0 0  0 0 0  0 0 0  0 0  0 0 0  0 0 0  0 1 0  0 0 0];
N = [0 0 0  0 0 0  0 0 0  0 0 0  1 0  0 0 0  0 0 0  0 0 0  0 0 0];
S = [0 0 0  0 0 0  0 0 0  0 0 0  0 1  0 0 0  0 0 0  0 0 0  0 0 0];
E = [0 0 0  0 0 0  0 0 0  0 1 0  0 0  0 0 0  0 0 0  0 0 0  0 0 0];
W = [0 0 0  0 0 0  0 0 0  0 0 0  0 0  0 1 0  0 0 0  0 0 0  0 0 0];

disp('Centerline Extraction')



% "modified" is accumulating number of deleted points
modified = 1;
while(modified > 0)
    
%     disp(['Current number of Black points: ' num2str(sum(sum(sum(Y))))])
    
    modified = 0;   % number of deleted pixels
    [Y, modifiedIncr] = thinningSubiter(Y, U);
    modified = modified + modifiedIncr;
%     disp(['Remove ' num2str(modifiedIncr)]);
    
    [Y, modifiedIncr] = thinningSubiter(Y, D);
    modified = modified + modifiedIncr;
%     disp(['Remove ' num2str(modifiedIncr)]);
    
    [Y, modifiedIncr] = thinningSubiter(Y, N);
    modified = modified + modifiedIncr;
%     disp(['Remove ' num2str(modifiedIncr)]);
    
    [Y, modifiedIncr] = thinningSubiter(Y, S);
    modified = modified + modifiedIncr;
%     disp(['Remove ' num2str(modifiedIncr)]);
     
    [Y, modifiedIncr] = thinningSubiter(Y, E);
    modified = modified + modifiedIncr;
%   disp(['Remove ' num2str(modifiedIncr)]);
    
    [Y, modifiedIncr] = thinningSubiter(Y, W);
    modified = modified + modifiedIncr;
%     disp(['Remove ' num2str(modifiedIncr)]);


    
end

% points are removed if they remain simple and non-endpoints
%
% A black point {p} is a simple point if its deletion does not alter the
% topology of the image. If and only if all conditions hold:
% 1. p is not alone in (3x3x3 neigh.)
% 2. all black points are 26-connected 
% 3. p is a border point
% 4. all white points are 6-connectd in N18

function [Y, modified] = thinningSubiter(Y,direction)

dim = size(Y);

% define S6 and S26

% forward and backward 6-connectivity in N18
%S6{1} = [];
S6{2} = [5 11];
%S6{3} = 2;
S6{4} = [5 13];
S6{5} = [2 4 6 8];
S6{6} = [5 14];
%S6{7} = 4;
S6{8} = [5 16];
%S6{9} = [6 8];
S6{10} = [11 13];
S6{11} = [2 10 12 19];
S6{12} = [11 14];
S6{13} = [4 10 15 21];
S6{14} = [6 12 17 23];
S6{15} = [13 16];
S6{16} = [8 15 17 25];
S6{17} = [14 16];
%S6{18} = 10;
S6{19} = [11 22];
%S6{20} = [12 19];
S6{21} = [13 22];
S6{22} = [19 21 23 25];
S6{23} = [14 22];
%S6{24} = [15 21];
S6{25} = [16 22];
%S6{26} = [17 23 25];

% forward and backward 26-connectivity in N26
S26{1} = [1 2 4 5 10 11 13];
S26{2} = [1 3 4 5 6 10 11 12 13 14];
S26{3} = [2 5 6 11 12 14];
S26{4} = [1 2 5 7 8 10 11 13 15 16];
S26{5} = [1 2 3 4 6 7 8 9 10 11 12 13 14 15 16 17];
S26{6} = [2 3 5 8 9 11 12 14 16 17];
S26{7} = [4 5 8 13 15 16];
S26{8} = [4 5 6 7 9 13 14 15 16 17];
S26{9} = [5 6 8 14 16 17];
S26{10} = [1 2 4 5 11 13 18 19 21 22];
S26{11} = [1 2 3 4 5 6 10 12 13 14 18 19 20 21 22 23];
S26{12} = [2 3 5 6 11 14 19 20 22 23];
S26{13} = [1 2 4 5 7 8 10 11 15 16 18 19 21 22 24 25];
S26{14} = [2 3 5 6 8 9 11 12 16 17 19 20 22 23 25 26];
S26{15} = [4 5 7 8 13 16 21 22 24 25];
S26{16} = [4 5 6 7 8 9 13 14 15 17 21 22 23 24 25 26];
S26{17} = [5 6 8 9 14 16 22 23 25 26];
S26{18} = [10 11 13 19 21 22];
S26{19} = [10 11 12 13 14 18 20 21 22 23];
S26{20} = [11 12 14 19 22 23];
S26{21} = [10 11 13 15 16 18 19 22 24 25];
S26{22} = [10 11 12 13 14 15 16 17 18 19 20 21 23 24 25 26];
S26{23} = [11 12 14 16 17 19 20 22 25 26];
S26{24} = [13 15 16 21 22 25];
S26{25} = [13 14 15 16 17 21 22 23 24 26];
S26{26} = [14 16 17 22 23 25];

modified = 0;
list = [0 0 0];   % create empty list. Border points will be inserted here
elementsInList = 0;

Y(1,:,:) = 0; Y(dim(1),:,:) = 0; Y(:,1,:) = 0; Y(:,dim(2),:) = 0; Y(:,:,1) = 0; Y(:,:,dim(3)) = 0; % make all edges 0
Yindices = find(Y);

% PHASE 1: list simple points

for i = 1:length(Yindices)  % loop over all points
    
    [x0, y0, z0] = ind2sub(dim , Yindices(i));    % find point p
    Np26 = Y(x0-1:x0+1, y0-1:y0+1, z0-1:z0+1);    % collect neighborhood
    Np26 = reshape(Np26, 1, 27);    % reshape neighborhood
    Np26(14) = [];    % remove midpoint

    Np18 = Np26;    % Np18 is Np26 with corners "removed":
    Np18(1) = -1; Np18(3) = -1; Np18(7) = -1; Np18(9) = -1; Np18(18) = -1; Np18(20) = -1; Np18(24) = -1; Np18(26) = -1;
    
    Np6 = (-1)*ones(1,26);  % Np6 is the face-part of Np26
    for element = [5 11 13 14 16 22];
        Np6(element) = Np26(element);
    end

    if sum(direction.*Np26) == 0;  % if border point (condition 3)

        if sum(Np26) > 1 % if not end point (condition 1)

            % is simple if
            % 1. condition 2 true
            % 2. condition 4 true
            
            % condition 2
            condition2satisfied = 1;    % 1 by default. is changed to 0 in loop below if not true
            
            % label all the black points in N26: L = 1,2, ..., Nblackpoints
            label = 0;
            L = zeros(1,26);
            for m = 1:26;
                if Np26(m) == 1;
                    label = label + 1;
                    L(m) = label;
                end
            end

            labelSum1 = sum(L);
            labelSum2 = 0;
            while labelSum1 ~= labelSum2
                labelSum1 = sum(L);
                for m = find(L == label)
                    for j = S26{m}
                        if Np26(j) == 1
                            L(j) = label;
                        end
                    end
                end
                labelSum2 = sum(L);
            end

            for m = 1:26;
                if (Np26(m) == 1) && (L(m) ~= label);
                    condition2satisfied = 0;
                end
            end
            
            % condition 4
            condition4satisfied = 1;    % 1 by default. is changed to 0 in loop below if not true
            
            % label all the white points in Np6: 1,2, ..., Nwhitepoints
            label = 0;
            L = zeros(1,26);
            for m = 1:26;
                if Np6(m) == 0;
                    label = label + 1;
                    L(m) = label;
                end
            end

            labelSum1 = sum(L);
            labelSum2 = 0;
            while labelSum1 ~= labelSum2
                labelSum1 = sum(L);
                for m = find(L == label)
                    for j = S6{m}
                        if Np18(j) == 0
                            L(j) = label;
                        end
                    end
                end
                labelSum2 = sum(L);
            end

            for m = 1:26;
                if (Np6(m) == 0) && (L(m) ~= label);
                    condition4satisfied = 0;
                end
            end

            % if simple
            
%            condition2satisfied = 1;
%            condition4satisfied = 1;

            if condition2satisfied && condition4satisfied
                elementsInList = elementsInList + 1;
                list(elementsInList,:) = [x0 y0 z0];
            end
            
        end
        
    end
        

end


% PHASE 2:
% re-cheking procedure : each point in the list is removed if it remains
% simple and non-end-point in the actual (modified) image.
% disp(['In list ' num2str(size(list,1))])

if sum(sum(list)) ~= 0  % while there are points in the list

    for i = 1:size(list,1)  % loop over all points IN LIST
        
        x0 = list(i,1);
        y0 = list(i,2);
        
        z0 = list(i,3);

        Np26 = Y(x0-1:x0+1, y0-1:y0+1, z0-1:z0+1);    % collect neighborhood
        Np26 = reshape(Np26, 1, 27);    % reshape neighborhood
        Np26(14) = [];    % remove midpoint

        Np18 = Np26;    % Np18 is Np26 with cornenrs "removed":
        Np18(1) = -1; Np18(3) = -1; Np18(7) = -1; Np18(9) = -1; Np18(18) = -1; Np18(20) = -1; Np18(24) = -1; Np18(26) = -1;
    
        Np6 = (-1)*ones(1,26);  % Np6 is the face-part of Np26
        for element = [5 11 13 14 16 22];
            Np6(element) = Np26(element);
        end
    
        % border point check not needed
        
        if sum(Np26) > 1 % if not end point
            
            % is simple if
            % 1. condition 2 true
            % 2. condition 4 true
            
            % condition 2
            condition2satisfied = 1;    % 1 by default. is changed to 0 in loop below if not true
            
            label = 0;
            L = zeros(1,26);
            for m = 1:26;
                if Np26(m) == 1;
                    label = label + 1;
                     L(m) = label;          
                end
                
            end

            labelSum1 = sum(L);
            labelSum2 = 0;
            while labelSum1 ~= labelSum2
                labelSum1 = sum(L);
                for m = find(L == label)
                    for j = S26{m}
                        if Np26(j) == 1
                            L(j) = label;
                        end
                    end
                end
                labelSum2 = sum(L);
            end

            for m = 1:26;
                if (Np26(m) == 1) && (L(m) ~= label);
                    condition2satisfied = 0;
                end
            end
            
            % condition 4
            condition4satisfied = 1;    % 1 by default. is changed to 0 in loop below if not true
            
            % label all the white points in Np6: 1,2, ..., Nwhitepoints
            label = 0;
            L = zeros(1,26);
            for m = 1:26;
                if Np6(m) == 0;
                    label = label + 1;
                    L(m) = label;
                end
            end    

            labelSum1 = sum(L);
            labelSum2 = 0;
            while labelSum1 ~= labelSum2
                labelSum1 = sum(L);
                for m = find(L == label)
                    for j = S6{m}
                        if Np18(j) == 0
                            L(j) = label;
                        end
                    end
                end
                labelSum2 = sum(L);
            end

            for m = 1:26;
                if (Np6(m) == 0) && (L(m) ~= label);
                    condition4satisfied = 0;
                end
            end

            % if simple

%            condition2satisfied = 1;            
%            condition4satisfied = 1;

            if condition2satisfied && condition4satisfied
                Y(x0, y0, z0) = 0;
                modified = modified + 1;
            end
            
        end
    
    end
    
end