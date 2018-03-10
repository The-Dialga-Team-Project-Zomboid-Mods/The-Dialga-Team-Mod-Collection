TheDialgaTeam = TheDialgaTeam or {};

-- ######################################################################################
-- Inject TDTModChatBoxAPI
-- ######################################################################################

if type(TheDialgaTeam.TDTModChatBoxAPI) ~= "table" then
    TheDialgaTeam.TDTModChatBoxAPI = {};
end

TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags = {
    -- No users are allowed.
    None = 0,

    -- Users that are not whitelisted and not admins.
    Users = 1,

    -- Users that are whitelisted.
    WhiteListedUsers = 2,

    -- Users that are admins.
    Admins = 4,

    -- Everyone.
    Everyone = 7,
};

TheDialgaTeam.TDTModChatBoxAPI.Commands = {};
TheDialgaTeam.TDTModChatBoxAPI.Commands.RegisteredCommand = {};

TheDialgaTeam.TDTModChatBoxAPI.Events = {};
TheDialgaTeam.TDTModChatBoxAPI.Events.OnCommandEntered = {};
TheDialgaTeam.TDTModChatBoxAPI.Events.OnCommandEntered.Trigger = {};

function TheDialgaTeam.TDTModChatBoxAPI.Events.OnCommandEntered.Add(func)
    TheDialgaTeam.TDTModAPI.Event.Add(TheDialgaTeam.TDTModChatBoxAPI.Events.OnCommandEntered.Trigger, func);
end

function TheDialgaTeam.TDTModChatBoxAPI.Events.OnCommandEntered.Remove(func)
    TheDialgaTeam.TDTModAPI.Event.Remove(TheDialgaTeam.TDTModChatBoxAPI.Events.OnCommandEntered.Trigger, func);
end

function TheDialgaTeam.TDTModChatBoxAPI.Commands.RegisterCommand(commandName, func)
    table.insert(TheDialgaTeam.TDTModChatBoxAPI.Commands.RegisteredCommand, { Command = commandName, Function = func });
end

print "[TDTModChatBoxAPI] Global table injected!";