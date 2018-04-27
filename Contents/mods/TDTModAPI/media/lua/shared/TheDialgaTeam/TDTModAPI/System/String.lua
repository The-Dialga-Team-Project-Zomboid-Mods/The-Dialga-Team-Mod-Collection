--- @type TheDialgaTeam.TDTModAPI.System.Object
local Object = require "TheDialgaTeam/TDTModAPI/System/Object";

--- @type TheDialgaTeam.TDTModAPI.Lua.Table
local Table = require "TheDialgaTeam/TDTModAPI/Lua/Table";

--- @type TheDialgaTeam.TDTModAPI.Lua.Assert
local Assert = require "TheDialgaTeam/TDTModAPI/Lua/Assert";

--- @class TheDialgaTeam.TDTModAPI.System.String
--- @field public Empty string
local TDTModAPI_System_String = {};

--- Represents the empty string. This field is read-only.
TDTModAPI_System_String.Empty = "";

--- Initializes a new instance of the string class to the value indicated by a specified pointer to an array of Unicode characters.
--- @param value string A pointer to a null-terminated array of Unicode characters.
--- @return TheDialgaTeam.TDTModAPI.System.String.Instance A new instance of the string.
function TDTModAPI_System_String.new(value)
    --- @class TheDialgaTeam.TDTModAPI.System.String.Instance : TheDialgaTeam.TDTModAPI.System.Object.Instance
    local self = Object.new();

    self.__Type = "TheDialgaTeam.TDTModAPI.System.String";
    self.__Value = value;

    --- Returns a reference to this instance of string.
    --- @return TheDialgaTeam.TDTModAPI.System.String.Instance A reference to this instance of string.
    function self:Clone()
        return Table.Copy(self);
    end

    -- CompareTo

    --- Returns a value indicating whether a specified substring occurs within this string.
    --- @param value string | TheDialgaTeam.TDTModAPI.System.String.Instance
    --- @return boolean true if the value parameter occurs within this string, or if value is the empty string (""); otherwise, false.
    function self:Contains(value)
        local status, error = pcall(function ()
            if value == nil then
                error "ArgumentNullException: value is null.";
            elseif type(value) ~= "string" and type(value) ~= "table" then
                error "ArgumentException: value is not a string.";
            end
        end);

        if status then
            return self:IndexOf(tostring(value), false) >= 1;
        else
            print(error);
            return nil;
        end
    end

    --- Determines whether the end of this string instance matches the specified string.
    --- @overload fun(value:string | TheDialgaTeam.TDTModAPI.System.String.Instance):boolean
    --- @param value string | TheDialgaTeam.TDTModAPI.System.String.Instance The string to compare to the substring at the end of this instance.
    --- @param ignoreCase boolean true to ignore case during the comparison; otherwise, false.
    --- @return boolean true if value matches the end of this instance; otherwise, false.
    function self:EndsWith(value, ignoreCase)
        local status, error = pcall(function ()
            if value == nil then
                error "ArgumentNullException: value is null.";
            elseif type(value) ~= "string" and type(value) ~= "table" then
                error "ArgumentException: value is not a string.";
            end

            Assert.AssertBoolean(ignoreCase, "ignoreCase", true);
        end);

        if status then
            local newInstance = self.__Value;
            local newValue = tostring(value);

            if ignoreCase or false then
                newInstance = string.lower(newInstance);
                newValue = string.lower(newValue);
            end

            return newInstance == newValue or string.len(newValue) == 0 or string.sub(newInstance, -string.len(newValue)) == newValue;
        else
            print(error);
            return nil;
        end
    end

    --- Determines whether two specified string instance have the same value.
    --- @overload fun(value:string | TheDialgaTeam.TDTModAPI.System.String.Instance):boolean
    --- @param value string | TheDialgaTeam.TDTModAPI.System.String.Instance The string to compare to this instance.
    --- @param ignoreCase boolean true to ignore case during the comparison; otherwise, false.
    --- @return boolean true if the value of the a parameter is equal to the value of the b parameter; otherwise, false.
    function self:Equals(value, ignoreCase)
        local status, error = pcall(function ()
            if value == nil then
                error "ArgumentNullException: value is null.";
            elseif type(value) ~= "string" and type(value) ~= "table" then
                error "ArgumentException: value is not a string.";
            end

            Assert.AssertBoolean(ignoreCase, "ignoreCase", true);
        end);

        if status then
            local newInstance = self.__Value;
            local newValue = tostring(value);

            if ignoreCase or false then
                newInstance = string.lower(newInstance);
                newValue = string.lower(newValue);
            end

            return newInstance == newValue;
        else
            print(error);
            return nil;
        end
    end

    --- Reports the one-based index of the first occurrence of the specified string in the current string instance.
    --- Parameters specify the starting search position in the current string, the number of characters in the current string to search, and the type of search to use for the specified string.
    --- @overload fun(value:string | TheDialgaTeam.TDTModAPI.System.String.Instance):number
    --- @overload fun(value:string | TheDialgaTeam.TDTModAPI.System.String.Instance, startIndex:number):number
    --- @overload fun(value:string | TheDialgaTeam.TDTModAPI.System.String.Instance, startIndex:number, count:number):number
    --- @overload fun(value:string | TheDialgaTeam.TDTModAPI.System.String.Instance, ignoreCase:boolean):number
    --- @overload fun(value:string | TheDialgaTeam.TDTModAPI.System.String.Instance, startIndex:number, ignoreCase:boolean):number
    --- @overload fun(value:string | TheDialgaTeam.TDTModAPI.System.String.Instance, startIndex:number, count:number, ignoreCase:boolean):number
    --- @param value string | TheDialgaTeam.TDTModAPI.System.String.Instance The string to seek.
    --- @param startIndex number The search starting position.
    --- @param count number The number of character positions to examine.
    --- @param ignoreCase boolean true to ignore case during the comparison; otherwise, false.
    --- @return number The one-based index position of the value parameter from the start of the current instance if that string is found, or 0 if it is not. If value is empty, the return value is startIndex.
    function self:IndexOf(value, startIndex, count, ignoreCase)
        local status, error = pcall(function ()
            if value == nil then
                error "ArgumentNullException: value is null.";
            elseif type(value) ~= "string" and type(value) ~= "table" then
                error "ArgumentException: value is not a string.";
            end
        end);

        if status then
            local newInstance = self.__Value;
            local newValue = tostring(value);
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
        else
            print(error);
            return nil;
        end
    end

    -- IndexOfAny

    --- Returns a new string in which a specified string is inserted at a specified index position in this instance.
    --- @param startIndex number The one-based index position of the insertion.
    --- @param value string | TheDialgaTeam.TDTModAPI.System.String.Instance The string to insert.
    --- @return TheDialgaTeam.TDTModAPI.System.String.Instance A new string that is equivalent to this instance, but with value inserted at position startIndex.
    function self:Insert(startIndex, value)
        local status, error = pcall(function ()
            if value == nil then
                error "ArgumentNullException: value is null.";
            elseif type(value) ~= "string" and type(value) ~= "table" then
                error "ArgumentException: value is not a string.";
            end

            Assert.AssertNumber(startIndex, "startIndex");
        end);

        if status then
            local newInstance = self.__Value;
            local newValue = tostring(value);

            if startIndex > string.len(newInstance) then
                return TDTModAPI_System_String.new(newInstance .. newValue);
            elseif startIndex == 1 then
                return TDTModAPI_System_String.new(newValue .. newInstance);
            else
                return TDTModAPI_System_String.new(string.sub(newInstance, 1, startIndex - 1) .. newValue .. string.sub(newInstance, startIndex));
            end
        else
            print(error);
            return nil;
        end
    end

    -- LastIndexOf

    -- LastIndexOfAny

    --- Returns a new string that right-aligns the characters in this instance by padding them on the left with a specified Unicode character, for a specified total length.
    --- @overload fun(totalWidth:number):TheDialgaTeam.TDTModAPI.System.String.Instance
    --- @param totalWidth number The number of characters in the resulting string, equal to the number of original characters plus any additional padding characters.
    --- @param paddingChar string | TheDialgaTeam.TDTModAPI.System.String.Instance A Unicode padding character.
    --- @return TheDialgaTeam.TDTModAPI.System.String.Instance A new string that is equivalent to this instance, but right-aligned and padded on the left with as many paddingChar characters as needed to create a length of totalWidth.
    --- However, if totalWidth is less than the length of this instance, the method returns a reference to the existing instance.
    --- If totalWidth is equal to the length of this instance, the method returns a new string that is identical to this instance.
    function self:PadLeft(totalWidth, paddingChar)
        local status, error = pcall(function ()
            if paddingChar == nil then
                error "ArgumentNullException: paddingChar is null.";
            elseif type(paddingChar) ~= "string" and type(paddingChar) ~= "table" then
                error "ArgumentException: paddingChar is not a string.";
            end

            Assert.AssertNumber(totalWidth, "totalWidth");
        end);

        if status then
            local newInstance = self.__Value;
            local newPaddingChar = string.sub(tostring(paddingChar or " "), 1, 1);

            if totalWidth <= string.len(newInstance) then
                return TDTModAPI_System_String.new(newInstance);
            else
                for i = 1, totalWidth - string.len(newInstance) do
                    newInstance = newPaddingChar .. newInstance;
                end

                return TDTModAPI_System_String.new(newInstance);
            end
        else
            print(error);
            return nil;
        end
    end

    --- Returns a new string that left-aligns the characters in this string by padding them on the right with a specified Unicode character, for a specified total length.
    --- @overload fun(totalWidth:number):TheDialgaTeam.TDTModAPI.System.String.Instance
    --- @param totalWidth number The number of characters in the resulting string, equal to the number of original characters plus any additional padding characters.
    --- @param paddingChar string | TheDialgaTeam.TDTModAPI.System.String.Instance A Unicode padding character.
    --- @return TheDialgaTeam.TDTModAPI.System.String.Instance A new string that is equivalent to this instance, but left-aligned and padded on the right with as many paddingChar characters as needed to create a length of totalWidth.
    --- However, if totalWidth is less than the length of this instance, the method returns a reference to the existing instance.
    --- If totalWidth is equal to the length of this instance, the method returns a new string that is identical to this instance.
    function self:PadRight(totalWidth, paddingChar)
        local status, error = pcall(function ()
            if paddingChar == nil then
                error "ArgumentNullException: paddingChar is null.";
            elseif type(paddingChar) ~= "string" and type(paddingChar) ~= "table" then
                error "ArgumentException: paddingChar is not a string.";
            end

            Assert.AssertNumber(totalWidth, "totalWidth");
        end);

        if status then
            local newInstance = self.__Value;
            local newPaddingChar = string.sub(tostring(paddingChar or " "), 1, 1);

            if totalWidth <= string.len(newInstance) then
                return TDTModAPI_System_String.new(newInstance);
            else
                for i = 1, totalWidth - string.len(newInstance) do
                    newInstance = newInstance .. newPaddingChar;
                end

                return TDTModAPI_System_String.new(newInstance);
            end
        else
            print(error);
            return nil;
        end
    end

    --- Returns a new string in which a specified number of characters in the current instance beginning at a specified position have been deleted.
    --- @overload fun(startIndex:number):string
    --- @param startIndex number The one-based position to begin deleting characters.
    --- @param count number The number of characters to delete.
    --- @return TheDialgaTeam.TDTModAPI.System.String.Instance A new string that is equivalent to this instance except for the removed characters.
    function self:Remove(startIndex, count)
        local status, error = pcall(function ()
            Assert.AssertNumber(startIndex, "startIndex");
            Assert.AssertNumber(count, "count", true);
        end);

        if status then
            local newInstance = self.__Value;
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

            return TDTModAPI_System_String.new(newString);
        else
            print(error);
            return nil;
        end
    end

    -- Replace

    -- Split

    --- Determines whether the beginning of this string instance matches the specified string when compared using the specified comparison option.
    --- @param value string | TheDialgaTeam.TDTModAPI.System.String.Instance The string to compare.
    --- @param ignoreCase boolean true to ignore case during the comparison; otherwise, false.
    --- @return boolean true if this instance begins with value; otherwise, false.
    function self:StartsWith(value, ignoreCase)
        local status, error = pcall(function ()
            if value == nil then
                error "ArgumentNullException: value is null.";
            elseif type(value) ~= "string" and type(value) ~= "table" then
                error "ArgumentException: value is not a string.";
            end

            Assert.AssertBoolean(ignoreCase, "ignoreCase", true);
        end);

        if status then
            local newInstance = self.__Value;
            local newValue = tostring(value);

            if ignoreCase or false then
                newInstance = string.lower(newInstance);
                newValue = string.lower(newValue);
            end

            return newInstance == newValue or string.len(newValue) == 0 or string.sub(newInstance, 1, string.len(newValue)) == newValue;
        else
            print(error);
            return nil;
        end
    end

    -- SubString

    -- ToCharArray

    --- Returns a copy of this string converted to lowercase.
    --- @return TheDialgaTeam.TDTModAPI.System.String.Instance A string in lowercase.
    function self:ToLower()
        return TDTModAPI_System_String.new(string.lower(self.__Value));
    end

    --- Returns this instance of string; no actual conversion is performed.
    --- @return string The current string.
    function self:ToString()
        return self.__Value;
    end

    --- Returns a copy of this string converted to uppercase.
    --- @return TheDialgaTeam.TDTModAPI.System.String.Instance The uppercase equivalent of the current string.
    function self:ToUpper()
        return TDTModAPI_System_String.new(string.upper(self.__Value));
    end

    --- Removes all leading and trailing occurrences of a set of characters specified in an array from the current string object.
    --- @return TheDialgaTeam.TDTModAPI.System.String.Instance The string that remains after all white-space characters are removed from the start and end of the current string.
    --- If no characters can be trimmed from the current instance, the method returns the current instance unchanged.
    function self:Trim()
        return TDTModAPI_System_String.new(string.gsub(self.__Value, "^%s*(.-)%s*$", "%1"));
    end

    --- Removes all trailing occurrences of a set of characters specified in an array from the current string object.
    --- @return TheDialgaTeam.TDTModAPI.System.String.Instance The string that remains after all white-space characters are removed from the end of the current string.
    --- If no characters can be trimmed from the current instance, the method returns the current instance unchanged.
    function self:TrimEnd()
        return TDTModAPI_System_String.new(string.gsub(self.__Value,"^(.-)%s*$", "%1"));
    end

    --- Removes all trailing occurrences of a set of characters specified in an array from the current string object.
    --- @return TheDialgaTeam.TDTModAPI.System.String.Instance The string that remains after all white-space characters are removed from the start of the current string.
    --- If no characters can be trimmed from the current instance, the method returns the current instance unchanged.
    function self:TrimStart()
        return TDTModAPI_System_String.new(string.gsub(self.__Value,"^%s*(.-)$", "%1"));
    end

    return self;
