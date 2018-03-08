local Assert = require "TheDialgaTeam/TDTModAPI/Lua/Assert";
local TDTModAPI_Event = {};

--- Subscribe to the specified event.
--- @param eventTable table Event to subscribe.
--- @param luaFunction function Function to fire when this event invoke.
function TDTModAPI_Event.Add(eventTable, luaFunction)
    local status, error = pcall(function ()
        Assert.AssertTable(eventTable, "eventTable");
        Assert.AssertFunction(luaFunction, "luaFunction");
    end);

    if status then
        table.insert(eventTable, luaFunction);
    else
        print(error);
    end
end

--- Unsubscribe to the specified event.
--- @param eventTable table Event to unsubscribe.
--- @param luaFunction function Function that fire this event.
function TDTModAPI_Event.Remove(eventTable, luaFunction)
    local status, error = pcall(function ()
        Assert.AssertTable(eventTable, "eventTable");
        Assert.AssertFunction(luaFunction, "luaFunction");
    end);

    if status then
        for i, v in ipairs(eventTable) do
            if v == luaFunction then
                table.remove(eventTable, i);
                break;
            end
        end
    else
        print(error);
    end
end

return TDTModAPI_Event;