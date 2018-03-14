local PZ = TheDialgaTeam.TDTModAPI.PZ;
local ChatBox = {};

function ChatBox:new(parent)
    local o = ISCollapsableWindow:new(0, 0, 0, 0);
    setmetatable(o, self);
    self.__index = self;

    o.Super = parent;

    o.title = parent.SettingsHandler:getChatBoxTitle();

    o.width = 500;
    o.height = o.titleBarHeight() + 200 + getTextManager():getFontFromEnum(UIFont.Medium):getLineHeight() + 10 + 2 + o.resizeWidgetHeight();

    o.minimumWidth = o.width;
    o.minimumHeight = o.height;

    o.x = 0;
    o.y = getCore():getScreenHeight() - o.height;

    o.borderColor = parent.SettingsHandler:getChatBoxBorderColor();
    o.backgroundColor = parent.SettingsHandler:getChatBoxBackgroundColor();

    o.pin = true;

    o.FontColor = parent.SettingsHandler:getChatBoxFontColor();
    o.CurrentTab = "Default";

    return o;
end

function ChatBox:initialise()
    ISCollapsableWindow.initialise(self);
end

function ChatBox:createChildren()
    ISCollapsableWindow.createChildren(self);
    ChatBox.InitializeChatMessage(self);
    -- ChatBox.InitializeInputField(self);
    -- ChatBox.InitializeColorPickerButton(self);
end

function ChatBox:InitializeChatMessage()
    self.ChatMessage = ISRichTextPanel:new(0, self.titleBarHeight, 500, 200);
    self.ChatMessage:initialise();
    self.ChatMessage.background = false;
    self.ChatMessage.clip = true;
    self.ChatMessage:setAnchorBottom(true);
    self.ChatMessage:setAnchorRight(true);
    self.ChatMessage.marginTop = 4;
    self.ChatMessage.marginBottom = 4;
    self.ChatMessage.maxLines = 500;
    self.ChatMessage.autosetheight = false;
    self.ChatMessage.text = "TEST";
    self.ChatMessage:paginate()
    self.ChatMessage:addScrollBars();
    self.ChatMessage.vscroll.background = false;
    self.ChatMessage:ignoreHeightChange();
    self.ChatMessage:setVisible(true);

    self:addChild(self.ChatMessage);
end

return ChatBox;