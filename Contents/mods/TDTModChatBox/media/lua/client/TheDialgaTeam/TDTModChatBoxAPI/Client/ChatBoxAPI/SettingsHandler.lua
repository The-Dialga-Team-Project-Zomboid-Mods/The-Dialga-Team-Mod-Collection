--- @type TheDialgaTeam.TDTModAPI.PZ
local PZ = TheDialgaTeam.TDTModAPI.PZ;

--- @type TheDialgaTeam.TDTModAPI.System.Bitwise
local Bitwise = TheDialgaTeam.TDTModAPI.System.Bitwise;

--- @type TheDialgaTeam.TDTModChatBoxAPI.ColorPicker
local ColorPicker = TheDialgaTeam.TDTModChatBoxAPI.ColorPicker;

--- @type TheDialgaTeam.TDTModChatBoxAPI.LuaNetHandler.PackageTypes
local PackageTypes = TheDialgaTeam.TDTModChatBoxAPI.LuaNetHandler.PackageTypes;

--- @class TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.SettingsHandler
local SettingsHandler = {};

function SettingsHandler.new(parent)
    --- @class TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.SettingsHandler.Instance : TheDialgaTeam.TDTModAPI.System.Object.Instance
    local self = TheDialgaTeam.TDTModAPI.System.Object.new();

    self.__Type = "TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.SettingsHandler";

    --- @type TheDialgaTeam.TDTModChatBoxAPI.Client.Main
    self.Super = parent;

    self.RequestSettingsFromServer = true;

    self.GlobalSettings = false;
    self.UserSettings = false;

    function self:GetGlobalSettings()
        if not self.GlobalSettings then
            self.Super.LuaNetHandler:SendToServer(PackageTypes.GlobalSettings, { playerId = getPlayer():getOnlineID() });
            return nil;
        else
            return self.GlobalSettings;
        end
    end

    function self:SetGlobalSettings(settings)
        self.GlobalSettings = settings;
    end

    function self:GetUserSettings()
        if not self.UserSettings then
            self.Super.LuaNetHandler:SendToServer(PackageTypes.UserSettings, { playerId = getPlayer():getOnlineID(), steamId = getSteamIDFromUsername(getPlayer():getUsername()) });
            return nil;
        else
            return self.UserSettings;
        end
    end

    function self:SetUserSettings(settings)
        self.UserSettings = settings;
    end

    function self:SetUserFontColor(color)
        self.Super.LuaNetHandler:SendToServer(PackageTypes.UserFontColor, { playerId = getPlayer():getOnlineID(), steamId = getSteamIDFromUsername(getPlayer():getUsername()), isGlobal = false, value = PZ.Color.ConvertToRGB(color) });
    end

    function self:ReloadServerSettings()
        self.Super.LuaNetHandler:SendToServer(PackageTypes.ReloadServerSettings, { playerId = getPlayer():getOnlineID() });
    end

    function self:CanUseColorPicker()
        local currentPermission = ColorPicker.PermissionFlags.Users;

        if isAdmin() then
            currentPermission = Bitwise.Or(currentPermission, ColorPicker.PermissionFlags.Admins);
        end

        if self.UserSettings.ColorPickerPermission then
            currentPermission = Bitwise.Or(currentPermission, ColorPicker.PermissionFlags.WhitelistOnly);
        end

        if Bitwise.And(self.GlobalSettings.ChatBox.ColorPicker.Permission.Use, currentPermission) ~= 0 then
            return true;
        else
            return false;
        end
    end

    function self:GetChatBoxDimensions()
        local currentX = 0;
        local currentY = 16;
        local maxWidth = 0;
        local maxHeight = 16;
        local tabs = {};

        currentX = currentX + 2;
        currentY = currentY + 2;
        maxWidth = maxWidth + 2;
        maxHeight = maxHeight + 2;

        local tab = {};

        tab.type = "TabButton";
        tab.name = "All";
        tab.enabled = self.GlobalSettings.ChatBox.Tabs.Enabled;
        tab.width = getTextManager():MeasureStringX(UIFont.Medium, "All") + 10;
        tab.height = getTextManager():getFontFromEnum(UIFont.Medium):getLineHeight() + 4;
        tab.x = currentX;
        tab.y = currentY;

        if self.GlobalSettings.ChatBox.Tabs.Enabled then
            currentX = currentX + tab.width + 2;
            maxWidth = maxWidth + tab.width + 2;

            table.insert(tabs, tab);

            for i, v in ipairs(self.GlobalSettings.ChatBox.Tabs.Categories) do
                tab = {};

                if v.Enabled then
                    tab.type = "TabButton";
                    tab.name = v.Name;
                    tab.enabled = true;
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
        else
            currentY = currentY - 2;
            maxHeight = maxHeight - 2;
        end

        currentX = 0;

        if maxWidth < 500 then
            maxWidth = 500;
        end

        local messageBox = { type = "MessageBox", x = currentX, y = currentY, width = maxWidth, height = 200 };

        currentX = currentX + 2;
        currentY = currentY + 200 + 2;
        maxHeight = maxHeight + 200 + 2;

        local inputField = { type = "InputField", x = currentX, y = currentY, width = maxWidth - 4, height = getTextManager():getFontFromEnum(UIFont.Medium):getLineHeight() + 10 }
        local colorPicker = {};

        if self.GlobalSettings.ChatBox.ColorPicker.Enabled and self:CanUseColorPicker() then
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