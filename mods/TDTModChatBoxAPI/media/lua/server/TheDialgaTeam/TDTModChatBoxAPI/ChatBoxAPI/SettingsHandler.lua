--- @type TheDialgaTeam.TDTModAPI.System.IO.File
local File = TheDialgaTeam.TDTModAPI.System.IO.File;

--- @type TheDialgaTeam.TDTModAPI.Json
local Json = TheDialgaTeam.TDTModAPI.Json;

--- @type TheDialgaTeam.TDTModAPI.System.Object
local Object = TheDialgaTeam.TDTModAPI.System.Object;

--- @type TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags;
local PermissionFlags = TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags;

--- @class Server.TheDialgaTeam.TDTModChatBoxAPI.ChatBoxAPI.SettingsHandler : TheDialgaTeam.TDTModAPI.System.Object
local SettingsHandler = Object:derive("Server.TheDialgaTeam.TDTModChatBoxAPI.ChatBoxAPI.SettingsHandler");

function SettingsHandler:new(parent)
    local o = {};
    setmetatable(o, self);
    self.__index = self;

    o.Super = parent;

    o.Settings = {};

    return o;
end

function SettingsHandler:LoadSettings()
    print "[TDTModChatBoxAPI:SettingsHandler] Load Settings.";

    self.Settings = Json.Deserialize(File.ReadAllText("TDTModChatBoxAPI", "Settings/TDTModChatBoxAPI.json"));

    if type(self.Settings) ~= "table" then
        self.Settings = {};
        self.Settings.Global = {};

        -- #############################################################################################################
        -- Global Chatbox settings.
        -- #############################################################################################################
        self.Settings.Global.Chatbox = {};
        self.Settings.Global.Chatbox.Enabled = false;

        self.Settings.Global.Chatbox.Title = "";

        self.Settings.Global.Chatbox.FontColor = { r = 255, g = 255, b = 255 };
        self.Settings.Global.Chatbox.BackgroundColor = { r = 0, g = 0, b = 0, a = 204 };
        self.Settings.Global.Chatbox.BorderColor = { r = 102, g = 102, b = 102, a = 255 };

        self.Settings.Global.Chatbox.BackgroundCanFade = true;
        self.Settings.Global.Chatbox.InvisibleTime = 5;

        -- #############################################################################################################
        -- Global Server message settings.
        -- #############################################################################################################
        self.Settings.Global.Chatbox.ServerMessage = {};
        self.Settings.Global.Chatbox.ServerMessage.Enabled = true;

        self.Settings.Global.Chatbox.ServerMessage.DisplayTime = 5;

        self.Settings.Global.Chatbox.ServerMessage.Color = { r = 255, g = 25.5, b = 25.5, a = 255 };
        self.Settings.Global.Chatbox.ServerMessage.Prefix = "SERVER : ";
        self.Settings.Global.Chatbox.ServerMessage.Suffix = "";

        self.Settings.Global.Chatbox.ServerMessage.Permission = {};
        self.Settings.Global.Chatbox.ServerMessage.Permission.Send = PermissionFlags.Admins;

        -- #############################################################################################################
        -- Global Chatbox tabs settings.
        -- #############################################################################################################
        self.Settings.Global.Chatbox.Tabs = {};
        self.Settings.Global.Chatbox.Tabs.Enabled = false;

        self.Settings.Global.Chatbox.Tabs.Categories = {};

        -- #############################################################################################################
        -- Default tab settings.
        -- #############################################################################################################
        self.Settings.Global.Chatbox.Tabs.Categories.Default = {};
        self.Settings.Global.Chatbox.Tabs.Categories.Default.Enabled = true;

        -- #############################################################################################################
        -- Default tab rich textbox settings.
        -- #############################################################################################################
        self.Settings.Global.Chatbox.Tabs.Categories.Default.Message = {};
        self.Settings.Global.Chatbox.Tabs.Categories.Default.Message.ChatHistoryLines = 50;

        self.Settings.Global.Chatbox.Tabs.Categories.Default.Message.NameColor = { r = 255, g = 255, b = 255 };
        self.Settings.Global.Chatbox.Tabs.Categories.Default.Message.NamePrefix = "";
        self.Settings.Global.Chatbox.Tabs.Categories.Default.Message.NameSuffix = "";

        self.Settings.Global.Chatbox.Tabs.Categories.Default.Message.AdminNameColor = { r = 255, g = 255, b = 255 };
        self.Settings.Global.Chatbox.Tabs.Categories.Default.Message.AdminNamePrefix = "";
        self.Settings.Global.Chatbox.Tabs.Categories.Default.Message.AdminNameSuffix = "";

        self.Settings.Global.Chatbox.Tabs.Categories.Default.Message.WhisperDistance = 10;
        self.Settings.Global.Chatbox.Tabs.Categories.Default.Message.TalkDistance = 30;
        self.Settings.Global.Chatbox.Tabs.Categories.Default.Message.ShoutDistance = 60;

        self.Settings.Global.Chatbox.Tabs.Categories.Default.Message.Permission = {};
        self.Settings.Global.Chatbox.Tabs.Categories.Default.Message.Permission.Receive = PermissionFlags.Everyone;

        -- #############################################################################################################
        -- Default tab input field settings.
        -- #############################################################################################################
        self.Settings.Global.Chatbox.Tabs.Categories.Default.InputField = {};
        self.Settings.Global.Chatbox.Tabs.Categories.Default.InputField.Permission = {};
        self.Settings.Global.Chatbox.Tabs.Categories.Default.InputField.Permission.Send = PermissionFlags.Everyone;

        -- #############################################################################################################
        -- Default tab color picker settings.
        -- #############################################################################################################
        self.Settings.Global.Chatbox.Tabs.Categories.Default.ColorPicker = {};
        self.Settings.Global.Chatbox.Tabs.Categories.Default.ColorPicker.Enabled = false;

        self.Settings.Global.Chatbox.Tabs.Categories.Default.ColorPicker.Permission = {};
        self.Settings.Global.Chatbox.Tabs.Categories.Default.ColorPicker.Permission.Use = PermissionFlags.Everyone;

        self.Settings.Users = {};
        self.Settings.Users.Steam = {};
        self.Settings.Users.Character = {};
    end

    File.WriteAllText("TDTModChatBoxAPI", "Settings/TDTModChatBoxAPI.json", Json.Serialize(self.Settings));
end

function SettingsHandler:getGlobalSettings()
    return self.Settings.Global;
end

return SettingsHandler;