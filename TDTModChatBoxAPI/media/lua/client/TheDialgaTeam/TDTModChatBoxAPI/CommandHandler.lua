local System = TheDialgaTeam.TDTModAPI.System;
local CommandHandler = {};

function CommandHandler:new(chatbox, fullCommand)
	local o = {};
	setmetatable(o, self)
	self.__index = self
	
	o.chatbox = chatbox;
	
	local command = System.String.Trim(fullCommand);
	local commandArgsIndex = System.String.IndexOf(command, ' ');
	
	if commandArgsIndex == 0 then
		o.command = command;
		o.commandArgs = "";
	else
		o.command = System.String.Remove(command, commandArgsIndex);
		o.commandArgs = command:sub(commandArgsIndex + 1);
	end
	
	return o;
end

function CommandHandler:GetCommandParamenters(paramenterTypes)
	local result = {};
	local commandArgs = self.commandArgs;
	local paramenterLength = #paramenterTypes;
	
	if paramenterLength == 0 then
		return nil;
	end
	
	for i = 1, paramenterLength do
		local paramenterType = paramenterTypes[i];
		
		-- Ensures that there is no trailing space :)
		commandArgs = System.String.Trim(commandArgs);
		if type(paramenterType) == "string" then
			if paramenterType == "boolean" then
				-- true | false | 0 | 1
				if System.String.StartsWith(commandArgs, "true") then
					table.insert(result, true);
					commandArgs = System.String.Remove(commandArgs, 1, 4);
				elseif System.String.StartsWith(commandArgs, "false") then
					table.insert(result, false);
					commandArgs = System.String.Remove(commandArgs, 1, 5);
				elseif System.String.StartsWith(commandArgs, "1") then
					table.insert(result, true);
					commandArgs = System.String.Remove(commandArgs, 1, 1);
				elseif System.String.StartsWith(commandArgs, "0") then
					table.insert(result, false);
					commandArgs = System.String.Remove(commandArgs, 1, 1);
				else
					table.insert(result, nil);
				end
			elseif paramenterType == "number" then
				-- 4 | 0.4 | 4.57e-3 | 0.3e12 | 5e+20
				local startIndex, endIndex = commandArgs:find("%-?%d*%.?%d+[Ee]?%+?%-?%d*");
				
				if startIndex ~= nil and startIndex == 1 and endIndex ~= nil then
					if endIndex == #commandArgs then
						table.insert(result, tonumber(commandArgs));
						commandArgs = "";
					elseif commandArgs:sub(endIndex + 1, endIndex + 1) == " " then
						table.insert(result, tonumber(commandArgs:sub(1, endIndex)));
						commandArgs = System.String.Remove(commandArgs, 1, endIndex);
					else
						table.insert(result, nil);
					end
				else
					table.insert(result, nil);
				end
			elseif paramenterType == "string" then
				-- "ABC"
				if System.String.StartsWith(commandArgs, "\"") then
					local word = commandArgs:match("\"(.-)\"");
					table.insert(result, word);
					commandArgs = System.String.Remove(commandArgs, 1, #word + 2);
				elseif System.String.StartsWith(commandArgs, "'") then
					local word = commandArgs:match("'(.-)'");
					table.insert(result, word);
					commandArgs = System.String.Remove(commandArgs, 1, #word + 2);
				else
					table.insert(result, nil);
				end
			end
		elseif type(paramenterType) == "function" then
			commandArgs = paramenterType(commandArgs);
		else
			return nil;
		end
	end
	
	return result;
end

function CommandHandler:DisplayOutputToChatBox(text, say)
	if say then
		getPlayer():Say(text, true, 1, 1, 1, UIFont.Dialogue, self.Settings.Global.Chatbox.TalkDistance, "default", false, false, false, false, false, true);
	end
	
	self.AddMessageInChatBox("", text, false, false);
end