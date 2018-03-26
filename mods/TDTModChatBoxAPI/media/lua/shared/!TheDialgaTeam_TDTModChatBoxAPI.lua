--- @type TheDialgaTeam
TheDialgaTeam = TheDialgaTeam or {};

--- ####################################################################################################################
--- Inject TDTModChatBoxAPI
--- ####################################################################################################################

--- @class TheDialgaTeam.TDTModChatBoxAPI
--- @field public ServerMessage TheDialgaTeam.TDTModChatBoxAPI.ServerMessage
--- @field public ColorPicker TheDialgaTeam.TDTModChatBoxAPI.ColorPicker
TheDialgaTeam.TDTModChatBoxAPI = {};

--- @class TheDialgaTeam.TDTModChatBoxAPI.ServerMessage
--- @field public PermissionFlags TheDialgaTeam.TDTModChatBoxAPI.ServerMessage.PermissionFlags
TheDialgaTeam.TDTModChatBoxAPI.ServerMessage = {};

--- @class TheDialgaTeam.TDTModChatBoxAPI.ServerMessage.PermissionFlags
--- @field public None string
--- @field public Admin string
--- @field public Everyone string
TheDialgaTeam.TDTModChatBoxAPI.ServerMessage.PermissionFlags = {
    None = "None",
    Admin = "Admin",
    Everyone = "Everyone"
};

--- @class TheDialgaTeam.TDTModChatBoxAPI.ColorPicker
--- @field public PermissionFlags TheDialgaTeam.TDTModChatBoxAPI.ColorPicker.PermissionFlags
TheDialgaTeam.TDTModChatBoxAPI.ColorPicker = {};

--- @class TheDialgaTeam.TDTModChatBoxAPI.ColorPicker.PermissionFlags
--- @field public None number
--- @field public WhitelistOnly number
--- @field public Users number
--- @field public Admins number
--- @field public Everyone number
TheDialgaTeam.TDTModChatBoxAPI.ColorPicker.PermissionFlags = {
    None = 0,
    WhitelistOnly = 1,
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