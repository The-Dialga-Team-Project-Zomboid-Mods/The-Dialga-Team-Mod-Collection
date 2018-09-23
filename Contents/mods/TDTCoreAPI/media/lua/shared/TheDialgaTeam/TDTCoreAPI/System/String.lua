--- @class TheDialgaTeam.TDTCoreAPI.System.String @Represents text as a sequence of UTF-16 code units.
local TDTCoreAPI_System_String = {};

-- Static Compare

-- Static Concat

-- Static Format

--- Indicates whether the specified string is nil or an empty string.
--- @param value string @The string to test.
--- @return boolean @true if the value parameter is nil or an empty string (""); otherwise, false.
function TDTCoreAPI_System_String.IsNullOrEmpty(value)
    return value == nil or string.len(tostring(value)) == 0;
end

--- Indicates whether a specified string is nil, empty, or consists only of white-space characters.
--- @param value string @The string to test.
--- @return boolean @true if the value parameter is nil or empty, or if value consists exclusively of white-space characters.
function TDTCoreAPI_System_String.IsNullorWhiteSpace(value)
    local newValue = TDTCoreAPI_System_String:new(tostring(value));

    return TDTCoreAPI_System_String.IsNullOrEmpty(newValue:Trim());
end

--- Concatenates all the elements of a string array, using the specified separator between each element.
--- @param separator string | TheDialgaTeam.TDTCoreAPI.System.String @The string to use as a separator. separator is included in the returned string only if value has more than one element.
--- @param value string[] | TheDialgaTeam.TDTCoreAPI.System.String[] @An array that contains the elements to concatenate.
--- @return string @A string that consists of the elements in value delimited by the separator string. If value is an empty array, the method returns an empty string.
function TDTCoreAPI_System_String.Join(separator, value)
    local newString = "";

    for i, v in ipairs(value) do
        if i == 1 then
            newString = tostring(v);
        else
            newString = newString .. tostring(separator) .. tostring(v);
        end
    end

    return newString;
end

--[[
Non Static functions
--]]

-- CompareTo

--- Returns a value indicating whether a specified substring occurs within this string.
--- @param value2 string @The string to seek.
--- @return boolean @true if the value parameter occurs within this string, or if value is the empty string (""); otherwise, false.
function TDTCoreAPI_System_String.Contains(value, value2)
    return TDTCoreAPI_System_String.IndexOf(value, tostring(value2), false) >= 1;
end

--- Determines whether the end of this string instance matches the specified string.
--- @overload fun(value:string, value2:string):boolean
--- @param value string @The string to compare.
--- @param value2 string @The string to compare.
--- @param ignoreCase boolean @true to ignore case during the comparison; otherwise, false.
--- @return boolean @true if value matches the end of this instance; otherwise, false.
function TDTCoreAPI_System_String.EndsWith(value, value2, ignoreCase)
    local newInstance = value;
    local newValue = tostring(value2);

    if ignoreCase or false then
        newInstance = string.lower(newInstance);
        newValue = string.lower(newValue);
    end

    return newInstance == newValue or string.len(newValue) == 0 or string.sub(newInstance, -string.len(newValue)) == newValue;
end

--- Determines whether two specified string instance have the same value.
--- @overload fun(value:string, value2:string):boolean
--- @param value string @The string to compare.
--- @param value2 string @The string to compare.
--- @param ignoreCase boolean @true to ignore case during the comparison; otherwise, false.
--- @return boolean @true if the value of the a parameter is equal to the value of the b parameter; otherwise, false.
function TDTCoreAPI_System_String.Equals(value, value2, ignoreCase)
    local newInstance = value;
    local newValue = tostring(value2);

    if ignoreCase or false then
        newInstance = string.lower(newInstance);
        newValue = string.lower(newValue);
    end

    return newInstance == newValue;
end

