--- ==================================================
--- The Dialga Team Mod Loader
--- ==================================================
TheDialgaTeam = TheDialgaTeam or {};

local supportedMods = {};
table.insert(supportedMods, "TDTCoreAPI");
table.insert(supportedMods, "TDTModCoordinateView");

local function loadMod(modId, loadedModIds)
    if TheDialgaTeam[modId] ~= nil then
        return;
    end

    --- @type { modInfo:{ ModName:string, ModId:string, ModAlias:string, ModVersion:number, ModAuthor:string, Require:table }, modExposedAPI:table }
    local mod = require(string.format("!TheDialgaTeam_%s", modId));
    local loadGraph = loadedModIds or {};

    if mod == nil then
        print(string.format("[%s] Require mod files are missing, this mod will not be loaded!", modId));
        return;
    elseif mod.modInfo == nil or mod.modInfo.ModId == nil or mod.modInfo.ModId == "" then
        print(string.format("[%s] Unknown mod file loaded. Maybe the mod definition file is overridden by other mods.", modId));
    else
        for i, v in ipairs(loadGraph) do
            if v == modId then
                print(string.format("[%s] Circular dependencies found. This will not be loaded.", modId));
                return;
            end
        end

        table.insert(loadGraph, modId);

        -- Look for dependencies first.
        if mod.modInfo.Require ~= nil then
            for k, v in pairs(mod.modInfo.Require) do
                loadMod(k, loadGraph);

                if TheDialgaTeam[k] == nil then
                    print(string.format("[%s] %s is missing, the mod will not be loaded!", mod.modInfo.ModId, k));
                    return;
                elseif TheDialgaTeam[k]["modInfo"] == nil or TheDialgaTeam[k]["modInfo"]["ModVersion"] == nil or TheDialgaTeam[k]["modInfo"]["ModVersion"] < v then
                    print(string.format("[%s] %s is incompatible with this mod, this mod will not be loaded!", mod.modInfo.ModId, k));
                    return;
                end
            end
        end

        TheDialgaTeam[mod.modInfo.ModId] = {};
        TheDialgaTeam[mod.modInfo.ModId]["modInfo"] = mod.modInfo;

        if mod.modExposedAPI ~= nil then
            for k, v in pairs(mod.modExposedAPI) do
                TheDialgaTeam[mod.modInfo.ModId][k] = v;
            end
        end

        if mod.modInfo.ModAlias ~= nil and mod.modInfo.ModAlias ~= "" then
            TheDialgaTeam[mod.modInfo.ModAlias] = TheDialgaTeam[mod.modInfo.ModId];
        end
    end
end

for i, v in ipairs(supportedMods) do
    loadMod(v);
end