local LuaNetHandler = {};

function LuaNetHandler:new(parent)
    local o = TheDialgaTeam.TDTModAPI.PZ.LuaNetHandler:new("TDTModChatBoxAPI");
    setmetatable(o, self);
    self.__index = self;

    o.Super = parent;

    return o;
end

function LuaNetHandler:InitializeCommandHandler()
    self:AddCommandHandler("InitializeGlobalSettings", function (_, settings)
        LuaNetHandler.ReceiveGlobalSettings(self, settings, true);
    end);

    self:AddCommandHandler("ReloadGlobalSettings", function (_, settings)
        LuaNetHandler.ReceiveGlobalSettings(self, settings, false);
    end);
end

function LuaNetHandler:RequestGlobalSettings()
    print "[TDTModChatBoxAPI:LuaNetHandler] Request global settings from server.";
    self.LuaNetModule.send("GetGlobalSettings", getPlayer():getOnlineID());
end

function LuaNetHandler:ReceiveGlobalSettings(settings, loadChatbox)
    if type(settings) ~= "table" then
        print "[TDTModChatBoxAPI:LuaNetHandler] Invalid package data sent from the server.";
    else
        self.Super.SettingsHandler:ApplyGlobalSettings(settings);

        if loadChatbox then
            self.Super.InitializeChatBox();
        end
    end
end

return LuaNetHandler;