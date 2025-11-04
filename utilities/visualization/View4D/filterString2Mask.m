% Converts a filter string into a mask. If the filter string is invalid, it
% is manipulated to form a valid string which is returned in place of a
% mask.
%
% Usage:
% ------
% mask = filterString2Mask(fString)
% mask = filterString2Mask(fString, maxVal) - the number of frames is
% specified to tighten validation.
%
% Example formats include:
% 1-5,9 - frames 1,2,3,4,5, and 9

% By Ran Klein 20-Oct-2005


function mask = filterString2Mask(fString, maxVal)

if nargin==1 || isempty(maxVal)% No maxVal provided
	maxVal = inf;
end
minVal = 1;

nonvalid = false;  % Assume valid filter string
fString = deblank(fString); % Ignore all blanks
if isempty(fString)
	if isfinite(maxVal)
		mask = 1:maxVal;
	else
		mask = [];
	end
	return
end
fString = strrep(fString,'-',':'); % ##-## and ##:## formats are identical
valid = ((fString>='0' & fString<='9') | fString==':' | fString==','); % The valid character set
if any(~valid) % Remove non valid characters from the string
	nonvalid = true;
	fString = fString(valid);
end

mask = [];
corrString = [];
[token, fString] = strtok(fString,',');
while ~isempty(token) || ~isempty(fString)
	i = findstr(token,':');
	if isempty(i) % (##) format
		smask = str2num(token);
		if smask>maxVal
			corrString = [corrString ',' num2str(maxVal)];
			nonvalid = true;
		elseif smask<minVal
			corrString = [corrString ',' num2str(minVal)];
			nonvalid = true;
		else
			corrString = [corrString ',' token];
		end
	elseif length(i)>1
		smask = [];
		nonvalid = true;
	else % (##-## / ##:##) format
		if i==1 || i==length(token)
			smask = [];
			nonvalid = true;
		else
			thisok = true;
			first = str2num(token(1:i-1));
			last = str2num(token(i+1:end));
			if first<minVal
				first = minVal;
				nonvalid = true;  thisok = false;
			end
			if last>maxVal
				last = maxVal;
				nonvalid = true;  thisok = false;
			end
			if thisok
				smask = first:last;
				corrString = [corrString ',' token];
			else
				smask = [];
				if last>first
					corrString = [corrString ',' num2str(first) '-' num2str(last)];
				else
					corrString = [corrString ',' num2str(first)];
				end
			end
		end
	end
	mask = [mask smask];
	[token, fString] = strtok(fString,',');
end

if nonvalid % Was not a valid string then return the corrected string
	if ~isempty(corrString)  % Remove the first character as it is a comma
		corrString = corrString(2:end);
	end
	mask = corrString;
end  % Otherwise the mask is returned