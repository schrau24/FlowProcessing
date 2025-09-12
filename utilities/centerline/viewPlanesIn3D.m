function viewPlanesIn3D(ax, Tangent_V, planeWidth, branchActual)

% This will find a normalized vector perpendicular to the tangent vector
[~,idx_max] = max(abs(Tangent_V),[],2);
idx_max(idx_max==2) = 1;
max_pts = sub2ind(size(Tangent_V),[1:size(Tangent_V,1)]',idx_max);
temp = zeros(size(Tangent_V));
temp(max_pts) = 1;
[~,idx_shift] = max(abs(circshift(temp,1,2)),[],2);
shift_pts = sub2ind(size(Tangent_V),[1:size(Tangent_V,1)]',idx_shift);
V2 = zeros(size(Tangent_V));
V2(max_pts) = Tangent_V(shift_pts);
V2(shift_pts) = -Tangent_V(max_pts);
N = repmat(sqrt(sum(abs(V2).^2,2)),[1 3]);
V2 = V2./N;
%Third vector that is normalized
V3 = cross(Tangent_V,V2);

% Get the full tangent plane for all the points
Side = planeWidth;
width = Side.*2+1; %width of plane in pixels
Mid = zeros(length(branchActual),1);

% Find x Values on line
temp = repmat(V2(:,1),[1 Side]);
Test = cumsum(temp,2);
Test2 = -fliplr(Test);
x_val = [Test2 Mid Test];
x_val = bsxfun(@plus,x_val,branchActual(:,1));
x_val = reshape(x_val,[numel(x_val) 1]);

% Find y Values on line
temp = repmat(V2(:,2),[1 Side]);
Test = cumsum(temp,2);
Test2 = -fliplr(Test);
y_val = [Test2 Mid Test];
y_val = bsxfun(@plus,y_val,branchActual(:,2));
y_val = reshape(y_val,[numel(y_val) 1]);

% Find z values on the line
temp = repmat(V2(:,3),[1 Side]);
Test = cumsum(temp,2);
Test2 = -fliplr(Test);
z_val = [Test2 Mid Test];
z_val = bsxfun(@plus,z_val,branchActual(:,3));
z_val = reshape(z_val,[numel(z_val) 1]);

% At this point the x,y,z values have created a tanget line in
% the perpedicular plane to the normal vector for all centerline points.
% Find x Values on plane
Mid = zeros(length(branchActual)*(Side*2+1),1);
temp = repmat(V3(:,1),[(Side*2+1) Side]);
Test = cumsum(temp,2);
Test2 = -fliplr(Test);
x_full = [Test2 Mid Test];
x_full = bsxfun(@plus,x_full,x_val);
x_full = reshape(x_full,[length(branchActual)*(Side.*2+1).^2,1]);

% Find x Values on plane
temp = repmat(V3(:,2),[(Side*2+1) Side]);
Test = cumsum(temp,2);
Test2 = -fliplr(Test);
y_full = [Test2 Mid Test];
y_full = bsxfun(@plus,y_full,y_val);
y_full = reshape(y_full,[length(branchActual)*(Side.*2+1).^2,1]);

% Find  Values on plane
temp = repmat(V3(:,3),[(Side*2+1) Side]);
Test = cumsum(temp,2);
Test2 = -fliplr(Test);
z_full = [Test2 Mid Test];
z_full = bsxfun(@plus,z_full,z_val);
z_full = reshape(z_full,[length(branchActual)*(Side.*2+1).^2,1]);

x_full = single(x_full);
y_full = single(y_full);
z_full = single(z_full);

x_full = reshape(x_full,[length(branchActual),(Side.*2+1).^2]);
y_full = reshape(y_full,[length(branchActual),(Side.*2+1).^2]);
z_full = reshape(z_full,[length(branchActual),(Side.*2+1).^2]);

% Get corners of UNINTERPOLATED planes
Planes = zeros(length(branchActual),4,3);
Planes(:,:,1) = [x_full(:,1),x_full(:,width),x_full(:,end),x_full(:,end-width+1)];
Planes(:,:,2) = [y_full(:,1),y_full(:,width),y_full(:,end),y_full(:,end-width+1)];
Planes(:,:,3) = [z_full(:,1),z_full(:,width),z_full(:,end),z_full(:,end-width+1)];

%%
hold(ax,'on')
for k = 1:5:size(Planes,1)  % hard-coded to 1 in every 5 planes
    fill3(ax,Planes(k,:,2)',Planes(k,:,1)',Planes(k,:,3)','k', ...
        'EdgeColor','k','FaceAlpha',0.6,'PickableParts','none');
end