end

-- Compare

-- Concat

-- Equals

-- Format

--- Indicates whether the specified string is nil or an empty string.
--- @param value string | TheDialgaTeam.TDTModAPI.System.String.Instance The string to test.
--- @return boolean true if the value parameter is nil or an empty string (""); otherwise, false.
function TDTModAPI_System_String.IsNullOrEmpty(value)
    local status, error = pcall(function ()
        if value ~= nil and type(value) ~= "string" and type(value) ~= "table" then
            error "ArgumentException: value is not a string.";
        end
    end);

    if status then
        return value == nil or string.len(tostring(value)) == 0;
    else
        print(error);
        return nil;
    end
end

--- Indicates whether a specified string is nil, empty, or consists only of white-space characters.
--- @param value string | TheDialgaTeam.TDTModAPI.System.String.Instance The string to test.
--- @return boolean true if the value parameter is nil or empty, or if value consists exclusively of white-space characters.
function TDTModAPI_System_String.IsNullorWhiteSpace(value)
    local status, error = pcall(function ()
        if value ~= nil and type(value) ~= "string" and type(value) ~= "table" then
            error "ArgumentException: value is not a string.";
        end
    end);

    if status then
        local newValue = TDTModAPI_System_String.new(tostring(value));

        return TDTModAPI_System_String.IsNullOrEmpty(newValue:Trim());
    else
        print(error);
        return nil;
    end
end

--[[
function TDTModAPI_System_String.Join(separator, value)
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
]]--

return TDTModAPI_System_String;