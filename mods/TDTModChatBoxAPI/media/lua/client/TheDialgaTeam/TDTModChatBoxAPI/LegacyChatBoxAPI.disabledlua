function ISChat:onCommandEntered()
    local command = ISChat.instance.textEntry:getText();

	ISChat.instance.textEntry:clear();
    ISChat.instance.textEntry:unfocus();
    ISChat.instance.textEntry:setText("");
    ISChat.instance.textEntry:setVisible(false);
	
	ISChat.instance.logIndex = 0;
	
    if not command or command == "" then
        return;
    end
    
    if command and command ~= "" then
        local newLog = {};
        table.insert(newLog, command);
		
        for i,v in ipairs(ISChat.instance.log) do
            table.insert(newLog, v);
			
            if i > 20 then
                break;
            end
        end
		
        ISChat.instance.log = newLog;
    end

    local commandProcessed, isShout, isWhisper = false, false, false;

	for i, v in ipairs(TheDialgaTeam.TDTModChatBoxAPI.Events.OnCommandEntered.Trigger) do
		if type(v) == "function" then
			local result = v(command);
			
			if type(result) == "table" then
				-- Handle custom command output
				
				-- isCommand (boolean)
				-- commandOutput (string)
				-- commandPrefixOutput (string) [optional] = "";
				-- isCommandConsumed (boolean) [optional] = false;
				if type(result.isCommand) == "boolean" and result.isCommand and type(result.commandOutput) == "string" then
					local prefix = nil;
					
					if type(result.commandPrefixOutput) == "string" then
						prefix = result.commandPrefixOutput;
					end
					
					ISChat.addLineInChat(prefix, result.commandOutput, false, false);
					
					if type(result.isCommandConsumed) == "boolean" and result.isCommandConsumed then
						commandProcessed = true;
					end
				end
				
				-- isShout (boolean)
				if type(result.isShout) == "boolean" and result.isShout then
					isShout = true;
				end
				
				-- isWhisper (boolean)
				if type(result.isWhisper) == "boolean" and result.isWhisper then
					isWhisper = true;
				end
			end
		end
	end
	
	if not commandProcessed then
		if luautils.stringStarts(command, "/all") and getServerOptions():getBoolean("GlobalChat") then
			local message = luautils.trim(string.gsub(command, "/all", ""));
			
			if message ~= "" then
				sendWorldMessage(message);
			end
			
			commandProcessed = true;
		elseif luautils.stringStarts(command, "/help") then
			ISChat.addLineInChat(nil, getListOfCommands(command), false, false);
			
			commandProcessed = true;
		elseif luautils.stringStarts(command, "/s ") or luautils.stringStarts(command, "/shout ") then
			isShout = true;
			
			if luautils.stringStarts(command, "/s ") then
				command = string.sub(command, #"/s ");
			elseif luautils.stringStarts(command, "/shout ") then
				command = string.sub(command, #"/shout ");
			end
		elseif luautils.stringStarts(command, "/w ") or luautils.stringStarts(command, "/whisper ") then
			isWhisper = true;
			
			if luautils.stringStarts(command, "/w ") then
				command = string.sub(command, #"/w ");
			elseif luautils.stringStarts(command, "/whisper ") then
				command = string.sub(command, #"/whisper ");
			end
		elseif luautils.stringStarts(command, "/") then
			SendCommandToServer(command);
			
			commandProcessed = true;
		end
	end
	
    if not commandProcessed then
        local suffix = "";
		
        if isShout then
            getPlayer():SayShout(command);
            suffix = " (shout)";
        elseif isWhisper then
            getPlayer():SayWhisper(command);
            suffix = " (whisper)";
        else
            getPlayer():Say(command);
        end

        if getServerOptions():getBoolean("LogLocalChat") then
            command = string.gsub(command, "<", "&lt;")
            command = string.gsub(command, ">", "&gt;")
			
            ISChat.addLineInChat(getOnlineUsername() .. suffix, command, true, true);
        end
    end
	
    doKeyPress(false);
    ISChat.instance.timerTextEntry = 20;
end