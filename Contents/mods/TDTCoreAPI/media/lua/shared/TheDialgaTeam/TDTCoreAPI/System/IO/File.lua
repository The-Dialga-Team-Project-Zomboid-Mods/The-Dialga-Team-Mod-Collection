--- @class TheDialgaTeam.TDTCoreAPI.System.IO.File
local TDTCoreAPI_System_IO_File = {};

--- Opens a file, appends the specified string to the file, and then closes the file.
--- If the file does not exist, this method creates a file, writes the specified string to the file, then closes the file.
--- @param modId string @Project Zomboid workshop mod id.
--- @param path string @Relative path from the mod folder.
--- @param contents string @The lines to append to the file.
function TDTCoreAPI_System_IO_File.AppendAllLines(modId, path, contents)
    local file = getModFileWriter(modId, path, true, true);

    for i, v in ipairs(contents) do
        file:write(v .. "\n");
    end

    file:close();
end

--- Opens a file, appends the specified string to the file, and then closes the file.
--- If the file does not exist, this method creates a file, writes the specified string to the file, then closes the file.
--- @param modId string @Project Zomboid workshop mod id.
--- @param path string @Relative path from the mod folder.
--- @param contents string @The string to append to the file.
function TDTCoreAPI_System_IO_File.AppendAllText(modId, path, contents)
    local file = getModFileWriter(modId, path, true, true);
    file:write(contents);
    file:close();
end

--- Opens a text file, reads all lines of the file, and then closes the file.
--- @param modId string @Project Zomboid workshop mod id.
--- @param path string @Relative path from the mod folder.
--- @return string @A string array containing all lines of the file.
function TDTCoreAPI_System_IO_File.ReadAllLines(modId, path)
    local file = getModFileReader(modId, path, true);
    local content = {};
    local line;

    while true do
        line = file:readLine();

        if line == nil then
            file:close();
            break;
        end

        table.insert(content, line);
    end

    return content;
end

--- Opens a text file, reads all lines of the file, and then closes the file.
--- @param modId string @Project Zomboid workshop mod id.
--- @param path string @Relative path from the mod folder.
--- @return string @A string containing all lines of the file.
function TDTCoreAPI_System_IO_File.ReadAllText(modId, path)
    local file = getModFileReader(modId, path, true);
    local content = "";
    local line;

    while true do
        line = file:readLine();

        if line == nil then
            file:close();
            break;
        end

        content = content .. line .. "\n";
    end

    return content;
end

--- Creates a new file, writes the specified string to the file, and then closes the file.
--- If the target file already exists, it is overwritten.
--- @param modId string @Project Zomboid workshop mod id.
--- @param path string @Relative path from the mod folder.
--- @param contents string @The string array to write to the file.
function TDTCoreAPI_System_IO_File.WriteAllLines(modId, path, contents)
    local file = getModFileWriter(modId, path, true, false);

    for i, v in ipairs(contents) do
        file:write(v .. "\n");
    end

    file:close();
end

--- Creates a new file, writes the specified string to the file, and then closes the file.
--- If the target file already exists, it is overwritten.
--- @param modId string @Project Zomboid workshop mod id.
--- @param path string @Relative path from the mod folder.
--- @param contents string @The string to write to the file.
function TDTCoreAPI_System_IO_File.WriteAllText(modId, path, contents)
    local file = getModFileWriter(modId, path, true, false);
    file:write(contents);
    file:close();
end

return TDTCoreAPI_System_IO_File;