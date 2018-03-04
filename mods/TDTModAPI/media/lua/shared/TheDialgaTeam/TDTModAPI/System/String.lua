local TDTModAPI_System_String = {};

--- Initializes a new instance of the string class.
-- @param value The string to instantiate.
-- @return The instance of the string.
function TDTModAPI_System_String:new(value)
    local o = {};
    o.value = tostring(value);

    --- Returns a reference to this instance of String.
    -- @return This instance of String.
    function o:Clone()
        return TDTModAPI_System_String:new(self.value);
    end

    setmetatable(o, {
        __newindex = function (table, key, value) end,

        __len = function (table)
            return table.value:len();
        end,

        __tostring = function (table)
            return table.value;
        end,

        __pairs = function (table)
            local i,n = 0, table.value:len();
            return function ()
                if i < n then
                    return i, table.value:sub(i + 1, i +1);
                end
                i = i + 1;
            end
        end,

        __ipairs = function (table)
            local i,n = 0, table.value:len();
            return function ()
                if i < n then
                    return i, table.value:sub(i + 1, i +1);
                end
                i = i + 1;
            end
        end,

        __concat = function (table, table2)
            if type(table) == "string" then
                return table .. table2.value;
            elseif type(table2) == "string" then
                return table.value .. table2;
            else
                return table.value .. table2.value;
            end
        end,

        __eq = function (table, table2)
            if type(table) == "string" then
                return table == table2.value;
            elseif type(table2) == "string" then
                return table.value == table2;
            else
                return table.value == table2.value;
            end
        end
    });

    return o;
end

--- Returns a reference to this instance of String.
-- @return This instance of String.
function TDTModAPI_System_String:Clone()
    return TDTModAPI_System_String:new(self.value);
end

--- Concatenates the string representations of the elements in a specified table.
-- @param values A table that contains the elements to concatenate.
-- @return The concatenated elements of values.
function TDTModAPI_System_String.Concat(values)
    if values == nil then
        error "ArgumentNullException: values is null.";
    elseif type(values) ~= "table" then
        error "ArgumentException: values is not a table.";
    end

    local result = "";

    for _, v in pairs(values) do
        result = result .. v;
    end

    return result;
end

function TDTModAPI_System_String:Contains(value)
    -- IndexOf
end

--- Determines whether the end of this string instance matches the specified string.
-- @param value The string to compare to the substring at the end of this instance.
-- @param ignoreCase true to ignore case during the comparison; otherwise, false.
-- @return true if value matches the end of this instance; otherwise, false.
function TDTModAPI_System_String:EndsWith(value, ignoreCase)
    if value == nil then
        error "ArgumentNullException: value is null.";
    elseif type(value) ~= "string" then
        error "ArgumentException: value is not a string.";
    elseif ignoreCase ~= nil and type(ignoreCase) ~= "boolean" then
        error "ArgumentException: ignoreCase is not a boolean.";
    end

    local newInstance = self.value;
    local newValue = value;

    if ignoreCase or false then
        newInstance = self.value:lower();
        newValue = value:lower();
    end

    return newInstance == newValue or newValue:len() == 0 or newInstance:sub(-newValue:len()) == newValue;
end

--- Determines whether two specified string instance have the same value.
-- @param a The first string to compare, or nil.
-- @param b The second string to compare, or nil.
-- @param ignoreCase true to ignore case during the comparison; otherwise, false.
-- @return true if the value of the a parameter is equal to the value of the b parameter; otherwise, false.
function TDTModAPI_System_String.Equals(a, b, ignoreCase)
    if a ~= nil and type(a) ~= "string" then
        error "ArgumentException: a is not a string.";
    elseif b ~= nil and type(b) ~= "string" then
        error "ArgumentException: b is not a string.";
    elseif ignoreCase ~= nil and type(ignoreCase) ~= "boolean" then
        error "ArgumentException: ignoreCase is not a boolean.";
    end

    local newA = a;
    local newB = b;

    if ignoreCase or false then
        newA = a:lower();
        newB = b:lower();
    end

    return newA == newB;
end

