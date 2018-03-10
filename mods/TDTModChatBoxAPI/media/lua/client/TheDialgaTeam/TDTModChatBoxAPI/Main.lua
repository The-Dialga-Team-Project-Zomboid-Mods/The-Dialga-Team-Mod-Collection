local LuaNetHandler = require "TheDialgaTeam/TDTModChatBoxAPI/ChatBoxAPI/LuaNetHandler";
local SettingsHandler = require "TheDialgaTeam/TDTModChatBoxAPI/ChatBoxAPI/SettingsHandler";

local Main = {};

Main.LuaNetHandler = LuaNetHandler:new(Main);
Main.SettingsHandler = SettingsHandler:new(Main);

function Main.OnConnected()
    if isClient() then
        Main.LuaNetHandler:Initialize();
    end
end

function Main.OnGameStart()
    if isClient() then
        Events.OnTick.Add(Main.OnTick);
    end
end

function Main.OnTick()
    if Main.SettingsHandler.RequestSettingsFromServer then
        Main.LuaNetHandler.RequestGlobalSettings();
        Main.SettingsHandler.RequestSettingsFromServer = false;
    end
end

Events.OnConnected.Add(Main.OnConnected);
Events.OnGameStart.Add(Main.OnGameStart);