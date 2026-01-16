function streamsOut = calculateStreamlines(currSeg, currV, subsample, pixdim, minVel, maxVel, ...
    visType, visPts, branchActual, tangent_V)

nframes = size(currV,5);

% bins for alpha values and corresponding patches, to max
% velocity value
edges = [0 0.3 0.6 1.0] * maxVel;
alphas = [0.2 0.5 0.9];
nbins = numel(alphas);
Xb = cell(nbins,nframes); Yb = cell(nbins,nframes); Zb = cell(nbins,nframes); Cb = cell(nbins,nframes);

[xcoor_grid,ycoor_grid,zcoor_grid] = meshgrid((1:size(currSeg,2))*pixdim(1),(1:size(currSeg,1))*pixdim(2), ...
        (1:size(currSeg,3))*pixdim(3));

h = waitbar(0, sprintf('Calculating streamlines...'));
for t = 1:nframes
    vx = -currSeg.*currV(:,:,:,1,t)/10;
    vy = -currSeg.*currV(:,:,:,2,t)/10;
    vz = -currSeg.*currV(:,:,:,3,t)/10;
    vmagn = sqrt(vx.^2 + vy.^2 + vz.^2);
    
    % determine start positions of streamlines
    switch visType  % the current vis state, slice-wise not allowed
        case 'centerline contours'
            % set the subsampling to reduce number of streamlines
            substreams = subsample;
            str = visPts;
            eval(['ptRange=[' str '];']);

            % get oblique slices
            startX = []; startY = []; startZ = [];
            for ii = ptRange
                currCP = [branchActual(ii,2),branchActual(ii,1),branchActual(ii,3)];
                currNorm = tangent_V(ii,:); currNorm = [currNorm(1) -currNorm(2) currNorm(3)];
                [B,x,y,z] = obliqueslice(currSeg,currCP,currNorm,'FillValues',0);
                % do a quick region grow from our centerline point
                tmp = cat(2,x(:),y(:),z(:)) - currCP;
                tmp = sqrt(sum(tmp.*tmp,2));
                [~, pointLinearIndexInSlice] = min(tmp);
                [pointColumn,pointRow] = ind2sub(size(B),pointLinearIndexInSlice(1));
                B = regiongrowing(B,pointColumn,pointRow);

                currL = find(B(:));
                currL = currL(1:substreams:end);
                % the start points in true image coordinates
                startX = cat(1,startX,x(currL)*pixdim(1));
                startY = cat(1,startY,y(currL)*pixdim(2));
                startZ = cat(1,startZ,z(currL)*pixdim(3));

            end

        case 'segmentation'   % 3d streamlines from the whole segmentation
            % set the subsampling to reduce number of streamlines,
            % this is ~5x larger than subsample for computational
            % reasons
            substreams = round(5*subsample);
            L = find(currSeg);
            startX = xcoor_grid(L(1:substreams:end));
            startY = ycoor_grid(L(1:substreams:end));
            startZ = zcoor_grid(L(1:substreams:end));
    end

    S = stream3(xcoor_grid,ycoor_grid,zcoor_grid,...
        -vy,-vx,-vz,startX,startY,startZ);
    P = [2 1 3];
    F = griddedInterpolant(permute(xcoor_grid,P),permute(ycoor_grid,P),...
        permute(zcoor_grid,P),permute(vmagn,P),'linear','none');

    for ii = 1:numel(S)
        pts = S{ii};
        n = size(pts,1);
        if n < 2
            continue
        end

        XX = pts(:,1); YY = pts(:,2); ZZ = pts(:,3);
        c = F(XX,YY,ZZ);
        c(c < minVel) = NaN;
        c(c > maxVel) = maxVel;

        % Bin indices per point
        bin = discretize(c, edges);

        for k = 1:nbins
            idx = find(bin == k);
            if isempty(idx)
                continue
            end

            % Extract contiguous segments
            d = diff(idx);
            segStart = [1; find(d > 1)+1];
            segEnd   = [segStart(2:end)-1; numel(idx)];

            for s = 1:numel(segStart)
                ii0 = idx(segStart(s):segEnd(s));
                Xb{k,t} = [Xb{k,t}; XX(ii0); NaN];
                Yb{k,t} = [Yb{k,t}; YY(ii0); NaN];
                Zb{k,t} = [Zb{k,t}; ZZ(ii0); NaN];
                Cb{k,t} = [Cb{k,t}; c(ii0); NaN];
            end
        end
    end
    if exist('h')
        waitbar (t/nframes, h)
    end
end
if exist('h')
    close(h);
end

streamsOut = [];
streamsOut.Xb = Xb; streamsOut.Yb = Yb; streamsOut.Zb = Zb; streamsOut.Cb = Cb;