--- @type TheDialgaTeam.TDTModAPI.PZ
local PZ = TheDialgaTeam.TDTModAPI.PZ;

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

    return o;
end

function ChatBox:initialise()
    ISCollapsableWindow.initialise(self);
    ChatBox.InitializeColorPicker(self);

    self:addToUIManager();
    self:setVisible(false);
    self.pinButton:setVisible(false);
    self.collapseButton:setVisible(false);

    Events.OnKeyPressed.Add(function (key)
        self:OnKeyPressed(key);
    end);

    Events.OnKeyKeepPressed.Add(function (key)
        self:OnKeyPressed(key);
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
            self.Super.SettingsHandler:UpdateUserFontColor(color);
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
    self.Tabs = {};

    for i, v in ipairs(self.Dimensions.items) do
        if v.type == "TabButton" then
            local tab = ISButton:new(v.x, v.y, v.width, v.height, v.name);
            tab:setFont(UIFont.Medium);
            tab:initialise();

            if i == 1 then
                tab.backgroundColor = tab.backgroundColorMouseOver;
            end

            tab.onclick = function ()
                self.InputField:unfocus();
            end;

            table.insert(self.Tabs, { Name = v.name, Tab = tab });
            self:addChild(tab);
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
            self.ChatMessage.maxLines = 500;
            self.ChatMessage.autosetheight = false;
            self.ChatMessage.text = "";
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

            local defaultFontColor = self.UserSettings.FontColor;
            defaultFontColor.a = 255;

            self.InputField.javaObject:setTextColor(PZ.Color.ConvertToPZColorInfo(defaultFontColor));

            self.InputField.onOtherKey = function(key)
                if key == Keyboard.KEY_ESCAPE then
                    self.InputField:unfocus();
                end
            end;

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
            self:setVisible(true);
            self.ChatMessage:setVisible(true);
            self.InputField:focus();
            self.InputField:setText("");
            self.InputField:ignoreFirstInput();
        end

        if key == getCore():getKey("Global Chat") and getServerOptions():getBoolean("GlobalChat") then
            self:setVisible(true);
            self.ChatMessage:setVisible(true);
            self.InputField:focus();
            self.InputField:setText("/all ");
            self.InputField:ignoreFirstInput();
        end
    end
end

function ChatBox:OnKeyKeepPressed(key)
    --- If tab button is hold, it should stay visible.
    if key == 15 then
        self:setVisible(true);
        self.ChatMessage:setVisible(true);
    end
end

return ChatBox;