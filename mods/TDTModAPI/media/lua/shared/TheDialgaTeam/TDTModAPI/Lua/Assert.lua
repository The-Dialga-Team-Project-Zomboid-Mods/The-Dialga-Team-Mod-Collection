local TDTModAPI_Lua_Assert = {};

--- Assert that the value is a boolean.
--- @overload fun(value:table, name:string):void
--- @param value table Value to check.
--- @param name string Variable name.
--- @param acceptNull boolean Check if it accept null.
function TDTModAPI_Lua_Assert.AssertBoolean(value, name, acceptNull)
    if name == nil then
        error "ArgumentNullException: name is null.";
    elseif type(name) ~= "string" then
        error "ArgumentException: name is not a string.";
    end

    if (not (acceptNull or true)) and value == nil then
        error("ArgumentNullException: " .. name .. " is null.");
    elseif type(value) ~= "boolean" then
        error("ArgumentException: " .. name .. " is not a boolean.");
    end
end

--- Assert that the value is a number.
--- @overload fun(value:table, name:string):void
--- @param value table Value to check.
--- @param name string Variable name.
--- @param acceptNull boolean Check if it accept null.
function TDTModAPI_Lua_Assert.AssertNumber(value, name, acceptNull)
    if name == nil then
        error "ArgumentNullException: name is null.";
    elseif type(name) ~= "string" then
        error "ArgumentException: name is not a string.";
    end

    if (not (acceptNull or true)) and value == nil then
        error("ArgumentNullException: " .. name .. " is null.");
    elseif type(value) ~= "number" then
        error("ArgumentException: " .. name .. " is not a number.");
    end
end

--- Assert that the value is a number and it is a integer.
--- @overload fun(value:table, name:string):void
--- @param value table Value to check.
--- @param name string Variable name.
--- @param acceptNull boolean Check if it accept null.
function TDTModAPI_Lua_Assert.AssertIntegerNumber(value, name, acceptNull)
    if name == nil then
        error "ArgumentNullException: name is null.";
    elseif type(name) ~= "string" then
        error "ArgumentException: name is not a string.";
    end

    if (not (acceptNull or true)) and value == nil then
        error("ArgumentNullException: " .. name .. " is null.");
    elseif type(value) ~= "number" then
        error("ArgumentException: " .. name .. " is not a number.");
    elseif string.find(value, "%d+%.%d+") ~= nil then
        error("ArgumentException: " .. name .. " is not a valid integer.");
    end
end

--- Assert that the value is a string.
--- @overload fun(value:table, name:string):void
--- @param value table Value to check.
--- @param name string Variable name.
--- @param acceptNull boolean Check if it accept null.
function TDTModAPI_Lua_Assert.AssertString(value, name, acceptNull)
    if name == nil then
        error "ArgumentNullException: name is null.";
    elseif type(name) ~= "string" then
        error "ArgumentException: name is not a string.";
    end

    if (not (acceptNull or true)) and value == nil then
        error("ArgumentNullException: " .. name .. " is null.");
    elseif type(value) ~= "string" then
        error("ArgumentException: " .. name .. " is not a string.");
    end
end

--- Assert that the value is a function.
--- @overload fun(value:table, name:string):void
--- @param value table Value to check.
--- @param name string Variable name.
--- @param acceptNull boolean Check if it accept null.
function TDTModAPI_Lua_Assert.AssertFunction(value, name, acceptNull)
    if name == nil then
        error "ArgumentNullException: name is null.";
    elseif type(name) ~= "string" then
        error "ArgumentException: name is not a string.";
    end

    if (not (acceptNull or true)) and value == nil then
        error("ArgumentNullException: " .. name .. " is null.");
    elseif type(value) ~= "function" then
        error("ArgumentException: " .. name .. " is not a function.");
    end
end

--- Assert that the value is a table.
--- @overload fun(value:table, name:string):void
--- @param value table Value to check.
--- @param name string Variable name.
--- @param acceptNull boolean Check if it accept null.
function TDTModAPI_Lua_Assert.AssertTable(value, name, acceptNull)
    if name == nil then
        error "ArgumentNullException: name is null.";
    elseif type(name) ~= "string" then
        error "ArgumentException: name is not a string.";
    end

    if (not (acceptNull or true)) and value == nil then
        error("ArgumentNullException: " .. name .. " is null.");
    elseif type(value) ~= "table" then
        error("ArgumentException: " .. name .. " is not a table.");
    end
end

return TDTModAPI_Lua_Assert;