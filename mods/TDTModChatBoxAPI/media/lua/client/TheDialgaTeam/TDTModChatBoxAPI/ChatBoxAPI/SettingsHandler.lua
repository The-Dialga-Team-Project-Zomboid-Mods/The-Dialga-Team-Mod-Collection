local SettingsHandler = {};

function SettingsHandler:new(parent)
    local o = {};
    setmetatable(o, self);
    self.__index = self;

    o.Parent = parent;

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

return SettingsHandler;