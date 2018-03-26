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

        self:AddCommandHandler("GetUserSettings", function (_, playerTable)
            local player = getPlayerByOnlineID(playerTable.playerId);

            self:SendToPlayer(playerTable.playerId, "UpdateUserSettings", self.Super.SettingsHandler:GetUserSettings(playerTable.steamId, player:getUsername()));
        end);

        self:AddCommandHandler("UpdateUserFontColor", function (_, playerTable)
            self.Super.SettingsHandler:ApplyUserFontColor(getPlayerByOnlineID(playerTable.playerId):getUsername(), playerTable.color);
        end);
    end

    return self;
end

return LuaNetHandler;