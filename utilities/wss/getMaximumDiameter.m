function D = getMaximumDiameter(F,V,N)
% D = getMaximumDiameter(F,V,N)
% diameters D [X 1]
% Faces     F [Y 3] (connection of edge points)
% Vertices  V [X 3] (edge points of triangles)
% Normals   N [X 3] (inward normals of points)
% uses intersectLineTriangle3d by David Legland, 2011
% uses patchnormals by D. Croon
% (Both obtained through MathWorks FileExchange)
%
% Code was edited by Wouter Potters, 2012

%plot_on = 1;

t1 = tic;
color_magnitudes = nan(size(V,1),1);

% operation takes +/-420 seconds on 1 CPU on Mac OS X laptop with ...
% points

% %mlps = matlabpool('size'); % matlab pool size // number of cpu's available
% if mlps == 0; mlps = 1; end
% total_time = num2str(ceil((0.027*numel(V(:,1))) / (mlps*60))+1);
% currenttime = sprintf('%.0f%.0f%.0f:%.0f,%.0f',((fix(clock) .* [0 0 1 1 1 1])'));
% if mlps > 1, cputxt = '''s'; else cputxt =''; end
%disp(['busy calculating ray triangle intersections.... ' total_time ' minutes left on ' num2str(mlps) ' cpu' cputxt ' starting from: ' currenttime])

parfor i_v = 1:length(V)
    [~, posOfIntersection, ~] = intersectLineMesh3d([V(i_v,:) N(i_v,:)], V, F);
    
    posOfIntersection(posOfIntersection < 10^-10) = [];
    
    if ~isempty(posOfIntersection)
        color_magnitudes(i_v) = abs(posOfIntersection(find( abs(posOfIntersection) == min(abs(posOfIntersection)), 1, 'first' )))
    end
end

D = color_magnitudes;
toc(t1)
%disp(['finished calculating ' length(V)^2 ' ray-triangle intersections! At time: ' currenttime])