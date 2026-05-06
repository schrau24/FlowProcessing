function dposdt = pathlineODE(t, pos, interpU, interpV, interpW)
try
    u = interpU(pos(1), pos(2), pos(3), t);
    v = interpV(pos(1), pos(2), pos(3), t);
    w = interpW(pos(1), pos(2), pos(3), t);
    if any(isnan([u,v,w])), dposdt = [0;0;0]; return; end
    dposdt = [u; v; w];
catch
    dposdt = [0; 0; 0]; % Stops integration if out of bounds
end
end