local TDTModAPI_Event = {};

function TDTModAPI_Event.Add(lua_table, lua_function)
	table.insert(lua_table, lua_function);
end

function TDTModAPI_Event.Remove(lua_table, lua_function)
	for i, v in ipairs(lua_table) do
		if v == lua_function then
			table.remove(lua_table, i);
			break;
		end
	end
end

return TDTModAPI_Event;