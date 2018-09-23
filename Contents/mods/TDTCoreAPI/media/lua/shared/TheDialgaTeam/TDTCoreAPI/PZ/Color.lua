--- @class TheDialgaTeam.TDTCoreAPI.PZ.Color @Class that handles PZ colors.
local TDTCoreAPI_PZ_Color = {};

--- Convert PZ color table to rgb color table.
--- @param pzColorTable {r:number, g:number, b:number} @PZ color table.
--- @return {r:number, g:number, b:number} @RGB color table.
function TDTCoreAPI_PZ_Color.ConvertToRGB(pzColorTable)
    local newColor = {};

    newColor.r = tonumber(pzColorTable.r) * 255.0;
    newColor.g = tonumber(pzColorTable.g) * 255.0;
    newColor.b = tonumber(pzColorTable.b) * 255.0;

    return newColor;
end

--- Convert PZ color table to rgba color table.
--- @param pzColorTable {r:number, g:number, b:number, a:number} @PZ color table.
--- @return {r:number, g:number, b:number, a:number} @RGBA color table.
function TDTCoreAPI_PZ_Color.ConvertToRGBA(pzColorTable)
    local newColor = {};

    newColor.r = tonumber(pzColorTable.r) * 255.0;
    newColor.g = tonumber(pzColorTable.g) * 255.0;
    newColor.b = tonumber(pzColorTable.b) * 255.0;
    newColor.a = tonumber(pzColorTable.a) * 255.0;

    return newColor;
end

--- Convert color table to PZ rgb color table.
--- @param colorTable {r:number, g:number, b:number} @Color table.
--- @return {r:number, g:number, b:number} @PZ rgb color table.
function TDTCoreAPI_PZ_Color.ConvertToPZRGB(colorTable)
    local newColor = {};

    newColor.r = tonumber(colorTable.r) / 255.0;
    newColor.g = tonumber(colorTable.g) / 255.0;
    newColor.b = tonumber(colorTable.b) / 255.0;

    return newColor;
end

--- Convert color table to PZ rgba color table.
--- @param colorTable {r:number, g:number, b:number, a:number} @Color table.
--- @return {r:number, g:number, b:number, a:number} @PZ rgba color table.
function TDTCoreAPI_PZ_Color.ConvertToPZRGBA(colorTable)
    local newColor = {};

    newColor.r = tonumber(colorTable.r) / 255.0;
    newColor.g = tonumber(colorTable.g) / 255.0;
    newColor.b = tonumber(colorTable.b) / 255.0;
    newColor.a = tonumber(colorTable.a) / 255.0;

    return newColor;
end

--- Convert color table to PZ rich text rgb color text.
--- @param pzColorTable {r:number, g:number, b:number} @PZ color table.
--- @return string @Rich text rgb color text.
function TDTCoreAPI_PZ_Color.ConvertToPZRichTextRGB(pzColorTable)
    return " <RGB:" .. pzColorTable.r .. "," .. pzColorTable.g .. "," .. pzColorTable.b .. "> ";
end

--- Convert color table to PZ ColorInfo.
--- @param colorTable {r:number, g:number, b:number, a:number} @Color table.
--- @return zombie.core.textures.ColorInfo @ColorInfo.
function TDTCoreAPI_PZ_Color.ConvertToPZColorInfo(colorTable)
    return ColorInfo.new(tonumber(colorTable.r) / 255.0, tonumber(colorTable.g) / 255.0, tonumber(colorTable.b) / 255.0, tonumber(colorTable.a) / 255.0);
end

return TDTCoreAPI_PZ_Color;