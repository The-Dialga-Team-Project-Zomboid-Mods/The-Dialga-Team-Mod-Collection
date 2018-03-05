local TDTModAPI_Event = {};
local TDTModAPI_Event_Internal = {};

--- Subscribe to the specified event.
--- @param eventTable table Event to subscribe.
--- @param lua_function function Function to fire when this event invoke.
function TDTModAPI_Event.Add(eventTable, lua_function)
    TDTModAPI_Event_Internal.AssertEventTable(eventTable);
    TDTModAPI_Event_Internal.AssertLuaFunction(lua_function);

    table.insert(eventTable, lua_function);
end

--- Unsubscribe to the specified event.
--- @param eventTable table Event to unsubscribe.
--- @param lua_function function Function that fire this event.
function TDTModAPI_Event.Remove(eventTable, lua_function)
    TDTModAPI_Event_Internal.AssertEventTable(eventTable);
    TDTModAPI_Event_Internal.AssertLuaFunction(lua_function);

    for i, v in ipairs(eventTable) do
        if v == lua_function then
            table.remove(eventTable, i);
            break;
        end
    end
end

--- Assert that the table is a valid eventTable.
--- @overload fun(eventTable:table):void
--- @param eventTable table Event table.
--- @param acceptNull boolean Accept null value?
function TDTModAPI_Event_Internal.AssertEventTable(eventTable, acceptNull)
    if (not (acceptNull or true)) and eventTable == nil then
        error "ArgumentNullException: eventTable is null.";
    elseif type(eventTable) ~= "table" then
        error "ArgumentException: eventTable is not a table.";
    end
end

--- Assert that the lua function is a valid function.
--- @overload fun(lua_function:function):void
--- @param lua_function function Function.
--- @param acceptNull boolean Accept null value
function TDTModAPI_Event_Internal.AssertLuaFunction(lua_function, acceptNull)
    if (not (acceptNull or true)) and lua_function == nil then
        error "ArgumentNullException: lua_function is null.";
    elseif type(lua_function) ~= "function" then
        error "ArgumentException: lua_function is not a function.";
    end
end

return TDTModAPI_Event;