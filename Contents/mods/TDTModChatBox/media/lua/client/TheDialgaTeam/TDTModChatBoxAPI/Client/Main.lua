--- @type TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.LuaNetHandler
local LuaNetHandler = require "TheDialgaTeam/TDTModChatBoxAPI/Client/ChatBoxAPI/LuaNetHandler";

--- @type TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.SettingsHandler
local SettingsHandler = require "TheDialgaTeam/TDTModChatBoxAPI/Client/ChatBoxAPI/SettingsHandler";

--- @type TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.ChatBox
local ChatBox = require "TheDialgaTeam/TDTModChatBoxAPI/Client/ChatBoxAPI/ChatBox";

--- @class TheDialgaTeam.TDTModChatBoxAPI.Client.Main
--- @field public LuaNetHandler TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.LuaNetHandler
--- @field public SettingsHandler TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.SettingsHandler
--- @field public ChatBox TheDialgaTeam.TDTModChatBoxAPI.Client.ChatBoxAPI.ChatBox
--- @field public ChatBoxLoaded boolean
local Main = {};
Main.ChatBoxLoaded = false;

function Main.OnConnected()
    if isClient() then
        Main.LuaNetHandler = LuaNetHandler.new(Main);
        Main.LuaNetHandler:Initialize();
    end
end

function Main.OnGameStart()
    if isClient() then
        Main.SettingsHandler = SettingsHandler.new(Main);
        Events.OnTick.Add(Main.OnTick);
    end
end

function Main.OnTick()
    if Main.SettingsHandler.RequestSettingsFromServer then
        Main.SettingsHandler:GetUserSettings();
        Main.SettingsHandler:GetGlobalSettings();
        Main.SettingsHandler.RequestSettingsFromServer = false;
    end

    Events.OnTick.Remove(Main.OnTick);
end

function Main.InitializeChatBox()
    if Main.SettingsHandler.GlobalSettings.ChatBox.Enabled then
        Main.ChatBox = ChatBox:new(Main);
        Main.ChatBox:initialise();

        function ISScoreboard:onContext(button)
            local username = self.selectedPlayer;
            username = '"'..username..'"'
            if button.internal == "KICK" then
                SendCommandToServer("/kickuser " .. username);
            elseif button.internal == "BAN" then
                SendCommandToServer("/banuser " .. username);
            elseif button.internal == "BANIP" then
                SendCommandToServer("/banuser " .. username .. " -ip");
            elseif button.internal == "GODMOD" then
                SendCommandToServer("/godmod " .. username);
            elseif button.internal == "INVISIBLE" then
                SendCommandToServer("/invisible " .. username);
            elseif button.internal == "TELEPORT" then
                SendCommandToServer("/teleport " .. username);
            elseif button.internal == "TELEPORTTOYOU" then
                SendCommandToServer("/teleport " .. username .. " \"" .. getPlayer():getDisplayName() .. "\"");
            elseif button.internal == "MUTE" then
                --- ISChat.instance:mute(self.selectedPlayer)
                self:doAdminButtons()
            elseif button.internal == "VOIPMUTE" then
                VoiceManager:playerSetMute(self.selectedPlayer)
                self:doAdminButtons()
            end
        end

        function ISScoreboard:doAdminButtons()
            self.kickButton.enable = false;
            self.banButton.enable = false;
            if self.banIpButton then self.banIpButton.enable = false; end
            self.teleportButton.enable = false;
            self.teleportToYouButton.enable = false;
            self.invisibleButton.enable = false;
            self.godmodButton.enable = false;
            self.voipmuteButton.enable = false;
            self.muteButton.enable = false;
            if not ISScoreboard.isAdmin then
                self.kickButton:setVisible(false);
                self.banButton:setVisible(false);
                if self.banIpButton then self.banIpButton:setVisible(false); end
                self.godmodButton:setVisible(false);
                self.invisibleButton:setVisible(false);
                self.teleportButton:setVisible(false);
                self.teleportToYouButton:setVisible(false);
            end
            if self.selectedPlayer and ISScoreboard.isAdmin then
                local dy = self.listbox:getYScroll()
                local username = self.selectedPlayer
                if username ~= getSpecificPlayer(0):getDisplayName() then
                    self.kickButton.enable = not (isAccessLevel("gm") or isAccessLevel("observer"));
                    self.banButton.enable = (isAccessLevel("admin") or isAccessLevel("moderator"));
                    self.teleportButton.enable = true;
                    self.teleportToYouButton.enable = true;
                    self.invisibleButton.enable = not isAccessLevel("observer");
                    self.godmodButton.enable = not isAccessLevel("observer");
                    self.voipmuteButton.enable = true;
                    self.muteButton.enable = true;

                    if self.banIpButton then
                        self.banIpButton.enable = (isAccessLevel("admin") or isAccessLevel("moderator"));
                    end

                    local muted = false; --- ISChat.instance:isMuted(username)
                    self.muteButton:setTitle(muted and getText("UI_Scoreboard_Unmute") or getText("UI_Scoreboard_Mute"))

                    local voipmuted = VoiceManager:playerGetMute(username)
                    self.voipmuteButton:setTitle(voipmuted and getText("UI_Scoreboard_VOIPUnmute") or getText("UI_Scoreboard_VOIPMute"))
                else
                    self.invisibleButton.enable = not isAccessLevel("observer");
                    self.godmodButton.enable = not isAccessLevel("observer");
                end
            elseif self.selectedPlayer then
                local dy = self.listbox:getYScroll()
                local username = self.selectedPlayer
                if username ~= getSpecificPlayer(0):getDisplayName() then
                    self.voipmuteButton.enable = true;
                    self.muteButton.enable = true;

                    local muted = false; --- ISChat.instance:isMuted(username)
                    self.muteButton:setTitle(muted and getText("UI_Scoreboard_Unmute") or getText("UI_Scoreboard_Mute"))
                    self.muteButton:setX(self.listbox.x + self.listbox.width + 10);
                    self.muteButton:setY(self.listbox.y);

                    local voipmuted = VoiceManager:playerGetMute(username)
                    self.voipmuteButton:setTitle(voipmuted and getText("UI_Scoreboard_VOIPUnmute") or getText("UI_Scoreboard_VOIPMute"))
                    self.voipmuteButton:setX(self.muteButton.x + 105);
                    self.voipmuteButton:setY(self.listbox.y);

                end
            end
        end
    else
        ISChat.createChat();
    end
end

Events.OnConnected.Add(Main.OnConnected);
Events.OnGameStart.Add(Main.OnGameStart);
Events.OnGameStart.Remove(ISChat.createChat);