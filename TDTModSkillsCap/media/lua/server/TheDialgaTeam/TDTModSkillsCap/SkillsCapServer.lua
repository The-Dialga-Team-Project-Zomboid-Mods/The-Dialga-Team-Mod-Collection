local Json = TheDialgaTeam.TDTModAPI.Json;
local File = TheDialgaTeam.TDTModAPI.System.IO.File;

local SkillsCapServer = {};
SkillsCapServer.LuaNet = LuaNet:getInstance();
SkillsCapServer.LuaNetModule = SkillsCapServer.LuaNet.getModule("TDTModSkillsCap");
SkillsCapServer.Settings = {};

function SkillsCapServer.OnGameBoot()
	if isServer() then
		print "[TDTModSkillsCap] Initializing mod settings.";
		SkillsCapServer.LoadSettings();
		
		print "[TDTModSkillsCap] Initializing LuaNet.";
		SkillsCapServer.LuaNet.onInitAdd(SkillsCapServer.InitializeServer);
	end
end

function SkillsCapServer.InitializeServer()
	print "[TDTModSkillsCap] Initializing server command.";
	
	SkillsCapServer.LuaNetModule.addCommandHandler("GetSettings", function (_, playerId)
		if type(playerId) ~= "number" then
			print "[TDTModSkillsCap] Invalid package data sent from the client.";
			return;
		end
		
		local player = getPlayerByOnlineID(playerId);
		
		if player ~= nil then
			local playerUsername = player:getUsername();
			
			SkillsCapServer.LuaNetModule.sendPlayer(player, "LoadSettings", SkillsCapServer.Settings);
			print("[TDTModSkillsCap] Package data sent to " .. playerUsername);
		else
			print "[TDTModSkillsCap] Unable to find user to send the package data.";
		end
	end);
	
	SkillsCapServer.LuaNetModule.addCommandHandler("ReloadSettings", function ()
		SkillsCapServer.LoadSettings();
		print "[TDTModSkillsCap] Settings reloaded.";
		
		SkillsCapServer.LuaNetModule.send("LoadSettings", SkillsCapServer.Settings);
	end);
end

function SkillsCapServer.LoadSettings()
	SkillsCapServer.Settings = Json.Decode(File.LoadFile("TDTModSkillsCap", "Settings/SkillsCap_Global.json"))
		
	if type(SkillsCapServer.Settings) ~= "table" then
		SkillsCapServer.Settings = {};
	end
	
	if type(SkillsCapServer.Settings.GlobalPerksMaxLevel) ~= "table" then
		SkillsCapServer.Settings.GlobalPerksMaxLevel = {};
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Trapping"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Survivalist"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Reloading"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Passive"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Agility"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Firearm"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Metalworking"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Carpentry"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["First Aid"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Blunt"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Nimble"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Fitness"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Sprinting"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Guard"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Crafting"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Accuracy"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Strength"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Lightfooted"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Electrical"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Fishing"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Aiming"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Farming"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Maintenance"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Sneaking"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Foraging"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Blade"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Mechanics"] = 10;
		SkillsCapServer.Settings.GlobalPerksMaxLevel["Cooking"] = 10;
	end
	
	if type(SkillsCapServer.Settings.Users) ~= "table" then
		SkillsCapServer.Settings.Users = {};
		
		table.insert(SkillsCapServer.Settings.Users, { Name = "Character Name", IgnoreGlobally = false, PerksMaxLevel = SkillsCapServer.Settings.GlobalPerksMaxLevel });
		table.insert(SkillsCapServer.Settings.Users, { SteamId = "76561198119937183", IgnoreGlobally = false });
	end
		
	File.SaveFile("TDTModSkillsCap", "Settings/SkillsCap_Global.json", Json.EncodePretty(SkillsCapServer.Settings));
end

Events.OnGameBoot.Add(SkillsCapServer.OnGameBoot)