local TDTModAPI_System_String = {};

function TDTModAPI_System_String.StartsWith(value, match)
	return string.sub(value, 1, string.len(match)) == match;
end

function TDTModAPI_System_String.EndsWith(value, match)
	return match == '' or string.sub(value, -string.len(match)) == match
end

function TDTModAPI_System_String.Join(seperator, value)
	local result = "";

	for i, v in ipairs(value) do
		if i == 1 then
			result = v;
		else
			result = result .. seperator .. v;
		end
	end
	
	return result;
end

function TDTModAPI_System_String.Trim(value)
	return string.gsub(value, "^%s*(.-)%s*$", "%1");
end

function TDTModAPI_System_String.IndexOf(originalValue, value, occurence)
	local currentOccurence = 0;
	local stopOccurence = occurence or 1;
	
	for i = 1, #originalValue do
		if i + #value - 1 > #originalValue then
			break;
		end
	
		if originalValue:sub(i, i + #value - 1) == value then
			currentOccurence = currentOccurence + 1;
			
			if currentOccurence == stopOccurence then
				return i;
			end
		end
	end
	
	return 0;
end

function TDTModAPI_System_String.Remove(value, index, count)
	local newString = "";
	local removeCount = 0;
	
	for i = 1, #value do
		if i >= index then
			removeCount = removeCount + 1;
			
			if removeCount > (count or #value) then
				newString = newString .. value:sub(i, i);
			end
		else
			newString = newString .. value:sub(i, i);
		end
	end
	
	return newString;
end

return TDTModAPI_System_String;