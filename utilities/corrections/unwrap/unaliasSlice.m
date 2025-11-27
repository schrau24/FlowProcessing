function vOut = unaliasSlice(v,VENC)

% the previous unaliased timeframe
velocity_x1 = v(:,:,1,1);
velocity_y1 = v(:,:,2,1);
velocity_z1 = v(:,:,3,1);

velocity_x1_filt = medfilt2(velocity_x1);
velocity_y1_filt = medfilt2(velocity_y1);
velocity_z1_filt = medfilt2(velocity_z1);

velocity_x2 = v(:,:,1,2);
velocity_y2 = v(:,:,2,2);
velocity_z2 = v(:,:,3,2);

Lx = (sign(velocity_x2) ~= sign(velocity_x1_filt) & (abs(velocity_x2-velocity_x1) > 0.75*VENC) );
Ly = (sign(velocity_y2) ~= sign(velocity_y1_filt) & (abs(velocity_y2-velocity_y1) > 0.75*VENC) );
Lz = (sign(velocity_z2) ~= sign(velocity_z1_filt) & (abs(velocity_z2-velocity_z1) > 0.75*VENC) );

vx2_array = velocity_x2(Lx);
vy2_array = velocity_y2(Ly);
vz2_array = velocity_z2(Lz);

if ~isempty(vx2_array)
    for ix = 1:length(vx2_array)
    if vx2_array(ix,1) < 0
        vx2_array(ix,1) = vx2_array(ix,1) + 2*VENC;
    elseif vx2_array(ix,1) > 0
        vx2_array(ix,1) = vx2_array(ix,1) - 2*VENC;
    end
end
end
if ~isempty(vy2_array)
    for iy = 1:length(vy2_array)
    if vy2_array(iy,1) < 0
        vy2_array(iy,1) = vy2_array(iy,1) + 2*VENC;
    elseif vy2_array(iy,1) > 0
        vy2_array(iy,1) = vy2_array(iy,1) - 2*VENC;
    end
end
end
if ~isempty(vz2_array)
    for iz = 1:length(vz2_array)
    if vz2_array(iz,1) < 0
        vz2_array(iz,1) = vz2_array(iz,1) + 2*VENC;
    elseif vz2_array(iz,1) > 0
        vz2_array(iz,1) = vz2_array(iz,1) - 2*VENC;
        end
    end
end
velocity_x2(Lx) = vx2_array;
velocity_y2(Ly) = vy2_array;
velocity_z2(Lz) = vz2_array;

vOut(:,:,1) = velocity_x2;
vOut(:,:,2) = velocity_y2;
vOut(:,:,3) = velocity_z2;
