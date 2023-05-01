function [shearstress_object,surface_faces,surface_vertices] = calculate_wss_3d_flexdiameter(...
    n,number_of_points_on_normal,length_inward_normal_in_m,datax,datay,dataz,...
    velocity_x,velocity_y,velocity_z, ...
    viscosity_medium,...
    surface_faces,surface_vertices)%,...
%length_inward_normal_in_m,...
%distance_per_point_in_m )

% [shearstress_object,surface_faces,surface_vertices] = calculate_wss_3d(...
%                     datax,datay,dataz,...
%                     velocity_x,velocity_y,velocity_z, ...
%                     viscosity_medium,...
%                     surface_faces,surface_vertices,...
%                     length_inward_normal_in_m,...
%                     distance_per_point_in_m)

% --- Author information
% Wouter Potters
% Academic Medical Center, Amsterdam, The Netherlands
% w.v.potters@amc.nl
% Date: 22-August-2013
        interpolation_method = 'natural';
        extrapolation_method = 'nearest'; % usually zero
       
dt = DelaunayTri([datax(:), datay(:), dataz(:)]); %in m       
Fx = TriScatteredInterp(dt, velocity_x(:),interpolation_method); %creates function F which can interpolate values
%waitbar(0,handlew,'X interpolation function created. Please wait while interpolating the data.');
Fy = TriScatteredInterp(dt, velocity_y(:),interpolation_method); %creates function F which can interpolate values
%waitbar(0,handlew,'X,Y interpolation functions created. Please wait while interpolating the data.');
Fz = TriScatteredInterp(dt, velocity_z(:),interpolation_method); %creates function F which can interpolate values
%waitbar(0,handlew,'X,Y,Z interpolation functions created. Please wait while interpolating the data.');

% Doesn't work yet in MATLAB 2012b so using the old code above
% %create tesselation
% Fx = scatteredInterpolant(datax(:), datay(:), dataz(:), velocity_x(:),interpolation_method, extrapolation_method);
% Fy = scatteredInterpolant(datax(:), datay(:), dataz(:), velocity_y(:),interpolation_method, extrapolation_method);
% Fz = scatteredInterpolant(datax(:), datay(:), dataz(:), velocity_z(:),interpolation_method, extrapolation_method);

position_along_normal = cell(size(number_of_points_on_normal,1),2);
for iPos = 1:size(number_of_points_on_normal,1)
    position_along_normal{iPos,1} = (length_inward_normal_in_m(iPos) ./ number_of_points_on_normal(iPos)) * (1:number_of_points_on_normal(iPos));
    position_along_normal{iPos,2} = number_of_points_on_normal(iPos);
end

% %DO NOT INCLUDE THE ZERO POINTS in position_along_normal; these point lie
% %at the wall and might be outside the convexhull, causing the interpolation
% %algorithm to return NaN. The values do not have to be interpolated anyway as they are
% %explicitely defined as ZERO. (no slip condition)
% disp(['interpolation functions created; total time passed: ' num2str(toc(ttt)/60) ' minutes'])
% disp(['calculating values for measurement points...'])

%direction_of_normal = zeros(size(n,1),max([position_along_normal{:,2}]),3);
direction_of_normal     = cell(size(n,1),1);
originating_points      = cell(size(n,1),1);
measurement_coordinates = cell(size(n,1),1);

for i_v = 1:size(n,1)
    direction_of_normal{i_v,1,1} = n(i_v,1) * position_along_normal{i_v,1};
    direction_of_normal{i_v,1,2} = n(i_v,2) * position_along_normal{i_v,1};
    direction_of_normal{i_v,1,3} = n(i_v,3) * position_along_normal{i_v,1};
    
    originating_points{i_v,1,1} = surface_vertices(i_v,1) * ones(1,position_along_normal{i_v,2});
    originating_points{i_v,1,2} = surface_vertices(i_v,2) * ones(1,position_along_normal{i_v,2});
    originating_points{i_v,1,3} = surface_vertices(i_v,3) * ones(1,position_along_normal{i_v,2});
    
    measurement_coordinates{i_v,1,1} = originating_points{i_v,1,1} + direction_of_normal{i_v,1,1}; %[ X nrofpointsalongnormal 3 ]
    measurement_coordinates{i_v,1,2} = originating_points{i_v,1,2} + direction_of_normal{i_v,1,2}; %[ X nrofpointsalongnormal 3 ]
    measurement_coordinates{i_v,1,3} = originating_points{i_v,1,3} + direction_of_normal{i_v,1,3}; %[ X nrofpointsalongnormal 3 ]
