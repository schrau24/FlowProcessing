function streamsOut = calculateStreamlines(currSeg, currV, subsample, pixdim, minVel, maxVel, ...
    visType, visPts, contourCoords)

nframes = size(currV,5);

% bins for alpha values and corresponding patches, to max velocity value
edges = [0 0.3 0.6 1.0] * maxVel;
alphas = [0.2 0.5 0.9];
nbins = numel(alphas);
Xb = cell(nbins,nframes); Yb = cell(nbins,nframes);
Zb = cell(nbins,nframes); Cb = cell(nbins,nframes);

[xcoor_grid,ycoor_grid,zcoor_grid] = meshgrid( ...
    (1:size(currSeg,2))*pixdim(1), ...
    (1:size(currSeg,1))*pixdim(2), ...
    (1:size(currSeg,3))*pixdim(3));

% =========================================================================
% PRE-COMPUTE START POSITIONS (identical every frame - do this ONCE)
% =========================================================================
switch visType
    case 'centerline contours'
        ptRange = str2num(visPts); %#ok<ST2NM>
        ptRange(ptRange > size(contourCoords.x,1)) = [];
        ptRange(ptRange < 1) = [];

        startX = []; startY = []; startZ = [];
        for ii = ptRange
            % Use stored contour coordinates from params_timeResolved.
            % .x = col positions, .y = row positions (empirically confirmed swap)
            x_plane = double(contourCoords.y(ii,:));   % rows
            y_plane = double(contourCoords.x(ii,:));   % cols
            z_plane = double(contourCoords.z(ii,:));   % slices

            seg_plane = contourCoords.seg(ii,:);       % segmentation mask at this plane
            maskPx = find(seg_plane > 0.5);
            if isempty(maskPx), continue; end
            maskPx = maskPx(1:subsample:end);

            startX = cat(1, startX, x_plane(maskPx)' * pixdim(1));
            startY = cat(1, startY, y_plane(maskPx)' * pixdim(2));
            startZ = cat(1, startZ, z_plane(maskPx)' * pixdim(3));
        end

        if isempty(startX)
            warning('calculateStreamlines: no valid start points for centerline contours.');
            streamsOut.Xb = Xb; streamsOut.Yb = Yb;
            streamsOut.Zb = Zb; streamsOut.Cb = Cb;
            return
        end

    case 'segmentation'
        substreams = round(5 * subsample);
        L      = find(currSeg);
        L      = L(1:substreams:end);
        startX = xcoor_grid(L);
        startY = ycoor_grid(L);
        startZ = zcoor_grid(L);
end

% =========================================================================
% TIME LOOP – parallel when toolbox available, serial fallback
% =========================================================================
useParallel = license('test', 'Distrib_Computing_Toolbox') && ...
              ~isempty(ver('parallel'));

P   = [2 1 3];
xgP = permute(xcoor_grid, P);
ygP = permute(ycoor_grid, P);
zgP = permute(zcoor_grid, P);

if useParallel
    dq    = parallel.pool.DataQueue;
    hWait = waitbar(0, 'Calculating streamlines (parallel)...');
    afterEach(dq, @(~) incrementWaitbar(hWait, nframes));

    currV_all = currV;
    currSeg_l = currSeg;

    parfor t = 1:nframes
        [Xb_t, Yb_t, Zb_t, Cb_t] = computeOneFrame( ...
            currSeg_l, currV_all(:,:,:,:,t), ...
            xcoor_grid, ycoor_grid, zcoor_grid, ...
            xgP, ygP, zgP, ...
            startX, startY, startZ, ...
            edges, nbins, minVel, maxVel);
        for k = 1:nbins
            Xb{k,t} = Xb_t{k}; 
            Yb{k,t} = Yb_t{k}; 
            Zb{k,t} = Zb_t{k}; 
            Cb{k,t} = Cb_t{k}; 
        end
        send(dq, t);
    end
    if ishandle(hWait), close(hWait); end

else
    h = waitbar(0, 'Calculating streamlines...');
    for t = 1:nframes
        [Xb_t, Yb_t, Zb_t, Cb_t] = computeOneFrame( ...
            currSeg, currV(:,:,:,:,t), ...
            xcoor_grid, ycoor_grid, zcoor_grid, ...
            xgP, ygP, zgP, ...
            startX, startY, startZ, ...
            edges, nbins, minVel, maxVel);
        for k = 1:nbins
            Xb{k,t} = Xb_t{k};
            Yb{k,t} = Yb_t{k};
            Zb{k,t} = Zb_t{k};
            Cb{k,t} = Cb_t{k};
        end
        if ishandle(h), waitbar(t/nframes, h); end
    end
    if ishandle(h), close(h); end
end

streamsOut.Xb = Xb; streamsOut.Yb = Yb;
streamsOut.Zb = Zb; streamsOut.Cb = Cb;

end

% =========================================================================
% LOCAL HELPER – process a single time frame (called by both parfor and for)
% =========================================================================
function [Xb_t, Yb_t, Zb_t, Cb_t] = computeOneFrame( ...
        currSeg, currV_t, ...
        xcoor_grid, ycoor_grid, zcoor_grid, ...
        xgP, ygP, zgP, ...
        startX, startY, startZ, ...
        edges, nbins, minVel, maxVel)

    vx    = -currSeg .* currV_t(:,:,:,1) / 10;
    vy    = -currSeg .* currV_t(:,:,:,2) / 10;
    vz    = -currSeg .* currV_t(:,:,:,3) / 10;
    vmagn = sqrt(vx.^2 + vy.^2 + vz.^2);

    S = stream3(xcoor_grid, ycoor_grid, zcoor_grid, -vy, -vx, -vz, startX, startY, startZ);
    F = griddedInterpolant(xgP, ygP, zgP, permute(vmagn,[2 1 3]), 'linear', 'none');

    Xb_t = cell(nbins,1); Yb_t = cell(nbins,1);
    Zb_t = cell(nbins,1); Cb_t = cell(nbins,1);

    for ii = 1:numel(S)
        pts = S{ii};
        if size(pts,1) < 2, continue; end

        XX = pts(:,1); YY = pts(:,2); ZZ = pts(:,3);
        c  = F(XX, YY, ZZ);
        c(c < minVel) = NaN;
        c(c > maxVel) = maxVel;

        bin = discretize(c, edges);

        for k = 1:nbins
            idx = find(bin == k);
            if isempty(idx), continue; end

            d        = diff(idx);
            segStart = [1; find(d > 1) + 1];
            segEnd   = [segStart(2:end) - 1; numel(idx)];

            for s = 1:numel(segStart)
                ii0      = idx(segStart(s):segEnd(s));
                Xb_t{k} = [Xb_t{k}; XX(ii0); NaN];
                Yb_t{k} = [Yb_t{k}; YY(ii0); NaN];
                Zb_t{k} = [Zb_t{k}; ZZ(ii0); NaN];
                Cb_t{k} = [Cb_t{k}; c(ii0);  NaN];
            end
        end
    end
end

% =========================================================================
% LOCAL HELPER – waitbar increment via DataQueue callback
% =========================================================================
function incrementWaitbar(hWait, nframes)
    persistent count
    if isempty(count), count = 0; end
    count = count + 1;
    if ishandle(hWait)
        waitbar(count/nframes, hWait, ...
            sprintf('Calculating streamlines... (%d/%d)', count, nframes));
    end
    if count >= nframes, count = 0; end
end