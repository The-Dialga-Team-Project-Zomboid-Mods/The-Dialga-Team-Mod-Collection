local TDTModAPI_PZ_Color = {};

function TDTModAPI_PZ_Color.ConvertToRGB(color)
	if type(color) ~= "table" then
		return nil;
	else
		local newColor = {};
		
		newColor.r = tonumber(color.r) * 255.0;
		newColor.g = tonumber(color.g) * 255.0;
		newColor.b = tonumber(color.b) * 255.0;
		
		return newColor;
	end
end

function TDTModAPI_PZ_Color.ConvertToRGBA(color)
	if type(color) ~= "table" then
		return nil;
	else
		local newColor = {};
		
		newColor.r = tonumber(color.r) * 255.0;
		newColor.g = tonumber(color.g) * 255.0;
		newColor.b = tonumber(color.b) * 255.0;
		newColor.a = tonumber(color.a) * 255.0;
		
		return newColor;
	end
end

function TDTModAPI_PZ_Color.ConvertToPZRGB(color)
	if type(color) ~= "table" then
		return nil;
	else
		local newColor = {};
		
		newColor.r = tonumber(color.r) / 255.0;
		newColor.g = tonumber(color.g) / 255.0;
		newColor.b = tonumber(color.b) / 255.0;
		
		return newColor;
	end
end

function TDTModAPI_PZ_Color.ConvertToPZRichTextRGB(color)
	if type(color) ~= "table" then
		return nil;
	else
		return " <RGB:" .. color.r .. "," .. color.g .. "," .. color.b .. "> ";
	end
end

function TDTModAPI_PZ_Color.ConvertToPZRGBA(color)
	if type(color) ~= "table" then
		return nil;
	else
		local newColor = {};
		
		newColor.r = tonumber(color.r) / 255.0;
		newColor.g = tonumber(color.g) / 255.0;
		newColor.b = tonumber(color.b) / 255.0;
		newColor.a = tonumber(color.a) / 255.0;
		
		return newColor;
	end
end

function TDTModAPI_PZ_Color.ConvertToPZColorInfo(color)
	if type(color) ~= "table" then
		return nil;
	else
		return ColorInfo.new(tonumber(color.r) / 255.0, tonumber(color.g) / 255.0, tonumber(color.b) / 255.0, tonumber(color.a) / 255.0);
	end
end

return TDTModAPI_PZ_Color;