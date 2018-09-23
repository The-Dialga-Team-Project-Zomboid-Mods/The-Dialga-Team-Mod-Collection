local modInfo = {
    ModName = "The Dialga Team Core API",
    ModId = "TDTCoreAPI",
    ModAlias = "TDTModAPI",
    ModVersion = 1,
    ModAuthor = "jianmingyong",
    Require = {},
};

local modExposedAPI = {
    Json = require(string.format("TheDialgaTeam/%s/Json", modInfo.ModId)),
    Lua = require(string.format("TheDialgaTeam/%s/Lua", modInfo.ModId)),
    PZ = require(string.format("TheDialgaTeam/%s/PZ", modInfo.ModId)),
    System = require(string.format("TheDialgaTeam/%s/System", modInfo.ModId)),
};

return {
    modInfo = modInfo,
    modExposedAPI = modExposedAPI,
}