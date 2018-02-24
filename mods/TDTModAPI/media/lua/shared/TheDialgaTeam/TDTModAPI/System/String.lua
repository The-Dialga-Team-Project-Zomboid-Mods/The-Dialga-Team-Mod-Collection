local TDTModAPI_System_String = {};

--- Determines whether the end of this string instance matches the specified string.
-- @param instance
-- @param value The string to compare to the substring at the end of this instance.
-- @param ignoreCase true to ignore case during the comparison; otherwise, false.
-- @return true if value matches the end of this instance; otherwise, false.
function TDTModAPI_System_String.EndsWith(instance, value, ignoreCase)
    if instance == nil then
        error "ArgumentNullException: instance is null.";
    elseif value == nil then
        error "ArgumentNullException: value is null.";
    elseif type(instance) ~= "string" then
        error "ArgumentException: instance is not a string.";
    elseif type(value) ~= "string" then
        error "ArgumentException: value is not a string.";
    elseif ignoreCase ~= nil and type(ignoreCase) ~= "boolean" then
        error "ArgumentException: ignoreCase is not a boolean.";
    end

    if ignoreCase or false then
        local newInstance = instance:lower();
        local newValue = value:lower();

        if newInstance == newValue then
            return true;
        elseif newValue:len() == 0 then
            return true;
        else
            return newInstance:sub(-newValue:len()) == newValue;
        end
    else
        if instance == value then
            return true;
        elseif value:len() == 0 then
            return true;
        else
            return instance:sub(-value:len()) == value;
        end
    end
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

function TDTModAPI_System_String.StartsWith(value, match)
	return string.sub(value, 1, string.len(match)) == match;
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
	return value:gsub("^%s*(.-)%s*$", "%1");
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