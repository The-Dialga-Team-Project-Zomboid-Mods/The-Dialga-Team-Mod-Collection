local TDTModAPI_System_IO_File = {};

function TDTModAPI_System_IO_File.LoadFile(modId, filename)
	local file = getModFileReader(modId, filename, true);
	local content = "";
	local line = nil;
	
	while true do
		line = file:readLine();
		
		if line == nil then
			file:close();
			break;
		end
		
		content = content .. line .. "\n";
	end
	
	return content;
end

function TDTModAPI_System_IO_File.SaveFile(modId, filename, data)
	local file = getModFileWriter(modId, filename, true, false);
	file:write(data);
	file:close();
end

function TDTModAPI_System_IO_File.LoadIniFile(modId, filename)
	local file = getModFileReader(modId, filename, true);
	local data = {};
	local section;
	local line = nil;
	
	while true do
		line = file:readLine();
		
		if line == nil then
			file:close();
			break;
		end
		
		local tempSection = line:match('^%[([^%[%]]+)%]$');
		
		if tempSection then
			section = tonumber(tempSection) and tonumber(tempSection) or tempSection;
			data[section] = data[section] or {};
		end
		
		local param, value = line:match('^([%w|_]+)%s-=%s-(.+)$');
		
		if param and value ~= nil then
			if tonumber(value) then
				value = tonumber(value);
			elseif value == 'true' then
				value = true;
			elseif value == 'false' then
				value = false;
			end
			
			if tonumber(param) then
				param = tonumber(param);
			end
			
			data[section][param] = value;
		end
	end
	
	return data;
end

function TDTModAPI_System_IO_File.SaveIniFile(modId, filename, data)
	local file = getModFileWriter(modId, filename, true, false);
	local contents = '';
	
	for section, param in pairs(data) do
		contents = contents .. ('[%s]\r\n'):format(section);
		
		for key, value in pairs(param) do
			contents = contents .. ('%s=%s\r\n'):format(key, tostring(value));
		end
		
		contents = contents .. '\r\n';
	end
	
	file:write(contents);
	file:close();
end

return TDTModAPI_System_IO_File;