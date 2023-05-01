function [F,V] = SmoothLaplacian(F,V,iterations)
[~,IND_V]=patchIND(F,V);
[I,J,v] = find(IND_V);
L=0.1;
for i=1:iterations;
    Xp=accumarray({I,J},V(v,1),size(IND_V),[],NaN);
    Yp=accumarray({I,J},V(v,2),size(IND_V),[],NaN);
    Zp=accumarray({I,J},V(v,3),size(IND_V),[],NaN);
    Vp=[nanmean(Xp,2) nanmean(Yp,2) nanmean(Zp,2)];
    V =V+L.*(Vp-V);
end
% %%
% figure(7)
% patch('Faces',F,'Vertices',V,'FaceColor','red')
