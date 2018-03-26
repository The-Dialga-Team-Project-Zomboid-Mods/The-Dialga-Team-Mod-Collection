--- @type TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.LuaNetHandler
local LuaNetHandler = require "TheDialgaTeam/TDTModChatBoxAPI/Client/ChatBoxAPI/LuaNetHandler";

--- @type TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.SettingsHandler
local SettingsHandler = require "TheDialgaTeam/TDTModChatBoxAPI/Client/ChatBoxAPI/SettingsHandler";

--- @type TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.ChatBox
local ChatBox = require "TheDialgaTeam/TDTModChatBoxAPI/Client/ChatBoxAPI/ChatBox";

--- @class TheDialgaTeam.TDTModChatBoxAPI.Client.Main
--- @field public LuaNetHandler TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.LuaNetHandler
--- @field public SettingsHandler TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.SettingsHandler
--- @field public ChatBox TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.ChatBox
local Main = {};

function Main.OnConnected()
    if isClient() then
        Main.LuaNetHandler = LuaNetHandler.new(Main);
        Main.LuaNetHandler:Initialize();
    end
end

function Main.OnGameStart()
    if isClient() then
        Main.SettingsHandler = SettingsHandler.new(Main);
        Events.OnTick.Add(Main.OnTick);
    end
end

function Main.OnTick()
    if Main.SettingsHandler.RequestSettingsFromServer then
        Main.LuaNetHandler:RequestUserSettings();
        Main.LuaNetHandler:RequestGlobalSettings();
        Main.SettingsHandler.RequestSettingsFromServer = false;
    end

    Events.OnTick.Remove(Main.OnTick);
end

function Main.InitializeChatBox()
    if Main.SettingsHandler.GlobalSettings.ChatBox.Enabled then
        Main.ChatBox = ChatBox:new(Main);
        Main.ChatBox:initialise();
    else
        ISChat.createChat();
    end
end

Events.OnConnected.Add(Main.OnConnected);
Events.OnGameStart.Add(Main.OnGameStart);
Events.OnGameStart.Remove(ISChat.createChat);