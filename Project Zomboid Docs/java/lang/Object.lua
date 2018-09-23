--- @class java.lang.Object
local Object = {}

--- @return java.lang.Object
function Object.new() end

--- @param paramObject any
--- @return boolean
function Object:equals(paramObject) end

--- @return java.lang.Class
function Object:getClass() end

--- @return number
function Object:hashCode() end

function Object:notify() end

function Object:notifyAll() end

--- @return string
function Object:toString() end

--- @overload fun()
--- @overload fun(paramLong:number)
--- @param paramLong number
--- @param paramInt number
function Object:wait(paramLong, paramInt) end