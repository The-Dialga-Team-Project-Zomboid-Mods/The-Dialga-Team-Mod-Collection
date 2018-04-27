--- @type TheDialgaTeam.TDTModChatBoxAPI.LuaNetHandler.PackageTypes
local PackageTypes = TheDialgaTeam.TDTModChatBoxAPI.LuaNetHandler.PackageTypes;

--- @class TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.LuaNetHandler
local LuaNetHandler = {};

function LuaNetHandler.new(parent)
    --- @class TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.LuaNetHandler.Instance : TheDialgaTeam.TDTModAPI.PZ.LuaNetHandler.Instance
    local self = TheDialgaTeam.TDTModAPI.PZ.LuaNetHandler.new(TheDialgaTeam.TDTModChatBoxAPI.ModId);

    self.__Type = "TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.LuaNetHandler";

    --- @type TheDialgaTeam.TDTModChatBoxAPI.Client.Main
    self.Super = parent;

    function self:InitializePackageListener()
        self:AddPackageListener(PackageTypes.GlobalSettings, function (package)
            self.Super.SettingsHandler:SetGlobalSettings(package);

            if not self.Super.ChatBoxLoaded then
                self.Super.InitializeChatBox();
                self.Super.ChatBoxLoaded = true;
            end
        end);

        self:AddPackageListener(PackageTypes.UserSettings, function (package)
            self.Super.SettingsHandler:SetUserSettings(package);
        end);

        self:AddPackageListener(PackageTypes.ChatMessage, function (package)
            self.Super.ChatBox:HandleServerMessage(package);
        end);
    end

    return self;
end

return LuaNetHandler;