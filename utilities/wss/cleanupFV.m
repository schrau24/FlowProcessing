function [F,V] = cleanupFV(F,V)
% removes unused vertices and changes faces accordingly
    F_unique = sort(unique(F(:)),'ascend');
    new_V = V(F_unique,:);
    
    new_F_indices = 1:length(F_unique);
    
    new_F = F;
    for i = 1:size(new_F_indices,1)
        new_F(F == F_unique(i)) = new_F_indices(i);
    end
    
    V = new_V;
    F = new_F;
end