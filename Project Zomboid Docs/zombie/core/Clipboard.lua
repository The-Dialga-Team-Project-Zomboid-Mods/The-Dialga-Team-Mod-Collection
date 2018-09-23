--- @class zombie.core.Clipboard : java.lang.Object
local Clipboard = {};

--- @return zombie.core.Clipboard
function Clipboard.new() end

--- @return string
function Clipboard.getClipboard() end

--- @param str string
function Clipboard.setClipboard(str) end