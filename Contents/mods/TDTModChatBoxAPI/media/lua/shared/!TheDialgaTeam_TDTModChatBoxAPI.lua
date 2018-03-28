--- @type TheDialgaTeam
TheDialgaTeam = TheDialgaTeam or {};

--- ####################################################################################################################
--- Inject TDTModChatBoxAPI
--- ####################################################################################################################

--- @class TheDialgaTeam.TDTModChatBoxAPI
--- @field public ServerMessage TheDialgaTeam.TDTModChatBoxAPI.ServerMessage
--- @field public ColorPicker TheDialgaTeam.TDTModChatBoxAPI.ColorPicker
--- @field public LuaNetHandler TheDialgaTeam.TDTModChatBoxAPI.LuaNetHandler
TheDialgaTeam.TDTModChatBoxAPI = {};

--- ####################################################################################################################
--- Inject TDTModChatBoxAPI.ServerMessage
--- ####################################################################################################################

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

--- ####################################################################################################################
--- Inject TDTModChatBoxAPI.ColorPicker
--- ####################################################################################################################

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

--- ####################################################################################################################
--- Inject TDTModChatBoxAPI.LuaNetHandler
--- ####################################################################################################################

--- @class TheDialgaTeam.TDTModChatBoxAPI.LuaNetHandler
--- @field public PackageTypes TheDialgaTeam.TDTModChatBoxAPI.LuaNetHandler.PackageTypes
TheDialgaTeam.TDTModChatBoxAPI.LuaNetHandler = {};

--- @class TheDialgaTeam.TDTModChatBoxAPI.LuaNetHandler.PackageTypes
--- @field public GlobalSettings string
--- @field public UserSettings string
--- @field public UserFontColor string
--- @field public ChatMessage string
--- @field public ReloadServerSettings string
TheDialgaTeam.TDTModChatBoxAPI.LuaNetHandler.PackageTypes = {
    --- Package Type: Global Settings
    --- From Client: { playerId:number }
    --- From Server: { Global Settings table }
    GlobalSettings = "GlobalSettings",

    --- Package Type: User Settings
    --- From Client: { playerId:number, steamId:string }
    --- From Server: { Merged User Settings table }
    UserSettings = "UserSettings",

    --- Package Type: User Font Color
    --- From Client: { playerId:number, steamId:string, isGlobal:boolean, value:any }
    UserFontColor = "UserFontColor",

    --- Package Type: Chat Message
    --- From Client: { playerId:number, data:table }
    --- From Server: { data }
    ChatMessage = "ChatMessage",

    --- Package Type: Reload Server Settings
    --- From Client: { playerId:number }
    ReloadServerSettings = "ReloadServerSetting",
};

--- ####################################################################################################################
--- Inject TDTModChatBoxAPI.Commands
--- ####################################################################################################################

--- @class TheDialgaTeam.TDTModChatBoxAPI.Commands
TheDialgaTeam.TDTModChatBoxAPI.Commands = {};
TheDialgaTeam.TDTModChatBoxAPI.Commands.RegisteredCommand = {};

function TheDialgaTeam.TDTModChatBoxAPI.Commands.RegisterCommand(modId, commandName, func)
    table.insert(TheDialgaTeam.TDTModChatBoxAPI.Commands.RegisteredCommand, { ModId = modId, Command = commandName, Function = func });
end

print "[TDTModChatBoxAPI] Global table injected!";