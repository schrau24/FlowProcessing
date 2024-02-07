function interpRes = interpolateInputs(pixdim)
goOn = 0;
while goOn<1
    prompt = {sprintf('Enter resolution to interpolate to\noriginal res = %1.1f x %1.1f x %1.1f\nminimum res = %1.1f:',...
        pixdim(1),pixdim(2),pixdim(3),min(pixdim)/4)};
    dlgtitle = 'data interpolation';
    dims = [1 50];
    definput = {sprintf('%1.1f',min(pixdim)/2)};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    interpRes = str2double(answer{1});
    if str2double(answer{1}) < min(pixdim)/4
        msgbox('Error: requested resolution too small')
    else
        goOn = 1;
    end
end