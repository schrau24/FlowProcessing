function dposdt = pathlineODE(t, pos, interpU, interpV, interpW)
% pathlineODE  Velocity field for ODE45 integration of particle pathlines.
% Returns [0;0;0] if the particle is outside the interpolant domain,
% which in combination with the maskBoundaryEvent will stop integration.
try
    u = double(interpU(pos(1), pos(2), pos(3), t));
    v = double(interpV(pos(1), pos(2), pos(3), t));
    w = double(interpW(pos(1), pos(2), pos(3), t));
    if any(isnan([u, v, w]))
        dposdt = [0; 0; 0];
        return;
    end
    dposdt = [u; v; w];
catch
    % Outside interpolant domain — stop integration
    dposdt = [0; 0; 0];
end
end