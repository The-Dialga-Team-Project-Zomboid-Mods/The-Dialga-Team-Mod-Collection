local Assert = require "TheDialgaTeam/TDTModAPI/Lua/Assert";
local Json = require "TheDialgaTeam/TDTModAPI/Json/Plugin";
local TDTModAPI_Json = {};

--- Serialize Json object.
--- @overload fun(table:table):string
--- @param jsonTable table Table to serialize.
--- @param isPretty boolean Makes the json output pretty.
--- @return string String containing the json object.
function TDTModAPI_Json.Serialize(jsonTable, isPretty)
    local status, error = pcall(function ()
        Assert.AssertTable(jsonTable, "jsonTable");
        Assert.AssertBoolean(isPretty, "pretty", true);
    end);

    if status then
        if isPretty or false then
            return Json:encode(jsonTable);
        else
            return Json:encode_pretty(jsonTable);
        end
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