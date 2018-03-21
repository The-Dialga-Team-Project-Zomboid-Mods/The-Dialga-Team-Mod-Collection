--- @type TheDialgaTeam.TDTModChatBoxAPI.Server.ChatBoxAPI.LuaNetHandler
local LuaNetHandler = require "TheDialgaTeam/TDTModChatBoxAPI/Server/ChatBoxAPI/LuaNetHandler";

--- @type TheDialgaTeam.TDTModChatBoxAPI.Server.ChatBoxAPI.SettingsHandler
local SettingsHandler = require "TheDialgaTeam/TDTModChatBoxAPI/Server/ChatBoxAPI/SettingsHandler";

--- @class TheDialgaTeam.TDTModChatBoxAPI.Server.Main
local Main = {};

function Main.OnGameBoot()
    Main.LuaNetHandler = LuaNetHandler.new(Main);
    Main.LuaNetHandler:Initialize();

    Main.SettingsHandler = SettingsHandler.new(Main);
    Main.SettingsHandler:LoadSettings();
end

Events.OnGameBoot.Add(Main.OnGameBoot);