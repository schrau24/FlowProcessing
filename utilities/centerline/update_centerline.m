function branchActual_new = update_centerline(data, branchActual_orig)
branchActual_orig = flipud(branchActual_orig);
choice = 0;
while ~choice
    %% create the information figure, which will be updated accordingly
    infoFig = figure(200); clf
    infoFig.Name = 'Instructions/information';
    infoFig.Units = 'normalized';
    infoFig.Position = [0.5005    0.5194    0.4990    0.4019];
    
    % Add a textbox
    txtbox = annotation('textbox', [0.1, 0.5, 0.8, 0.4], ...
        'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 14);
    set(txtbox, 'String', {'Instructions: ' ,'1. click on the vessel to select a new starting point', ...
        '2. click on the vessel to select a new ending point',...
        '3. Press Enter to recalculate centerline',...
        '4. Verify results or start over'});
    
    % Add a textbox for information
    txtbox2 = annotation('textbox', [0.1, 0.05, 0.8, 0.4], ...
        'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 14);
    set(txtbox2, 'String', {'Information: ' ,sprintf('original centerline length = %i points',size(branchActual_orig,1))});
    
    % create a new figure, half-screen
    fig = figure(199); clf
    fig.Name = 'Update centerline';
    fig.Units = 'normalized';
    fig.Position = [0.0005    0.0380    0.4990    0.8833];
    
    hpatch = patch(isosurface(data,0.05),'FaceAlpha',0.25);
    isonormals(data, hpatch.Vertices);
    set(hpatch, 'FaceColor', 'k', 'EdgeColor', 'none');
    
    lighting( 'gouraud');
    lightangle( 0,0);
    axis('off','tight')
    view( [0 0 -1]);
    daspect([1 1 1]);
    
    % overlay current centerline
    hline2 = line(branchActual_orig(:,2), branchActual_orig(:,1), branchActual_orig(:,3),...
        'Color','g','Marker','.','MarkerSize',12,'LineStyle','none','PickableParts','none');
    ll = legend(hline2,'original centerline');
    
    % Enable data cursor mode
    dcm_obj = datacursormode(fig);
    set(dcm_obj, 'DisplayStyle', 'window', 'Enable', 'on');
    set(dcm_obj, 'UpdateFcn', @updateDataCursor);
    
    % 1. first define new starting point
    figure(fig);
    title('Step 1: new starting point')
    waitforbuttonpress;
    load('tmp_pt.mat'); delete('tmp_pt.mat')
    start_new = [pos(2) pos(1) pos(3)];
    hold on;
    plot3(start_new(2),start_new(1),start_new(3), 'r.', 'MarkerSize', 35, 'LineWidth', 2);
    hold off;
    ll.String{2} = 'new starting point';
    txtbox2.String{3} = sprintf('original start: [%i %i %i], new start: [%i %i %i]',...
        branchActual_orig(1,1),branchActual_orig(1,2),branchActual_orig(1,3),...
        start_new(1),start_new(2),start_new(3));
    
    % 2. define new ending point
    figure(fig);
    title('Step 2: new ending point')
    waitforbuttonpress;
    load('tmp_pt.mat'); delete('tmp_pt.mat')
    end_new = [pos(2) pos(1) pos(3)];
    figure(fig);hold on;
    plot3(end_new(2),end_new(1),end_new(3), 'b.', 'MarkerSize', 35, 'LineWidth', 2);
    hold off;
    ll.String{3} = 'new ending point';
    txtbox2.String{4} = sprintf('original end: [%i %i %i], new end: [%i %i %i]',...
        branchActual_orig(end,1),branchActual_orig(end,2),branchActual_orig(end,3),...
        end_new(1),end_new(2),end_new(3));
    set(dcm_obj, 'UpdateFcn', []);
    datacursormode off
    
    % 3. Press enter to recalculate
    figure(fig);
    title('Step 3: Press Enter to recalculate')
    waitforbuttonpress;
    branchActual_new = calculateCenterline(data,start_new,end_new,branchActual_orig);
    txtbox2.String{5} = sprintf('original centerline length = %i points',size(branchActual_orig,1));
    
    % 4. Verify the result
    % overlay new centerline
    figure(fig);
    title('Step 4: Verify new centerline')
    hold on;
    hline3 = line(branchActual_new(:,2), branchActual_new(:,1), branchActual_new(:,3),...
        'Color','k','Marker','.','MarkerSize',8,'LineStyle','none','PickableParts','none');
    hold off;
    ll.String{4} = 'new centerline';
    
    answer = questdlg('Does the centerline look appropriate?', ...
        'Verify new centerline', ...
        'Good, continue!','No, retry','Good, continue!');
    % Handle response
    switch answer
        case 'Good, continue!'
            choice = 1;
            % close figures
            close(fig); close(infoFig);
        case 'No, restart'
            choice = 0;
    end
end
end

function txt = updateDataCursor(~, event_obj)
% Get clicked point coordinates
pos = round(get(event_obj, 'Position'));
txt = {['X: ', num2str(pos(1))], ['Y: ', num2str(pos(2))], ['Z: ', num2str(pos(3))]};
save('tmp_pt.mat','pos');
end