--- Reports the one-based index of the first occurrence of the specified string in the current string instance. Parameters specify the starting search position in the current string, the number of characters in the current string to search, and the type of search to use for the specified string.
-- @param instance The original string to search.
-- @param value The string to seek.
-- @param startIndex The search starting position.
-- @param count The number of character positions to examine.
-- @param ignoreCase true to ignore case during the comparison; otherwise, false.
-- @return The one-based index position of the value parameter from the start of the current instance if that string is found, or 0 if it is not. If value is empty, the return value is startIndex.
function TDTModAPI_System_String.IndexOf(instance, value, startIndex, count, ignoreCase)
    if instance == nil then
        error "ArgumentNullException: instance is null.";
    elseif value == nil then
        error "ArgumentNullException: value is null.";
    elseif type(instance) ~= "string" then
        error "ArgumentException: instance is not a string.";
    elseif type(value) ~= "string" then
        error "ArgumentException: value is not a string.";
    elseif startIndex ~= nil and type(startIndex) ~= "number" then
        error "ArgumentException: startIndex is not a number.";
    elseif startIndex ~= nil and (startIndex - 1 < 0 or startIndex - 1 > instance:len()) then
        error "ArgumentOutOfRangeException: startIndex is out of range.";
    elseif count ~= nil and type(count) ~= "number" then
        error "ArgumentException: count is not a number.";
    elseif count ~= nil and (count < 0 or startIndex - 1 > instance:len() - count) then
        error "ArgumentOutOfRangeException: count is out of range."
    elseif ignoreCase ~= nil and type(ignoreCase) ~= "boolean" then
        error "ArgumentException: ignoreCase is not a boolean.";
    end

    if value == "" then
        return startIndex;
    end

    local newInstance = instance;
    local newValue = value;
    local newStartIndex = startIndex or 1;
    local newCount = count or instance:len() - startIndex - 1;

    if ignoreCase or false then
        newInstance = instance:lower();
        newValue = instance:lower();
    end

    for i = newStartIndex, newStartIndex + newCount - 1 do
        if i + newValue:len() - 1 > newInstance:len() then
            break;
        end

        if newValue:len() > newCount then
           if newInstance:sub(i, i + newCount - 1) == newValue then
               return i;
           end
        else
            if newInstance:sub(i, i + newValue:len() - 1) == newValue then
                return i;
            end
        end
    end

    return 0;
end

--- Returns a new string in which a specified string is inserted at a specified index position in this instance.
-- @param instance The original string to insert.
-- @param startIndex The one-based index position of the insertion.
-- @param value The string to insert.
-- @return A new string that is equivalent to this instance, but with value inserted at position startIndex.
function TDTModAPI_System_String.Insert(instance, startIndex, value)
    if instance == nil then
        error "ArgumentNullException: instance is null.";
    elseif startIndex == nil then
        error "ArgumentNullException: startIndex is null.";
    elseif value == nil then
        error "ArgumentNullException: value is null.";
    elseif type(instance) ~= "string" then
        error "ArgumentException: instance is not a string.";
    elseif type(value) ~= "string" then
        error "ArgumentException: value is not a string.";
    elseif startIndex ~= nil and type(startIndex) ~= "number" then
        error "ArgumentException: startIndex is not a number.";
    elseif startIndex ~= nil and (startIndex - 1 < 0 or startIndex - 1 > instance:len()) then
        error "ArgumentOutOfRangeException: startIndex is out of range.";
    end

    if startIndex > instance:len() then
        return instance .. value;
    elseif startIndex == 1 then
        return value .. instance;
    else
        return instance:sub(1, startIndex - 1) .. value .. instance:sub(startIndex);
    end
end

--- Indicates whether the specified string is nil or an empty string.
-- @param value The string to test.
-- @return true if the value parameter is nil or an empty string (""); otherwise, false.
function TDTModAPI_System_String.IsNullOrEmpty(value)
    if value ~= nil and type(value) ~= "string" then
        error "ArgumentException: value is not a string.";
    end

    return value == nil or value:len() == 0;
end

--- Indicates whether a specified string is nil, empty, or consists only of white-space characters.
-- @param value The string to test.
-- @return true if the value parameter is nil or empty, or if value consists exclusively of white-space characters.
function TDTModAPI_System_String.IsNullorWhiteSpace(value)
    if value ~= nil and type(value) ~= "string" then
        error "ArgumentException: value is not a string.";
    end

    return TDTModAPI_System_String.IsNullOrEmpty(TDTModAPI_System_String.Trim(value));
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

function TDTModAPI_System_String.StartsWith(value, match)
    return string.sub(value, 1, string.len(match)) == match;
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