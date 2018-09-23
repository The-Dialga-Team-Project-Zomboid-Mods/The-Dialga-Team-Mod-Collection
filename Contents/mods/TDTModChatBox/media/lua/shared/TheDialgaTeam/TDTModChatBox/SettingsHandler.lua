--- @type TheDialgaTeam.TDTCoreAPI.Json
local Json = TheDialgaTeam.TDTCoreAPI.Json;

--- @type TheDialgaTeam.TDTCoreAPI.System.IO.File
local File = TheDialgaTeam.TDTCoreAPI.System.IO.File;

local ModInfo = TheDialgaTeam.TDTModChatBox.ModInfo;

--- @class TheDialgaTeam.TDTModChatBox.SettingsHandler
--- @field Settings table
local SettingsHandler = {};

--- Create a new instance of SettingsHandler.
--- @return TheDialgaTeam.TDTModChatBox.SettingsHandler
function SettingsHandler.new()
    local o = {};

    if isServer() then
        o.Settings = {};
    end

    setmetatable(o, { __index = SettingsHandler });
    return o;
end

function SettingsHandler:LoadSettings()
    if isServer() then
        self.Settings = Json.Deserialize(File.ReadAllText(ModInfo.ModId, "Settings/TDTModChatBox.json"))
    end
end