local TDTModAPI_System_Math = {};

function TDTModAPI_System_Math.Floor(value)
	return math.floor(value);
end

function TDTModAPI_System_Math.Clamp(value, minValue, maxValue)
	if value < minValue then
		return minValue
	elseif value > maxValue then
		return maxValue
	else
		return value
	end
end

return TDTModAPI_System_Math;