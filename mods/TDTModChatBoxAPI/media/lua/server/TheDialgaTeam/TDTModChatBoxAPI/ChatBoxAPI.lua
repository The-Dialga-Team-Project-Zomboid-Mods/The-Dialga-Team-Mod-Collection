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
	
	TDTModChatBox.LuaNetModule.addCommandHandler("GetSettings", function (_, playerId)
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
	
	TDTModChatBox.LuaNetModule.addCommandHandler("ReloadSettings", function ()
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
		TDTModChatBox.Settings.Global.Chatbox = {};
		
		TDTModChatBox.Settings.Global.Chatbox.Enabled = true;
		
		TDTModChatBox.Settings.Global.Chatbox.Title = "Shoutbox";
		
		TDTModChatBox.Settings.Global.Chatbox.FontColor = { r = 255, g = 255, b = 255 };
		TDTModChatBox.Settings.Global.Chatbox.BackgroundColor = { r = 0, g = 0, b = 0, a = 204 };
		TDTModChatBox.Settings.Global.Chatbox.BorderColor = { r = 102, g = 102, b = 102, a = 255 };

		TDTModChatBox.Settings.Global.Chatbox.BackgroundCanFade = false;
		TDTModChatBox.Settings.Global.Chatbox.InvisibleTime = 5;

		TDTModChatBox.Settings.Global.Chatbox.NameColor = { r = 255, g = 255, b = 255 };
		TDTModChatBox.Settings.Global.Chatbox.NamePrefix = "";
		TDTModChatBox.Settings.Global.Chatbox.NameSuffix = "";

		TDTModChatBox.Settings.Global.Chatbox.AdminNameColor = { r = 255, g = 0, b = 0 };
		TDTModChatBox.Settings.Global.Chatbox.AdminNamePrefix = "[Admin]";
		TDTModChatBox.Settings.Global.Chatbox.AdminNameSuffix = "";
		
		TDTModChatBox.Settings.Global.Chatbox.ServerMessageTime = 5;
		TDTModChatBox.Settings.Global.Chatbox.ServerMessageColor = { r = 255, g = 25.5, b = 25.5, a = 255 };
		TDTModChatBox.Settings.Global.Chatbox.ServerMessagePrefix = "SERVER :";
		TDTModChatBox.Settings.Global.Chatbox.ServerMessageSuffix = "";
		
		TDTModChatBox.Settings.Global.Chatbox.ChatHistoryLines = 500;

		TDTModChatBox.Settings.Global.Chatbox.WhisperDistance = 3.0;
		TDTModChatBox.Settings.Global.Chatbox.TalkDistance = 30.0;
		TDTModChatBox.Settings.Global.Chatbox.ShoutDistance = 60.0;
		
		TDTModChatBox.Settings.Global.Chatbox.ColorPicker = {};
		TDTModChatBox.Settings.Global.Chatbox.ColorPicker.Enabled = true;
		TDTModChatBox.Settings.Global.Chatbox.ColorPicker.AdminOnly = false;
		TDTModChatBox.Settings.Global.Chatbox.ColorPicker.WhitelistOnly = false;
		
		TDTModChatBox.Settings.Users = {};
		TDTModChatBox.Settings.Users.Steam = {};
		TDTModChatBox.Settings.Users.Character = {};
	end
	
	File.SaveFile("TDTModChatBoxAPI", "Settings/TDTModChatBoxAPI.json", Json.Serialize(TDTModChatBox.Settings));
end

Events.OnGameBoot.Add(TDTModChatBox.OnGameBoot);