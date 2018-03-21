--- @type TheDialgaTeam.TDTModAPI.PZ
local PZ = TheDialgaTeam.TDTModAPI.PZ;

--- @class TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.SettingsHandler
local SettingsHandler = {};

function SettingsHandler.new(parent)
    --- @class TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.SettingsHandler.Instance : TheDialgaTeam.TDTModAPI.System.Object.Instance
    local self = TheDialgaTeam.TDTModAPI.System.Object.new();

    self.__Type = "TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.SettingsHandler";

    --- @type TheDialgaTeam.TDTModChatBoxAPI.Client.Main
    self.Super = parent;

    self.RequestSettingsFromServer = true;
    self.GlobalSettings = {};
    self.UserSettings = {};

    function self:ApplyGlobalSettings(settings)
        print "[TDTModChatBoxAPI:SettingsHandler] Apply global settings.";
        self.GlobalSettings = settings;
    end

    function self:ApplyUserSettings(settings)
        print "[TDTModChatBoxAPI:SettingsHandler] Apply user settings.";
        self.UserSettings = settings;
    end

    function self:GetChatBoxDimensions()
        local currentX = 0;
        local currentY = 16;
        local maxWidth = 0;
        local maxHeight = 16;
        local tabs = {};

        if self.GlobalSettings.ChatBox.Tabs.Enabled then
            currentX = currentX + 2;
            currentY = currentY + 2;
            maxWidth = maxWidth + 2;
            maxHeight = maxHeight + 2;

            for i, v in ipairs(self.GlobalSettings.ChatBox.Tabs.Categories) do
                local tab = {};

                if v.Name == "Default" or v.Enabled then
                    tab.type = "TabButton";
                    tab.name = v.Name;
                    tab.width = getTextManager():MeasureStringX(UIFont.Medium, v.Name) + 10;
                    tab.height = getTextManager():getFontFromEnum(UIFont.Medium):getLineHeight() + 4;
                    tab.x = currentX;
                    tab.y = currentY;

                    currentX = currentX + tab.width + 2;
                    maxWidth = maxWidth + tab.width + 2;
                end

                table.insert(tabs, tab);
            end

            currentY = currentY + getTextManager():getFontFromEnum(UIFont.Medium):getLineHeight() + 4;
            maxHeight = maxHeight + getTextManager():getFontFromEnum(UIFont.Medium):getLineHeight() + 4;
            currentX = 0;
        end

        if maxWidth < 500 then
            maxWidth = 500;
        end

        local messageBox = { type = "MessageBox", x = currentX, y = currentY, width = maxWidth, height = 200 };

        currentX = currentX + 2;
        currentY = currentY + 200 + 2;
        maxHeight = maxHeight + 200 + 2;

        local inputField = { type = "InputField", x = currentX, y = currentY, width = maxWidth - 4, height = getTextManager():getFontFromEnum(UIFont.Medium):getLineHeight() + 10 }
        local colorPicker = {};

        if self.GlobalSettings.ChatBox.ColorPicker.Enabled then
            inputField.width = inputField.width - inputField.height - 4;
            currentX = currentX + inputField.width + 2;

            colorPicker = { type = "ColorPicker", x = currentX, y = currentY, width = inputField.height, height = inputField.height };
        end

        currentY = currentY + getTextManager():getFontFromEnum(UIFont.Medium):getLineHeight() + 10 + 2 + 8;
        maxHeight = maxHeight + getTextManager():getFontFromEnum(UIFont.Medium):getLineHeight() + 10 + 2 + 8;

        local result = { x = 0, y = 0, width = maxWidth, height = maxHeight, items = {} };

        if #tabs > 0 then
            for i, v in ipairs(tabs) do
                table.insert(result.items, v);
            end
        end

        table.insert(result.items, messageBox);
        table.insert(result.items, inputField);

        if colorPicker.type ~= nil then
            table.insert(result.items, colorPicker);
        end

        return result;
    end

    return self;
end

return SettingsHandler;