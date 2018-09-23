--- @class zombie.core.Color : java.lang.Object
local Color = {};

--- @overload fun(color:zombie.core.Color):zombie.core.Color
--- @overload fun(A:zombie.core.Color, B:zombie.core.Color, delta:number):zombie.core.Color
--- @overload fun(r:number, g:number, b:number):zombie.core.Color
--- @overload fun(value:number):zombie.core.Color
--- @param r number
--- @param g number
--- @param b number
--- @param a number
--- @return zombie.core.Color
function Color.new(r, g, b, a) end

--- @param hue number
--- @param saturation number
--- @param brightness number
--- @return number[]
function Color.HSBtoRGB(hue, saturation, brightness) end

--- @param c zombie.core.Color
function Color:add(c) end

--- @param c zombie.core.Color
--- @return zombie.core.Color
function Color:addToCopy(c) end

--- @overload fun():zombie.core.Color
--- @param scale number
--- @return zombie.core.Color
function Color:brighter(scale) end

--- @overload fun():zombie.core.Color
--- @param scale number
--- @return zombie.core.Color
function Color:darker(scale) end

--- @param nm string
--- @return zombie.core.Color
function Color.decode(nm) end

--- @param other any
--- @return boolean
function Color:equals(other) end

--- @param value number
function Color:fromColor(value) end

--- @return number
function Color:getAlpha() end

--- @return number
function Color:getAlphaByte() end

--- @return number
function Color:getAlphaFloat() end

--- @return number
function Color:getBluw() end

--- @return number
function Color:getBlueByte() end

--- @return number
function Color:getBlueFloat() end

--- @return number
function Color:getGreen() end

--- @return number
function Color:getGreenByte() end

--- @return number
function Color:getGreenFloat() end

--- @return number
function Color:getRed() end

--- @return number
function Color:getRedByte() end

--- @return number
function Color:getRedFloat() end

--- @return number
function Color:hashCode() end

--- @param to zombie.core.Color
--- @param delta number
--- @param dest zombie.core.Color
function Color:interp(to, delta, dest) end

--- @param c zombie.core.Color
--- @return zombie.core.Color
function Color:multiply(c) end

--- @param value number
function Color:scale(value) end

--- @param value number
--- @return zombie.core.Color
function Color:scaleCopy(value) end

--- @param other zombie.core.Color
function Color:set(other) end

--- @param A zombie.core.Color
--- @param B zombie.core.Color
--- @param delta number
function Color:setColor(A, B, delta) end

--- @return string
function Color:toString() end