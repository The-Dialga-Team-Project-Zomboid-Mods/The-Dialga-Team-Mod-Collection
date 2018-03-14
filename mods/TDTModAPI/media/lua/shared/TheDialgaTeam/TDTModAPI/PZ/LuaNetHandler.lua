--- @type TheDialgaTeam.TDTModAPI.System.Object
local Object = require "TheDialgaTeam/TDTModAPI/System/Object";

--- @class TheDialgaTeam.TDTModAPI.PZ.LuaNetHandler
local TDTModAPI_PZ_LuaNetHandler = {};

--- Create a new instance of LuaNetHandler.
--- @param modId string Modification identifier.
--- @return TheDialgaTeam.TDTModAPI.PZ.LuaNetHandler.Instance A new instance of LuaNetHandler.
function TDTModAPI_PZ_LuaNetHandler.new(modId)
    --- @class TheDialgaTeam.TDTModAPI.PZ.LuaNetHandler.Instance : TheDialgaTeam.TDTModAPI.System.Object.Instance
    local self = Object.new();

    self.__Type = "TheDialgaTeam.TDTModAPI.PZ.LuaNetHandler";

    self.ModId = modId;

    self.LuaNet = LuaNet:getInstance();
    self.LuaNetModule = self.LuaNet.getModule(modID);

    --- Initialize LuaNetHandler.
    function self:Initialize()
        print("[" .. self.ModId .. ":LuaNetHandler] Initialize LuaNetHandler.");

        self.LuaNet.onInitAdd(function ()
            print("[" .. self.ModId .. ":LuaNetHandler] Initialize Command Handler.");
            self:InitializeCommandHandler();
        end);
    end

    --- Initialize Command Handler.
    function self:InitializeCommandHandler()

    end

    --- Add Command Handler into this LuaNet instance.
    --- @param name string Command name.
    --- @param luaFunction function Function to invoke.
    function self:AddCommandHandler(name, luaFunction)
        self.LuaNetModule.addCommandHandler(name, luaFunction);
    end

    --- Send command into the server.
    --- @param command string Command to send.
    --- @param params any Parameters to send.
    function self:SendToServer(command, params)
        if isClient() then
            self.LuaNetModule.send(command, params);
        end
    end

    --- Send command into the client.
    --- @param playerId number Player to send this command.
    --- @param command string Command to send.
    --- @param params any Parameters to send.
    function self:SendToPlayer(playerId, command, params)
        if isServer() then
            if type(playerId) ~= "number" then
                print("[" .. self.ModID .. ":LuaNetHandler] Invalid package data sent from the client.");
                return;
            end

            local player = getPlayerByOnlineID(playerId);

            if player ~= nil then
                self.LuaNetModule.sendPlayer(player, command, params);
                print("[" .. self.ModID .. ":LuaNetHandler] Package data sent to " .. player:getUsername());
            else
                print("[" .. self.ModID .. ":LuaNetHandler] Unable to find the user to send the package data.");
            end
        end
    end

    --- Send command into all the client.
    --- @param command string Command to send.
    --- @param params any Parameters to send.
    function self:SendToAllPlayer(command, params)
        if isServer() then
            self.LuaNetModule.send(command, params);
        end
    end

    return self;
end

return TDTModAPI_PZ_LuaNetHandler;