local LuaNetHandler = require "TheDialgaTeam/TDTModChatBoxAPI/ChatBoxAPI/LuaNetHandler";
local SettingsHandler = require "TheDialgaTeam/TDTModChatBoxAPI/ChatBoxAPI/SettingsHandler";
local ChatBox = require "TheDialgaTeam/TDTModChatBoxAPI/ChatBoxAPI/ChatBox";

local Main = {};

function Main.OnConnected()
    if isClient() then
        Main.LuaNetHandler = LuaNetHandler:new(Main);
        Main.LuaNetHandler:Initialize();
    end
end

function Main.OnGameStart()
    if isClient() then
        Main.SettingsHandler = SettingsHandler:new(Main);
        Events.OnTick.Add(Main.OnTick);
    end
end

function Main.OnTick()
    if Main.SettingsHandler.RequestSettingsFromServer then
        Main.LuaNetHandler.RequestGlobalSettings();
        Main.SettingsHandler.RequestSettingsFromServer = false;
    end
end

function Main.InitializeChatBox()
    if Main.SettingsHandler:getChatBoxEnabled() then
        Main.ChatBox = ChatBox:new(Main);
        Main.ChatBox:initialise();
        Main.ChatBox:addToUIManager();
        Main.ChatBox:setVisible(true);
        Main.ChatBox.pinButton:setVisible(false);
        Main.ChatBox.collapseButton:setVisible(false);
    end
end

Events.OnConnected.Add(Main.OnConnected);
Events.OnGameStart.Add(Main.OnGameStart);