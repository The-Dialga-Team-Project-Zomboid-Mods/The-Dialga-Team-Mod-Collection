local TDTModAPI_Json = {}
local instance = require "TheDialgaTeam/TDTModAPI/Json/Plugin";

--- Serialize Json object.
--- @overload fun(table:table):string
--- @param table table Table to serialize.
--- @return string String containing the json object.
function TDTModAPI_Json.Serialize(table, pretty)
    if pretty or false then
        return instance:encode(table);
    else
        return instance:encode_pretty(table);
    end
end

--- Deserialize Json object.
--- @param text string String to deserialize.
--- @return table Table containing the json object.
function TDTModAPI_Json.Deserialize(text)
    return instance:decode(text);
end

return TDTModAPI_Json;