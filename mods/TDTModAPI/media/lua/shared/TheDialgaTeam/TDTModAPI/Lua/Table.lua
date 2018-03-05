local TDTModAPI_Lua_Table = {};

--- Copy the table contents recursively.
--- @param table table Table to copy.
--- @return table New table containing same value.
function TDTModAPI_Lua_Table.Copy(table)
    if table == nil then
        error "ArgumentNullException: table is null.";
    elseif type(table) ~= "table" then
        error "ArgumentException: table is not a table.";
    end

    local newTable = {};

    for k,v in pairs(table) do
        if type(v) ~= "table" then
            newTable[k] = table[k];
        else
            newTable[k] = TDTModAPI_Lua_Table.Copy(table[k]);
        end
    end

    return newTable;
end

return TDTModAPI_Lua_Table;