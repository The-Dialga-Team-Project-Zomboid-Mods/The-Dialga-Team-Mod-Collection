--- @class zombie.core.textures.ColorInfo : java.lang.Object
local ColorInfo = {};

--- @overload fun():zombie.core.textures.ColorInfo
--- @param R number
--- @param G number
--- @param B number
--- @param A number
--- @return zombie.core.textures.ColorInfo
function ColorInfo.new(R, G, B, A) end

--- @param s number
function ColorInfo:desaturate(s) end

--- @return number
function ColorInfo:getA() end

--- @return number
function ColorInfo:getB() end

--- @return number
function ColorInfo:getG() end

--- @return number
function ColorInfo:getR() end

--- @param to zombie.core.textures.ColorInfo
--- @param delta number
--- @param dest zombie.core.textures.ColorInfo
function ColorInfo:interp(to, delta, dest) end

--- @param R number
--- @param G number
--- @param B number
--- @param A number
--- @return zombie.core.textures.ColorInfo
function ColorInfo:set(R, G, B, A) end

--- @return zombie.core.Color
function ColorInfo:toColor() end