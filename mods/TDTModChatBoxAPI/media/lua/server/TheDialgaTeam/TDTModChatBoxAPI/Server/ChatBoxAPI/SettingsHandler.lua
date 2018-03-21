--- @type TheDialgaTeam.TDTModAPI.System.IO.File
local File = TheDialgaTeam.TDTModAPI.System.IO.File;

--- @type TheDialgaTeam.TDTModAPI.Json
local Json = TheDialgaTeam.TDTModAPI.Json;

--- @type TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags;
local PermissionFlags = TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags;

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
        print "[TDTModChatBoxAPI:SettingsHandler] Load Settings.";

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
            self.Settings.Global.ChatBox.ServerMessage.Prefix = "SERVER : ";
            self.Settings.Global.ChatBox.ServerMessage.Suffix = "";

            self.Settings.Global.ChatBox.ServerMessage.Permission = {};
            self.Settings.Global.ChatBox.ServerMessage.Permission.Send = PermissionFlags.Admins;

            --- ########################################################################################################
            --- Global Chatbox Tabs settings.
            --- ########################################################################################################
            self.Settings.Global.ChatBox.Tabs = {};
            self.Settings.Global.ChatBox.Tabs.Enabled = false;

            self.Settings.Global.ChatBox.Tabs.Categories = {};

            --- ########################################################################################################
            --- Tab: Default.
            --- ########################################################################################################
            table.insert(self.Settings.Global.ChatBox.Tabs.Categories, {
                Name = "Default",
                Permission = {
                    Send = PermissionFlags.Everyone,
                    Receive = PermissionFlags.Everyone
                }
            });

            --- ########################################################################################################
            --- Tab: IC.
            --- ########################################################################################################
            table.insert(self.Settings.Global.ChatBox.Tabs.Categories, {
                Name = "IC",
                Enabled = false,
                Permission = {
                    Send = PermissionFlags.Everyone,
                    Receive = PermissionFlags.Everyone
                }
            });

            --- ########################################################################################################
            --- Tab: OOC.
            --- ########################################################################################################
            table.insert(self.Settings.Global.ChatBox.Tabs.Categories, {
                Name = "OOC",
                Enabled = false,
                Permission = {
                    Send = PermissionFlags.Everyone,
                    Receive = PermissionFlags.Everyone
                }
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
            self.Settings.Global.ChatBox.ColorPicker.Permission.Use = PermissionFlags.Everyone;

            --- ########################################################################################################
            --- Users settings.
            --- ########################################################################################################
            self.Settings.Users = {};

            --- ########################################################################################################
            --- Users: Steam settings.
            --- ########################################################################################################
            self.Settings.Users.Steam = {};

            table.insert(self.Settings.Users.Steam, {
                SteamID = "76561198119937183",
                IsMuted = false,
            });

            --- ########################################################################################################
            --- Users: Character settings.
            --- ########################################################################################################
            self.Settings.Users.Character = {};

            table.insert(self.Settings.Users.Character, {
                Username = "jianmingyong",
                IsMuted = false,
            });
        end

        File.WriteAllText("TDTModChatBoxAPI", "Settings/TDTModChatBoxAPI.json", Json.Serialize(self.Settings, { pretty = true, indent = "    ", array_newline = true }));
    end

    function self:GetGlobalSettings()
        return self.Settings.Global;
    end

    return self;
end

return SettingsHandler;