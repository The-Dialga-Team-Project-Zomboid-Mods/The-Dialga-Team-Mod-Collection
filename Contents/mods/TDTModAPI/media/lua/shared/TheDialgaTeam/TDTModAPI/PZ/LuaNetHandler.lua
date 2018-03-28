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
    self.LuaNetModule = self.LuaNet.getModule(modId);

    --- Initialize LuaNetHandler.
    function self:Initialize()
        print("[" .. self.ModId .. ":LuaNetHandler] Initialize LuaNetHandler.");

        self.LuaNet.onInitAdd(function ()
            print("[" .. self.ModId .. ":LuaNetHandler] Initialize package listener.");
            self:InitializePackageListener();
        end);
    end

    --- Initialize package listener.
    function self:InitializePackageListener()
    end

    --- Subscribe to the package type events.
    --- @param packageType string Package type.
    --- @param eventFunction function Function to invoke.
    function self:AddPackageListener(packageType, eventFunction)
        self.LuaNetModule.addCommandHandler(packageType, function (_, package)
            if isServer() then
                print("[" .. self.ModId .. ":LuaNetHandler] Package: " .. packageType .. " received from the client.");
            else
                print("[" .. self.ModId .. ":LuaNetHandler] Package: " .. packageType .. " received from the server.");
            end

            eventFunction(package);
        end);
    end

    --- Send command into the server.
    --- @param command string Command to send.
    --- @param params any Parameters to send.
    function self:SendToServer(command, params)
        if isClient() then
            self.LuaNetModule.send(command, params);
            print("[" .. self.ModId .. ":LuaNetHandler] Package: " .. command .. " sent to the server.");
        end
    end

    --- Send command into the client.
    --- @param playerId number Player to send this command.
    --- @param command string Command to send.
    --- @param params any Parameters to send.
    function self:SendToPlayer(playerId, command, params)
        if isServer() then
            if type(playerId) ~= "number" then
                print("[" .. self.ModId .. ":LuaNetHandler] Invalid package data sent from the client.");
                return;
            end

            local player = getPlayerByOnlineID(playerId);

            if player ~= nil then
                self.LuaNetModule.sendPlayer(player, command, params);
                print("[" .. self.ModId .. ":LuaNetHandler] Package: " .. command .. " sent to " .. player:getUsername());
            else
                print("[" .. self.ModId .. ":LuaNetHandler] Unable to find the user to sent the package data.");
            end
        end
    end

    --- Send command into all other client.
    --- @param playerId number Player to send this command.
    --- @param command string Command to send.
    --- @param params any Parameters to send.
    function self:SendToOtherPlayer(playerId, command, params)
        if isServer() then
            if type(playerId) ~= "number" then
                print("[" .. self.ModId .. ":LuaNetHandler] Invalid package data sent from the client.");
                return;
            end

            local players = getOnlinePlayers();

            for i = 0, players:size() - 1 do
                local player = players:get(i);

                if player:getOnlineID() ~= playerId then
                    self.LuaNetModule.sendPlayer(player, command, params);
                    print("[" .. self.ModId .. ":LuaNetHandler] Package: " .. command .. " sent to " .. player:getUsername());
                end
            end
        end
    end

    --- Send command into all the client.
    --- @param command string Command to send.
    --- @param params any Parameters to send.
    function self:SendToAllPlayer(command, params)
        if isServer() then
            self.LuaNetModule.send(command, params);
            print("[" .. self.ModId .. ":LuaNetHandler] Package: " .. command .. " sent to all players.");
        end
    end

    return self;
end

return TDTModAPI_PZ_LuaNetHandler;