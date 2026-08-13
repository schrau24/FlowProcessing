function choice = choosedialog
answer = questdlg('Is this correct?', ...
    'Check the centerline', ...
    'Yes, continue', ...
    'No, select new branches', ...
    'Pick start/end points', ...
    'Yes, continue');
switch answer
    case 'Yes, continue'
        choice = 1;
    case 'No, select new branches'
        choice = 0;
    case 'Pick start/end points'
        choice = 3;
    otherwise
        choice = 0;
end