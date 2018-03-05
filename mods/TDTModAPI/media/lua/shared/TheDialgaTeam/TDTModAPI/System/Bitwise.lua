local Table = require "TheDialgaTeam/TDTModAPI/Lua/Table";
local TDTModAPI_System_Bitwise = {};

--- Bitwise types.
TDTModAPI_System_Bitwise.Types = {
    --- Boolean flag: false, true.
    bool = { type = "bool", minValue = 0, maxValue = 1, bits = 1, hasNegativeBits = false, value = {} },

    --- Unsigned Byte: 0, 255.
    byte = { type = "byte", minValue = 0, maxValue = 255, bits = 8, hasNegativeBits = false, value = {} },

    --- Signed Byte: -128, 127.
    sbyte = { type = "sbyte", minValue = -128, maxValue = 127, bits = 8, hasNegativeBits = true, value = {} },

    --- Signed Short Integer: -32768, 32767.
    short = { type = "short", minValue = -32768, maxValue = 32767, bits = 16, hasNegativeBits = true, value = {} },

    --- Unsigned Short Integer: 0, 65535.
    ushort = { type = "ushort", minValue = 0, maxValue = 65535, bits = 16, hasNegativeBits = false, value = {} },

    --- Signed Integer: -2147483648, 2147483647.
    int = { type = "int", minValue = -2147483648, maxValue = 2147483647, bits = 32, hasNegativeBits = true, value = {} },

    --- Unsigned Integer: 0, 4294967295.
    uint = { type = "uint", minValue = 0, maxValue = 4294967295, bits = 32, hasNegativeBits = false, value = {} },

    --- Signed Long Integer: -9*10^18, 9*10^18.
    long = { type = "long", minValue = -9*10^18, maxValue = 9*10^18, bits = 64, hasNegativeBits = true, value = {} },

    --- Unsigned Long Integer: 0, 1.8*10^19.
    ulong = { type = "ulong", minValue = 0, maxValue = 1.8*10^19, bits = 64, hasNegativeBits = false, value = {} }
};

--- Bitwise operation NOT (~)
--- @overload fun(binaryTable:number):number
--- @param binaryTable table Binary bits in table representation.
--- @return number Numeric value of the binary bits representation.
function TDTModAPI_System_Bitwise.Not(binaryTable)
    if binaryTable == nil then
        error "ArgumentNullException: binaryTable is null.";
    elseif type(binaryTable) ~= "table" and type(binaryTable) ~= "number" then
        error "ArgumentException: binaryTable is not a table or a number.";
    elseif type(binaryTable) == "table" then
        if binaryTable.type == nil then
            error "ArgumentException: binaryTable is not a valid table.";
        elseif type(binaryTable.type) ~= "string" then
            error "ArgumentException: binaryTable.type is not a string.";
        elseif binaryTable.minValue == nil then
            error "ArgumentException: binaryTable is not a valid table.";
        elseif type(binaryTable.minValue) ~= "number" then
            error "ArgumentException: binaryTable.minValue is not a number.";
        elseif binaryTable.maxValue == nil then
            error "ArgumentException: binaryTable is not a valid table.";
        elseif type(binaryTable.maxValue) ~= "number" then
            error "ArgumentException: binaryTable.maxValue is not a number.";
        elseif binaryTable.bits == nil then
            error "ArgumentException: binaryTable is not a valid table.";
        elseif type(binaryTable.bits) ~= "number" then
            error "ArgumentException: binaryTable.bits is not a number.";
        elseif binaryTable.hasNegativeBits == nil then
            error "ArgumentException: binaryTable is not a valid table.";
        elseif type(binaryTable.hasNegativeBits) ~= "boolean" then
            error "ArgumentException: binaryTable.hasNegativeBits is not a boolean.";
        elseif binaryTable.value == nil then
            error "ArgumentException: binaryTable is not a valid table.";
        elseif type(binaryTable.value) ~= "table" then
            error "ArgumentException: binaryTable.value is not a table.";
        end
    end

    local binaryBits = {};

    if type(binaryTable) == "table" then
        binaryBits = Table.Copy(binaryTable);
    else
        binaryBits = TDTModAPI_System_Bitwise.ConvertToBinaryBits(binaryTable);
    end

    local index = 1;

    while index <= binaryBits.bits do
        if binaryBits.value[index] ~= nil and binaryBits.value[index] == 1 then
            binaryBits.value[index] = 0;
        else
            binaryBits.value[index] = 1;
        end

        index = index + 1;
    end

    return TDTModAPI_System_Bitwise.ConvertToBinaryValue(binaryBits);
end

