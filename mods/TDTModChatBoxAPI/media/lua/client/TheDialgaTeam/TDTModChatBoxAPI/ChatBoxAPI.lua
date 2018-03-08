local System = TheDialgaTeam.TDTModAPI.System;
local PZ = TheDialgaTeam.TDTModAPI.PZ;
local CommandHandler = require "TheDialgaTeam/TDTModChatBoxAPI/CommandHandler";

-- Remove event handler for original chat box.
Events.OnGameStart.Remove(ISChat.createChat);

local TDTModChatBox = ISCollapsableWindow:derive("TDTModChatBox");
TDTModChatBox.FontColor = { r = 1, g = 1, b = 1 };
TDTModChatBox.Messages = {};
TDTModChatBox.MessageLog = {};
TDTModChatBox.LogIndex = 0;
TDTModChatBox.InvisibleTime = 0;
TDTModChatBox.InputDelay = 20;
TDTModChatBox.ServerMessage = "";
TDTModChatBox.ServerMessageDelay = 0;

TDTModChatBox.LuaNet = LuaNet:getInstance();
TDTModChatBox.LuaNetModule = TDTModChatBox.LuaNet.getModule("TDTModChatBoxAPI");
TDTModChatBox.RequestSettingsFromServer = true;
TDTModChatBox.Settings = {};

function TDTModChatBox:new()
	local o = ISCollapsableWindow:new(0, 0, 0, 0);
	setmetatable(o, self);
	self.__index = self;
	
	o.width = 500;
	o.height = o.titleBarHeight() + 200 + getTextManager():getFontFromEnum(UIFont.Medium):getLineHeight() + 10 + 2 + o.resizeWidgetHeight();
	
	o.minimumWidth = o.width;
	o.minimumHeight = o.height;
	
	o.x = 0;
	o.y = getCore():getScreenHeight() - o.height;
	
	o.borderColor = PZ.Color.ConvertToPZRGBA(TDTModChatBox.Settings.Global.Chatbox.BorderColor);
	o.backgroundColor = PZ.Color.ConvertToPZRGBA(TDTModChatBox.Settings.Global.Chatbox.BackgroundColor);
	
	o.pin = true;
	
	o.title = TDTModChatBox.Settings.Global.Chatbox.Title;
	
	return o;
end

function TDTModChatBox:initialise()
	ISCollapsableWindow.initialise(TDTModChatBox.Chatbox);
	
	if not TDTModChatBox.Settings.Global.Chatbox.ColorPicker.Enabled then
		return;
	end
	
	if TDTModChatBox.Settings.Global.Chatbox.ColorPicker.AdminOnly and not isAdmin() then
		return;
	end
	
	-- TODO: Whitelisted only.
	
	TDTModChatBox.Chatbox.ColorPicker = ISColorPicker:new(0, 0);
	TDTModChatBox.Chatbox.ColorPicker:initialise();
	TDTModChatBox.Chatbox.ColorPicker.pickedTarget = TDTModChatBox.Chatbox;
	TDTModChatBox.Chatbox.ColorPicker.resetFocusTo = TDTModChatBox.Chatbox;
	TDTModChatBox.Chatbox.ColorPicker:addToUIManager();
	TDTModChatBox.Chatbox.ColorPicker:setVisible(false);
	TDTModChatBox.Chatbox.ColorPicker.otherFct = true;
	TDTModChatBox.Chatbox.ColorPicker.parent = TDTModChatBox.Chatbox;
	
	TDTModChatBox.Chatbox.ColorPicker.pickedFunc = function (target, color)
		TDTModChatBox.FontColor = color;
		TDTModChatBox.Chatbox.InputField.javaObject:setTextColor(ColorInfo.new(color.r, color.g, color.b, 1));
		TDTModChatBox.Chatbox.InputField:focus();
		TDTModChatBox.Chatbox.ColorPicker:setVisible(false);
	end;
	
	TDTModChatBox.Chatbox.ColorPicker.onMouseDownOutside = function ()
		TDTModChatBox.Chatbox.ColorPicker:setVisible(false);
	end;
end

function TDTModChatBox:createChildren()
	ISCollapsableWindow.createChildren(TDTModChatBox.Chatbox);
	TDTModChatBox.InitializeChatMessage(TDTModChatBox.Chatbox);
	TDTModChatBox.InitializeInputField(TDTModChatBox.Chatbox);
	TDTModChatBox.InitializeColorPickerButton(TDTModChatBox.Chatbox);
