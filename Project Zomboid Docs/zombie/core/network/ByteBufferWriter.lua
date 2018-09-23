--- @class zombie.core.network.ByteBufferWriter : java.lang.Object
local ByteBufferWriter = {};

--- @param v boolean
function ByteBufferWriter:putBoolean(v) end

--- @param v number
function ByteBufferWriter:putByte(v) end

--- @param v number
function ByteBufferWriter:putChar(v) end

--- @param v number
function ByteBufferWriter:putDouble(v) end

--- @param v number
function ByteBufferWriter:putFloat(v) end

--- @param v number
function ByteBufferWriter:putInt(v) end

--- @param v number
function ByteBufferWriter:putLong(v) end

--- @param v number
function ByteBufferWriter:putShort(v) end

--- @param string string
function ByteBufferWriter:putUTF(string) end