function [branchActual_new, Tangent_V] = update_centerline(data, branchActual_orig, planeWidth, app)
choice = 0;
while ~choice

    % grab value from slider
    % fit and extract the spline plus normals for this centerline
    % user choice points to do spline fit along centerline, only if
    % branch is long enough
    tmpBranch = branchActual_orig;
    percBranchLengthSpline = app.SplineSpacingSlider.Value;     % the target distance (%) between chosen points for fit
    ptSkip = round(size(tmpBranch,1)*percBranchLengthSpline/100);
    curve_long = cscvn(cat(2,tmpBranch(1:ptSkip:end,:)',tmpBranch(end,:)'));
    tlong = linspace(0,curve_long.breaks(end),size(tmpBranch,1));

    % the final centerline
    branchActual = fnval(curve_long, tlong);
    branchActual = branchActual';

    % and the tangent vector
    Tangent_V = fnval(fnder(curve_long), tlong);
    Tangent_V = Tangent_V';
    Tangent_V = normalize(Tangent_V,2,'norm');

    disp('Update centerline: Adjust the slider to update the spacing along the centerline for the spline fit');

    reset3DSegmentationAndCenterline(app);
    hline2 = line(app.View3D_2,branchActual(:,2), branchActual(:,1), branchActual(:,3),...
        'Color','g','Marker','.','MarkerSize',12,'LineStyle','none','PickableParts','none');
    viewPlanesIn3D(app.View3D_2,Tangent_V,planeWidth,branchActual);

    waitfor(app.SplineSpacingSlider,'Value');

    tmpBranch = branchActual_orig;
    percBranchLengthSpline = app.SplineSpacingSlider.Value;     % the target distance (%) between chosen points for fit
    ptSkip = round(size(tmpBranch,1)*percBranchLengthSpline/100);
    curve_long = cscvn(cat(2,tmpBranch(1:ptSkip:end,:)',tmpBranch(end,:)'));
    tlong = linspace(0,curve_long.breaks(end),size(tmpBranch,1));

    % the final centerline
    branchActual_new = fnval(curve_long, tlong);
    branchActual_new = branchActual_new';

    % and the tangent vector
    Tangent_V = fnval(fnder(curve_long), tlong);
    Tangent_V = Tangent_V';
    Tangent_V = normalize(Tangent_V,2,'norm');

    reset3DSegmentationAndCenterline(app);
    hline2 = line(app.View3D_2,branchActual_new(:,2), branchActual_new(:,1), branchActual_new(:,3),...
        'Color','g','Marker','.','MarkerSize',12,'LineStyle','none','PickableParts','none');
    viewPlanesIn3D(app.View3D_2,Tangent_V,planeWidth,branchActual_new);

    answer = questdlg('Does the centerline look appropriate?', ...
        '', ...
        'Good, continue!','No, retry','Good, continue!');
    % Handle response
    switch answer
        case 'Good, continue!'
            choice = 1;
        case 'No, restart'
            choice = 0;
    end
end
end