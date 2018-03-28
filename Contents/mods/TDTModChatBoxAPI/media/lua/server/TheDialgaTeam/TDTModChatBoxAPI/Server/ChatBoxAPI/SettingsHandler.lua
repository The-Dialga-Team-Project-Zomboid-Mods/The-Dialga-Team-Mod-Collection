--- @type TheDialgaTeam.TDTModAPI.Json
local Json = TheDialgaTeam.TDTModAPI.Json;

--- @type TheDialgaTeam.TDTModAPI.Lua.Table
local Table = TheDialgaTeam.TDTModAPI.Lua.Table;

--- @type TheDialgaTeam.TDTModAPI.System.IO.File
local File = TheDialgaTeam.TDTModAPI.System.IO.File;

--- @class TheDialgaTeam.TDTModChatBoxAPI.Server.ChatBoxAPI.SettingsHandler
local SettingsHandler = {};

function SettingsHandler.new(parent)
    --- @class TheDialgaTeam.TDTModChatBoxAPI.Server.ChatBoxAPI.SettingsHandler.Instance : TheDialgaTeam.TDTModAPI.System.Object.Instance
    local self = TheDialgaTeam.TDTModAPI.System.Object.new();

    self.__Type = "TheDialgaTeam.TDTModChatBoxAPI.Server.ChatBoxAPI.SettingsHandler";

    --- @type TheDialgaTeam.TDTModChatBoxAPI.Server.Main
    self.Super = parent;

    self.Settings = {};

    function self:LoadSettings()
        self.Settings = Json.Deserialize(File.ReadAllText("TDTModChatBoxAPI", "Settings/TDTModChatBoxAPI.json"));

        if type(self.Settings) ~= "table" then
            self.Settings = {};
            self.Settings.Global = {};

            --- ########################################################################################################
            --- Global ChatBox settings.
            --- ########################################################################################################
            self.Settings.Global.ChatBox = {};
            self.Settings.Global.ChatBox.Enabled = false;

            self.Settings.Global.ChatBox.Title = "";

            self.Settings.Global.ChatBox.BorderColor = { r = 102, g = 102, b = 102, a = 255 };
            self.Settings.Global.ChatBox.BackgroundColor = { r = 0, g = 0, b = 0, a = 204 };

            self.Settings.Global.ChatBox.BackgroundCanFade = true;
            self.Settings.Global.ChatBox.InvisibleTime = 5;

            --- ########################################################################################################
            --- Global Server Message settings.
            --- ########################################################################################################
            self.Settings.Global.ChatBox.ServerMessage = {};
            self.Settings.Global.ChatBox.ServerMessage.Enabled = true;

            self.Settings.Global.ChatBox.ServerMessage.DisplayTime = 5;

            self.Settings.Global.ChatBox.ServerMessage.Color = { r = 255, g = 25.5, b = 25.5, a = 255 };
            self.Settings.Global.ChatBox.ServerMessage.Prefix = "SERVER: ";
            self.Settings.Global.ChatBox.ServerMessage.Suffix = "";

            self.Settings.Global.ChatBox.ServerMessage.Permission = {};
            self.Settings.Global.ChatBox.ServerMessage.Permission.Send = TheDialgaTeam.TDTModChatBoxAPI.ServerMessage.PermissionFlags.Everyone;

            --- ########################################################################################################
            --- Global Chatbox Tabs settings.
            --- ########################################################################################################
            self.Settings.Global.ChatBox.Tabs = {};
            self.Settings.Global.ChatBox.Tabs.Enabled = false;

            self.Settings.Global.ChatBox.Tabs.Categories = {};

            --- ########################################################################################################
            --- Tab: IC.
            --- ########################################################################################################
            table.insert(self.Settings.Global.ChatBox.Tabs.Categories, {
                Name = "IC",
                Enabled = false
            });

            --- ########################################################################################################
            --- Tab: OOC.
            --- ########################################################################################################
            table.insert(self.Settings.Global.ChatBox.Tabs.Categories, {
                Name = "OOC",
                Enabled = false
            });

            --- ########################################################################################################
            --- Global MessageBox settings.
            --- ########################################################################################################
            self.Settings.Global.ChatBox.MessageBox = {};
            self.Settings.Global.ChatBox.MessageBox.ChatHistoryLines = 50;

            self.Settings.Global.ChatBox.MessageBox.Color = { r = 255, g = 255, b = 255 };

            self.Settings.Global.ChatBox.MessageBox.NameColor = { r = 255, g = 255, b = 255 };
            self.Settings.Global.ChatBox.MessageBox.NamePrefix = "";
            self.Settings.Global.ChatBox.MessageBox.NameSuffix = "";

            self.Settings.Global.ChatBox.MessageBox.AdminNameColor = { r = 255, g = 255, b = 255 };
            self.Settings.Global.ChatBox.MessageBox.AdminNamePrefix = "";
            self.Settings.Global.ChatBox.MessageBox.AdminNameSuffix = "";

            self.Settings.Global.ChatBox.MessageBox.WhisperDistance = 10;
            self.Settings.Global.ChatBox.MessageBox.TalkDistance = 30;
            self.Settings.Global.ChatBox.MessageBox.ShoutDistance = 60;

            --- ########################################################################################################
            --- Global InputField settings.
            --- ########################################################################################################
            self.Settings.Global.ChatBox.InputField = {};
            self.Settings.Global.ChatBox.InputField.Color = { r = 255, g = 255, b = 255 };

            --- ########################################################################################################
            --- Global ColorPicker settings.
            --- ########################################################################################################
            self.Settings.Global.ChatBox.ColorPicker = {};
            self.Settings.Global.ChatBox.ColorPicker.Enabled = false;

            self.Settings.Global.ChatBox.ColorPicker.Permission = {};
            self.Settings.Global.ChatBox.ColorPicker.Permission.Use = TheDialgaTeam.TDTModChatBoxAPI.ColorPicker.PermissionFlags.Everyone;

            --- ########################################################################################################
            --- Users settings.
            --- ########################################################################################################
            self.Settings.Users = {};

            --- ########################################################################################################
            --- Users: Steam settings.
            --- ########################################################################################################
            self.Settings.Users.Steam = {};

            --- ########################################################################################################
            --- Users: Character settings.
            --- ########################################################################################################
            self.Settings.Users.Character = {};
        end

        self:SaveSettings();
    end

    function self:SaveSettings()
        File.WriteAllText("TDTModChatBoxAPI", "Settings/TDTModChatBoxAPI.json", Json.Serialize(self.Settings, Json.Options.Pretty));
    end

    function self:GetGlobalSettings()
        return self.Settings.Global;
    end

    function self:GetUserSettings(steamId, username)
        local steam = self:GetSteamUserSettings(steamId);
        local user = self:GetCharacterUserSettings(username);

        return Table.Merge(user, steam);
    end

    function self:GetSteamUserSettings(steamId)
        for i, v in ipairs(self.Settings.Users.Steam) do
            if v.SteamID == steamId then
                return v;
            end
        end

        local newSteamUser = {
            SteamID = steamId,
        };

        table.insert(self.Settings.Users.Steam, newSteamUser);
        self:SaveSettings();

        return newSteamUser;
    end

    function self:GetCharacterUserSettings(username)
        for i, v in ipairs(self.Settings.Users.Character) do
            if v.Username == username then
                return v;
            end
        end

        local newCharacterUser = {
            Username = username,
            IsMuted = false,
            NameColor = false,
            FontColor = false,
            ColorPickerPermission = false,
        }

        table.insert(self.Settings.Users.Character, newCharacterUser);
        self:SaveSettings();

        return newCharacterUser;
    end

    function self:SetUserIsMuted(steamId, username, global, value)
        if global then
            local settings = self:GetSteamUserSettings(steamId);
            settings.IsMuted = value;
        else
            local settings = self:GetCharacterUserSettings(username);
            settings.IsMuted = value;
        end

        self:SaveSettings();
    end

    function self:SetUserNameColor(steamId, username, global, value)
        if global then
            local settings = self:GetSteamUserSettings(steamId);
            settings.NameColor = value;
        else
            local settings = self:GetCharacterUserSettings(username);
            settings.NameColor = value;
        end

        self:SaveSettings();
    end

    function self:SetUserFontColor(steamId, username, global, value)
        if global then
            local settings = self:GetSteamUserSettings(steamId);
            settings.FontColor = value;
        else
            local settings = self:GetCharacterUserSettings(username);
            settings.FontColor = value;
        end

        self:SaveSettings();
    end

    function self:SetUserColorPickerPermission(steamId, username, global, value)
        if global then
            local settings = self:GetSteamUserSettings(steamId);
            settings.ColorPickerPermission = value;
        else
            local settings = self:GetCharacterUserSettings(username);
            settings.ColorPickerPermission = value;
        end

        self:SaveSettings();
    end

    return self;
end

return SettingsHandler;