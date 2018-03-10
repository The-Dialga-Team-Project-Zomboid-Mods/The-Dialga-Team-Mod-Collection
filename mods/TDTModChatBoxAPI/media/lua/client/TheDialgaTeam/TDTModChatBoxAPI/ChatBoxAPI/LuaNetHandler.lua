local LuaNetHandler = {};

function LuaNetHandler:new(parent)
    local o = {};
    setmetatable(o, self);
    self.__index = self;

    o.Parent = parent;

    o.LuaNet = LuaNet:getInstance();
    o.LuaNetModule = o.LuaNet.getModule("TDTModChatBoxAPI");

    return o;
end

function LuaNetHandler:Initialize()
    print "[TDTModChatBoxAPI:LuaNetHandler] Initialize LuaNetHandler.";

    self.LuaNet.onInitAdd(function ()
        LuaNetHandler.InitializeClient(self);
    end);
end

function LuaNetHandler:InitializeClient()
    print "[TDTModChatBoxAPI:LuaNetHandler] Initialize Client Command.";

    self.LuaNetModule.addCommandHandler("LoadGlobalSettings", function(player, settings)
        LuaNetHandler.ReceiveGlobalSettings(self, player, settings);
    end);
end

function LuaNetHandler:RequestGlobalSettings()
    print "[TDTModChatBoxAPI:LuaNetHandler] Request global settings from server.";
    self.LuaNetModule.send("GetGlobalSettings", getPlayer():getOnlineID());
end

function LuaNetHandler:ReceiveGlobalSettings(player, settings)
    if type(settings) ~= "table" then
        print "[TDTModChatBoxAPI:LuaNetHandler] Invalid package data sent from the server.";
    else
        self.Parent.SettingsHandler:ApplyGlobalSettings(settings);
    end
end

return LuaNetHandler;