--- Reports the one-based index of the first occurrence of the specified string in the current string instance.
--- Parameters specify the starting search position in the current string, the number of characters in the current string to search, and the type of search to use for the specified string.
--- @overload fun(value:string, value2:string):number
--- @overload fun(value:string, value2:string, startIndex:number):number
--- @overload fun(value:string, value2:string, startIndex:number, count:number):number
--- @overload fun(value:string, value2:string, ignoreCase:boolean):number
--- @overload fun(value:string, value2:string, startIndex:number, ignoreCase:boolean):number
--- @overload fun(value:string, value2:string, startIndex:number, count:number, ignoreCase:boolean):number
--- @param value string @The string to compare.
--- @param value2 string @The string to seek.
--- @param startIndex number @The search starting position.
--- @param count number @The number of character positions to examine.
--- @param ignoreCase boolean @true to ignore case during the comparison; otherwise, false.
--- @return number @The one-based index position of the value parameter from the start of the current instance if that string is found, or 0 if it is not. If value is empty, the return value is startIndex.
function TDTCoreAPI_System_String.IndexOf(value, value2, startIndex, count, ignoreCase)
    local newInstance = value;
    local newValue = tostring(value2);
    local newStartIndex = startIndex;
    local newCount = count;
    local newIgnoreCase = ignoreCase;

    if type(newStartIndex) == "boolean" then
        newStartIndex = 1;
        newIgnoreCase = startIndex;
    elseif newStartIndex == nil then
        newStartIndex = 1;
    end

    if type(count) == "boolean" then
        newCount = string.len(newValue);
        newIgnoreCase = count;
    elseif newCount == nil then
        newCount = string.len(newValue)
    end

    if type(ignoreCase) == "boolean" then
        newIgnoreCase = ignoreCase;
    end

    if ignoreCase or false then
        newInstance = string.lower(newInstance);
        newValue = string.lower(newValue);
    end

    for i = newStartIndex, newStartIndex + newCount - 1 do
        if i + string.len(newValue) - 1 > string.len(newInstance) then
            break;
        end

        if string.len(newValue) > newCount then
            if string.sub(newInstance, i, i + newCount - 1) == newValue then
                return i;
            end
        else
            if string.sub(newInstance, i, i + newValue:len() - 1) == newValue then
                return i;
            end
        end
    end

    return 0;
end

-- IndexOfAny

--- Returns a new string in which a specified string is inserted at a specified index position in this instance.
--- @param value string @The string to insert.
--- @param startIndex number @The one-based index position of the insertion.
--- @param value2 string @The string to insert.
--- @return string @A new string that is equivalent to this instance, but with value inserted at position startIndex.
function TDTCoreAPI_System_String.Insert(value, startIndex, value2)
    local newInstance = value;
    local newValue = tostring(value2);

    if startIndex > string.len(newInstance) then
        return newInstance .. newValue;
    elseif startIndex == 1 then
        return newValue .. newInstance;
    else
        return string.sub(newInstance, 1, startIndex - 1) .. newValue .. string.sub(newInstance, startIndex);
    end
end

-- LastIndexOf

-- LastIndexOfAny

--- Returns a new string that right-aligns the characters in this instance by padding them on the left with a specified Unicode character, for a specified total length.
--- @overload fun(value:string, totalWidth:number):string
--- @param value string @The string to pad left.
--- @param totalWidth number @The number of characters in the resulting string, equal to the number of original characters plus any additional padding characters.
--- @param paddingChar string @A Unicode padding character.
--- @return string @A new string that is equivalent to this instance, but right-aligned and padded on the left with as many paddingChar characters as needed to create a length of totalWidth. However, if totalWidth is less than the length of this instance, the method returns a reference to the existing instance. If totalWidth is equal to the length of this instance, the method returns a new string that is identical to this instance.
function TDTCoreAPI_System_String.PadLeft(value, totalWidth, paddingChar)
    local newInstance = value;
    local newPaddingChar = string.sub(tostring(paddingChar or " "), 1, 1);

    if totalWidth <= string.len(newInstance) then
        return newInstance;
    else
        for i = 1, totalWidth - string.len(newInstance) do
            newInstance = newPaddingChar .. newInstance;
        end

        return newInstance;
    end
end

