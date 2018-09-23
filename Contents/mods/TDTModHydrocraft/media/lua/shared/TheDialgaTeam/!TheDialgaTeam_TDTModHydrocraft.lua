--- ==================================================
--- The Dialga Team Mod Loader
--- ==================================================
local modInfo = require("TheDialgaTeam/TDTModHydrocraft/Global/ModInfo");
local modExposedAPI = require("TheDialgaTeam/TDTModHydrocraft/Global/ModExposedAPI");

TheDialgaTeam = TheDialgaTeam or {};
TheDialgaTeam[modInfo.ModId] = {};

for k, v in pairs(modExposedAPI) do
    TheDialgaTeam[modInfo.ModId][k] = v;
end

print("[" .. modInfo.ModId .. "] Global API Exposed!");