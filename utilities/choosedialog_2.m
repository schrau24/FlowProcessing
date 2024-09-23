function choice = choosedialog_2
answer = questdlg('Save results?', ...
	'Check Map ROI and results', ...
	'Yes','No, redraw ROI','Cancel ROI drawing','Yes');
% Handle response
switch answer
    case 'Yes'
        choice = 1;
    case 'No, redraw ROI'
        choice = 2;
    case 'Cancel ROI drawing'
        choice = 0;
end