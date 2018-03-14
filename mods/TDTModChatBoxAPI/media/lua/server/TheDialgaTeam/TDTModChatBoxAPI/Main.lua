--- @type Server.TheDialgaTeam.TDTModChatBoxAPI.ChatBoxAPI.LuaNetHandler
local LuaNetHandler = require "TheDialgaTeam/TDTModChatBoxAPI/ChatBoxAPI/LuaNetHandler";

--- @type Server.TheDialgaTeam.TDTModChatBoxAPI.ChatBoxAPI.SettingsHandler
local SettingsHandler = require "TheDialgaTeam/TDTModChatBoxAPI/ChatBoxAPI/SettingsHandler";

--- @type Server.TheDialgaTeam.TDTModChatBoxAPI.Main
local Main = {};

function Main.OnGameBoot()
    Main.LuaNetHandler = LuaNetHandler:new(Main);
    Main.LuaNetHandler:Initialize();

    Main.SettingsHandler = SettingsHandler:new(Main);
    Main.SettingsHandler:LoadSettings();
end

Events.OnGameBoot.Add(Main.OnGameBoot);