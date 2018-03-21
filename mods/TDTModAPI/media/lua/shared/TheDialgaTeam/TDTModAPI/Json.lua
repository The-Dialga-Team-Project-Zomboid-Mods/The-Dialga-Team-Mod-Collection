--- @type TheDialgaTeam.TDTModAPI.Lua.Assert
local Assert = require "TheDialgaTeam/TDTModAPI/Lua/Assert";
local Json = require "TheDialgaTeam/TDTModAPI/Json/Plugin";

--- @class TheDialgaTeam.TDTModAPI.Json
local TDTModAPI_Json = {};

--- Serialize Json object.
--- @overload fun(jsonTable:table):string
--- @param jsonTable table Table to serialize.
--- @param options table Custom json output options.
--- @return string String containing the json object.
function TDTModAPI_Json.Serialize(jsonTable, options)
    local status, error = pcall(function ()
        Assert.AssertTable(jsonTable, "jsonTable");
        Assert.AssertTable(options, "options", true);
    end);

    if status then
        return Json:encode(jsonTable, nil, options);
    else
        print(error);
        return nil;
    end
end

--- Deserialize Json object.
--- @param text string String to deserialize.
--- @return table Table containing the json object.
function TDTModAPI_Json.Deserialize(text)
    local status, error = pcall(function ()
        Assert.AssertString(text, "text");
    end);

    if status then
        return Json:decode(text);
    else
        print(error);
        return nil;
    end
end

return TDTModAPI_Json;