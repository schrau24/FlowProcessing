function [flowPerHeartCycle_vol, flowPulsatile_vol,vTimeFramerowMean] = paramMap_params_new(...
    branchActual, res, angio, v, nframes, pixdim, aortaSeg)

% tic
global r angiocrossection segment1 vTimeFrameave

d = 3;  % the number of points before and after to calculate orthogonal plane
Tangent_V = zeros(0,3);


dir_temp = zeros(size(branchActual,1),3);
for i = 1:size(branchActual,1)
    % extract normal to cross-section
    if i < d+1
        dir = (branchActual(i+d,1:3) - branchActual(i,1:3));
    elseif i >= size(branchActual,1)-d
        dir = (branchActual(i,1:3) - branchActual(i-d,1:3));
    else
        dir = (branchActual(i+d,1:3) - branchActual(i-d,1:3));
    end
    dir_temp(i,:) = dir/norm(dir);
end
Tangent_V = [Tangent_V;dir_temp];


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
% toc

% Get the full tangent plane for all the points
r = 11; %Size of plane to select from non interpolated data is r*2+1
InterpVals = 4; % Chose the interpolation between points
Side = r*InterpVals; % Creates the correct number of points for interpolation
Mid = zeros(length(branchActual),1);

% tic
% Find x Values on line
temp = repmat(V2(:,1)./InterpVals,[1 Side]);
Test = cumsum(temp,2);
Test2 = -fliplr(Test);
x_val = [Test2 Mid Test];
x_val = bsxfun(@plus,x_val,branchActual(:,1));
x_val = reshape(x_val,[numel(x_val) 1]);

% Find y Values on line
temp = repmat(V2(:,2)./InterpVals,[1 Side]);
Test = cumsum(temp,2);
Test2 = -fliplr(Test);
y_val = [Test2 Mid Test];
y_val = bsxfun(@plus,y_val,branchActual(:,2));
y_val = reshape(y_val,[numel(y_val) 1]);

% Find z values on the line
temp = repmat(V2(:,3)./InterpVals,[1 Side]);
Test = cumsum(temp,2);
Test2 = -fliplr(Test);
z_val = [Test2 Mid Test];
z_val = bsxfun(@plus,z_val,branchActual(:,3));
z_val = reshape(z_val,[numel(z_val) 1]);

% At this point the x,y,z values have created a tanget line in
% the perpedicular plane to the normal vector for all centerline points.

% Find x Values on plane
Mid = zeros(length(branchActual)*(Side*2+1),1);
temp = repmat(V3(:,1)./InterpVals,[(Side*2+1) Side]);
Test = cumsum(temp,2);
Test2 = -fliplr(Test);
x_full = [Test2 Mid Test];
x_full = bsxfun(@plus,x_full,x_val);
x_full = reshape(x_full,[length(branchActual)*(Side.*2+1).^2,1]);

% Find x Values on plane
temp = repmat(V3(:,2)./InterpVals,[(Side*2+1) Side]);
Test = cumsum(temp,2);
Test2 = -fliplr(Test);
y_full = [Test2 Mid Test];
y_full = bsxfun(@plus,y_full,y_val);
y_full = reshape(y_full,[length(branchActual)*(Side.*2+1).^2,1]);

% Find  Values on plane
temp = repmat(V3(:,3)./InterpVals,[(Side*2+1) Side]);
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

x = 1:res(1);
y = 1:res(2);
z = 1:res(3);
vtimeave = mean(v,5);

% Get the interpolated velocity data from 3 directions and apply
% multiplication of tangent vector
v1 = interp3(y,x,z,vtimeave(:,:,:,1),y_full(:),x_full(:),z_full(:),'cubic',0);
v2 = interp3(y,x,z,vtimeave(:,:,:,2),y_full(:),x_full(:),z_full(:),'cubic',0);
v3 = interp3(y,x,z,vtimeave(:,:,:,3),y_full(:),x_full(:),z_full(:),'cubic',0);
v1 = reshape(v1,[length(branchActual),(Side.*2+1).^2]);
v2 = reshape(v2,[length(branchActual),(Side.*2+1).^2]);
v3 = reshape(v3,[length(branchActual),(Side.*2+1).^2]);
temp = zeros([size(v1),3]); % used to hold velocity data information
temp(:,:,1) = bsxfun(@times,v1,Tangent_V(:,1));
temp(:,:,2) = bsxfun(@times,v2,Tangent_V(:,2));
temp(:,:,3) = bsxfun(@times,v3,Tangent_V(:,3));
vTimeFrameave = (temp(:,:,1).^2+temp(:,:,2).^2+temp(:,:,3).^2).^(0.5); %Velocity planes for all points

