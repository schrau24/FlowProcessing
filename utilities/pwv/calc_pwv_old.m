function [D, fitObject, dist_total] = calc_pwv(waveforms,dist_total, timeres, PWVcalctype, scale)

% PWV calc type: 1 is cross correlation, 2 is TTF, 3 is Wavelet

% to interp to 1/scale ms, we need how many frames?
nFrames = size(waveforms,2);
nFrames_interp = floor(timeres/scale*nFrames);

% interp params
x = 1:nFrames;
xq = linspace(1,nFrames,nFrames_interp);
METHOD = 'pchip';
plot_steps = true;

% grab first flow waveform
flow_sl1 = smooth(interp1(x,waveforms(1,:),xq,METHOD));
if min(flow_sl1) < 0
    flow_sl1 = flow_sl1 + abs(min(flow_sl1)) + 1;
end
if min(flow_sl1) > 0
    flow_sl1 = flow_sl1 - (min(flow_sl1)) + 1;
end

% normalize
flow_sl1 = flow_sl1./max(abs(flow_sl1));

% find the systolic upslope, TTF and wavelet
[maxFl, indMax1] = max(flow_sl1);

% circshift to put max at center
midPt = round(length(flow_sl1)/2);
flow_sl1 = circshift(flow_sl1, midPt-indMax1);

% 20% of max, first to the left
indStart = max(find(flow_sl1(1:midPt) < 0.2*maxFl)) + 1;
indEnd   = max(find(flow_sl1(indStart:midPt) < 0.8*maxFl)) + indStart -1;

% indStart = max(find(flow_sl1(1:indMax1) < 0.2*maxFl)) + 1;
% indEnd   = max(find(flow_sl1(indStart:indMax1) < 0.8*maxFl)) + indStart -1;
pts1 = indStart:indEnd;

if PWVcalctype == 2     % TTF
    fitObject = polyfit(pts1,flow_sl1(pts1),1);
    D(1) = -fitObject(2) / fitObject(1);
end

% for wavelet
[y1,PERIOD,SCALE,COI,DJ, PARAMOUT, K] = contwt(flow_sl1,0.001,1,[],[],[],'dog',4);
f1 = 1./PERIOD;
ind = [];
% loop over all flow curves
for slice = 2:size(waveforms,1)
    
    % second flow waveform, circshift by same amount as first waveform
    flow_sl2 = smooth(circshift(interp1(x,waveforms(slice,:),xq,METHOD), midPt-indMax1));
%     flow_sl2 = smooth(interp1(x,waveforms(slice,:),xq,METHOD));
    
    if min(flow_sl2) < 0
        flow_sl2 = flow_sl2 + abs(min(flow_sl2)) + 1;
    end
    if min(flow_sl2) > 0
        flow_sl2 = flow_sl2 - (min(flow_sl2)) + 1;
    end
    
    %     normalize
    flow_sl2 = flow_sl2./max(abs(flow_sl2));
    
    % find the systolic upslope (20% < x < 80%) at or after maxInd of
    % flow_sl1
    [maxFl, indMax2] = max(flow_sl2);
    % 20% of max, first to the left
    indStart = max(find(flow_sl2(1:indMax2) < 0.2*maxFl)) + 1;
    indEnd   = max(find(flow_sl2(indStart:indMax2) < 0.8*maxFl)) + indStart -1;
    pts2 = indStart:indEnd;
    
    switch PWVcalctype
        case 1      % cross-correlation
            %             tempDelay = abs(finddelay(flow_sl1,flow_sl2)) * scale;
            % delay calculated on systolic upstroke only as per Saintounge
            % paperclc; clear all; close all;
            
            sl1 = zeros(size(flow_sl1));sl1(pts1) = flow_sl1(pts1);
            sl2 = zeros(size(flow_sl2));sl2(pts2) = flow_sl2(pts2);
            tempDelay = abs(finddelay(sl1,sl2)) * scale;
            if (dist_total(slice-1) > 20 && tempDelay < 1) || ...
                    (dist_total(slice-1) > 40 && tempDelay < 2) || ...
                    (dist_total(slice-1) > 60 && tempDelay < 3) || ...
                    (dist_total(slice-1) > 80 && tempDelay < 4) || ...
                    (dist_total(slice-1) > 100 && tempDelay < 6)
                % force the delays to make sense along vessel
                ind = cat(1,ind,slice);     % to remove at the end for fitting
            end
            D(slice-1) = tempDelay * scale;
            
        case 2      % TTF
            fitObject = polyfit(pts2,flow_sl2(pts2),1);
            D(slice) = -fitObject(2) / fitObject(1);
            
        case 3      % Wavelet time delay estimation
            [y2,~,~,~,~,~,~] = contwt(flow_sl2,0.001,1,[],[],[],'dog',4);

            % cross-spectrum is only performed on 
            % 1) points during systole
            % 2) over frequencies as between fc and 10 Hz
            % the points between foot of flow_sl1 and peak of flow_sl2
            pts = unique([pts1, pts2]);
            fc = 1/numel(pts);     % in Hz, the fundamental freq
            ind_f = find(f1 >= fc & f1 <= 10);
            
            % the complex cross-spectrum
            y = y1(ind_f,pts).*conj(y2(ind_f,pts));
              
            % calculate y_hat
            y_hat = y/(sum(sum(abs(y))));
            
            psi =   atan2(imag(y),real(y))./repmat(f1(ind_f)'*2*pi,[1 length(pts)]);
            aa =    dot(y_hat,psi);  % eqn 7 in Bargiotas paper
            
%             tempDelay = abs(sum(aa(:)))*1000*4 * scale;
            tempDelay = abs(sum(aa(:)))*1000 * scale;
            if (dist_total(slice-1) > 20 && tempDelay < 1) || ...
                    (dist_total(slice-1) > 40 && tempDelay < 2) || ...
                    (dist_total(slice-1) > 60 && tempDelay < 3) || ...
                    (dist_total(slice-1) > 80 && tempDelay < 4) || ...
                    (dist_total(slice-1) > 100 && tempDelay < 6)
                % force the delays to make sense along vessel
                ind = cat(1,ind,slice);     % to remove at the end for fitting
            end
            D(slice - 1) = tempDelay;
    end
    
    
    if plot_steps && mod(slice,10) == 2
        figure(400); clf;
        plot(flow_sl1,'r'); hold on;
        plot(pts1,flow_sl1(pts1),'r*')
        plot(flow_sl2,'b')
        plot(pts2,flow_sl2(pts2),'b*')
        legend('flow 1','flow 1 upslope', 'flow 2','flow 2 upslope')
        xlabel('time (ms)')
        title(['Point ' num2str(slice) ', delay = ' num2str(D(slice-1)) ' ms'])
        pause(0.1)
    end
    
end
% remove unused slices
D(ind-1) = [];
dist_total(ind-1) = [];

% remove outliers
[D, TF] = rmoutliers(D,'movmedian', 30, 'ThresholdFactor',2);
dist_total(find(TF)) = [];

% now do a linear fit to calculate slope, save also rmse
[fitObject, ~] = polyfit(dist_total,D,1);
