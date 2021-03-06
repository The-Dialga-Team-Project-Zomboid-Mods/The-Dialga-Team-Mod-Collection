--- @class TheDialgaTeam.TDTCoreAPI.System.Random
local TDTCoreAPI_System_Random = {};

--- Returns a random integer that is within a specified range.
--- @overload fun():number
--- @overload fun(maxValue:number):number
--- @param minValue number @The inclusive lower bound of the random number returned.
--- @param maxValue number @The exclusive upper bound of the random number returned.
--- @return number @A number that is greater than or equal to minValue and less than maxValue.
function TDTCoreAPI_System_Random.Next(minValue, maxValue)
    local targetMinValue = 0;
    local targetMaxValue = 0;

    if minValue == nil and maxValue == nil then
        targetMinValue = 0;
        targetMaxValue = 2147483648;
    elseif minValue ~= nil and maxValue == nil then
        targetMinValue = 0;
        targetMaxValue = minValue;
    else
        targetMinValue = minValue;
        targetMaxValue = maxValue;
    end

    return ZombRand(targetMinValue, targetMaxValue);
end

return TDTCoreAPI_System_Random;