function [clim, thresholds, ylim] = getView4DClims(handles)
if get(handles.UScale,'value')
	clim = str2double(get(handles.MaxIntEdit,'String'));
	if isempty(clim)
		clim = getappdata(handles.GDScale,'Scale');
	else
		if strcmpi(getappdata(handles.GDScale,'ScaleLimitsMode'),'[-max max]')
			clim = [-clim clim];
		elseif strcmpi(getappdata(handles.GDScale,'ScaleLimitsMode'),'[0 max]')
			clim = [0 clim];
		else
			clim = [str2double(get(handles.MinIntEdit,'String')) clim];
		end
	end
	clim = fixCLim(clim);
elseif get(handles.GDScale,'value')
	clim = fixCLim(getappdata(handles.GDScale,'Scale'));
elseif get(handles.GSScale,'value')
	clim = fixCLim(getappdata(handles.GSScale,'Scale'));
else %ISScale
	clim = [];
end

if nargout>1 
	if get(handles.ISScale,'Value')
		thresholds = [];
	else
		thresholds = getappdata(handles.CBAxis,'Thresholds');
	end
end

if nargout>2
	if get(handles.UScale,'Value')
		ylim = getappdata(handles.GDScale,'Scale');
	else
		ylim = clim;
	end
end

function clim = fixCLim(clim)
if clim(1)>=clim(2)
	clim(2) = clim(1)+1;
end