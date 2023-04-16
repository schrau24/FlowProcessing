function choice = choosedialog
answer = questdlg('Is this correct?', ...
	'Check the centerline', ...
	'Yes, continue','No','Yes, continue');
% Handle response
switch answer
    case 'Yes, continue'
        choice = 1;
    case 'No'
        choice = 0;
end