%     if rem(i_v,10000) == 0
%         disp([num2str(round((i_v/size(n,1))*100)) '% done... total time passed: ' num2str(toc(ttt)/60) ' minutes'])
%     end
end

clear originating_points direction_of_normal %not needed; clear memory
%%% Interpolation of velocity values at normal vectors using natural triangular interpolation
velocity_values_interpolated_x = cell(size(surface_vertices,1),1);
velocity_values_interpolated_y = velocity_values_interpolated_x;
velocity_values_interpolated_z = velocity_values_interpolated_x;

disp(['Now calculating velocities using the created interpolation functions for ' num2str(size(velocity_values_interpolated_x,1)) ' points...'])

% put this stuff in an array to optimize the parfor loop
me_co_array_x = cat(1,measurement_coordinates{:,1,1});
me_co_array_y = cat(1,measurement_coordinates{:,1,2});
me_co_array_z = cat(1,measurement_coordinates{:,1,3});

parfor k = 1:size(measurement_coordinates,1)
    mx = me_co_array_x(k,:);
    my = me_co_array_y(k,:);
    mz = me_co_array_z(k,:);
    velocity_values_interpolated_x{k,1} = Fx(mx,my,mz); %#ok<PFBNS>
    velocity_values_interpolated_y{k,1} = Fy(mx,my,mz); %#ok<PFBNS>
    velocity_values_interpolated_z{k,1} = Fz(mx,my,mz); %#ok<PFBNS>
end
clear me_co_array_x me_co_array_y me_co_array_z Fx Fy Fz

%disp([' - Interpolation complete step 2; total time passed: ' num2str(toc(ttt)/60) ' minutes'])

%% STEP 3: Calculating rotation matrices for each point
disp('================================================================================')
disp('Step 3: calculating rotation matrices for each point on the wall.')
%reshape to [X nrofpointsalongnormal 3]
velocity_values_interpolated = cat(3,velocity_values_interpolated_x,velocity_values_interpolated_y,velocity_values_interpolated_z);

%%%% define axes
xaxis  = [ 1 0 0];
yaxis  = [ 0 1 0];
zaxis  = [ 0 0 1];

%nrofpoints = size(c,1);
nrofpoints = size(surface_vertices,1);

