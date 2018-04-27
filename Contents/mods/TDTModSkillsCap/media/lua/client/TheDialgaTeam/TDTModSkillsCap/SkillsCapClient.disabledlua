local SkillsCapClient = {};
SkillsCapClient.Settings = {};
SkillsCapClient.LuaNet = LuaNet:getInstance();
SkillsCapClient.LuaNetModule = SkillsCapClient.LuaNet.getModule("TDTModSkillsCap");

function SkillsCapClient.OnConnected()
	if isClient() then
		print "[TDTModSkillsCap] Initializing LuaNet.";
		SkillsCapClient.LuaNet.onInitAdd(SkillsCapClient.InitializeClient);
	end
end

function SkillsCapClient.InitializeClient()
	print "[TDTModSkillsCap] Initializing client command.";
	SkillsCapClient.LuaNetModule.addCommandHandler("LoadSettings", function (_, settings)
		if type(settings) ~= "table" then
			print("[TDTModSkillsCap] Invalid package data sent from the server.");
		else
			SkillsCapClient.Settings = settings;
			print("[TDTModSkillsCap] Settings initialized.");
		end
	end);

	print "[TDTModSkillsCap] Initializing chatbox command.";
	TheDialgaTeam.TDTModChatBoxAPI.Events.OnCommandEntered.Add(SkillsCapClient.CommandHandler);
end

function SkillsCapClient.RequestDataFromServer()
	print("[TDTModSkillsCap] Requesting data from server.");
	local playerId = getPlayer():getOnlineID();

	SkillsCapClient.LuaNetModule.send("GetSettings", playerId);
	Events.OnTick.Remove(SkillsCapClient.RequestDataFromServer);
end

function SkillsCapClient.AddXP(player, perk, amount)
	if not isAdmin() then
		local perkName = PerkFactory.getPerk(perk):getName();
		local perkLevelCap = 10;
		
		-- Check Global Perk Cap
		local globalPerksCap = SkillsCapClient.Settings.GlobalPerksMaxLevel;
		
		if type(globalPerksCap) == "table" then
			local perkCap = globalPerksCap[perkName];
			
			if type(perkCap) == "number" then
				perkLevelCap = perkCap;
			end
		end
		
		-- Check Player Perk Cap
		local steamId = getSteamIDFromUsername(player:getUsername());
		local playerName = player:getName();
		
		local userSettings = SkillsCapClient.Settings.Users;
		local steamIgnore = nil;
		local userIgnore = nil;
		local steamOverride = nil;
		local userOverride = nil;
		
		if type(userSettings) == "table" then
			for _, userSetting in pairs(userSettings) do
				if type(userSetting) == "table" then
					if type(userSetting.SteamId) == "string" and userSetting.SteamId == steamId then
						if type(userSetting.IgnoreGlobally) == "boolean" then
							steamIgnore = userSetting.IgnoreGlobally;
						end
						
						if type(userSetting.PerksMaxLevel) == "table" then
							local perkCap = userSetting.PerksMaxLevel[perkName];
							
							if type(perkCap) == "number" then
								steamOverride = perkCap;
							end
						end
					elseif type(userSetting.Name) == "string" and userSetting.Name == playerName then
						if type(userSetting.IgnoreGlobally) == "boolean" then
							userIgnore = userSetting.IgnoreGlobally;
						end
						
						if type(userSetting.PerksMaxLevel) == "table" then
							local perkCap = userSetting.PerksMaxLevel[perkName];
							
							if type(perkCap) == "number" then
								userOverride = perkCap;
							end
						end
					end
				end
			end
		end
		
		if userIgnore ~= nil and userIgnore and steamIgnore == nil then
			return;
		elseif steamIgnore ~= nil and steamIgnore and userIgnore == nil then
			return;
		elseif userIgnore ~= nil and userIgnore and steamIgnore ~= nil and steamIgnore then
			return;
		else
			if steamOverride ~= nil then
				perkLevelCap = steamOverride;
			end
			
			if userOverride ~= nil then
				perkLevelCap = userOverride;
			end
		end
		
		local currentPerkTotalXP = player:getXp():getXP(perk);
		local maxPerkTotalXP = PerkFactory.getPerk(perk):getTotalXpForLevel(perkLevelCap);
		
		if currentPerkTotalXP > maxPerkTotalXP then
			player:getXp():AddXP(perk, maxPerkTotalXP - currentPerkTotalXP);
			
			local perkInfo = player:getPerkInfo(perk);
			
			if perkInfo ~= nil then
				local perkLevel = perkInfo:getLevel();
				
				if perkLevel ~= nil then
					while perkLevel > perkLevelCap do
						player:LoseLevel(perk);
					end
				end				
			end
		end
	end
end

function SkillsCapClient.CommandHandler(message)
	if isAdmin() then
		if message == "!reloadsettings" then
			SkillsCapClient.LuaNetModule.send("ReloadSettings");
			return { isCommand = true, commandOutput = "You have successfully requested the server to reload the settings!", commandPrefixOutput = "[TDTModSkillsCap]", isCommandConsumed = true };
		end
	end
end

Events.OnConnected.Add(SkillsCapClient.OnConnected);
Events.OnTick.Add(SkillsCapClient.RequestDataFromServer);
Events.AddXP.Add(SkillsCapClient.AddXP);