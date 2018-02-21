local TDTModAPI_System_Random = {};

-- TheDialgaTeam.System.Random.Next(minValue)
-- TheDialgaTeam.System.Random.Next(minValue, maxValue)
function TDTModAPI_System_Random.Next(...)
	local args = {...}
	
	if #args == 1 then
		return ZombRand(select(1, ...))
	elseif #args == 2 then
		return ZombRand(select(1, ...), select(2, ...))
	else
		return nil
	end
end

-- TheDialgaTeam.System.Random.NextInclusive(minValue)
-- TheDialgaTeam.System.Random.NextInclusive(minValue, maxValue)
function TDTModAPI_System_Random.NextInclusive(...)
	local args = {...}
	
	if #args == 1 then
		return ZombRand(select(1, ...) + 1)
	elseif #args == 2 then
		return ZombRand(select(1, ...), select(2, ...) + 1)
	else
		return nil
	end
end

return TDTModAPI_System_Random;