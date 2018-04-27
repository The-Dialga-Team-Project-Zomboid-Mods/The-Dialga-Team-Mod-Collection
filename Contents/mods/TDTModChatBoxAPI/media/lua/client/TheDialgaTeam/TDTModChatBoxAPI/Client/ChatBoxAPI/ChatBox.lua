--- @type TheDialgaTeam.TDTModAPI.PZ
local PZ = TheDialgaTeam.TDTModAPI.PZ;

--- @type TheDialgaTeam.TDTModAPI.System.String
local String = TheDialgaTeam.TDTModAPI.System.String;

--- @type TheDialgaTeam.TDTModChatBoxAPI.LuaNetHandler.PackageTypes
local PackageTypes = TheDialgaTeam.TDTModChatBoxAPI.LuaNetHandler.PackageTypes;

--- @class TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.ChatBox
--- @field public Super TheDialgaTeam.TDTModChatBoxAPI.Client.Main
local ChatBox = ISCollapsableWindow:derive("TDTModChatBox");

function ChatBox:new(parent)
    local o = ISCollapsableWindow:new(0, 0, 0, 0);
    setmetatable(o, self);
    self.__index = self;

    --- @type TheDialgaTeam.TDTModChatBoxAPI.Client.Main
    o.Super = parent;

    o.GlobalSettings = o.Super.SettingsHandler.GlobalSettings.ChatBox;
    o.UserSettings = o.Super.SettingsHandler.UserSettings;

    o.title = o.GlobalSettings.Title;
    o.borderColor = PZ.Color.ConvertToPZRGBA(o.GlobalSettings.BorderColor);
    o.backgroundColor = PZ.Color.ConvertToPZRGBA(o.GlobalSettings.BackgroundColor);

    o.Dimensions = o.Super.SettingsHandler:GetChatBoxDimensions();

    o.x = o.Dimensions.x;
    o.y = getCore():getScreenHeight() - o.Dimensions.height;

    o.width = o.Dimensions.width;
    o.height = o.Dimensions.height;

    o.minimumWidth = o.width;
    o.minimumHeight = o.height;

    o.pin = true;

    --- ################################################################################################################
    --- ChatBox vars
    --- ################################################################################################################
    o.InvisibleTime = 0;
    o.InputDelay = 20;

    --- @type { Name:string, Tab:table, Messages:string[] }
    o.Tabs = {};
    o.CurrentTab = 1;

    o.ChatMessage = false;
    o.ChatMessageHistory = {};

    --- @type { Message:string, Duration:number }
    o.ServerMessage = {};

    o.InputField = false;
    o.InputFieldHistory = {};
    o.InputFieldHistoryIndex = 0;

    o.ColorPickerButton = false;
    o.ColorPicker = false;

    o.ChatTypes = {
        Normal = "default",
        Whisper = "whisper",
        Shout = "shout",
        Custom = "custom",
    };

    return o;
end

function ChatBox:initialise()
    ISCollapsableWindow.initialise(self);
    ChatBox.InitializeColorPicker(self);

    self:addToUIManager();
    self:setVisible(true);
    self.pinButton:setVisible(false);
    self.collapseButton:setVisible(false);

    if getServerOptions():getOption("ServerWelcomeMessage") ~= "" then
        self:AddMessageToChatBox({
            ShowDateTime = false, ShowName = false, ChatType = self.ChatTypes.Custom, Message = getServerOptions():getOption("ServerWelcomeMessage"),
        }, false);
    end

    Events.OnKeyPressed.Add(function (key)
        self:OnKeyPressed(key);
    end);

    Events.OnKeyKeepPressed.Add(function (key)
        self:OnKeyKeepPressed(key);
    end);

    Events.OnTick.Add(function ()
        self:OnTick();
    end);

    Events.OnWorldMessage.Add(function(user, line, addLocal, addTimestamp)
        self:OnWorldMessage(user, line, addLocal, addTimestamp);
    end);
end

