local Json = TheDialgaTeam.TDTModAPI.Json;
local File = TheDialgaTeam.TDTModAPI.System.IO.File;

local TDTModChatBox = {};
TDTModChatBox.LuaNet = LuaNet:getInstance();
TDTModChatBox.LuaNetModule = TDTModChatBox.LuaNet.getModule("TDTModChatBoxAPI");
TDTModChatBox.Settings = {};

function TDTModChatBox.OnGameBoot()
    if isServer() then
        print "[TDTModChatBoxAPI] Initializing mod settings.";
        TDTModChatBox.LoadSettings();

        print "[TDTModChatBoxAPI] Initializing LuaNet.";
        TDTModChatBox.LuaNet.onInitAdd(TDTModChatBox.InitializeServer);
    end
end

function TDTModChatBox.InitializeServer()
    print "[TDTModChatBoxAPI] Initializing server command.";

    TDTModChatBox.LuaNetModule.addCommandHandler("GetSettings", function(_, playerId)
        if type(playerId) ~= "number" then
            print "[TDTModChatBoxAPI] Invalid package data sent from the client.";
            return;
        end

        local player = getPlayerByOnlineID(playerId);

        if player ~= nil then
            local playerUsername = player:getUsername();

            TDTModChatBox.LuaNetModule.sendPlayer(player, "LoadSettings", TDTModChatBox.Settings);
            print("[TDTModChatBoxAPI] Package data sent to " .. playerUsername);
        else
            print "[TDTModChatBoxAPI] Unable to find user to send the package data.";
        end
    end);

    TDTModChatBox.LuaNetModule.addCommandHandler("ReloadSettings", function()
        TDTModChatBox.LoadSettings();
        print "[TDTModChatBoxAPI] Settings reloaded.";

        TDTModChatBox.LuaNetModule.send("LoadSettings", TDTModChatBox.Settings);
    end);
end

function TDTModChatBox.LoadSettings()
    TDTModChatBox.Settings = Json.Deserialize(File.LoadFile("TDTModChatBoxAPI", "Settings/TDTModChatBoxAPI.json"));

    if type(TDTModChatBox.Settings) ~= "table" then
        TDTModChatBox.Settings = {};
        TDTModChatBox.Settings.Global = {};

        -- #############################################################################################################
        -- Global Chatbox settings.
        -- #############################################################################################################
        TDTModChatBox.Settings.Global.Chatbox = {};
        TDTModChatBox.Settings.Global.Chatbox.Enabled = false;

        TDTModChatBox.Settings.Global.Chatbox.Title = "";

        TDTModChatBox.Settings.Global.Chatbox.FontColor = { r = 255, g = 255, b = 255 };
        TDTModChatBox.Settings.Global.Chatbox.BackgroundColor = { r = 0, g = 0, b = 0, a = 204 };
        TDTModChatBox.Settings.Global.Chatbox.BorderColor = { r = 102, g = 102, b = 102, a = 255 };

        TDTModChatBox.Settings.Global.Chatbox.BackgroundCanFade = true;
        TDTModChatBox.Settings.Global.Chatbox.InvisibleTime = 5;

        -- #############################################################################################################
        -- Global Server message settings.
        -- #############################################################################################################
        TDTModChatBox.Settings.Global.Chatbox.ServerMessage = {};
        TDTModChatBox.Settings.Global.Chatbox.ServerMessage.Enabled = true;

        TDTModChatBox.Settings.Global.Chatbox.ServerMessage.DisplayTime = 5;

        TDTModChatBox.Settings.Global.Chatbox.ServerMessage.Color = { r = 255, g = 25.5, b = 25.5, a = 255 };
        TDTModChatBox.Settings.Global.Chatbox.ServerMessage.Prefix = "SERVER : ";
        TDTModChatBox.Settings.Global.Chatbox.ServerMessage.Suffix = "";

        TDTModChatBox.Settings.Global.Chatbox.ServerMessage.Permission = {};
        TDTModChatBox.Settings.Global.Chatbox.ServerMessage.Permission.Send = TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags.Admins;

        -- #############################################################################################################
        -- Global Chatbox tabs settings.
        -- #############################################################################################################
        TDTModChatBox.Settings.Global.Chatbox.Tabs = {};
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Enabled = false;

        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories = {};

        -- #############################################################################################################
        -- Default tab settings.
        -- #############################################################################################################
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default = {};
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.Enabled = true;

        -- #############################################################################################################
        -- Default tab rich textbox settings.
        -- #############################################################################################################
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.Message = {};
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.Message.ChatHistoryLines = 50;

        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.Message.NameColor = { r = 255, g = 255, b = 255 };
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.Message.NamePrefix = "";
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.Message.NameSuffix = "";

        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.Message.AdminNameColor = { r = 255, g = 255, b = 255 };
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.Message.AdminNamePrefix = "";
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.Message.AdminNameSuffix = "";

        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.Message.WhisperDistance = 10;
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.Message.TalkDistance = 30;
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.Message.ShoutDistance = 60;

        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.Message.Permission = {};
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.Message.Permission.Receive = TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags.Everyone;

        -- #############################################################################################################
        -- Default tab input field settings.
        -- #############################################################################################################
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.InputField = {};
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.InputField.Permission = {};
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.InputField.Permission.Send = TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags.Everyone;

        -- #############################################################################################################
        -- Default tab color picker settings.
        -- #############################################################################################################
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.ColorPicker = {};
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.ColorPicker.Enabled = false;

        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.ColorPicker.Permission = {};
        TDTModChatBox.Settings.Global.Chatbox.Tabs.Categories.Default.ColorPicker.Permission.Use = TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags.Everyone;

        TDTModChatBox.Settings.Users = {};
        TDTModChatBox.Settings.Users.Steam = {};
        TDTModChatBox.Settings.Users.Character = {};
    end

    File.SaveFile("TDTModChatBoxAPI", "Settings/TDTModChatBoxAPI.json", Json.Serialize(TDTModChatBox.Settings));
end

Events.OnGameBoot.Add(TDTModChatBox.OnGameBoot);