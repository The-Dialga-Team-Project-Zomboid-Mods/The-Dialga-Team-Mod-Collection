--- @class TheDialgaTeam.TDTModChatBoxAPI.Server.ChatBoxAPI.LuaNetHandler
local LuaNetHandler = {};

function LuaNetHandler.new(parent)
    --- @class TheDialgaTeam.TDTModChatBoxAPI.Server.ChatBoxAPI.LuaNetHandler.Instance : TheDialgaTeam.TDTModAPI.PZ.LuaNetHandler.Instance
    local self = TheDialgaTeam.TDTModAPI.PZ.LuaNetHandler.new("TDTModChatBoxAPI");

    self.__Type = "TheDialgaTeam.TDTModChatBoxAPI.Server.ChatBoxAPI.LuaNetHandler";

    --- @type TheDialgaTeam.TDTModChatBoxAPI.Server.Main
    self.Super = parent;

    function self:InitializeCommandHandler()
        self:AddCommandHandler("GetGlobalSettings", function (_, playerId)
            self:SendToPlayer(playerId, "InitializeGlobalSettings", self.Super.SettingsHandler:GetGlobalSettings());
        end);
    end

    return self;
end

return LuaNetHandler;