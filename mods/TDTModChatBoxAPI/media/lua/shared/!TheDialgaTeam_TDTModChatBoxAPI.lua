--- @type TheDialgaTeam
TheDialgaTeam = TheDialgaTeam or {};

-- ######################################################################################
-- Inject TDTModChatBoxAPI
-- ######################################################################################

if type(TheDialgaTeam.TDTModChatBoxAPI) ~= "table" then
    --- @class TheDialgaTeam.TDTModChatBoxAPI
    --- @field public PermissionFlags TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags
    TheDialgaTeam.TDTModChatBoxAPI = {};
end

--- @class TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags
--- @field public None TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags | permissionFlags
--- @field public Self TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags | permissionFlags
--- @field public Users TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags | permissionFlags
--- @field public Admins TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags | permissionFlags
--- @field public Everyone TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags | permissionFlags
TheDialgaTeam.TDTModChatBoxAPI.PermissionFlags = {
    None = 0,
    Self = 1,
    Users = 2,
    Admins = 4,
    Everyone = 1 + 2 + 4,
};

--- @class TheDialgaTeam.TDTModChatBoxAPI.Commands
TheDialgaTeam.TDTModChatBoxAPI.Commands = {};
TheDialgaTeam.TDTModChatBoxAPI.Commands.RegisteredCommand = {};

function TheDialgaTeam.TDTModChatBoxAPI.Commands.RegisterCommand(modId, commandName, func)
    table.insert(TheDialgaTeam.TDTModChatBoxAPI.Commands.RegisteredCommand, { ModId = modId, Command = commandName, Function = func });
end

print "[TDTModChatBoxAPI] Global table injected!";