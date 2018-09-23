--- @class TheDialgaTeam.TDTCoreAPI.System.Math
local TDTCoreAPI_System_Math = {};

--- Clamp the value between minValue and maxValue inclusive.
--- @param value number @Value to clamp.
--- @param minValue number @Minimum value to clamp.
--- @param maxValue number @Maximum value to clamp.
--- @return number @A value that is between minValue and maxValue inclusive.
function TDTCoreAPI_System_Math.Clamp(value, minValue, maxValue)
    if value < minValue then
        return minValue
    elseif value > maxValue then
        return maxValue
    else
        return value
    end
end

return TDTCoreAPI_System_Math;