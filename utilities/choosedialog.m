function choice = choosedialog
answer = questdlg('Is this correct?', ...
	'Check the centerline', ...
	'Yes, continue','No, select new branches',...
    'Manual update','Yes, continue');
% Handle response
switch answer
    case 'Yes, continue'
        choice = 1;
    case 'No, select new branches'
        choice = 0;
    case 'Manual update'
        choice = 2;
end