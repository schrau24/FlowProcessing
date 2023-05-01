function varargout = isPointInsideMesh(F,V,N,p,varargin)
%value = isPointInsideMesh(F,V,N,p,varargin)
% Faces F
% Vertices V
% Inward normal N
% Points p
% Option varargin: {'inside','outside','onwall'} to select specific points

% --- Author information
% Wouter Potters
% Academic Medical Center, Amsterdam, The Netherlands
% w.v.potters@amc.nl
% Date: 26-March-2013

narginchk(4,5);
nargoutchk(1,2);
%checkParallelProcessing;

if size(V,2) ~= size(p,2) && size(p,1) == 1
    error('point not same size as V')
end

if nargin == 5
    selection = varargin{1};
else
    selection = '';
end

if isempty(N)
    N = patchnormals(struct('faces',F,'vertices',V));
end

% Show debug plots
plot_on = 0;

% first select based on bounding box of V +/- % of max-min
percentage_outside_box = 0.02; % 2 percent
if plot_on
    disp(['Busy locating all voxels inside the vessel bounding box +/- ' num2str(100*percentage_outside_box) '%... May take a few minutes...'])
end

mimawidth = percentage_outside_box*(max(V) - min(V));

sel = find(all(p  < (ones(length(p),1) * (max(V)+mimawidth)),2) & all(p  > (ones(length(p),1) * (min(V)-mimawidth)),2));
% only points within min -> max boundaries +/- X % of max-min 

perc = 100*(1-numel(sel)/numel(p));
if plot_on
    disp(['Ignoring ' num2str(perc) ' % of the data; this datapoints are outside the bounding box of the vessel segmentation.']);
end

if plot_on
    figure(516531);
    patch('Faces',F,'Vertices',V,'FaceColor',[.8 .5 .5],'edgecolor','none','faceAlpha',0.25); hold on
    plot3(p(sel,1),p(sel,2),p(sel,3),'g.')
    axis equal tight vis3d; view(3); drawnow;
end

% REMOVE POINTS OUTSIDE CONVHULL TO AVOID USELESS COMP. TIME
[ch_orig] = convhull(V(:,1),V(:,2),V(:,3));
ch_orig_mi_ma = [min(V(ch_orig(:),:)); max(V(ch_orig(:),:))];

sel_p = (p(:,1) > ch_orig_mi_ma(1,1) & p(:,1) < ch_orig_mi_ma(2,1) & p(:,2) > ch_orig_mi_ma(1,2) & p(:,2) < ch_orig_mi_ma(2,2) & p(:,3) > ch_orig_mi_ma(1,3) & p(:,3) < ch_orig_mi_ma(2,3));
p = p(sel_p,:);

sel = find(all(p  < (ones(length(p),1) * (max(V)+mimawidth)),2) & all(p  > (ones(length(p),1) * (min(V)-mimawidth)),2));

%%% SELECTION OF POINTS AT OPEN ENDS (INLETS, OUTLETS) TO AVOID UNWANTED INSIDE MARKING OUTSIDE VESSEL
%[edgepoints_indices] = find(histc(F(:),1:1:max(F(:))) < 5); %counts < 5 selects all edge elements in V


%% FIND CLOSEST POINTS AT MESH FOR EACH POINT
i = zeros(1,size(p,1));
parfor ip = 1:size(p,1)
    if any(sel == ip)
        dist = sqrt(sum((V - ones(size(V,1),1)*p(ip,:)).^2,2));
        i(ip) = find(dist == min(dist(:)),1);
    end
    if (rem(ip,10000) == 0) && (plot_on ~= 1)
        disp([num2str(100*ip/size(p,1)) ' %'])
    end
end

%% CALCULATE DISTANCE VECTOR TO CLOSEST POINT
vectors = zeros(size(p)); normals = zeros(size(p));
vectors(sel,:) = p(sel,:) - V(i(sel),:);
normals(sel,:)  = N(i(sel),:);

%% DOT PRODUCT < 0 GIVES POINTS OUTSIDE VESSEL
distance      = -ones(1,size(p,1));
distance(sel) =  dot(vectors(sel,:)',normals(sel,:)');

sel_inside  = distance(:) > 0;
sel_outside = distance(:) < 0;
sel_onwall  = distance(:) == 0;

%% CHECK IF ALL POINTS WERE SELECTED SOMEHOW - could be ignored
if sum(sel_inside + sel_onwall + sel_outside) ~= numel(distance)
    %error('points missing')
    warning('please note that sel_inside uses all points > -.01');
end

%% OUTPUT VALUES
if plot_on
    %plot3(p(sel_outside,1),p(sel_outside,2),p(sel_outside,3),'r*') %outside 
    plot3(p(sel_inside,1),p(sel_inside,2),p(sel_inside,3),'b.') %inside the wall
    plot3(p(sel_onwall,1),p(sel_onwall,2),p(sel_onwall,3),'go') %on the wall
    rotate3d on
end

switch selection
    case 'inside'
        value = sel_inside;
    case 'outside'
        value = sel_outside;
    case 'onwall'
        value = sel_onwall;
    case 'onwall_inside'
        value = sel_inside | sel_onwall;
    otherwise
        disp('No valid argument; inside points selected');
        value = sel_inside;
end

switch nargout
    case 1
        varargout{1} = find(value);
    case 2
        varargout{1} = find(value);
        varargout{2} = distance;
end