--- Returns a new string that left-aligns the characters in this string by padding them on the right with a specified Unicode character, for a specified total length.
--- @overload fun(value:string, totalWidth:number):string
--- @param value string @The string to pad right.
--- @param totalWidth number @The number of characters in the resulting string, equal to the number of original characters plus any additional padding characters.
--- @param paddingChar string @A Unicode padding character.
--- @return string @A new string that is equivalent to this instance, but left-aligned and padded on the right with as many paddingChar characters as needed to create a length of totalWidth. However, if totalWidth is less than the length of this instance, the method returns a reference to the existing instance. If totalWidth is equal to the length of this instance, the method returns a new string that is identical to this instance.
function TDTCoreAPI_System_String.PadRight(value, totalWidth, paddingChar)
    local newInstance = value;
    local newPaddingChar = string.sub(tostring(paddingChar or " "), 1, 1);

    if totalWidth <= string.len(newInstance) then
        return newInstance;
    else
        for i = 1, totalWidth - string.len(newInstance) do
            newInstance = newInstance .. newPaddingChar;
        end

        return newInstance;
    end
end

--- Returns a new string in which a specified number of characters in the current instance beginning at a specified position have been deleted.
--- @overload fun(value:string, startIndex:number):string
--- @param value string @The string to remove.
--- @param startIndex number @The one-based position to begin deleting characters.
--- @param count number @The number of characters to delete.
--- @return string @A new string that is equivalent to this instance except for the removed characters.
function TDTCoreAPI_System_String.Remove(value, startIndex, count)
    local newInstance = value;
    local newString = "";
    local removeCount = 0;

    for i = 1, string.len(newInstance) do
        if i >= startIndex then
            removeCount = removeCount + 1;

            if removeCount > (count or string.len(newInstance)) then
                newString = newString .. string.sub(newInstance, i, i);
            end
        else
            newString = newString .. string.sub(newInstance, i, i);
        end
    end

    return newString;
end

-- Replace

-- Split

--- Determines whether the beginning of this string instance matches the specified string when compared using the specified comparison option.
--- @param value string @The string to compare.
--- @param value2 string @The string to compare.
--- @param ignoreCase boolean @true to ignore case during the comparison; otherwise, false.
--- @return boolean @true if this instance begins with value; otherwise, false.
function TDTCoreAPI_System_String.StartsWith(value, value2, ignoreCase)
    local newInstance = value;
    local newValue = tostring(value2);

    if ignoreCase or false then
        newInstance = string.lower(newInstance);
        newValue = string.lower(newValue);
    end

    return newInstance == newValue or string.len(newValue) == 0 or string.sub(newInstance, 1, string.len(newValue)) == newValue;
end

-- SubString

-- ToCharArray

--- Returns a copy of this string converted to lowercase.
--- @param value string @The string to convert to lowercase.
--- @return string @A string in lowercase.
function TDTCoreAPI_System_String.ToLower(value)
    return string.lower(value);
end

--- Returns a copy of this string converted to uppercase.
--- @param value string @The string to convert to uppercase.
--- @return string @The uppercase equivalent of the current string.
function TDTCoreAPI_System_String:ToUpper(value)
    return string.upper(value);
end

--- Removes all leading and trailing occurrences of a set of characters specified in an array from the current string object.
--- @param value string @The string to trim.
--- @return string @The string that remains after all white-space characters are removed from the start and end of the current string. If no characters can be trimmed from the current instance, the method returns the current instance unchanged.
function TDTCoreAPI_System_String.Trim(value)
    return string.gsub(value, "^%s*(.-)%s*$", "%1");
end

--- Removes all trailing occurrences of a set of characters specified in an array from the current string object.
--- @param value string @The string to trim.
--- @return string @The string that remains after all white-space characters are removed from the end of the current string. If no characters can be trimmed from the current instance, the method returns the current instance unchanged.
function TDTCoreAPI_System_String.TrimEnd(value)
    return string.gsub(value,"^(.-)%s*$", "%1");
end

--- Removes all trailing occurrences of a set of characters specified in an array from the current string object.
--- @param value string @The string to trim.
--- @return string @The string that remains after all white-space characters are removed from the start of the current string. If no characters can be trimmed from the current instance, the method returns the current instance unchanged.
function TDTCoreAPI_System_String.TrimStart(value)
    return string.gsub(value,"^%s*(.-)$", "%1");
end

return TDTCoreAPI_System_String;