function ChatBox:InitializeColorPicker()
    if self.Super.SettingsHandler:CanUseColorPicker() then
        self.ColorPicker = ISColorPicker:new(0, 0);
        self.ColorPicker:initialise();
        self.ColorPicker.pickedTarget = self;
        self.ColorPicker.resetFocusTo = self.InputField;
        self.ColorPicker.parent = self;
        self.ColorPicker.otherFct = true;
        self.ColorPicker:addToUIManager();
        self.ColorPicker:setVisible(false);

        self.ColorPicker.pickedFunc = function(_, color)
            self.UserSettings.FontColor = PZ.Color.ConvertToRGB(color);
            self.Super.SettingsHandler:SetUserFontColor(color);
            self.InputField.javaObject:setTextColor(ColorInfo.new(color.r, color.g, color.b, 1));
            self.InputField:focus();
            self.ColorPicker:setVisible(false);
        end;

        self.ColorPicker.onMouseDownOutside = function ()
            self.InputField:focus();
            self.ColorPicker:setVisible(false);
        end
    end
end

function ChatBox:createChildren()
    ISCollapsableWindow.createChildren(self);
    ChatBox.InitializeTabsBar(self);
    ChatBox.InitializeChatMessage(self);
    ChatBox.InitializeInputField(self);
    ChatBox.InitializeColorPickerButton(self);
end

function ChatBox:InitializeTabsBar()
    for i, v in ipairs(self.Dimensions.items) do
        if v.type == "TabButton" then

            if v.enabled then
                local tab = ISButton:new(v.x, v.y, v.width, v.height, v.name);
                tab:setFont(UIFont.Medium);
                tab:initialise();

                if i == 1 then
                    tab.backgroundColor = tab.backgroundColorMouseOver;
                end

                tab.onclick = function ()
                    self.Tabs[self.CurrentTab].Tab.backgroundColor = { r = 0, g = 0, b = 0, a = 1.0 };
                    self.CurrentTab = i;
                    self.Tabs[self.CurrentTab].Tab.backgroundColor = self.Tabs[self.CurrentTab].Tab.backgroundColorMouseOver;
                    self.ChatMessage.text = "";
                    self.ChatMessage:paginate();
                    self.InputField:unfocus();
                    self:RefreshTabMessage();
                end;

                table.insert(self.Tabs, { Name = v.name, Tab = tab, Messages = {} });

                self:addChild(tab);
            else
                table.insert(self.Tabs, { Name = v.name, Tab = false, Messages = {} });
            end
        end
    end
end

function ChatBox:InitializeChatMessage()
    for i, v in ipairs(self.Dimensions.items) do
        if v.type == "MessageBox" then
            self.ChatMessage = ISRichTextPanel:new(v.x, v.y, v.width, v.height);
            self.ChatMessage:initialise();
            self.ChatMessage.background = false;
            self.ChatMessage.clip = true;
            self.ChatMessage.autosetheight = false;
            self.ChatMessage.text = "";
            self.ChatMessage.maxLines = self.GlobalSettings.MessageBox.ChatHistoryLines;
            self.ChatMessage:setAnchorBottom(true);
            self.ChatMessage:setAnchorRight(true);
            self.ChatMessage:setMargins(20, 5, 10, 5);
            self.ChatMessage:paginate()
            self.ChatMessage:addScrollBars();
            self.ChatMessage.vscroll.background = false;
            self.ChatMessage:ignoreHeightChange();
            self.ChatMessage:setVisible(true);

            self:addChild(self.ChatMessage);
        end
    end
end

