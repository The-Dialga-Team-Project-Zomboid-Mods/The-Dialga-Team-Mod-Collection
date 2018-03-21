--- @class TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.LuaNetHandler
local LuaNetHandler = {};

function LuaNetHandler.new(parent)
    --- @class TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.LuaNetHandler.Instance : TheDialgaTeam.TDTModAPI.PZ.LuaNetHandler.Instance
    local self = TheDialgaTeam.TDTModAPI.PZ.LuaNetHandler.new("TDTModChatBoxAPI");

    self.__Type = "TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.LuaNetHandler";

    --- @type TheDialgaTeam.TDTModChatBoxAPI.Client.Main
    self.Super = parent;

    function self:InitializeCommandHandler()
        self:AddCommandHandler("InitializeGlobalSettings", function (_, settings)
            self:ReceiveGlobalSettings(settings, true);
        end);

        self:AddCommandHandler("ReloadGlobalSettings", function  (_, settings)
            self:ReceiveGlobalSettings(settings, false);
        end);
    end

    function self:RequestGlobalSettings()
        print "[TDTModChatBoxAPI:LuaNetHandler] Request global settings from server.";
        self:SendToServer("GetGlobalSettings", getPlayer():getOnlineID());
    end

    function self:ReceiveGlobalSettings(settings, loadChatbox)
        if type(settings) ~= "table" then
            print "[TDTModChatBoxAPI:LuaNetHandler] Invalid package data sent from the server.";
        else
            print "[TDTModChatBoxAPI:LuaNetHandler] Receive global settings from server.";
            self.Super.SettingsHandler:ApplyGlobalSettings(settings);

            if loadChatbox then
                self.Super.InitializeChatBox();
            end
        end
    end

    return self;
end

return LuaNetHandler;