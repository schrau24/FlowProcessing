classdef shearstress
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties
        x          % position along normal vector (in m)
        splinefits % b-spline of velocity (x,y,z) along normal
        shearrates % calculated shearrate (x,y,z) on x = 0
        deri_xy    % analytical derivative
        total_vel  % total velocity sqrt(x^2+y^2+z^2) along normal
        medium = 'blood';
        viscosity_model = 0; % switch; when set to 1, the Carreau-Yasuda model is used in case of blood viscosity.
    end

    properties (Constant, Access = private)
        viscosity_blood = 3.2e-3; %Viscosity in Pa.s
        viscosity_water = 1.0e-3;
        viscosity_cfd_blood = 4e-3; % viscosity used by Pim
    end

    methods
        function obj = shearstress(x,splinefits,shearrates,deri_xy,total_vel,varargin)
            % creator function
            % called when creating the shearstress object
            % input is created in pcmri_image2D
            if nargin > 4
                obj.x = x; obj.splinefits = splinefits; obj.shearrates = shearrates; 
                obj.deri_xy = deri_xy; obj.total_vel = total_vel;
            else 
                error('shearstress:input_invalid','Not enough input arguments.');
            end
            if nargin > 5 && ischar(varargin{1}) && (strcmp(varargin{1},'water') || strcmp(varargin{1},'blood')), 
                obj.medium = varargin{1}; %set viscosity
                if nargin > 6
                    obj.viscosity_model = varargin{2};
                end
            else %use default blood viscosity
                warning('shearstress:viscosity_invalid','String ''blood'' or ''water'' expected. Not found; now using blood viscosity');
            end 
        end
        
        function wallshearstress = wallshearstress(obj,varargin)
            % calculates WSS from shearrate and viscosity
            wallshearstress = obj.shearrates.*obj.viscosity;
            if nargin > 1
                for finddots = find(strcmp(':',varargin));
                    varargin{finddots} = '1:end';
                end
                if nargin >= 2, run = ['wallshearstress([' num2str(varargin{1}) ']']; end
                if nargin >= 3, run = [run ',[' num2str(varargin{2}) ']']; end
                if nargin >= 4, warning('shearstress:wallshearstress','Too many input arguments for wallshearstress. \n Maximum is 2 input arguments, e.g. wallshearstress(:,3). Last inputs are ignored'), end
                run = [run ')']; wallshearstress = eval(run);
            end
        end
        
        function viscosity = viscosity(obj)
            % viscosity constant selected based on medium
            switch obj.medium
                case 'blood'
                    if obj.viscosity_model % Carreau-Yasuda model
                        viscosity = obj.CarreauYasudaViscosity;
                    else
                        viscosity = obj.viscosity_blood;
                    end
                case 'water'
                    if obj.viscosity_model
                        error('Carreau Yasuda only defined for blood; not water')
                    end
                    viscosity = obj.viscosity_water;
                case {'pim_blood','cfd_viscosity'}
                    if obj.viscosity_model % Carreau-Yasuda model
                        viscosity = obj.CarreauYasudaViscosity;
                    else
                        viscosity = obj.viscosity_cfd_blood;
                    end
                    
                otherwise
                    error('shearstress:viscosity_calculation','Viscosity value not found.')
            end
        end
        
        function display(obj)
            fprintf('\n================================\n\n')
            disp('SHEARSTRESS OBJECT')
            fprintf('\n');
            disp(['    Medium: ' obj.medium ]);
            temp_viscosity = obj.viscosity; if length(temp_viscosity)>1, ad = ' (Carreau-Yasuda blood viscosity model)'; else ad = ' (constant viscosity)'; end
            disp([' Viscosity: ' num2str(nanmean(temp_viscosity(:))) ' +/- ' num2str(nanstd(temp_viscosity(:))) ' Pa s' ad]);
            fprintf('\n')            
            disp( 'Shearstress ');
            disp(['    - mean: ' num2str(nanmean(obj.wallshearstress)) ' Pa']);
            disp(['    -  std: '  num2str(nanstd(obj.wallshearstress,1,1)) ' Pa']);
            fprintf('\n')
            disp(['  Splinefits using ' num2str(length(obj.x(1,:))) ' points']);
            disp(obj.splinefits{randi([1 length(obj.splinefits)],1,1)})
            fprintf('================================\n')
            
            fh = figure('Name','WSS histogram','NumberTitle','off'); clf; [n,xout]=hist(sqrt(sum(obj.wallshearstress.^2,2)),6); 
            bar(xout,n,'FaceColor',[0.2 .6 0.2]); 

            title('Histogram of WSS values'); xlabel('WSS (Pa)'); ylabel('#'); hold on;
            plot([mean(sqrt(sum(obj.wallshearstress.^2,2))),mean(sqrt(sum(obj.wallshearstress.^2,2)))],[-.1*max(n) 1.1*max(n)],'r-','LineWidth',3);
            plot([mean(sqrt(sum(obj.wallshearstress.^2,2))),mean(sqrt(sum(obj.wallshearstress.^2,2)))]-[std(sqrt(sum(obj.wallshearstress.^2,2))),std(sqrt(sum(obj.wallshearstress.^2,2)))],[-.1*max(n) 1.1*max(n)],'b-','LineWidth',3);
            plot([mean(sqrt(sum(obj.wallshearstress.^2,2))),mean(sqrt(sum(obj.wallshearstress.^2,2)))]+[std(sqrt(sum(obj.wallshearstress.^2,2))),std(sqrt(sum(obj.wallshearstress.^2,2)))],[-.1*max(n) 1.1*max(n)],'b-','LineWidth',3);
            text(mean(sqrt(sum(obj.wallshearstress.^2,2))),1.12*max(n),'Mean WSS','FontSize',15,'HorizontalAlignment','center')
            text(mean(sqrt(sum(obj.wallshearstress.^2,2)))-std(sqrt(sum(obj.wallshearstress.^2,2))),1.12*max(n),'-1 SD','FontSize',15,'HorizontalAlignment','center')
            text(mean(sqrt(sum(obj.wallshearstress.^2,2)))+std(sqrt(sum(obj.wallshearstress.^2,2))),1.12*max(n),'+1 SD','FontSize',15,'HorizontalAlignment','center')
            legend('WSS','mean','mean +/- SD');