end

function TDTModChatBox:InitializeChatMessage()
	self.ChatMessage = ISRichTextPanel:new(0, 16, 500, 200);
	self.ChatMessage:initialise();
	self.ChatMessage.background = false;
	self.ChatMessage.clip = true;
	self.ChatMessage:setAnchorBottom(true);
	self.ChatMessage:setAnchorRight(true);
	self.ChatMessage.marginTop = 4;
	self.ChatMessage.marginBottom = 4;
	self.ChatMessage.maxLines = 500;
	self.ChatMessage.autosetheight = false;
	self.ChatMessage.text = "";
	self.ChatMessage:paginate()
	self.ChatMessage:addScrollBars();
	self.ChatMessage.vscroll.background = false;
	self.ChatMessage:ignoreHeightChange();
	self.ChatMessage:setVisible(true);

	self:addChild(self.ChatMessage);
end

function TDTModChatBox:InitializeInputField()
	local fontSize = getTextManager():getFontFromEnum(UIFont.Medium):getLineHeight();

	if not TDTModChatBox.Settings.Global.Chatbox.ColorPicker.Enabled then
		self.InputField = ISTextEntryBox:new("", 2, 16 + 200, 500 - 4, fontSize + 10);
	elseif TDTModChatBox.Settings.Global.Chatbox.ColorPicker.AdminOnly and not isAdmin() then
		self.InputField = ISTextEntryBox:new("", 2, 16 + 200, 500 - 4, fontSize + 10);
	else
		self.InputField = ISTextEntryBox:new("", 2, 16 + 200, 500 - 4 - (fontSize + 10) - 2, fontSize + 10);
	end
	
	self.InputField.font = UIFont.Medium;
	self.InputField:initialise();
	self.InputField:instantiate();
	self.InputField.backgroundColor = { r = 0, g = 0, b = 0, a = 0.0 };
	self.InputField.borderColor = { r = 1, g = 1, b = 1, a = 0.0 };
	self.InputField:setHasFrame(true)
	self.InputField:setVisible(false);
	self.InputField:setAnchorTop(false);
	self.InputField:setAnchorBottom(true);
	self.InputField:setAnchorRight(true);
	
	local defaultFontColor = TDTModChatBox.Settings.Global.Chatbox.FontColor;
	defaultFontColor.a = 255;
	
	TDTModChatBox.FontColor = PZ.Color.ConvertToPZRGB(TDTModChatBox.Settings.Global.Chatbox.FontColor);
	self.InputField.javaObject:setTextColor(PZ.Color.ConvertToPZColorInfo(defaultFontColor));

	self.InputField.onOtherKey = function (key)
		if key == Keyboard.KEY_ESCAPE then
			TDTModChatBox.UnfocusInputField();
		end
	end;
	
	self.InputField.onPressUp = function ()
		if #TDTModChatBox.MessageLog > 0 then
			TDTModChatBox.LogIndex = TDTModChatBox.LogIndex - 1;
			
			if TDTModChatBox.LogIndex < 1 then
				TDTModChatBox.LogIndex = 1;
			elseif TDTModChatBox.LogIndex > #TDTModChatBox.MessageLog then
				TDTModChatBox.LogIndex = #TDTModChatBox.MessageLog;
			end
			
			self.InputField:setText(TDTModChatBox.MessageLog[TDTModChatBox.LogIndex]);
		end
	end;
	
	self.InputField.onPressDown = function ()
		if #TDTModChatBox.MessageLog > 0 then
			TDTModChatBox.LogIndex = TDTModChatBox.LogIndex + 1;
			
			if TDTModChatBox.LogIndex < 1 then
				TDTModChatBox.LogIndex = 1;
			elseif TDTModChatBox.LogIndex > #TDTModChatBox.MessageLog then
				TDTModChatBox.LogIndex = #TDTModChatBox.MessageLog;
			end
			
			self.InputField:setText(TDTModChatBox.MessageLog[TDTModChatBox.LogIndex]);
		end
	end;
	
	self.InputField.onCommandEntered = function ()
		local command = self.InputField:getText();
		
		local colorText = PZ.Color.ConvertToPZRichTextRGB(TDTModChatBox.FontColor);
		local resetColorText = PZ.Color.ConvertToPZRichTextRGB(PZ.Color.ConvertToPZRGB(TDTModChatBox.Settings.Global.Chatbox.FontColor));
		
		TDTModChatBox.UnfocusInputField();
		
		if not command or command == "" then
			return;
		end
		
		if #TDTModChatBox.MessageLog > 20 then
			table.remove(TDTModChatBox.MessageLog, 1);
		end
		
		table.insert(TDTModChatBox.MessageLog, command);
		
		TDTModChatBox.LogIndex = #TDTModChatBox.MessageLog + 1;
		
		local commandProcessed, isShout, isWhisper = false, false, false;
		
		for i, v in ipairs(TheDialgaTeam.TDTModChatBoxAPI.Events.OnCommandEntered.Trigger) do
			if type(v) == "function" then
				local result = v(command);
				
				if type(result) == "table" then
					-- Handle custom command output
					
					-- isCommand (boolean)
					-- commandOutput (string)
					-- commandPrefixOutput (string) [optional] = "";
					-- isCommandConsumed (boolean) [optional] = false;
					if type(result.isCommand) == "boolean" and result.isCommand and type(result.commandOutput) == "string" then
						local prefix;
						
						if type(result.commandPrefixOutput) == "string" then
							prefix = result.commandPrefixOutput;
						end
						
						TDTModChatBox.AddMessageInChatBox(prefix, result.commandOutput, false, false);
						
						if type(result.isCommandConsumed) == "boolean" and result.isCommandConsumed then
							commandProcessed = true;
						end
					end
					
					-- isShout (boolean)
					if type(result.isShout) == "boolean" and result.isShout then
						isShout = true;
					end
					
					-- isWhisper (boolean)
					if type(result.isWhisper) == "boolean" and result.isWhisper then
						isWhisper = true;
					end
				end
			end
		end
		
		for i, v in ipairs(TheDialgaTeam.TDTModChatBoxAPI.Commands.RegisteredCommand) do
			if type(v.Function) == "function" then
				local result = v.Function(CommandHandler:new(TDTModChatBox, command));
				
				if result then
					commandProcessed = true;
				end
			end
		end
		
		if not commandProcessed then
			if System.String.StartsWith(command, "/all") and getServerOptions():getBoolean("GlobalChat") then
				local message = System.String.Trim(string.gsub(command, "/all", ""));
				
				if message ~= "" then
					sendWorldMessage(colorText .. message);
				end
				
				commandProcessed = true;
			elseif System.String.StartsWith(command, "/help") then
				TDTModChatBox.AddMessageInChatBox(nil, getListOfCommands(command), false, false);
				
				commandProcessed = true;
			elseif System.String.StartsWith(command, "/s ") or System.String.StartsWith(command, "/shout ") then
				isShout = true;
				
				if System.String.StartsWith(command, "/s ") then
					command = string.sub(command, #"/s ");
				elseif System.String.StartsWith(command, "/shout ") then
					command = string.sub(command, #"/shout ");
				end
			elseif System.String.StartsWith(command, "/w ") or System.String.StartsWith(command, "/whisper ") then
				isWhisper = true;
				
				if System.String.StartsWith(command, "/w ") then
					command = string.sub(command, #"/w ");
				elseif System.String.StartsWith(command, "/whisper ") then
					command = string.sub(command, #"/whisper ");
				end
			elseif System.String.StartsWith(command, "/") then
				SendCommandToServer(command);
				
				commandProcessed = true;
			end
		end
		
		if not commandProcessed then
			local suffix = "";
			
			if TDTModChatBox.FontColor.r == 0 and TDTModChatBox.FontColor.g == 0 and TDTModChatBox.FontColor.b == 0 then
				if isShout then
					getPlayer():Say(command, true, 1, 1, 1, UIFont.Dialogue, TDTModChatBox.Settings.Global.Chatbox.ShoutDistance, "shout", false, false, false, false, false, true);
					suffix = " (shout)";
				elseif isWhisper then
					getPlayer():Say(command, true, 1, 1, 1, UIFont.Dialogue, TDTModChatBox.Settings.Global.Chatbox.WhisperDistance, "whisper", false, false, false, false, false, true);
					suffix = " (whisper)";
				else
					getPlayer():Say(command, true, 1, 1, 1, UIFont.Dialogue, TDTModChatBox.Settings.Global.Chatbox.TalkDistance, "default", false, false, false, false, false, true);
				end
			else
				if isShout then
					getPlayer():Say(command, true, TDTModChatBox.FontColor.r, TDTModChatBox.FontColor.g, TDTModChatBox.FontColor.b, UIFont.Dialogue, TDTModChatBox.Settings.Global.Chatbox.ShoutDistance, "shout", false, false, false, false, false, true);
					suffix = " (shout)";
				elseif isWhisper then
					getPlayer():Say(command, true, TDTModChatBox.FontColor.r, TDTModChatBox.FontColor.g, TDTModChatBox.FontColor.b, UIFont.Dialogue, TDTModChatBox.Settings.Global.Chatbox.WhisperDistance, "whisper", false, false, false, false, false, true);
					suffix = " (whisper)";
				else
					getPlayer():Say(command, true, TDTModChatBox.FontColor.r, TDTModChatBox.FontColor.g, TDTModChatBox.FontColor.b, UIFont.Dialogue, TDTModChatBox.Settings.Global.Chatbox.TalkDistance, "default", false, false, false, false, false, true);
				end
			end

			if getServerOptions():getBoolean("LogLocalChat") then
				command = command:gsub("<", "&lt;");
				command = command:gsub(">", "&gt;");
				
				local nameColorTable = {};
				local nameColor = "";
				local namePrefix = "";
				local nameSuffix = "";
				local name = "";
				
				if isAdmin() then
					nameColorTable = PZ.Color.ConvertToPZRGB(TDTModChatBox.Settings.Global.Chatbox.AdminNameColor);
					namePrefix = TDTModChatBox.Settings.Global.Chatbox.AdminNamePrefix;
					nameSuffix = TDTModChatBox.Settings.Global.Chatbox.AdminNameSuffix;
				else
					nameColorTable = PZ.Color.ConvertToPZRGB(TDTModChatBox.Settings.Global.Chatbox.NameColor);
					namePrefix = TDTModChatBox.Settings.Global.Chatbox.NamePrefix;
					nameSuffix = TDTModChatBox.Settings.Global.Chatbox.NameSuffix;
				end
				
				nameColor = PZ.Color.ConvertToPZRichTextRGB(nameColorTable);
				name = nameColor .. namePrefix .. " " .. getOnlineUsername() .. nameSuffix;
				
				TDTModChatBox.AddMessageInChatBox(name, colorText .. command, true, true);
			end
		end
		
		doKeyPress(false);
		TDTModChatBox.InputDelay = 20;
	end;

	self:addChild(self.InputField);
end

function TDTModChatBox:InitializeColorPickerButton()
	if not TDTModChatBox.Settings.Global.Chatbox.ColorPicker.Enabled then
		return;
	end
	
	if TDTModChatBox.Settings.Global.Chatbox.ColorPicker.AdminOnly and not isAdmin() then
		return;
	end
	
	-- TODO: Whitelisted only.
	
	local fontSize = getTextManager():getFontFromEnum(UIFont.Medium):getLineHeight();
	local colorPickerButtonTexture = getTexture("media/ui/TheDialgaTeam/TDTModChatBoxAPI/color_swatch.png");

	self.ColorPickerButton = ISButton:new(500 - (fontSize + 10) - 2, 16 + 200, fontSize + 10, fontSize + 10, "");
	self.ColorPickerButton:initialise();
	self.ColorPickerButton:setImage(colorPickerButtonTexture);
	self.ColorPickerButton:setAnchorLeft(false);
	self.ColorPickerButton:setAnchorTop(false);
	self.ColorPickerButton:setAnchorBottom(true);
	self.ColorPickerButton:setAnchorRight(true);
	self.ColorPickerButton:setVisible(false);
	
	self.ColorPickerButton.onclick = function ()
		self.ColorPicker:setX(getMouseX());
		self.ColorPicker:setY(getMouseY() - (12 * 20 + 12 * 2));
		self.ColorPicker:setVisible(true);
		self.ColorPicker:bringToTop();
	end;

	self:addChild(self.ColorPickerButton);
end

function TDTModChatBox:prerender()
	ISCollapsableWindow.prerender(TDTModChatBox.Chatbox);
	
	if TDTModChatBox.Settings.Global.Chatbox.BackgroundCanFade then
		TDTModChatBox.Chatbox.drawFrame = TDTModChatBox.Chatbox.mouseOver or false;
		TDTModChatBox.Chatbox.background = TDTModChatBox.Chatbox.mouseOver or false;
		TDTModChatBox.Chatbox.closeButton:setVisible(TDTModChatBox.Chatbox.mouseOver or false);
		
		if TDTModChatBox.Chatbox.mouseOver then
			TDTModChatBox.InvisibleTime = TDTModChatBox.Settings.Global.Chatbox.InvisibleTime * 60;
		end
		
		if not TDTModChatBox.Chatbox.InputField:getIsVisible() then
			if TDTModChatBox.InvisibleTime > 0 then
				TDTModChatBox.InvisibleTime = TDTModChatBox.InvisibleTime - 1;
			end
		end
		
		if TDTModChatBox.InvisibleTime == 0 then
			TDTModChatBox.Chatbox:setVisible(false);
		end
	end
	
	if TDTModChatBox.ServerMessage ~= "" then
		local serverMessageColor = PZ.Color.ConvertToPZRGBA(TDTModChatBox.Settings.Global.Chatbox.ServerMessageColor);

		TDTModChatBox.Chatbox:clearStencilRect();
		TDTModChatBox.Chatbox:drawTextCentre(TDTModChatBox.ServerMessage, getCore():getScreenWidth() / 2 - TDTModChatBox.Chatbox:getX(), getCore():getScreenHeight() / 4 - TDTModChatBox.Chatbox:getY(), serverMessageColor.r, serverMessageColor.g, serverMessageColor.b, serverMessageColor.a, UIFont.Cred1);
		TDTModChatBox.ServerMessageDelay = TDTModChatBox.ServerMessageDelay - 1;
		
		if TDTModChatBox.ServerMessageDelay < 1 then
			TDTModChatBox.ServerMessage = "";
		end
	end
end

-- Chatbox Static functions
function TDTModChatBox.FocusInputField(setText)
	if TDTModChatBox.Chatbox == nil then
		return;
	end
	
	TDTModChatBox.Chatbox.InputField:focus();
	TDTModChatBox.Chatbox.InputField:setVisible(true);
	TDTModChatBox.Chatbox.InputField:setText(setText);
	TDTModChatBox.Chatbox.InputField:ignoreFirstInput();
	
	if TDTModChatBox.Chatbox.ColorPickerButton ~= nil then
		TDTModChatBox.Chatbox.ColorPickerButton:setVisible(true);
	end
	
	TDTModChatBox.InvisibleTime = TDTModChatBox.Settings.Global.Chatbox.InvisibleTime * 60;
end

function TDTModChatBox.UnfocusInputField()
	if TDTModChatBox.Chatbox == nil then
		return;
	end
	
	TDTModChatBox.Chatbox.InputField:unfocus();
	TDTModChatBox.Chatbox.InputField:setVisible(false);
	TDTModChatBox.Chatbox.InputField:setText("");
	
	if TDTModChatBox.Chatbox.ColorPickerButton ~= nil then
		TDTModChatBox.Chatbox.ColorPickerButton:setVisible(false);
	end
end

function TDTModChatBox.AddMessageInChatBox(user, line, addLocal, addTimestamp)
	if System.String.StartsWith(line, "[SERVERMSG]") then
		TDTModChatBox.ServerMessage = TDTModChatBox.Settings.Global.Chatbox.ServerMessagePrefix .. " " .. line:sub(12) .. " " .. TDTModChatBox.Settings.Global.Chatbox.ServerMessageSuffix;
		TDTModChatBox.ServerMessageDelay = TDTModChatBox.Settings.Global.Chatbox.ServerMessageTime * 60;
		return;
	end
	
	local resetColorText = PZ.Color.ConvertToPZRichTextRGB(PZ.Color.ConvertToPZRGB(TDTModChatBox.Settings.Global.Chatbox.FontColor));

	if user then
		line = user .. ": " .. line;
	end
	
	if addTimestamp then
		line = resetColorText .. "[" .. getHourMinute() .. "] " .. line;
	end
	
	if addLocal then
		line = resetColorText .. getText("UI_chat_local") .. line
	end
	
	table.insert(TDTModChatBox.Messages, line);
	
	if #TDTModChatBox.Messages > TDTModChatBox.Settings.Global.Chatbox.ChatHistoryLines then
		table.remove(TDTModChatBox.Messages, 1);
	end
	
	local shouldScroll = TDTModChatBox.Chatbox.ChatMessage.vscroll and TDTModChatBox.Chatbox.ChatMessage.vscroll.pos == 1;
	
	TDTModChatBox.Chatbox.ChatMessage.text = System.String.Join(" <LINE> ", TDTModChatBox.Messages);
	TDTModChatBox.Chatbox.ChatMessage:paginate();
	
	if shouldScroll then
		TDTModChatBox.Chatbox.ChatMessage:setYScroll(-10000);
	end
	
	TDTModChatBox.InvisibleTime = TDTModChatBox.Settings.Global.Chatbox.InvisibleTime * 60;
end

-- Static functions
function TDTModChatBox.OnConnected()
	if isClient() then
		print "[TDTModChatBoxAPI] Initializing LuaNet.";
		TDTModChatBox.LuaNet.onInitAdd(TDTModChatBox.InitializeClient);
	end
end

function TDTModChatBox.InitializeClient()
	print "[TDTModChatBoxAPI] Initializing client command.";
	
	TDTModChatBox.LuaNetModule.addCommandHandler("LoadSettings", function (_, settings)
		if type(settings) ~= "table" then
			print("[TDTModChatBoxAPI] Invalid package data sent from the server.");
		else
			TDTModChatBox.Settings = settings;
			print("[TDTModChatBoxAPI] Settings initialized.");
			TDTModChatBox.InitializeChatbox();
		end
	end);
end

function TDTModChatBox.OnGameStart()
	if isClient() then
		Events.OnTick.Add(TDTModChatBox.OnTick);
	end
end

function TDTModChatBox.OnTick()
	if TDTModChatBox.RequestSettingsFromServer then
		print("[TDTModChatBoxAPI] Requesting data from server.");
		TDTModChatBox.LuaNetModule.send("GetSettings", getPlayer():getOnlineID());
		TDTModChatBox.RequestSettingsFromServer = false;
	end

	if TDTModChatBox.Chatbox == nil then
		return;
	end
	
	if TDTModChatBox.InputDelay > 0 then
		TDTModChatBox.InputDelay = TDTModChatBox.InputDelay - 1;
		
		if TDTModChatBox.InputDelay == 0 then
			doKeyPress(true);
		end
	end
end

function TDTModChatBox.InitializeChatbox()
	print "[TDTModChatBoxAPI] Initializing Chatbox.";
	
	if not TDTModChatBox.Settings.Global.Chatbox.Enabled then
		ISChat.createChat();
	else
		TDTModChatBox.Chatbox = TDTModChatBox:new();
		TDTModChatBox.Chatbox:initialise();
		TDTModChatBox.Chatbox:addToUIManager();
		TDTModChatBox.Chatbox:setVisible(true);
		TDTModChatBox.Chatbox.pinButton:setVisible(false);
		TDTModChatBox.Chatbox.collapseButton:setVisible(false);
		
		if getServerOptions():getOption("ServerWelcomeMessage") ~= "" then
			TDTModChatBox.AddMessageInChatBox(nil, getServerOptions():getOption("ServerWelcomeMessage"), false, false);
		end
		
		Events.OnWorldMessage.Add(TDTModChatBox.AddMessageInChatBox);
		Events.OnMouseDown.Add(TDTModChatBox.OnMouseDown);
		Events.OnKeyPressed.Add(TDTModChatBox.OnKeyPressed);
		Events.OnKeyKeepPressed.Add(TDTModChatBox.OnKeyKeepPressed);
	end
end

function TDTModChatBox.OnMouseDown()
	if TDTModChatBox.Chatbox == nil then
		return;
	end
	
	TDTModChatBox.UnfocusInputField();
end

function TDTModChatBox.OnKeyPressed(key)
	if TDTModChatBox.Chatbox == nil then
		return;
	end

	if key == getCore():getKey("Local Chat") then
		TDTModChatBox.Chatbox:setVisible(true);
		TDTModChatBox.Chatbox.ChatMessage:setVisible(true);
		TDTModChatBox.FocusInputField("");
	end

	if key == getCore():getKey("Global Chat") and getServerOptions():getBoolean("GlobalChat") then
		TDTModChatBox.Chatbox:setVisible(true);
		TDTModChatBox.Chatbox.ChatMessage:setVisible(true);
		TDTModChatBox.FocusInputField("/all ");
	end
end

function TDTModChatBox.OnKeyKeepPressed(key)
	if TDTModChatBox.Chatbox == nil then
		return;
	end
	
	-- If tab button is hold, it should stay visible.
	if key == 15 then
		TDTModChatBox.Chatbox:setVisible(true);
		TDTModChatBox.Chatbox.ChatMessage:setVisible(true);
		TDTModChatBox.InvisibleTime = TDTModChatBox.Settings.Global.Chatbox.InvisibleTime * 60;
	end
end

Events.OnConnected.Add(TDTModChatBox.OnConnected);
Events.OnGameStart.Add(TDTModChatBox.OnGameStart);