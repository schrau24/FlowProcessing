function rgb = visColor(name)
% RGB triplet for the colour names offered in the visualization options
% (background and text colour of the vis and maps viewers).
switch lower(char(name))
    case 'white';       rgb = [1 1 1];
    case 'black';       rgb = [0 0 0];
    case 'gray';        rgb = [0.5 0.5 0.5];
    case 'light gray';  rgb = [0.8 0.8 0.8];
    case 'light blue';  rgb = [0.68 0.85 0.90];
    case 'yellow';      rgb = [1 1 0];
    case 'red';         rgb = [1 0 0];
    case 'blue';        rgb = [0 0 1];
    otherwise;          rgb = [0 0 0];
end
end