function ChatBox:InitializeInputField()
    for i, v in ipairs(self.Dimensions.items) do
        if v.type == "InputField" then
            self.InputField = ISTextEntryBox:new("", v.x, v.y, v.width, v.height);
            self.InputField.font = UIFont.Medium;
            self.InputField.backgroundColor = { r = 0, g = 0, b = 0, a = 0.0 };
            self.InputField.borderColor = { r = 1, g = 1, b = 1, a = 0.0 };
            self.InputField:initialise();
            self.InputField:instantiate();
            self.InputField:setHasFrame(true)
            self.InputField:setAnchorTop(false);
            self.InputField:setAnchorBottom(true);
            self.InputField:setAnchorRight(true);
            self.InputField:setVisible(true);

            local defaultFontColor = self.UserSettings.FontColor or self.GlobalSettings.MessageBox.Color;
            defaultFontColor.a = 255;

            self.InputField.javaObject:setTextColor(PZ.Color.ConvertToPZColorInfo(defaultFontColor));

            self.InputField.onOtherKey = function(key)
                if key == Keyboard.KEY_ESCAPE then
                    self.InputField:unfocus();
                end
            end;

            self.InputField.onPressUp = function()
                if #self.InputFieldHistory > 0 then
                    self.InputFieldHistoryIndex = self.InputFieldHistoryIndex - 1;

                    if self.InputFieldHistoryIndex < 1 then
                        self.InputFieldHistoryIndex = 1;
                    elseif self.InputFieldHistoryIndex > #self.InputFieldHistory then
                        self.InputFieldHistoryIndex = #self.InputFieldHistory;
                    end

                    self.InputField:setText(self.InputFieldHistory[self.InputFieldHistoryIndex]);
                end
            end;

            self.InputField.onPressDown = function()
                if #self.InputFieldHistory > 0 then
                    self.InputFieldHistoryIndex = self.InputFieldHistoryIndex + 1;

                    if self.InputFieldHistoryIndex < 1 then
                        self.InputFieldHistoryIndex = 1;
                    elseif self.InputFieldHistoryIndex > #self.InputFieldHistory then
                        self.InputFieldHistoryIndex = #self.InputFieldHistory;
                    end

                    self.InputField:setText(self.InputFieldHistory[self.InputFieldHistoryIndex]);
                end
            end;

            self.InputField.onCommandEntered = function()
                local command = String.new(self.InputField:getText());

                self.InputField:unfocus();
                self.InputField:setText("");

                if command:Trim() == "" then
                    return;
                end

                if #self.InputFieldHistory > 20 then
                    table.remove(self.InputFieldHistory, 1);
                end

                table.insert(self.InputFieldHistory, command:ToString());
                self.InputFieldHistoryIndex = #self.InputFieldHistory + 1;

                -- TODO: ADD Custom Command Handler here

                local commandProcessed = false;
                local isWhisper = false;
                local isShout = false;

                if not commandProcessed then
                    if command:StartsWith("/all") and getServerOptions():getBoolean("GlobalChat") then
                        local message = String.new(string.gsub(command:ToString(), "/all", "")):Trim();

                        message = message:gsub("<", "&lt;");
                        message = message:gsub(">", "&gt;");

                        self:AddMessageToChatBox({
                            ShowDateTime = true, ShowName = true, ChatType = self.ChatTypes.Custom, Message = message,
                            FontColor = self.UserSettings.FontColor or self.GlobalSettings.MessageBox.Color, CurrentTab = 1
                        }, true);

                        commandProcessed = true;
                    elseif command:StartsWith("/help") then
                        self:AddMessageToChatBox({
                            ShowDateTime = false, ShowName = false, ChatType = self.ChatTypes.Custom, Message = getListOfCommands(command:ToString()),
                            CurrentTab = 1
                        }, false);

                        commandProcessed = true;
                    elseif command:StartsWith("/w ") or command:StartsWith("/whisper ") then
                        isWhisper = true;

                        if command:StartsWith("/w ") then
                            command = String.new(string.sub(command:ToString(), #"/w "));
                        elseif command:StartsWith("/whisper ") then
                            command = String.new(string.sub(command:ToString(), #"/whisper "));
                        end
                    elseif command:StartsWith("/s ") or command:StartsWith("/shout ") then
                        isShout = true;

                        if command:StartsWith("/s ") then
                            command = String.new(string.sub(command:ToString(), #"s "));
                        elseif command:StartsWith("/shout ") then
                            command = String.new(string.sub(command:ToString(), #"/shout "));
                        end
                    elseif command:StartsWith("/servermsg ") or command:StartsWith("[SERVERMSG]") then
                        if self.GlobalSettings.ServerMessage.Enabled then
                            if self.GlobalSettings.ServerMessage.Permission.Send == TheDialgaTeam.TDTModChatBoxAPI.ServerMessage.PermissionFlags.Everyone then
                                SendCommandToServer(command:ToString());
                            elseif self.GlobalSettings.ServerMessage.Permission.Send == TheDialgaTeam.TDTModChatBoxAPI.ServerMessage.PermissionFlags.Admin and isAdmin() then
                                SendCommandToServer(command:ToString());
                            end
                        end

                        commandProcessed = true;
                    elseif command:StartsWith("!reloadChatBoxSettings") then
                        self.Super.SettingsHandler:ReloadServerSettings();

                        commandProcessed = true;
                    elseif command:StartsWith("/") then
                        SendCommandToServer(command:ToString());
                        commandProcessed = true;
                    end
                end

                if not commandProcessed then
                    if getServerOptions():getBoolean("LogLocalChat") then
                        local chatType = 0;
                        local message = command:ToString();

                        message = message:gsub("<", "&lt;");
                        message = message:gsub(">", "&gt;");

                        if isWhisper then
                            chatType = self.ChatTypes.Whisper;
                        elseif isShout then
                            chatType = self.ChatTypes.Shout;
                        else
                            chatType = self.ChatTypes.Normal;
                        end

                        self:AddMessageToChatBox({
                            ShowDateTime = true, ShowName = true, ChatType = chatType, Message = message,
                            CustomTag = "[Local]"
                        }, true);
                    end
                end

                doKeyPress(false);
                self.InputDelay = 20;
            end

            self:addChild(self.InputField);
        end
    end
end

function ChatBox:InitializeColorPickerButton()
    for i, v in ipairs(self.Dimensions.items) do
        if v.type == "ColorPicker" then
            local colorPickerButtonTexture = getTexture("media/ui/TheDialgaTeam/TDTModChatBoxAPI/color_swatch.png");

            self.ColorPickerButton = ISButton:new(v.x, v.y, v.width, v.height, "");
            self.ColorPickerButton:initialise();
            self.ColorPickerButton:setImage(colorPickerButtonTexture);
            self.ColorPickerButton:setAnchorLeft(false);
            self.ColorPickerButton:setAnchorTop(false);
            self.ColorPickerButton:setAnchorBottom(true);
            self.ColorPickerButton:setAnchorRight(true);
            self.ColorPickerButton:setVisible(true);

            self.ColorPickerButton.onclick = function()
                self.ColorPicker:setX(self:getX() + v.x);
                self.ColorPicker:setY(self:getY() + v.y - (12 * 20 + 12 * 2));
                self.ColorPicker:setVisible(true);
                self.ColorPicker:bringToTop();
            end;

            self:addChild(self.ColorPickerButton);
        end
    end
end

function ChatBox:prerender()
    ISCollapsableWindow.prerender(self);

    if self.GlobalSettings.BackgroundCanFade then
        self.drawFrame = self.mouseOver or false;
        self.background = self.mouseOver or false;
        self.closeButton:setVisible(self.mouseOver or false);

        if self.mouseOver then
            self.InvisibleTime = self.GlobalSettings.InvisibleTime * 60;
        end
    end

    if not self.InputField.javaObject:isFocused() then
        if self.InvisibleTime > 0 then
            self.InvisibleTime = self.InvisibleTime - 1;
        end

        if self.InvisibleTime == 0 then
            self:setVisible(false);
        end
    else
        self.InvisibleTime = self.GlobalSettings.InvisibleTime * 60;
    end

    if #self.ServerMessage > 0 then
        local serverMessageColor = PZ.Color.ConvertToPZRGBA(self.GlobalSettings.ServerMessage.Color);

        self:clearStencilRect();
        self:drawTextCentre(self.GlobalSettings.ServerMessage.Prefix .. self.ServerMessage[1].Message .. self.GlobalSettings.ServerMessage.Suffix, getCore():getScreenWidth() / 2 - self:getX(), getCore():getScreenHeight() / 4 - self:getY(), serverMessageColor.r, serverMessageColor.g, serverMessageColor.b, serverMessageColor.a, UIFont.Cred1);
        self.ServerMessage[1].Duration = self.ServerMessage[1].Duration - 1;

        if self.ServerMessage[1].Duration < 1 then
            table.remove(self.ServerMessage, 1);
        end
    end
end

--- ####################################################################################################################
--- ChatBox Custom Events
--- ####################################################################################################################
function ChatBox:onMouseDown(x, y)
    ISCollapsableWindow.onMouseDown(self, x, y);
    self.InputField:unfocus();
end

function ChatBox:OnKeyPressed(key)
    if not self.InputField.javaObject:isFocused() then
        if key == getCore():getKey("Local Chat") then
            self.InvisibleTime = self.GlobalSettings.InvisibleTime * 60;
            self:setVisible(true);
            self.InputField:focus();
            self.InputField:setText("");
            self.InputField:ignoreFirstInput();
        end

        if key == getCore():getKey("Global Chat") and getServerOptions():getBoolean("GlobalChat") then
            self.InvisibleTime = self.GlobalSettings.InvisibleTime * 60;
            self:setVisible(true);
            self.InputField:focus();
            self.InputField:setText("/all ");
            self.InputField:ignoreFirstInput();
        end
    end
end

function ChatBox:OnKeyKeepPressed(key)
    --- If tab button is held, it should stay visible.
    if key == 15 then
        self.InvisibleTime = self.GlobalSettings.InvisibleTime * 60;
        self:setVisible(true);
    end
end

function ChatBox:OnTick()
    if self.InputDelay > 0 then
        self.InputDelay = self.InputDelay - 1;

        if self.InputDelay == 0 then
            doKeyPress(true);
        end
    end
end

function ChatBox:OnWorldMessage(user, line, addLocal, addTimestamp)
    if user == "[Device]" then
        self:AddMessageToChatBox({
            ShowDateTime = true, ShowName = false, ChatType = self.ChatTypes.Custom, Message = line,
            CustomTag = "[Local] [Device]", CurrentTab = 1
        }, false);
    elseif user == null then
        local message = String.new(line);

        if message:StartsWith("[SERVERMSG]") then
            table.insert(self.ServerMessage, { Message = string.sub(line, 12), Duration = self.GlobalSettings.ServerMessage.DisplayTime * 60 });
        else
            self:AddMessageToChatBox({
                ShowDateTime = false, ShowName = false, ChatType = self.ChatTypes.Custom, Message = line,
                CurrentTab = 1
            }, false);
        end
    else
        local lineToDelete = 0;

        for i, v in ipairs(self.ChatMessageHistory) do
            if v.Message == line then
                self:AddMessageToChatBox(v, false);
                lineToDelete = i;
                break;
            end
        end

        if lineToDelete > 0 then
            table.remove(self.ChatMessageHistory, lineToDelete);
        end
    end
end

--- ####################################################################################################################
--- ChatBox Custom Methods
--- ####################################################################################################################
function ChatBox:AddMessageToChatBox(messageTable, sendToServer)
    --- MessageTable:
    --- Required: { ShowDateTime:boolean, ShowName:boolean, ChatType:ChatTypes, Message:string }
    --- Optional: { CustomTag:string, NameColor:RGBColor, Name:string, FontColor:RGBColor, SayMessage:boolean, SayDistance:number, CurrentTab:number }
    --- Generated: { PlayerId:number }

    if messageTable.PlayerId == nil then
        messageTable.PlayerId = getPlayer():getOnlineID();

        if messageTable.CustomTag == nil then
            messageTable.CustomTag = "";
        end

        if messageTable.ShowName then
            if isAdmin() then
                if messageTable.NameColor == nil then
                    messageTable.NameColor = self.UserSettings.NameColor or self.GlobalSettings.MessageBox.AdminNameColor;
                end

                if messageTable.Name == nil then
                    messageTable.Name = self.GlobalSettings.MessageBox.AdminNamePrefix .. getOnlineUsername() .. self.GlobalSettings.MessageBox.AdminNameSuffix;
                end
            else
                if messageTable.NameColor == nil then
                    messageTable.NameColor = self.UserSettings.NameColor or self.GlobalSettings.MessageBox.NameColor;
                end

                if messageTable.Name == nil then
                    messageTable.Name = self.GlobalSettings.MessageBox.NamePrefix .. getOnlineUsername() .. self.GlobalSettings.MessageBox.NameSuffix;
                end
            end
        end

        if messageTable.FontColor == nil then
            if messageTable.ChatType == self.ChatTypes.Custom then
                messageTable.FontColor = self.GlobalSettings.MessageBox.Color
            else
                messageTable.FontColor = self.UserSettings.FontColor or self.GlobalSettings.MessageBox.Color;
            end
        end

        if messageTable.SayMessage == nil then
            if messageTable.ChatType == self.ChatTypes.Normal then
                messageTable.SayMessage = true;
                messageTable.SayDistance = self.GlobalSettings.MessageBox.TalkDistance;
            elseif messageTable.ChatType == self.ChatTypes.Whisper then
                messageTable.SayMessage = true;
                messageTable.SayDistance = self.GlobalSettings.MessageBox.WhisperDistance;
            elseif messageTable.ChatType == self.ChatTypes.Shout then
                messageTable.SayMessage = true;
                messageTable.SayDistance = self.GlobalSettings.MessageBox.ShoutDistance;
            else
                messageTable.SayMessage = false;
            end
        end

        if messageTable.SayDistance == nil then
            messageTable.SayDistance = self.GlobalSettings.MessageBox.TalkDistance;
        end

        if messageTable.CurrentTab == nil then
            messageTable.CurrentTab = self.CurrentTab;
        end

        if sendToServer or false then
            self.Super.LuaNetHandler:SendToServer(PackageTypes.ChatMessage, { playerId = messageTable.PlayerId, data = messageTable });
        end

        if messageTable.SayMessage then
            self:SayMessage(messageTable);
        end
    end

    --- Construct Message.
    local message = "";

    local defaultMessageColor = PZ.Color.ConvertToPZRGB(self.GlobalSettings.MessageBox.Color);
    message = message .. PZ.Color.ConvertToPZRichTextRGB(defaultMessageColor);

    if messageTable.ShowDateTime then
        message = message .. "[" .. getHourMinute() .. "] ";
    end

    if messageTable.CustomTag ~= "" then
        message = message .. messageTable.CustomTag .. " ";
    end

    if messageTable.ShowName then
        local nameColor = PZ.Color.ConvertToPZRGB(messageTable.NameColor);
        message = message .. PZ.Color.ConvertToPZRichTextRGB(nameColor);

        message = message .. " " .. messageTable.Name;
    end

    if messageTable.ChatType == self.ChatTypes.Whisper then
        message = message .. " (Whisper): ";
    elseif messageTable.ChatType == self.ChatTypes.Shout then
        message = message .. " (Shout): ";
    elseif messageTable.ChatType == self.ChatTypes.Normal then
        message = message .. ": ";
    else
        if messageTable.ShowName then
            message = message .. " ";
        end
    end

    local fontColor = PZ.Color.ConvertToPZRGB(messageTable.FontColor);
    message = message .. PZ.Color.ConvertToPZRichTextRGB(fontColor);

    message = message .. " " .. messageTable.Message .. " <LINE> ";

    --- Add message into respective tabs.
    if messageTable.CurrentTab ~= 1 then
        table.insert(self.Tabs[messageTable.CurrentTab].Messages, message);
    end

    table.insert(self.Tabs[1].Messages, message);

    --- Ensure message does not overflow.
    for i, v in ipairs(self.Tabs) do
        if #v.Messages > self.GlobalSettings.MessageBox.ChatHistoryLines then
            table.remove(v.Messages, 1);
        end
    end

    --- Step 4: Display message.
    self:RefreshTabMessage();

    self.InvisibleTime = self.GlobalSettings.InvisibleTime * 60;
    self:setVisible(true);
end

function ChatBox:SayMessage(messageTable)
    --- MessageTable:
    --- Required: { ShowDateTime:boolean, ShowName:boolean, ChatType:ChatTypes, Message:string }
    --- Optional: { CustomTag:string, NameColor:RGBColor, Name:string, FontColor:RGBColor, SayMessage:boolean, SayDistance:number }
    --- Generated: { PlayerId:number, CurrentTab:number }

    local fontColor = PZ.Color.ConvertToPZRGB(messageTable.FontColor);
    local player = getPlayerByOnlineID(messageTable.PlayerId);

    player:Say(messageTable.Message, false, fontColor.r, fontColor.g, fontColor.b, UIFont.Dialogue, messageTable.SayDistance, messageTable.ChatType, false, false, false, false, false, true);
end

function ChatBox:RefreshTabMessage()
    local messageToDisplay = "";
    local scrolledToBottom = (self.ChatMessage:getScrollHeight() <= self.ChatMessage:getHeight()) or (self.ChatMessage.vscroll and self.ChatMessage.vscroll.pos == 1);

    for i, v in ipairs(self.Tabs[self.CurrentTab].Messages) do
        messageToDisplay = messageToDisplay .. v;
    end

    messageToDisplay = string.gsub(messageToDisplay, " <LINE> $", "");

    self.ChatMessage.text = messageToDisplay;
    self.ChatMessage:paginate();

    if scrolledToBottom then
        self.ChatMessage:setYScroll((self.ChatMessage:getScrollHeight() - self.ChatMessage:getScrollAreaHeight()) * -1);
    end
end

function ChatBox:HandleServerMessage(messageTable)
    --- MessageTable:
    --- Required: { ShowDateTime:boolean, ShowName:boolean, ChatType:ChatTypes, Message:string }
    --- Optional: { CustomTag:string, NameColor:RGBColor, Name:string, FontColor:RGBColor, SayMessage:boolean, SayDistance:number }
    --- Generated: { PlayerId:number, CurrentTab:number }

    if messageTable.SayMessage then
        table.insert(self.ChatMessageHistory, messageTable);
        self:SayMessage(messageTable);
    else
        self:AddMessageToChatBox(messageTable, false);
    end
end

return ChatBox;