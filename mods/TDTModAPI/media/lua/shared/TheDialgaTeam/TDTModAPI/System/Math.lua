--- @type TheDialgaTeam.TDTModAPI.Lua.Assert
local Assert = require "TheDialgaTeam/TDTModAPI/Lua/Assert";

--- @class TheDialgaTeam.TDTModAPI.System.Math
local TDTModAPI_System_Math = {};

--- Clamp the value between minValue and maxValue inclusive.
--- @param value number Value to clamp.
--- @param minValue number Minimum value to clamp.
--- @param maxValue number Maximum value to clamp.
--- @return number A value that is between minValue and maxValue inclusive.
function TDTModAPI_System_Math.Clamp(value, minValue, maxValue)
    local status, error = pcall(function ()
        Assert.AssertNumber(value, "value");
        Assert.AssertNumber(minValue, "minValue");
        Assert.AssertNumber(maxValue, "maxValue");
    end);

    if status then
        if value < minValue then
            return minValue
        elseif value > maxValue then
            return maxValue
        else
            return value
        end
    else
        print(error);
        return nil;
    end
end

return TDTModAPI_System_Math;