%%% CALCULATE THE NEW X AND Y AXIS IN EACH POINT - ALIGN X AXIS WITH NORMAL
%%% VECTOR n IN EACH COORDINATE (RODRIGUES' ROTATION FORMULA)
k        = cross(repmat(zaxis',[1 nrofpoints]),n'); %[3 X]
costheta =   dot(repmat(zaxis',[1 nrofpoints]),n'); %[X 1]
C  = reshape(repmat(costheta(1:nrofpoints),[9 1]),[3 3 nrofpoints]) .* repmat(eye(3,3),[1 1 nrofpoints]);

R_ = [             zeros(1,1,nrofpoints)     -reshape(k(3,:),[1 1 nrofpoints])   reshape(k(2,:),[1 1 nrofpoints]) ; ...
    reshape(k(3,:),[1 1 nrofpoints])               zeros(1,1,nrofpoints)   -reshape(k(1,:),[1 1 nrofpoints]) ; ...
    -reshape(k(2,:),[1 1 nrofpoints])     reshape(k(1,:),[1 1 nrofpoints])              zeros(1,1,nrofpoints) ];
%selector matrices j and j2 - use to select k and k'
j  = repmat(1:numel(k),[3 1]); j = j(:); j2 = repmat([1:3:nrofpoints*3; 2:3:nrofpoints*3; 3:3:nrofpoints*3], [3 1]); j2 = j2(:); %selectors to manually perform a row-wise vector product in the next line
K = reshape(k(j2) .* k(j),[3 3 nrofpoints]); %K = k*k'
L_ = (1 - costheta) ...%(1-costheta)
    ./ sum(k.^2,1); %./sum(k.^2)
L  = reshape(repmat(L_(1:nrofpoints),[9 1]),[3 3 nrofpoints]); %[3 3 X]

% Rodrigues' Rotation Formula
R = C +  R_ + K .* L; %calculate rotation matrix to rotate xaxis to match normalvector
clear C R_ K L j j2 costheta k

% NOW WE HAVE  ROTATION MATRIX R; WE USE IT TO CALCULATE THE NEW X,Y AND
% Z AXIS IN EACH POINT AT THE WALL

new_xaxis = zeros(nrofpoints,3);
new_yaxis = zeros(nrofpoints,3);
new_zaxis = zeros(nrofpoints,3);
for i = 1:nrofpoints
    %build new velocity vector in each point, based on new axis, remove new z_axis component
    new_xaxis(i,:) = (R(:,:,i) * xaxis')';
    new_yaxis(i,:) = (R(:,:,i) * yaxis')';
    new_zaxis(i,:) = (R(:,:,i) * zaxis')';
end
%disp([' - calculating rotation matrices finished; total time passed: ' num2str(toc(ttt)/60) ' minutes'])

%% STEP 4: Calculating Shear Rates
disp('================================================================================')
disp('Step 4: Calculating Shear Rates')
% pre allocate some variables
new_velocity_x = cell(nrofpoints,1,1);
new_velocity_y = cell(nrofpoints,1,1);

new_velocity_vector = cell(nrofpoints,1,1);

%preallocate memory to speedup forloop
shearrate = zeros(nrofpoints,3);
length_shearrate = zeros(1,nrofpoints);
x = cell(nrofpoints,1);

deri_xy = nan(3,nrofpoints);
splinefit = cell(1,nrofpoints);
total_vel = cell(1,nrofpoints);

disp(['Making fits for ' num2str(nrofpoints) ' points'])
warning off
for i = 1:nrofpoints
    
    x{i,1} = ( 0 : 1/number_of_points_on_normal(i) : 1 ) * length_inward_normal_in_m(i);
    j = 1;
    
    % set all to zero
    new_velocity_vector{i,1}(1:size([x{i,1}],2),1:3) = 0;
    new_velocity_x{i,1}(1:size([x{i,1}],2),1:3) = 0;
    new_velocity_y{i,1}(1:size([x{i,1}],2),1:3) = 0;
    %     %new_velocity_z(i,j,:)     = [ 0 0 0];
    for j = 2:size([x{i,1}],2)
        %velocity_values_interpolated{i,j-1,:}
        cur_vel_int = squeeze(cat(3,velocity_values_interpolated{i,1,:}));
        new_velocity_x{i,1}(j,:) = dot(reshape(cur_vel_int(j-1,:),[3 1]),new_xaxis(i,:)') * new_xaxis(i,:);
        new_velocity_y{i,1}(j,:) = dot(reshape(cur_vel_int(j-1,:),[3 1]),new_yaxis(i,:)') * new_yaxis(i,:);
        %ignore z' component along inward normal
        %new_velocity_z(i,j,:) = dot(reshape(velocity_values_interpolated(i,j-1,:),[3 1]),new_zaxis(i,:)') * new_zaxis(i,:);
        
        new_velocity_vector{i,1}(j,:) = [new_velocity_x{i,1}(j,:)] + [new_velocity_y{i,1}(j,:)];   % New vector in old axes without x from new x axis
    end
    
    total_vel{i} = squeeze([new_velocity_x{i,:,:}] + [new_velocity_y{i,:,:}])';
    try
        splinefit{i} = spaps(x{i,1},... %position along normal
            total_vel{i},... %velocities at locations on normal
            max(sqrt(sum(total_vel{i}.^2,3))/100),... %tolerance of data points %tol 1000 to 100
            [.1 ones(1,size(total_vel{i},2)-1)],... weights first one .1
            3); %quintic
        deri_xy(:,i) = fnval(fnder(splinefit{i}),0 );
    catch
        % nothing
    end
    
    shearrate(i,:) = [ deri_xy(1,i) deri_xy(2,i) deri_xy(3,i)]; % in the original coordinate system, in 1/s
    length_shearrate(i) = sqrt(sum(shearrate(i,:).^2));
end

warning on
%disp([' - calculating shearrates complete; total time passed: ' num2str(toc(ttt)/60) ' minutes'])

%% final step: SHEAR STRESS CALCULATION
disp('================================================================================')
disp('Step 5: calculation of shear stress complete');
%shearstress_object = shearstress(x,splinefit,shearrate,deri_xy,total_vel,viscosity_medium);
shearstress_object = shearstress(x,splinefit,shearrate,deri_xy,total_vel,viscosity_medium,1);


%disp([' - calculating shearstress complete; total time passed: ' num2str(toc(ttt)/60) ' minutes'])
disp('================================================================================')