--- Convert value into binary bits representation.
--- @overload fun(value:number):table
--- @param value number Value to convert into binary bits.
--- @param valueType table Type of binary bits to convert into.
--- @return table Binary bits in table representation.
function TDTModAPI_System_Bitwise.ConvertToBinaryBits(value, valueType)
    if value == nil then
        error "ArgumentNullException: value is null.";
    elseif type(value) ~= "number" then
        error "ArgumentException: value is not a number.";
    elseif string.find(value, "%d+%.%d+") ~= nil then
        error "ArgumentException: value is not of a valid type.";
    elseif valueType ~= nil and type(valueType) ~= "table" then
        error "ArgumentException: type is not a table.";
    elseif valueType ~= nil and valueType ~= TDTModAPI_System_Bitwise.Types.bool and valueType ~= TDTModAPI_System_Bitwise.Types.byte and valueType ~= TDTModAPI_System_Bitwise.Types.sbyte and valueType ~= TDTModAPI_System_Bitwise.Types.short and valueType ~= TDTModAPI_System_Bitwise.Types.ushort and valueType ~= TDTModAPI_System_Bitwise.Types.int and valueType ~= TDTModAPI_System_Bitwise.Types.uint and valueType ~= TDTModAPI_System_Bitwise.Types.long and valueType ~= TDTModAPI_System_Bitwise.Types.ulong then
        error "ArgumentException: type is not of a valid type.";
    end

    local targetType = valueType;
    local targetValue = value;

    if targetType == nil then
        targetType = TDTModAPI_System_Bitwise.ResolveBestNumericType(value);
    else
        targetType = Table.Copy(valueType);
    end

    local isNegative = false;

    if value < 0 then
        isNegative = true;
        targetValue = targetValue * -1;
    end

    local index = targetType.bits;
    local binaryBits = targetType;

    if value == 0 then
        binaryBits.value = { 0 };
        return binaryBits;
    end

    while index > 0 do
        if index == targetType.bits and targetType.hasNegativeBits then
            binaryBits.value[index] = 0;
        elseif targetValue >= 2^(index - 1) then
            targetValue = targetValue - (2^(index - 1));
            binaryBits.value[index] = 1;
        else
            binaryBits.value[index] = 0;
        end

        index = index - 1;
    end

    if not isNegative then
        return TDTModAPI_System_Bitwise.TrimPaddedZeros(binaryBits);
    else
        -- Do two's complement.
        index = targetType.bits;

        while index > 0 do
            if binaryBits.value[index] == 0 then
                binaryBits.value[index] = 1;
            else
                binaryBits.value[index] = 0;
            end

            index = index - 1;
        end

        -- Add 1 bit.
        index = 1;
        local shouldContinueFlipping = true;

        while index <= targetType.bits do
            if binaryBits.value[index] == 0 then
                shouldContinueFlipping = false;
                binaryBits.value[index] = 1;
            else
                binaryBits.value[index] = 0;
            end

            if not shouldContinueFlipping then
                break;
            else
                index = index + 1;
            end
        end

        return TDTModAPI_System_Bitwise.TrimPaddedZeros(binaryBits);
    end
end

--- Get the best numeric type from the value.
--- @param value number Value to get the best numeric type.
--- @return table Best numeric type option.
function TDTModAPI_System_Bitwise.ResolveBestNumericType(value)
    if value == nil then
        error "ArgumentNullException: value is null.";
    elseif type(value) ~= "number" then
        error "ArgumentException: value is not a number.";
    elseif string.find(value, "%d+%.%d+") ~= nil then
        error "ArgumentException: value is not of a valid type.";
    end

    if value >= 0 and value <= 1 then
        return Table.Copy(TDTModAPI_System_Bitwise.Types.bool);
    elseif value >= 0 and value <= 255 then
        return Table.Copy(TDTModAPI_System_Bitwise.Types.byte);
    elseif value >= -128 and value <= 127 then
        return Table.Copy(TDTModAPI_System_Bitwise.Types.sbyte);
    elseif value >= -32768 and value <= 32767 then
        return Table.Copy(TDTModAPI_System_Bitwise.Types.short);
    elseif value >= 0 and value <= 65535 then
        return Table.Copy(TDTModAPI_System_Bitwise.Types.ushort);
    elseif value >= -2147483648 and value <= 2147483647 then
        return Table.Copy(TDTModAPI_System_Bitwise.Types.int);
    elseif value >= 0 and value <= 4294967295 then
        return Table.Copy(TDTModAPI_System_Bitwise.Types.uint);
    elseif value >= -9*10^18 and value <= 9*10^18 then
        return Table.Copy(TDTModAPI_System_Bitwise.Types.long);
    elseif value >= 0 and value <= 1.8*10^19 then
        return Table.Copy(TDTModAPI_System_Bitwise.Types.ulong);
    else
        return nil;
    end
end

