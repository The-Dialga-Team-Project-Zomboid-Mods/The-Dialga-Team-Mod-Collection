--- @type TheDialgaTeam.TDTModChatBoxAPI.LuaNetHandler.PackageTypes
local PackageTypes = TheDialgaTeam.TDTModChatBoxAPI.LuaNetHandler.PackageTypes;

--- @class TheDialgaTeam.TDTModChatBoxAPI.Server.ChatBoxAPI.LuaNetHandler
local LuaNetHandler = {};

function LuaNetHandler.new(parent)
    --- @class TheDialgaTeam.TDTModChatBoxAPI.Server.ChatBoxAPI.LuaNetHandler.Instance : TheDialgaTeam.TDTModAPI.PZ.LuaNetHandler.Instance
    local self = TheDialgaTeam.TDTModAPI.PZ.LuaNetHandler.new("TDTModChatBoxAPI");

    self.__Type = "TheDialgaTeam.TDTModChatBoxAPI.Server.ChatBoxAPI.LuaNetHandler";

    --- @type TheDialgaTeam.TDTModChatBoxAPI.Server.Main
    self.Super = parent;

    function self:InitializePackageListener()
        self:AddPackageListener(PackageTypes.GlobalSettings, function (package)
            self:SendToPlayer(package.playerId, PackageTypes.GlobalSettings, self.Super.SettingsHandler:GetGlobalSettings());
        end);

        self:AddPackageListener(PackageTypes.UserSettings, function (package)
            self:SendToPlayer(package.playerId, PackageTypes.UserSettings, self.Super.SettingsHandler:GetUserSettings(package.steamId, getPlayerByOnlineID(package.playerId):getUsername()));
        end);

        self:AddPackageListener(PackageTypes.UserFontColor, function (package)
            self.Super.SettingsHandler:SetUserFontColor(package.steamId, getPlayerByOnlineID(package.playerId):getUsername(), package.isGlobal, package.value);
        end);

        self:AddPackageListener(PackageTypes.ChatMessage, function (package)
            self:SendToOtherPlayer(package.playerId, PackageTypes.ChatMessage, package.data);
        end);

        self:AddPackageListener(PackageTypes.ReloadServerSettings, function (package)
            self.Super.SettingsHandler:LoadSettings();
            self:SendToAllPlayer(PackageTypes.GlobalSettings, self.Super.SettingsHandler:GetGlobalSettings());
        end);
    end

    return self;
end

return LuaNetHandler;