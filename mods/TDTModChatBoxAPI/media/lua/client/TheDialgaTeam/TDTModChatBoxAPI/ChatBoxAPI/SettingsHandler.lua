local PZ = TheDialgaTeam.TDTModAPI.PZ;
local SettingsHandler = {};

function SettingsHandler:new(parent)
    local o = {};
    setmetatable(o, self);
    self.__index = self;

    o.Super = parent;

    o.RequestSettingsFromServer = true;
    o.GlobalSettings = {};
    o.UserSettings = {};

    return o;
end

function SettingsHandler:ApplyGlobalSettings(settings)
    print "[TDTModChatBoxAPI:SettingsHandler] Apply Global Settings.";
    self.GlobalSettings = settings;
end

function SettingsHandler:ApplyUserSettings(settings)
    print "[TDTModChatBoxAPI:SettingsHandler] Apply User Settings.";
    self.UserSettings = settings;
end

function SettingsHandler:getChatBoxEnabled()
    return self.GlobalSettings.Chatbox.Enabled;
end

function SettingsHandler:getChatBoxTitle()
    return self.GlobalSettings.Chatbox.Title;
end

function SettingsHandler:getChatBoxFontColor()
    return PZ.Color.ConvertToPZRGB(self.GlobalSettings.Chatbox.FontColor);
end

function SettingsHandler:getChatBoxBackgroundColor()
    return PZ.Color.ConvertToPZRGBA(self.GlobalSettings.Chatbox.BackgroundColor);
end

function SettingsHandler:getChatBoxBorderColor()
    return PZ.Color.ConvertToPZRGBA(self.GlobalSettings.Chatbox.BorderColor);
end

function SettingsHandler:getChatBoxBackgroundCanFade()
    return self.GlobalSettings.Chatbox.BackgroundCanFade;
end

function SettingsHandler:getChatBoxInvisibleTime()
    if self.GlobalSettings.Chatbox.InvisibleTime >= 0 then
        return self.GlobalSettings.Chatbox.InvisibleTime * 60;
    else
        return -1;
    end
end

function SettingsHandler:getChatBoxServerMessageEnabled()
    return self.GlobalSettings.Chatbox.ServerMessage.Enabled;
end

function SettingsHandler:getChatBoxServerMessageDisplayTime()
    if self.GlobalSettings.Chatbox.ServerMessage.DisplayTime > 0 then
        return self.GlobalSettings.Chatbox.ServerMessage.DisplayTime * 60;
    else
        return 0;
    end
end

return SettingsHandler;