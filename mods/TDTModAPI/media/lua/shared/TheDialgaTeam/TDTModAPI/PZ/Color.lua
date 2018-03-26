--- @type TheDialgaTeam.TDTModAPI.Lua.Assert
local Assert = require "TheDialgaTeam/TDTModAPI/Lua/Assert";

--- @class TheDialgaTeam.TDTModAPI.PZ.Color
local TDTModAPI_PZ_Color = {};

--- Convert PZ color table to rgb color table.
--- @param colorTable {r:number, g:number, b:number} PZ color table.
--- @return {r:number, g:number, b:number} RGB color table.
function TDTModAPI_PZ_Color.ConvertToRGB(colorTable)
    local status, error = pcall(function ()
        Assert.AssertTable(colorTable, "colorTable");
    end);

    if status then
        local newColor = {};

        newColor.r = tonumber(colorTable.r) * 255.0;
        newColor.g = tonumber(colorTable.g) * 255.0;
        newColor.b = tonumber(colorTable.b) * 255.0;

        return newColor;
    else
        print(error);
        return nil;
    end
end

--- Convert PZ color table to rgba color table.
--- @param colorTable {r:number, g:number, b:number, a:number} PZ color table.
--- @return {r:number, g:number, b:number, a:number} RGBA color table.
function TDTModAPI_PZ_Color.ConvertToRGBA(colorTable)
    local status, error = pcall(function ()
        Assert.AssertTable(colorTable, "colorTable");
    end);

    if status then
        local newColor = {};

        newColor.r = tonumber(colorTable.r) * 255.0;
        newColor.g = tonumber(colorTable.g) * 255.0;
        newColor.b = tonumber(colorTable.b) * 255.0;
        newColor.a = tonumber(colorTable.a) * 255.0;

        return newColor;
    else
        print(error);
        return nil;
    end
end

--- Convert color table to PZ rgb color table.
--- @param colorTable {r:number, g:number, b:number} Color table.
--- @return {r:number, g:number, b:number} PZ rgb color table.
function TDTModAPI_PZ_Color.ConvertToPZRGB(colorTable)
    local status, error = pcall(function ()
        Assert.AssertTable(colorTable, "colorTable");
    end);

    if status then
        local newColor = {};

        newColor.r = tonumber(colorTable.r) / 255.0;
        newColor.g = tonumber(colorTable.g) / 255.0;
        newColor.b = tonumber(colorTable.b) / 255.0;

        return newColor;
    else
        print(error);
        return nil;
    end
end

--- Convert color table to PZ rich text rgb color text.
--- @param colorTable {r:number, g:number, b:number} Color table.
--- @return string Rich text rgb color text.
function TDTModAPI_PZ_Color.ConvertToPZRichTextRGB(colorTable)
    local status, error = pcall(function ()
        Assert.AssertTable(colorTable, "colorTable");
    end);

    if status then
        return " <RGB:" .. colorTable.r .. "," .. colorTable.g .. "," .. colorTable.b .. "> ";
    else
        print(error);
        return nil;
    end
end

--- Convert color table to PZ rgba color table.
--- @param colorTable {r:number, g:number, b:number, a:number} Color table.
--- @return {r:number, g:number, b:number, a:number} PZ rgba color table.
function TDTModAPI_PZ_Color.ConvertToPZRGBA(colorTable)
    local status, error = pcall(function ()
        Assert.AssertTable(colorTable, "colorTable");
    end);

    if status then
        local newColor = {};

        newColor.r = tonumber(colorTable.r) / 255.0;
        newColor.g = tonumber(colorTable.g) / 255.0;
        newColor.b = tonumber(colorTable.b) / 255.0;
        newColor.a = tonumber(colorTable.a) / 255.0;

        return newColor;
    else
        print(error);
        return nil;
    end
end

--- Convert color table to PZ ColorInfo.
--- @param colorTable {r:number, g:number, b:number, a:number} Color table.
--- @return zombie.core.Color.ColorInfo ColorInfo.
function TDTModAPI_PZ_Color.ConvertToPZColorInfo(colorTable)
    local status, error = pcall(function ()
        Assert.AssertTable(colorTable, "colorTable");
    end);

    if status then
        return ColorInfo.new(tonumber(colorTable.r) / 255.0, tonumber(colorTable.g) / 255.0, tonumber(colorTable.b) / 255.0, tonumber(colorTable.a) / 255.0);
    else
        print(error);
        return nil;
    end
end

return TDTModAPI_PZ_Color;