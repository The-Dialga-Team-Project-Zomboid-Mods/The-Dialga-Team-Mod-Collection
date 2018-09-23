--- @class TheDialgaTeam.TDTCoreAPI.Json.Options @Enum containing json serialization options.
--- @field Default table @Default serialization option.
--- @field Pretty table @Pretty serialization option.
local TDTCoreAPI_Json_Options = {};

TDTCoreAPI_Json_Options.Default = {};
TDTCoreAPI_Json_Options.Pretty = { pretty = true, indent = "  ", array_newline = true };

return TDTCoreAPI_Json_Options;