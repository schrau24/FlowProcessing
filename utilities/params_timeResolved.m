function [flowPerHeartCycle_vol, flowPulsatile_vol, segment1, V2, area_val] = ...
    params_timeResolved(branchActual, angio, MAG, v, nframes, pixdim, aortaSeg_timeResolved,...
    isSegLoaded, bTimeResolvedSeg, displayWaitBar)

d = 4;  % the number of points before and after to calculate orthogonal plane
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

% Get the full tangent plane for all the points
r = 25; %Size of plane to select from non interpolated data is r*2+1
InterpVals = 3; % Choose the interpolation between points
Side = r*InterpVals; % Creates the correct number of points for interpolation
width = Side.*2+1; %width of plane in pixels
Mid = zeros(length(branchActual),1);

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

% % Get corners of UNINTERPOLATED planes
% Planes = zeros(length(branchActual),4,3);
% Planes(:,:,1) = [x_full(:,1),x_full(:,width-InterpVals),x_full(:,end),x_full(:,end-width+1)];
% Planes(:,:,2) = [y_full(:,1),y_full(:,width-InterpVals),y_full(:,end),y_full(:,end-width+1)];
% Planes(:,:,3) = [z_full(:,1),z_full(:,width-InterpVals),z_full(:,end),z_full(:,end-width+1)];

x = 1:size(angio,1);
y = 1:size(angio,2);
z = 1:size(angio,3);

indexes = sub2ind(size(angio), round(branchActual(:,1)), round(branchActual(:,2)), round(branchActual(:,3)));

% Get the interpolated velocity data from 3 directions and apply
% multiplication of tangent vector
v1 = zeros([size(x_full) nframes]);
v2 = zeros([size(x_full) nframes]);
v3 = zeros([size(x_full) nframes]);

if displayWaitBar
    % progress bar
    h = waitbar(0, sprintf('Calculating flow...'));
end
segment1 = zeros(length(branchActual),(Side.*2+1)*(Side.*2+1),nframes);
for frame = 1:nframes
    v_temp = interp3(y,x,z,squeeze(v(:,:,:,1,frame)),y_full(:),x_full(:),z_full(:),'cubic',0);
    v1(:,:,frame) = reshape(v_temp,[length(branchActual),(Side.*2+1).^2]);
    v_temp = interp3(y,x,z,squeeze(v(:,:,:,2,frame)),y_full(:),x_full(:),z_full(:),'cubic',0);
    v2(:,:,frame) = reshape(v_temp,[length(branchActual),(Side.*2+1).^2]);
    v_temp = interp3(y,x,z,squeeze(v(:,:,:,3,frame)),y_full(:),x_full(:),z_full(:),'cubic',0);
    v3(:,:,frame) = reshape(v_temp,[length(branchActual),(Side.*2+1).^2]);
    
    if bTimeResolvedSeg         % if we have a time-resolved segmentation
        %Interpolation for the complex difference data
        CD_int = interp3(y,x,z,aortaSeg_timeResolved(:,:,:,frame),y_full(:),x_full(:),z_full(:),'cubic',0);
        
%         SE = strel('disk', 2);
%         ss = reshape(CD_int,[length(branchActual),(Side.*2+1),(Side.*2+1)]);
%         s = zeros(size(ss,1),(Side.*2+1).^2);
%         for sl = 1:size(ss,1)
%             segment2 = imerode(squeeze(ss(sl,:,:)),SE);
%             segment2 = regiongrowing(segment2,round(length(segment2)/2),round(length(segment2)/2));
%             segment2 = imdilate(segment2, SE);
%             s(sl,:) = reshape(segment2,[1 (Side.*2+1).^2]);
%         end
        s = reshape(CD_int,[length(branchActual),(Side.*2+1)*(Side.*2+1)]);
        
        % area
        vox = mean(pixdim)/10;
        area_val(:,frame) = sum(s,2)*(vox*(2*r+1)/(2*r*InterpVals+1))^2;
        segment1(:,:,frame) = s;
        if displayWaitBar
            waitbar (frame/(nframes*2), h);
        end
    end
end

