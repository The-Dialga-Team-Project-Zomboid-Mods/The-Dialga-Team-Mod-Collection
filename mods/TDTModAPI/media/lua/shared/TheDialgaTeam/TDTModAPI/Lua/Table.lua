--- @type TheDialgaTeam.TDTModAPI.Lua.Assert
local Assert = require "TheDialgaTeam/TDTModAPI/Lua/Assert";

--- @class TheDialgaTeam.TDTModAPI.Lua.Table
local TDTModAPI_Lua_Table = {};

--- Copy the table contents recursively.
--- @param luaTable table Table to copy.
--- @return table New table containing same value.
function TDTModAPI_Lua_Table.Copy(luaTable)
    local status, error = pcall(function ()
        Assert.AssertTable(luaTable, "luaTable");
    end);

    if status then
        local newTable = {};

        for k, v in pairs(luaTable) do
            if type(v) ~= "table" then
                newTable[k] = luaTable[k];
            else
                newTable[k] = TDTModAPI_Lua_Table.Copy(luaTable[k]);
            end
        end

        return newTable;
    else
        print(error);
        return nil;
    end
end

--- Merge the table contents recursively.
--- @param luaTable table Table to merge.
--- @param luaTable2 table Contents to merge.
--- @return table New table containing merged value.
function TDTModAPI_Lua_Table.Merge(luaTable, luaTable2)
    local status, error = pcall(function ()
        Assert.AssertTable(luaTable, "luaTable");
        Assert.AssertTable(luaTable2, "luaTable2");
    end);

    if status then
        local newTable = TDTModAPI_Lua_Table.Copy(luaTable);

        for k, v in pairs(luaTable2) do
            if tonumber(k) ~= nil then
                if type(v) ~= "table" then
                    table.insert(newTable, v);
                else
                    table.insert(newTable, TDTModAPI_Lua_Table.Copy(v));
                end
            else
                if type(v) ~= "table" then
                    newTable[k] = v;
                else
                    newTable[k] = TDTModAPI_Lua_Table.Copy(v);
                end
            end
        end

        return newTable;
    else
        print(error);
        return nil;
    end
end

return TDTModAPI_Lua_Table;