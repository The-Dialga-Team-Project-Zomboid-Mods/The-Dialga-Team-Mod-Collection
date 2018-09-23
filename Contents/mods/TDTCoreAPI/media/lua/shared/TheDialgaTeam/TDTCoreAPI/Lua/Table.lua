--- @class TheDialgaTeam.TDTCoreAPI.Lua.Table @Class containing lua table functions.
local TDTCoreAPI_Lua_Table = {};

--- Copy the table contents recursively.
--- @param luaTable table @Table to copy.
--- @return table @New table containing same value.
function TDTCoreAPI_Lua_Table.Copy(luaTable)
    local newTable = {};

    for k, v in pairs(luaTable) do
        if type(v) ~= "table" then
            newTable[k] = luaTable[k];
        else
            newTable[k] = TDTCoreAPI_Lua_Table.Copy(luaTable[k]);
        end
    end

    if getmetatable(luaTable) ~= nil then
        setmetatable(newTable, getmetatable(luaTable));
    end

    return newTable;
end

--- Merge the table contents recursively.
--- @param luaTable table @Table to merge.
--- @param luaTable2 table @Contents to merge.
--- @return table @New table containing merged value.
function TDTCoreAPI_Lua_Table.Merge(luaTable, luaTable2)
    local newTable = TDTCoreAPI_Lua_Table.Copy(luaTable);

    for k, v in pairs(luaTable2) do
        if tonumber(k) ~= nil then
            if type(v) ~= "table" then
                table.insert(newTable, v);
            else
                table.insert(newTable, TDTCoreAPI_Lua_Table.Copy(v));
            end
        else
            if type(v) ~= "table" then
                newTable[k] = v;
            else
                newTable[k] = TDTCoreAPI_Lua_Table.Copy(v);
            end
        end
    end

    return newTable;
end

return TDTCoreAPI_Lua_Table;