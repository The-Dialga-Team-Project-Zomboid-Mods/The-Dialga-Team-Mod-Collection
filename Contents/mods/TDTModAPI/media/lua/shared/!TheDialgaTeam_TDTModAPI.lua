--- @class TheDialgaTeam
--- @field public TDTModAPI TheDialgaTeam.TDTModAPI
--- @field public TDTModChatBoxAPI TheDialgaTeam.TDTModChatBoxAPI
TheDialgaTeam = TheDialgaTeam or {};

--- ####################################################################################################################
--- Inject TDTModAPI
--- ####################################################################################################################

--- @class TheDialgaTeam.TDTModAPI
--- @field public ModId string
--- @field public Event TheDialgaTeam.TDTModAPI.Event
--- @field public Json TheDialgaTeam.TDTModAPI.Json
--- @field public Lua TheDialgaTeam.TDTModAPI.Lua
--- @field public PZ TheDialgaTeam.TDTModAPI.PZ
--- @field public System TheDialgaTeam.TDTModAPI.System
TheDialgaTeam.TDTModAPI = {};
TheDialgaTeam.TDTModAPI.ModId = "TDTModAPI";

--- @type TheDialgaTeam.TDTModAPI.Event
TheDialgaTeam.TDTModAPI.Event = require "TheDialgaTeam/TDTModAPI/Event";

--- @type TheDialgaTeam.TDTModAPI.Json
TheDialgaTeam.TDTModAPI.Json = require "TheDialgaTeam/TDTModAPI/Json";

--- @type TheDialgaTeam.TDTModAPI.Lua
TheDialgaTeam.TDTModAPI.Lua = require "TheDialgaTeam/TDTModAPI/Lua";

--- @type TheDialgaTeam.TDTModAPI.PZ
TheDialgaTeam.TDTModAPI.PZ = require "TheDialgaTeam/TDTModAPI/PZ";

--- @type TheDialgaTeam.TDTModAPI.System
TheDialgaTeam.TDTModAPI.System = require "TheDialgaTeam/TDTModAPI/System";

print "[TDTModAPI] Global table injected!";