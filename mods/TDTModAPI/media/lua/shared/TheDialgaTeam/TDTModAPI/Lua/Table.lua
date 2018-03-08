local Assert = require "TheDialgaTeam/TDTModAPI/Lua/Assert";
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

return TDTModAPI_Lua_Table;