%             beautifyFigure(fh); %pause; close(fh);
        end
        
        function fh = inspect(obj,varargin)
            if nargin >= 2
                curvenr = varargin{1};
                if curvenr > size(obj.x,1)
                    curvenr = size(obj.x,1);
                end
            else
                curvenr = 1;
            end
            fh = figure(18372193); set(fh,'Name','Shear rate fitting of curve','NumberTitle','off','Position',[55 10 900 800]); clf;
            
            title(['Shear rate fitting of curve: ' num2str(curvenr) ]); xlabel('x (m)'); ylabel('Velocity (m/s)');hold on;
            if isempty(obj.splinefits{curvenr})
                return;
            end
            x = obj.x{curvenr,:}; %#ok<*PROP>
            xx = linspace(min(x),max(x),100);
           
            y = fnval(obj.splinefits{curvenr},x);
            dy = fnval(fnder(obj.splinefits{curvenr}),0);
            yy = fnval(obj.splinefits{curvenr},xx);
            
            % CURVES
            plot(x,y(1,:),'r.','MarkerSize',25); plot(xx,yy(1,:),'r--','LineWidth',3);
            plot(x,y(2,:),'g.','MarkerSize',25); plot(xx,yy(2,:),'g-.','LineWidth',3);
            plot(x,y(3,:),'b.','MarkerSize',25); plot(xx,yy(3,:),'b--','LineWidth',3);
            
            % DERIVATIVES
            plot(xx,dy(1).*xx,'r--','LineWidth',2);
            plot(xx,dy(2).*xx,'g--','LineWidth',2);
            plot(xx,dy(3).*xx,'b--','LineWidth',2);
            legend('x-r','','y-g','','z-b','');
%             beautifyFigure(fh); hold off;
            %axis([0 .0057 -.52 .52])
            axis tight
%             %%% TEMP
%             fh2 = figure(123415231); set(fh2,'Name','WSS curve loc','Position',[1000 10 280 230])
%             clf;
%             global ver fac
%             patch('vertices',ver,'faces',fac,'EdgeColor','none','FaceColor',[0.5 0.5 0.5],'FaceAlpha',.2)
%             axis equal; axis vis3d; view(90,0); axis tight; hold on
%             plot3(ver(curvenr,1),ver(curvenr,2),ver(curvenr,3),'r*'); hold off;
%             
%             %%% TEMP
%             fh3 = figure(123415232); set(fh3,'Name','WSS curve loc','Position',[1000 250 280 230])
%             clf;
%             patch('vertices',ver,'faces',fac,'EdgeColor','none','FaceColor',[0.5 0.5 0.5],'FaceAlpha',.2)
%             axis equal; axis vis3d; view(0,0); axis tight; hold on
%             plot3(ver(curvenr,1),ver(curvenr,2),ver(curvenr,3),'r*'); hold off;
%             global curpt 
%             curpt = ver(curvenr,:);
        end
        
        function inspectAll(obj)
            for m = 1:size(obj.x,1)
                obj.inspect(m);
                drawnow;
            end
        end

        % Carreau-Yasuda model blood viscosity
        viscosities = CarreauYasudaViscosity(obj)
    end

end