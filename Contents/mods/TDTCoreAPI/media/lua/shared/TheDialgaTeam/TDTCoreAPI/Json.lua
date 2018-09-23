local Json = require("TheDialgaTeam/TDTCoreAPI/Json/Plugin");

--- @class TheDialgaTeam.TDTCoreAPI.Json @Class that handles serialization and deserialization to json representation.
--- @field Options TheDialgaTeam.TDTCoreAPI.Json.Options @Enum containing json serialization options.
local TDTCoreAPI_Json = {};

TDTCoreAPI_Json.Options = require("TheDialgaTeam/TDTCoreAPI/Json/Options");

--- Serialize Json object.
--- @overload fun(jsonTable:table):string
--- @param jsonTable table @Table to serialize.
--- @param options TheDialgaTeam.TDTCoreAPI.Json.Options @Custom json output options.
--- @return string @String containing the json object.
function TDTCoreAPI_Json.Serialize(jsonTable, options)
    return Json:encode(jsonTable, nil, options);
end

--- Deserialize Json object.
--- @param text string @String to deserialize.
--- @return table @Table containing the json object.
function TDTCoreAPI_Json.Deserialize(text)
    return Json:decode(text);
end

return TDTCoreAPI_Json;