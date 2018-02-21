TheDialgaTeam = TheDialgaTeam or {};

-- ######################################################################################
-- Inject TDTModChatBoxAPI
-- ######################################################################################

if type(TheDialgaTeam.TDTModChatBoxAPI) ~= "table" then
	TheDialgaTeam.TDTModChatBoxAPI = {};
end

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