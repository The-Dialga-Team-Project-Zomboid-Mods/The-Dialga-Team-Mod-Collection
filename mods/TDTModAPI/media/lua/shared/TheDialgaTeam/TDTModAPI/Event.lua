local TDTModAPI_Event = {};

function TDTModAPI_Event.Add(table, func)
    table:insert(func);
end

function TDTModAPI_Event.Remove(lua_table, lua_function)
    for i, v in ipairs(lua_table) do
        if v == lua_function then
            table.remove(lua_table, i);
            break;
        end
    end
end

return TDTModAPI_Event;