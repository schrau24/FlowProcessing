function [D, fitObject, R, dist_total] = calc_pwv(waveforms,dist_total, timeres, PWVcalctype, AreaScale)
warning('off','all')
% waveforms = waveforms./repmat(AreaScale',[1 size(waveforms,2)]);
% PWV calc type: 1 is cross correlation, 2 is Wavelet
% normalize waveforms
% [waveforms,C,S] = normalize(waveforms', 'norm');
% waveforms = waveforms';

% to interp to 1 ms, we need how many frames?
nFrames = size(waveforms,2);
nFrames_interp = floor(timeres*nFrames);

% interp params
x = 1:nFrames;
xq = linspace(1,nFrames,nFrames_interp);
METHOD = 'linear';
smoothAmount = 25;
plot_steps = false;

% grab first flow waveform
flow_sl1 = smoothdata(interp1(x,waveforms(1,:),xq,METHOD),'sgolay',smoothAmount);

if min(flow_sl1) < 0
    flow_sl1 = flow_sl1 + abs(min(flow_sl1));
elseif min(flow_sl1) > 0
    flow_sl1 = flow_sl1 - min(flow_sl1);
end

% find the systolic upslope, Wavelet
[maxFl, indMax1] = max(flow_sl1);

flow_sl1=flow_sl1/maxFl;

% circshift to put max at center
midPt = round(length(flow_sl1)/2);
flow_sl1 = circshift(flow_sl1, midPt-indMax1);
fl1_copy = circshift(interp1(x,waveforms(1,:),xq,METHOD), midPt-indMax1);

% 20% of max, first to the left
indStart = max(find(flow_sl1(1:midPt) < 0.2)) + 1;
indEnd   = max(find(flow_sl1(indStart:midPt) < 0.8)) + indStart -1;

pts1 = indStart:indEnd;

% for wavelet
[y1,PERIOD,SCALE,COI,DJ, PARAMOUT, K] = contwt(flow_sl1,0.001,1,[],[],[],'dog',4);
f1 = 1./PERIOD;
% loop over all flow curves
for slice = 2:size(waveforms,1)
    
    % second flow waveform, circshift by same amount as first waveform
    flow_sl2 = smoothdata(circshift(interp1(x,waveforms(slice,:),xq,METHOD), midPt-indMax1),'sgolay',smoothAmount);
    fl2_copy = circshift(interp1(x,waveforms(slice,:),xq,METHOD), midPt-indMax1);
    if min(flow_sl2) < 0
        flow_sl2 = flow_sl2 + abs(min(flow_sl2));
    elseif min(flow_sl2)>0
        flow_sl2 = flow_sl2-min(flow_sl2);
    end
     
    % find the systolic upslope (20% < x < 80%) at or after maxInd of
    % flow_sl1
    [maxFl, indMax2] = max(flow_sl2);
    
    flow_sl2=flow_sl2/maxFl;
    
    % 20% of max, first to the left
    indStart = max(find(flow_sl2(1:indMax2) < 0.2)) + 1;
    indEnd   = max(find(flow_sl2(indStart:indMax2) < 0.8)) + indStart -1;
    pts2 = indStart:indEnd;
    
    switch PWVcalctype
        case 1      % cross-correlation
            sl1 = zeros(size(flow_sl1));sl1(pts1) = flow_sl1(pts1);
            sl2 = zeros(size(flow_sl2));sl2(pts2) = flow_sl2(pts2);
            tempDelay = abs(finddelay(sl1,sl2));
            D(slice-1) = tempDelay;
            
        case 2      % Wavelet time delay estimation
            [y2,~,~,~,~,~,~] = contwt(flow_sl2,0.001,1,[],[],[],'dog',4);

            % cross-spectrum is only performed on 
            % 1) points during systole
            % 2) over frequencies between fc and 10 Hz
            % the points between foot of flow_sl1 and peak of flow_sl2
            pts = unique([pts1, pts2]);
            fc = 1/(numel(pts)*1000);     % in Hz, the fundamental freq
            ind_f = find(f1 >= fc & f1 <= 10);
            
            % the complex cross-spectrum
            y = y1(ind_f,pts).*conj(y2(ind_f,pts));
              
            % calculate y_hat
            y_hat = y/(sum(sum(abs(y))));
            
            psi =   atan2(imag(y),real(y))./repmat(f1(ind_f)'*2*pi,[1 length(pts)]);
            aa =    dot(y_hat,psi);  % eqn 7 in Bargiotas paper
            tempDelay = abs(sum(aa(:)))*1000;
            
            % re-scale delay from zscore
%             [~, m1, s1] = zscore(fl1_copy(pts));
%             [~, m2, s2] = zscore(fl2_copy(pts));
%             tempDelay = tempDelay/(s1/s2);  
%             tempDelay = tempDelay*(S(1)/S(slice));
            D(slice - 1) = tempDelay;
    end
    
    if plot_steps && mod(slice,10) == 5
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

% remove outliers
[D, TF] = rmoutliers(D,'movmedian', 30, 'ThresholdFactor',2);
dist_total(find(TF)) = [];

idx = isnan(D);
D(idx) = []; dist_total(idx) = [];

if length(D) > 1
    [fitObject] = polyfitZero(dist_total,D,1);
    R = corrcoef(dist_total,D);
else
    fitObject = nan;
    R = nan;
end
warning('on','all')