local TDTModAPI_Json = {}
local instance = require "TheDialgaTeam/TDTModAPI/Json/Plugin";

function TDTModAPI_Json.Encode(lua_table)
	return instance:encode(lua_table);
end

function TDTModAPI_Json.EncodePretty(lua_table)
	return instance:encode_pretty(lua_table);
end

function TDTModAPI_Json.Decode(text)
	return instance:decode(text);
end

return TDTModAPI_Json;