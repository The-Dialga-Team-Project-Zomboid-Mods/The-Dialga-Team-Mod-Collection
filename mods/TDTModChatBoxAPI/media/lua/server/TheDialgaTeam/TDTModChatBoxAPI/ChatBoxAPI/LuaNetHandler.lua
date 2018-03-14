--- @type TheDialgaTeam.TDTModAPI.PZ.LuaNetHandler
local TheDialgaTeam_TDTModAPI_PZ_LuaNetHandler = TheDialgaTeam.TDTModAPI.PZ.LuaNetHandler;

--- @class Server.TheDialgaTeam.TDTModChatBoxAPI.ChatBoxAPI.LuaNetHandler
local LuaNetHandler = {};

function LuaNetHandler.new(parent)
    --- @class Server.TheDialgaTeam.TDTModChatBoxAPI.ChatBoxAPI.LuaNetHandler.self : TheDialgaTeam.TDTModAPI.PZ.LuaNetHandler.self
    local self = TheDialgaTeam_TDTModAPI_PZ_LuaNetHandler.new("TDTModChatBoxAPI");
    self.__Type = "Server.TheDialgaTeam.TDTModChatBoxAPI.ChatBoxAPI.LuaNetHandler";

    self.Super = parent;

    function self:InitializeCommandHandler()
        self:AddCommandHandler("GetGlobalSettings", function (_, playerId)
            if type(playerId) ~= "number" then
                print "[TDTModChatBoxAPI:LuaNetHandler] Invalid package data sent from the client.";
                return;
            end

            local player = getPlayerByOnlineID(playerId);

            if player ~= nil then
                self.SendToPlayer(playerId, "InitializeGlobalSettings", self.Super.SettingsHandler.getGlobalSettings());
                print("[TDTModChatBoxAPI:LuaNetHandler] Package data sent to " .. player:getUsername());
            else
                print "[TDTModChatBoxAPI:LuaNetHandler] Unable to find the user to send the package data.";
            end
        end);
    end

    return self;
end

return LuaNetHandler;