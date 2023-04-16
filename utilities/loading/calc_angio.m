
function [magWeightVel, angio] = calc_angio(MAG, v, Venc)

% time resolved (for contouring later)
Vmag = squeeze(sqrt( sum( v.^2,4)));
Vmag(Vmag > Venc) = Venc;

magWeightVel = 32000*MAG.*sin( pi/2*Vmag / Venc);

% time averaged (looks good)
mm = mean(MAG,4); vMean = mean(v,5);
Vmag = squeeze(sqrt( sum( vMean.^2,4)));
Vmag(Vmag > Venc) = Venc;

angio = 32000*mm.*sin( pi/2*Vmag / Venc);
return