if ~bTimeResolvedSeg    % if no time-resolved segmentation, use kmeans of magnitude and angio images
    %Interpolation for the complex difference data
    if isSegLoaded
        angio_int = interp3(y,x,z,aortaSeg_timeResolved(:,:,:,1),y_full(:),x_full(:),z_full(:),'cubic',0);
    else
        angio_int   = interp3(y,x,z,angio,y_full(:),x_full(:),z_full(:),'cubic',0);
    end
    %     MAG_int     = interp3(y,x,z,mean(MAG,4),y_full(:),x_full(:),z_full(:),'cubic',0);
    SE = strel('disk', 2);
    aa = reshape(angio_int,[length(branchActual),(Side.*2+1)*(Side.*2+1)]);
    %     mm = reshape(MAG_int,[length(branchActual),(Side.*2+1)*(Side.*2+1)]);
    for sl = 1:size(aa,1)
        clust = horzcat(aa(sl,:)');%,mm(sl,:)');
        [idx,~] = kmeans(clust,2);       % kmeans to segment
        segment2 = zeros([Side.*2+1,Side.*2+1]);
        segment2(idx==2) = 1;
        if segment2(round(numel(segment2(:,1))/2),round(numel(segment2(1,:))/2)) == 0
            segment2 = -1*segment2+1;
        end
        segment2 = imerode(segment2,SE);
        segment2 = regiongrowing(segment2,round(length(segment2)/2),round(length(segment2)/2));
        segment2 = imdilate(segment2, SE);
        s(sl,:) = reshape(segment2,[1 (Side.*2+1).^2]);
        
        if displayWaitBar
            waitbar (sl/size(aa,1), h);
        end
    end
    
    % area
    vox = mean(pixdim)/10;
    tmpArea = sum(s,2)*(vox*(2*r+1)/(2*r*InterpVals+1))^2;
%     % find outliers
%     outLieridx = find(isoutlier(tmpArea,'movmedian',length(tmpArea)));
%     indices = 1:length(tmpArea);
%     for ii = 1:length(outLieridx)
%        % search before and after ~3 cross sections to find a suitable
%        % segmentation to use and then average them
%        currInd = ii-3:ii+3;
%        segmentsToUse = find(ismember(currInd,indices) & ~ismember(currInd,outLieridx(ii)));
%        s(outLieridx(ii),:) = mean(s(segmentsToUse,:),1);
%     end
    area_val = repmat(sum(s,2)*(vox*(2*r+1)/(2*r*InterpVals+1))^2,[1 nframes]);
    segment1 = repmat(s,[1 1 nframes]);
    
    figure(4); %clf;
    a = aa(10:10:end,:);
    a = reshape(a,[size(a,1) 2*Side+1 2*Side+1]); a = a/max(a(:));
    subplot 121; montage(permute(a, [2 3 4 1]));
    title('angio images')
    ss = s(10:10:end,:);
    ss = reshape(ss,[size(ss,1) 2*Side+1 2*Side+1]);
    subplot 122; montage(permute(ss, [2 3 4 1]));
    % set(figure(4),'Name',);
    title(['segmentation for slices 10-' num2str(size(a,1)*10)])
    drawnow;
end

flowPulsatile = zeros(size(area_val,1),nframes);
% initialize pulsatile volume
flowPulsatile_vol = zeros(prod(size(angio)),nframes);
vTimeFramerowMean = zeros(size(area_val,1),nframes);

for j = 1:nframes
    
    v1 = interp3(y,x,z,v(:,:,:,1,j),y_full(:),x_full(:),z_full(:),'cubic',0);
    v2 = interp3(y,x,z,v(:,:,:,2,j),y_full(:),x_full(:),z_full(:),'cubic',0);
    v3 = interp3(y,x,z,v(:,:,:,3,j),y_full(:),x_full(:),z_full(:),'cubic',0);
    v1 = reshape(v1,[length(branchActual),(Side.*2+1).^2]);
    v2 = reshape(v2,[length(branchActual),(Side.*2+1).^2]);
    v3 = reshape(v3,[length(branchActual),(Side.*2+1).^2]);
    v1 = bsxfun(@times,v1,Tangent_V(:,1));        % this is Z direction
    v2 = bsxfun(@times,v2,Tangent_V(:,2));
    v3 = bsxfun(@times,v3,Tangent_V(:,3));
    
    % Apply rotations to velocity components in velocity cross
    % section before computing parameters
    vTimeFrame = segment1(:,:,j).*(0.1*(v1 + v2 + v3));
    vTimeFramerowMean(:,j) = sum(vTimeFrame,2) ./ sum(vTimeFrame~=0,2);
    flowPulsatile(:,j) = vTimeFramerowMean(:,j).*area_val(:,j);
    flowPulsatile_vol(indexes,j) = flowPulsatile(:,j);
    if displayWaitBar
        waitbar((nframes+j)/(nframes*2), h);
    end
end

% need to initialize 3D volumes for each of these parameters
flowPerHeartCycle_vol = zeros(size(angio));
% total flow
flowPerHeartCycle_vol(indexes) = sum(flowPulsatile,2)./(nframes);
if displayWaitBar
    close(h);
end
disp('Done!')