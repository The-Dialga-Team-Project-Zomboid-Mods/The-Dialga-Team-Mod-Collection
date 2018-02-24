TheDialgaTeam = TheDialgaTeam or {};

-- ######################################################################################
-- Inject TDTModAPI
-- ######################################################################################

if type(TheDialgaTeam.TDTModAPI) ~= "table" then
	TheDialgaTeam.TDTModAPI = {};
end

TheDialgaTeam.TDTModAPI.Event = require "TheDialgaTeam/TDTModAPI/Event";
TheDialgaTeam.TDTModAPI.Json = require "TheDialgaTeam/TDTModAPI/Json";
TheDialgaTeam.TDTModAPI.PZ = require "TheDialgaTeam/TDTModAPI/PZ";
TheDialgaTeam.TDTModAPI.System = require "TheDialgaTeam/TDTModAPI/System";

print "[TDTModAPI] Global table injected!";