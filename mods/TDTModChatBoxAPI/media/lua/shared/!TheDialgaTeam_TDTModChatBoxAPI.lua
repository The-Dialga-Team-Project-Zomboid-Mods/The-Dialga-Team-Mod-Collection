TheDialgaTeam = TheDialgaTeam or {};

-- ######################################################################################
-- Inject TDTModChatBoxAPI
-- ######################################################################################

if type(TheDialgaTeam.TDTModChatBoxAPI) ~= "table" then
    TheDialgaTeam.TDTModChatBoxAPI = {};
end

--- @type TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags
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

function TheDialgaTeam.TDTModChatBoxAPI.Commands.RegisterCommand(modId, commandName, func)
    table.insert(TheDialgaTeam.TDTModChatBoxAPI.Commands.RegisteredCommand, { ModId = modId, Command = commandName, Function = func });
end

print "[TDTModChatBoxAPI] Global table injected!";