--- Trim padded zeros in the binary bits.
--- @param binaryTable table Binary bits in table representation.
--- @return table Trimmed binary bits in table representation.
function TDTModAPI_System_Bitwise.TrimPaddedZeros(binaryTable)
    if binaryTable == nil then
        error "ArgumentNullException: binaryTable is null.";
    elseif type(binaryTable) ~= "table" then
        error "ArgumentException: binaryTable is not a table.";
    elseif binaryTable.type == nil then
        error "ArgumentException: binaryTable is not a valid table.";
    elseif type(binaryTable.type) ~= "string" then
        error "ArgumentException: binaryTable.type is not a string.";
    elseif binaryTable.minValue == nil then
        error "ArgumentException: binaryTable is not a valid table.";
    elseif type(binaryTable.minValue) ~= "number" then
        error "ArgumentException: binaryTable.minValue is not a number.";
    elseif binaryTable.maxValue == nil then
        error "ArgumentException: binaryTable is not a valid table.";
    elseif type(binaryTable.maxValue) ~= "number" then
        error "ArgumentException: binaryTable.maxValue is not a number.";
    elseif binaryTable.bits == nil then
        error "ArgumentException: binaryTable is not a valid table.";
    elseif type(binaryTable.bits) ~= "number" then
        error "ArgumentException: binaryTable.bits is not a number.";
    elseif binaryTable.hasNegativeBits == nil then
        error "ArgumentException: binaryTable is not a valid table.";
    elseif type(binaryTable.hasNegativeBits) ~= "boolean" then
        error "ArgumentException: binaryTable.hasNegativeBits is not a boolean.";
    elseif binaryTable.value == nil then
        error "ArgumentException: binaryTable is not a valid table.";
    elseif type(binaryTable.value) ~= "table" then
        error "ArgumentException: binaryTable.value is not a table.";
    end

    -- short circuit
    if binaryTable.value[#binaryTable.value] == 1 and binaryTable.hasNegativeBits and #binaryTable.value == binaryTable.bits then
        return Table.Copy(binaryTable);
    end

    local binaryBits = Table.Copy(binaryTable);
    binaryBits.value = {};

    local index = #binaryTable.value;
    local skip = true;

    while index > 0 do
        if binaryTable.value[index] == 1 and skip then
            skip = false;
        end

        if not skip then
            binaryBits.value[index] = binaryTable.value[index];
        end

        index = index - 1;
    end

    if #binaryBits.value == 0 then
        binaryBits.value = { 0 };
        return binaryBits;
    else
        return binaryBits;
    end
end

--- Convert binary bits into numeric representation.
--- @param binaryTable table Binary bits in table representation.
--- @return number Binary bits into numeric representation.
function TDTModAPI_System_Bitwise.ConvertToBinaryValue(binaryTable)
    if binaryTable == nil then
        error "ArgumentNullException: binaryTable is null.";
    elseif type(binaryTable) ~= "table" then
        error "ArgumentException: binaryTable is not a table.";
    elseif binaryTable.type == nil then
        error "ArgumentException: binaryTable is not a valid table.";
    elseif type(binaryTable.type) ~= "string" then
        error "ArgumentException: binaryTable.type is not a string.";
    elseif binaryTable.minValue == nil then
        error "ArgumentException: binaryTable is not a valid table.";
    elseif type(binaryTable.minValue) ~= "number" then
        error "ArgumentException: binaryTable.minValue is not a number.";
    elseif binaryTable.maxValue == nil then
        error "ArgumentException: binaryTable is not a valid table.";
    elseif type(binaryTable.maxValue) ~= "number" then
        error "ArgumentException: binaryTable.maxValue is not a number.";
    elseif binaryTable.bits == nil then
        error "ArgumentException: binaryTable is not a valid table.";
    elseif type(binaryTable.bits) ~= "number" then
        error "ArgumentException: binaryTable.bits is not a number.";
    elseif binaryTable.hasNegativeBits == nil then
        error "ArgumentException: binaryTable is not a valid table.";
    elseif type(binaryTable.hasNegativeBits) ~= "boolean" then
        error "ArgumentException: binaryTable.hasNegativeBits is not a boolean.";
    elseif binaryTable.value == nil then
        error "ArgumentException: binaryTable is not a valid table.";
    elseif type(binaryTable.value) ~= "table" then
        error "ArgumentException: binaryTable.value is not a table.";
    end

    local isNegative = false;

    if #binaryTable.value == binaryTable.bits and binaryTable.value[#binaryTable.value] == 1 then
        isNegative = true;
    end

    local binaryBits = Table.Copy(binaryTable);

    if isNegative then
        -- Do two's complement.
        local index = 1;

        while index <= binaryBits.bits do
            if binaryBits.value[index] == 0 then
                binaryBits.value[index] = 1;
            else
                binaryBits.value[index] = 0;
            end

            index = index + 1;
        end

        -- Add 1 bit.
        index = 1;
        local shouldContinueFlipping = true;

        while index <= binaryBits.bits do
            if binaryBits.value[index] == 0 then
                shouldContinueFlipping = false;
                binaryBits.value[index] = 1;
            else
                binaryBits.value[index] = 0;
            end

            if not shouldContinueFlipping then
                break;
            else
                index = index + 1;
            end
        end
    end

    local index = 1;
    local result = 0;

    while index <= binaryBits.bits do
        if binaryBits.value[index] == 1 then
            result = result + (2^(index - 1));
        end

        index = index + 1;
    end

    if isNegative then
        return result * -1;
    else
        return result;
    end
end

return TDTModAPI_System_Bitwise;