%Interpolation for the complex difference data
CD_int = interp3(y,x,z,angio,y_full(:),x_full(:),z_full(:),'cubic',0);
angiocrossection = reshape(CD_int,[length(branchActual),(Side.*2+1).^2]);

if numel(find(aortaSeg(:))) > 0
    %Interpolation for the aorta_seg data
    CD_int = interp3(y,x,z,aortaSeg,y_full(:),x_full(:),z_full(:),'cubic',0);
    CD_int(CD_int > 0.2) = 1; CD_int(CD_int <= 0.2) = 0;
    aorta_segcrossection = reshape(CD_int,[length(branchActual),(Side.*2+1).^2]);
end

clear temp CD_int vtimeave

SE = strel('square', 4);
% warning('off','all')

%Get the centerline point locations
indexes = sub2ind(size(angio), branchActual(:,1), branchActual(:,2), branchActual(:,3));
area_val = zeros(size(Tangent_V,1),1);
segment1 = zeros([length(branchActual),(Side.*2+1).^2]);

% progress bar
h = waitbar(0, sprintf('Calculating flow over aorta...'));

for n = 1:size(Tangent_V,1)
    
    %     if mod(size(Tangent_V,1),n) == 5
    waitbar (n/size(Tangent_V,1), h)
    %     end
    
    clust = horzcat(angiocrossection(n,:)',vTimeFrameave(n,:)');
    [idx,ctrs] = kmeans(clust,2);
    segment2 = zeros([Side.*2+1,Side.*2+1]);
    segment2(idx==2) = 1;
    if segment2(round(numel(segment2(:,1))/2),round(numel(segment2(1,:))/2)) == 0
        segment2 = -1*segment2+1;
    end
    
    % Eric, add activecontouring and code from Wouter to select based on
    % circularity
    % check circularity
    stats       = regionprops(segment2,'Area','Extrema','Perimeter');
    circularity = ([stats.Perimeter] > 0 & [stats.Area] > 0) .* (4*pi*[stats.Area]) ./ ([stats.Perimeter].^2);
    vv = reshape(vTimeFrameave(n,:),sqrt(size(angiocrossection,2)),sqrt(size(angiocrossection,2)));
    if circularity < 0.6
        segment2 = activecontour(vv,segment2,300);  % no changes to defaults
        
    else    % add some smoothing and don't allow much contraction
        segment2 = activecontour(vv,segment2,300,'Chan-Vese','SmoothFactor',20,'ContractionBias',-.5);
    end
    
    segment2 = imerode(segment2,SE);
    segment2 = regiongrowing(segment2,round(length(segment2)/2),round(length(segment2)/2));
    segment2 = imdilate(segment2, SE);
    
    % if we have an aorta, find intersection between calculated contour and
    % manual aorta segmentation
    if numel(find(aortaSeg(:))) > 0
        origSegment = segment2;
        segmentContour = reshape(aorta_segcrossection(n,:),sqrt(size(aorta_segcrossection,2)),sqrt(size(aorta_segcrossection,2)));
        
        % to avoid really wonky segmentations from k-means, override here
        % with manual aorta segmentation (when 
        if numel(find(segment2)) < numel(find(segmentContour))
            ind = segment2 | segmentContour;
            segment2(find(ind)) = 1;
        else
            segment2 = segmentContour;
        end
    end
    
    % plotting, change to 1 to view how the k-means is working
    if 0
        figure(4); clf;
        
        
        subplot(2,2,1);
        imagesc(reshape(angiocrossection(n,:),sqrt(size(angiocrossection,2)),sqrt(size(angiocrossection,2))));colormap gray;
        title('2X interpolated time MIP')
        
        subplot(2,2,2);
        imagesc(reshape(vTimeFrameave(n,:),sqrt(size(angiocrossection,2)),sqrt(size(angiocrossection,2))));colormap gray;
        title('2X interpolated magnitude velocity')
        
        subplot(2,2,3);
        plot(clust(idx==1,1),clust(idx==1,2),'r.','MarkerSize',12)
        hold on
        plot(clust(idx==2,1),clust(idx==2,2),'b.','MarkerSize',12)
        plot(ctrs(:,1),ctrs(:,2),'kx',...
            'MarkerSize',12,'LineWidth',2)
        plot(ctrs(:,1),ctrs(:,2),'ko',...
            'MarkerSize',12,'LineWidth',2)
        legend('Cluster 1','Cluster 2','Centroids',...
            'Location','NW')
        title('k-means clustering')
        
        subplot(2,2,4);
        imagesc(segment2); colormap gray;
        title('vessel mask')
        
        pause(0.2)
    end
    
    % plotting, change to 1 to view how the k-means is working
    if 0
        figure(4); clf;
        
        uu = reshape(v1(n,:),2*Side+1,2*Side+1).*segment2;
        vv = reshape(v2(n,:),2*Side+1,2*Side+1).*segment2;
        ww = reshape(v3(n,:),2*Side+1,2*Side+1).*segment2;
        temp = sqrt(uu.*uu + vv.*vv + ww.*ww);
        cdata = squeeze(ind2rgb(temp(:),'hot'));
        qq = quiver3(segment2,uu,vv,ww, 10, 'MaxHeadSize', 10);
        view(-13,-3);
        xlabel('x'); ylabel('y'); zlabel('z')
        axis tight
        pause(0.2)
    end
    
    if 0
        figure(4); clf;
        
        subplot(2,2,1);
        imagesc(reshape(angiocrossection(n,:),sqrt(size(angiocrossection,2)),sqrt(size(angiocrossection,2))));colormap gray;
        title('2X interpolated time MIP')
        axis equal off
        subplot(2,2,2);
        imagesc(origSegment);colormap gray;
        title('Original segmentation')
        axis equal off
        subplot(2,2,3);
        imagesc(reshape(aorta_segcrossection(n,:),sqrt(size(aorta_segcrossection,2)),sqrt(size(aorta_segcrossection,2))));colormap gray;
        title('aorta seg crossection')
        axis equal off
        subplot(2,2,4);
        imagesc(segment2); colormap gray;
        title('updated mask')
        axis equal off 
        
        pause(0.2)
    end
       
    % area
    vox = mean(pixdim)/10;
    area_val(n) = sum(segment2(:))*(vox*(2*r+1)/(2*r*InterpVals+1))^2;
    segment2 = reshape(segment2,[1,(Side.*2+1).^2]);
    segment1(n,:) = segment2;
    
end

flowPulsatile = zeros(size(area_val,1),nframes);
% initialize pulsatile volume
flowPulsatile_vol = zeros(res(1)*res(2)*res(3),nframes);
vTimeFramerowMean = zeros(size(area_val,1),nframes);

for j = 1:nframes
    
    v1 = interp3(y,x,z,v(:,:,:,1,j),y_full(:),x_full(:),z_full(:),'cubic',0);
    v2 = interp3(y,x,z,v(:,:,:,2,j),y_full(:),x_full(:),z_full(:),'cubic',0);
    v3 = interp3(y,x,z,v(:,:,:,3,j),y_full(:),x_full(:),z_full(:),'cubic',0);
    v1 = reshape(v1,[length(branchActual),(Side.*2+1).^2]);
    v2 = reshape(v2,[length(branchActual),(Side.*2+1).^2]);
    v3 = reshape(v3,[length(branchActual),(Side.*2+1).^2]);
    v1 = bsxfun(@times,v1,Tangent_V(:,1));
    v2 = bsxfun(@times,v2,Tangent_V(:,2));
    v3 = bsxfun(@times,v3,Tangent_V(:,3));
    
    % Apply rotations to velocity components in velocity cross
    % section before computing parameters
    vTimeFrame = segment1.*(0.1*(v1 + v2 + v3));
    vTimeFramerowMean(:,j) = sum(vTimeFrame,2) ./ sum(vTimeFrame~=0,2);
    flowPulsatile(:,j) = vTimeFramerowMean(:,j).*area_val;
    flowPulsatile_vol(indexes,j) = flowPulsatile(:,j);
end

% need to initialize 3D volumes for each of these parameters
area_vol = zeros(size(angio));
area_vol(indexes) = area_val;
flowPerHeartCycle_vol = zeros(size(angio));
% total flow
flowPerHeartCycle_vol(indexes) = sum(flowPulsatile,2)./(nframes);
close(h);
disp('Done!')