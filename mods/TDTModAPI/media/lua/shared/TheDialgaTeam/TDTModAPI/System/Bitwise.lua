local Table = require "TheDialgaTeam/TDTModAPI/Lua/Table";
local TDTModAPI_System_Bitwise = {};
local TDTModAPI_System_Bitwise_Internal = {};

--- Bitwise types.
TDTModAPI_System_Bitwise.Types = {
    --- Boolean flag: false, true.
    bool = { type = "bool", minValue = 0, maxValue = 1, bits = 1, hasNegativeBits = false, value = { 0 } },

    --- Unsigned Byte: 0, 255.
    byte = { type = "byte", minValue = 0, maxValue = 255, bits = 8, hasNegativeBits = false, value = { 0 } },

    --- Signed Byte: -128, 127.
    sbyte = { type = "sbyte", minValue = -128, maxValue = 127, bits = 8, hasNegativeBits = true, value = { 0 } },

    --- Signed Short Integer: -32768, 32767.
    short = { type = "short", minValue = -32768, maxValue = 32767, bits = 16, hasNegativeBits = true, value = { 0 } },

    --- Unsigned Short Integer: 0, 65535.
    ushort = { type = "ushort", minValue = 0, maxValue = 65535, bits = 16, hasNegativeBits = false, value = { 0 } },

    --- Signed Integer: -2147483648, 2147483647.
    int = { type = "int", minValue = -2147483648, maxValue = 2147483647, bits = 32, hasNegativeBits = true, value = { 0 } },

    --- Unsigned Integer: 0, 4294967295.
    uint = { type = "uint", minValue = 0, maxValue = 4294967295, bits = 32, hasNegativeBits = false, value = { 0 } },

    --- Signed Long Integer: -9*10^18, 9*10^18.
    long = { type = "long", minValue = -9*10^18, maxValue = 9*10^18, bits = 64, hasNegativeBits = true, value = { 0 } },

    --- Unsigned Long Integer: 0, 1.8*10^19.
    ulong = { type = "ulong", minValue = 0, maxValue = 1.8*10^19, bits = 64, hasNegativeBits = false, value = { 0 } }
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
        TDTModAPI_System_Bitwise_Internal.AssertBinaryTable(binaryTable);
    elseif type(binaryTable) == "number" then
        TDTModAPI_System_Bitwise_Internal.AssertIntegerValue(binaryTable);
    end

    local binaryBits = {};

    if type(binaryTable) == "table" then
        binaryBits = Table.Copy(binaryTable);
    else
        binaryBits = TDTModAPI_System_Bitwise.ConvertToBinaryTable(binaryTable);
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

    return TDTModAPI_System_Bitwise.ConvertToNumericValue(binaryBits);
end

--- Bitwise operation AND (&)
--- @overload fun(binaryTable:number, binaryTable2:number):number
--- @overload fun(binaryTable:number, binaryTable2:table):number
--- @overload fun(binaryTable:table, binaryTable2:number):number
--- @param binaryTable table Binary bits in table representation.
--- @param binaryTable2 table Binary bits in table representation.
--- @return number Numeric value of the binary bits representation.
function TDTModAPI_System_Bitwise.And(binaryTable, binaryTable2)
    if binaryTable == nil then
        error "ArgumentNullException: binaryTable is null.";
    elseif binaryTable2 == nil then
        error "ArgumentNullException: binaryTable2 is null.";
    elseif type(binaryTable) ~= "table" and type(binaryTable) ~= "number" then
        error "ArgumentException: binaryTable is not a table or a number.";
    elseif type(binaryTable2) ~= "table" and type(binaryTable2) ~= "number" then
        error "ArgumentException: binaryTable2 is not a table or a number.";
    elseif type(binaryTable) == "table" then
        TDTModAPI_System_Bitwise_Internal.AssertBinaryTable(binaryTable);
    elseif type(binaryTable) == "number" then
        TDTModAPI_System_Bitwise_Internal.AssertIntegerValue(binaryTable);
    elseif type(binaryTable2) == "table" then
        TDTModAPI_System_Bitwise_Internal.AssertBinaryTable(binaryTable2);
    elseif type(binaryTable2) == "number" then
        TDTModAPI_System_Bitwise_Internal.AssertIntegerValue(binaryTable2);
    end

    local binaryBits = {};
    local binaryBits2 = {};

    if type(binaryTable) == "table" then
        binaryBits = binaryTable;
    else
        binaryBits = TDTModAPI_System_Bitwise.ConvertToBinaryTable(binaryTable);
    end

    if type(binaryTable2) == "table" then
        binaryBits2 = binaryTable2;
    else
        binaryBits2 = TDTModAPI_System_Bitwise.ConvertToBinaryTable(binaryTable2);
    end

    local index = 1;
    local maxIndex = #binaryBits.value;
    local binaryBits3 = TDTModAPI_System_Bitwise_Internal.ResolveBestBinaryType(binaryBits, binaryBits2);

    if #binaryBits2.value <= maxIndex then
        maxIndex = #binaryBits2.value;
    end

    while index <= maxIndex do
        if binaryBits.value[index] ~= nil and binaryBits.value[index] == 1 and binaryBits2.value[index] ~= nil and binaryBits2.value[index] == 1 then
            binaryBits3.value[index] = 1;
        else
            binaryBits3.value[index] = 0;
        end

        index = index + 1;
    end

    return TDTModAPI_System_Bitwise.ConvertToNumericValue(binaryBits3);
end

--- Bitwise operation OR (|)
--- @overload fun(binaryTable:number, binaryTable2:number):number
--- @overload fun(binaryTable:number, binaryTable2:table):number
--- @overload fun(binaryTable:table, binaryTable2:number):number
--- @param binaryTable table Binary bits in table representation.
--- @param binaryTable2 table Binary bits in table representation.
--- @return number Numeric value of the binary bits representation.
function TDTModAPI_System_Bitwise.Or(binaryTable, binaryTable2)
    if binaryTable == nil then
        error "ArgumentNullException: binaryTable is null.";
    elseif binaryTable2 == nil then
        error "ArgumentNullException: binaryTable2 is null.";
    elseif type(binaryTable) ~= "table" and type(binaryTable) ~= "number" then
        error "ArgumentException: binaryTable is not a table or a number.";
    elseif type(binaryTable2) ~= "table" and type(binaryTable2) ~= "number" then
        error "ArgumentException: binaryTable2 is not a table or a number.";
    elseif type(binaryTable) == "table" then
        TDTModAPI_System_Bitwise_Internal.AssertBinaryTable(binaryTable);
    elseif type(binaryTable) == "number" then
        TDTModAPI_System_Bitwise_Internal.AssertIntegerValue(binaryTable);
    elseif type(binaryTable2) == "table" then
        TDTModAPI_System_Bitwise_Internal.AssertBinaryTable(binaryTable2);
    elseif type(binaryTable2) == "number" then
        TDTModAPI_System_Bitwise_Internal.AssertIntegerValue(binaryTable2);
    end

    local binaryBits = {};
    local binaryBits2 = {};

    if type(binaryTable) == "table" then
        binaryBits = binaryTable;
    else
        binaryBits = TDTModAPI_System_Bitwise.ConvertToBinaryTable(binaryTable);
    end

    if type(binaryTable2) == "table" then
        binaryBits2 = binaryTable2;
    else
        binaryBits2 = TDTModAPI_System_Bitwise.ConvertToBinaryTable(binaryTable2);
    end

    local index = 1;
    local maxIndex = #binaryBits.value;
    local binaryBits3 = TDTModAPI_System_Bitwise_Internal.ResolveBestBinaryType(binaryBits, binaryBits2);

    if #binaryBits2.value >= maxIndex then
        maxIndex = #binaryBits2.value;
    end

    while index <= maxIndex do
        if (binaryBits.value[index] ~= nil and binaryBits.value[index] == 1) or (binaryBits2.value[index] ~= nil and binaryBits2.value[index] == 1) then
            binaryBits3.value[index] = 1;
        else
            binaryBits3.value[index] = 0;
        end

        index = index + 1;
    end

    return TDTModAPI_System_Bitwise.ConvertToNumericValue(binaryBits3);
end

--- Bitwise operation XOR (^)
--- @overload fun(binaryTable:number, binaryTable2:number):number
--- @overload fun(binaryTable:number, binaryTable2:table):number
--- @overload fun(binaryTable:table, binaryTable2:number):number
--- @param binaryTable table Binary bits in table representation.
--- @param binaryTable2 table Binary bits in table representation.
--- @return number Numeric value of the binary bits representation.
function TDTModAPI_System_Bitwise.Xor(binaryTable, binaryTable2)
    if binaryTable == nil then
        error "ArgumentNullException: binaryTable is null.";
    elseif binaryTable2 == nil then
        error "ArgumentNullException: binaryTable2 is null.";
    elseif type(binaryTable) ~= "table" and type(binaryTable) ~= "number" then
        error "ArgumentException: binaryTable is not a table or a number.";
    elseif type(binaryTable2) ~= "table" and type(binaryTable2) ~= "number" then
        error "ArgumentException: binaryTable2 is not a table or a number.";
    elseif type(binaryTable) == "table" then
        TDTModAPI_System_Bitwise_Internal.AssertBinaryTable(binaryTable);
    elseif type(binaryTable) == "number" then
        TDTModAPI_System_Bitwise_Internal.AssertIntegerValue(binaryTable);
    elseif type(binaryTable2) == "table" then
        TDTModAPI_System_Bitwise_Internal.AssertBinaryTable(binaryTable2);
    elseif type(binaryTable2) == "number" then
        TDTModAPI_System_Bitwise_Internal.AssertIntegerValue(binaryTable2);
    end

    local binaryBits = {};
    local binaryBits2 = {};

    if type(binaryTable) == "table" then
        binaryBits = binaryTable;
    else
        binaryBits = TDTModAPI_System_Bitwise.ConvertToBinaryTable(binaryTable);
    end

    if type(binaryTable2) == "table" then
        binaryBits2 = binaryTable2;
    else
        binaryBits2 = TDTModAPI_System_Bitwise.ConvertToBinaryTable(binaryTable2);
    end

    local index = 1;
    local maxIndex = #binaryBits.value;
    local binaryBits3 = TDTModAPI_System_Bitwise_Internal.ResolveBestBinaryType(binaryBits, binaryBits2);

    if #binaryBits2.value >= maxIndex then
        maxIndex = #binaryBits2.value;
    end

    while index <= maxIndex do
        if ((binaryBits.value[index] ~= nil and binaryBits.value[index] == 0) and (binaryBits2.value[index] ~= nil and binaryBits2.value[index] == 1)) or ((binaryBits.value[index] ~= nil and binaryBits.value[index] == 1) and (binaryBits2.value[index] ~= nil and binaryBits2.value[index] == 0)) or (binaryBits.value[index] == nil and (binaryBits2.value[index] ~= nil and binaryBits2.value[index] == 1)) or ((binaryBits.value[index] ~= nil and binaryBits.value[index] == 1) and binaryBits2.value[index] == nil)
        then
            binaryBits3.value[index] = 1;
        else
            binaryBits3.value[index] = 0;
        end

        index = index + 1;
    end

    return TDTModAPI_System_Bitwise.ConvertToNumericValue(binaryBits3);
end

--- Bitwise operation LShift (<<)
--- @param binaryTable table Binary bits in table representation.
--- @param value number Amount to shift.
--- @return number Numeric value of the binary bits representation.
function TDTModAPI_System_Bitwise.LShift(binaryTable, value)
    if binaryTable == nil then
        error "ArgumentNullException: binaryTable is null.";
    elseif type(binaryTable) ~= "table" and type(binaryTable) ~= "number" then
        error "ArgumentException: binaryTable is not a table or a number.";
    elseif type(binaryTable) == "table" then
        TDTModAPI_System_Bitwise_Internal.AssertBinaryTable(binaryTable);
    elseif type(binaryTable) == "number" then
        TDTModAPI_System_Bitwise_Internal.AssertIntegerValue(binaryTable);
    end

    TDTModAPI_System_Bitwise_Internal.AssertIntegerValue(value);

    local binaryBits = {};

    if type(binaryTable) == "table" then
        binaryBits = Table.Copy(binaryTable);
    else
        binaryBits = TDTModAPI_System_Bitwise.ConvertToBinaryTable(binaryTable);
    end

    for i = 1, value do
        table.insert(binaryBits.value, 1, 0);
    end

    if #binaryBits.value > binaryBits.bits then
        for i = binaryBits.bits + 1, #binaryBits.value do
            table.remove(binaryBits.value);
        end
    end

    return TDTModAPI_System_Bitwise.ConvertToNumericValue(binaryBits);
end

--- Bitwise operation RShift (>>)
--- @param binaryTable table Binary bits in table representation.
--- @param value number Amount to shift.
--- @return number Numeric value of the binary bits representation.
function TDTModAPI_System_Bitwise.RShift(binaryTable, value)
    if binaryTable == nil then
        error "ArgumentNullException: binaryTable is null.";
    elseif type(binaryTable) ~= "table" and type(binaryTable) ~= "number" then
        error "ArgumentException: binaryTable is not a table or a number.";
    elseif type(binaryTable) == "table" then
        TDTModAPI_System_Bitwise_Internal.AssertBinaryTable(binaryTable);
    elseif type(binaryTable) == "number" then
        TDTModAPI_System_Bitwise_Internal.AssertIntegerValue(binaryTable);
    end

    TDTModAPI_System_Bitwise_Internal.AssertIntegerValue(value);

    local binaryBits = {};

    if type(binaryTable) == "table" then
        binaryBits = Table.Copy(binaryTable);
    else
        binaryBits = TDTModAPI_System_Bitwise.ConvertToBinaryTable(binaryTable);
    end

    local isNegative = false;

    if binaryBits.hasNegativeBits and #binaryBits.value == binaryBits.bits and binaryBits.value[#binaryBits.value] == 1 then
        isNegative = true;
    end

    for i = 1, value do
        if isNegative then
            table.insert(binaryBits.value, 1);
        else
            table.insert(binaryBits.value, 0);
        end
    end

    if #binaryBits.value > binaryBits.bits then
        for i = binaryBits.bits + 1, #binaryBits.value do
            table.remove(binaryBits.value, 1);
        end
    end

    return TDTModAPI_System_Bitwise.ConvertToNumericValue(binaryBits);
end

--- Convert value into binary bits representation.
--- @overload fun(value:number):table
--- @param value number Value to convert into binary bits.
--- @param valueType table Type of binary bits to convert into.
--- @return table Binary bits in table representation.
function TDTModAPI_System_Bitwise.ConvertToBinaryTable(value, valueType)
    TDTModAPI_System_Bitwise_Internal.AssertIntegerValue(value);
    TDTModAPI_System_Bitwise_Internal.AssertBitwiseType(valueType, true);

    if valueType ~= nil and (value < valueType.minValue or value > valueType.maxValue) then
        error("OverflowException: value is not within the range of " .. valueType.minValue .. " to " .. valueType.maxValue .. ".");
    end

    local targetType = valueType;
    local targetValue = value;

    if targetType == nil then
        targetType = TDTModAPI_System_Bitwise_Internal.ResolveBestNumericType(value);
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

--- Trim padded zeros in the binary bits.
--- @param binaryTable table Binary bits in table representation.
--- @return table Trimmed binary bits in table representation.
function TDTModAPI_System_Bitwise.TrimPaddedZeros(binaryTable)
    TDTModAPI_System_Bitwise_Internal.AssertBinaryTable(binaryTable);

    -- short circuit
    if binaryTable.hasNegativeBits and #binaryTable.value == binaryTable.bits and binaryTable.value[#binaryTable.value] == 1 then
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
function TDTModAPI_System_Bitwise.ConvertToNumericValue(binaryTable)
    TDTModAPI_System_Bitwise_Internal.AssertBinaryTable(binaryTable);

    local isNegative = false;

    if binaryTable.hasNegativeBits and #binaryTable.value == binaryTable.bits and binaryTable.value[#binaryTable.value] == 1 then
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

--- Get the best numeric type from the value.
--- @param value number Value to get the best numeric type.
--- @return table Best numeric type option.
function TDTModAPI_System_Bitwise_Internal.ResolveBestNumericType(value)
    TDTModAPI_System_Bitwise_Internal.AssertIntegerValue(value);

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

--- Get the biggest binary type from two binary values.
--- @param binaryTable table Binary bits in table representation.
--- @param binaryTable2 table Binary bits in table representation.
--- @return table Binary type table.
function TDTModAPI_System_Bitwise_Internal.ResolveBestBinaryType(binaryTable, binaryTable2)
    TDTModAPI_System_Bitwise_Internal.AssertBinaryTable(binaryTable);
    TDTModAPI_System_Bitwise_Internal.AssertBinaryTable(binaryTable2);

    if binaryTable.hasNegativeBits or binaryTable2.hasNegativeBits then
        -- long, int, short, sbyte
        if binaryTable.type == "long" or binaryTable2.type == "long" then
            return Table.Copy(TDTModAPI_System_Bitwise.Types.long);
        elseif binaryTable.type == "int" or binaryTable2.type == "int" then
            return Table.Copy(TDTModAPI_System_Bitwise.Types.int);
        elseif binaryTable.type == "short" or binaryTable2.type == "short" then
            return Table.Copy(TDTModAPI_System_Bitwise.Types.short);
        elseif binaryTable.type == "sbyte" or binaryTable2.type == "sbyte" then
            return Table.Copy(TDTModAPI_System_Bitwise.Types.sbyte);
        end
    else
        -- ulong, long, uint, int, ushort, short, sbyte, byte, bool
        if binaryTable.type == "ulong" or binaryTable2.type == "ulong" then
            return Table.Copy(TDTModAPI_System_Bitwise.Types.ulong);
        elseif binaryTable.type == "long" or binaryTable2.type == "long" then
            return Table.Copy(TDTModAPI_System_Bitwise.Types.long);
        elseif binaryTable.type == "uint" or binaryTable2.type == "uint" then
            return Table.Copy(TDTModAPI_System_Bitwise.Types.uint);
        elseif binaryTable.type == "int" or binaryTable2.type == "int" then
            return Table.Copy(TDTModAPI_System_Bitwise.Types.int);
        elseif binaryTable.type == "ushort" or binaryTable2.type == "ushort" then
            return Table.Copy(TDTModAPI_System_Bitwise.Types.ushort);
        elseif binaryTable.type == "short" or binaryTable2.type == "short" then
            return Table.Copy(TDTModAPI_System_Bitwise.Types.short);
        elseif binaryTable.type == "sbyte" or binaryTable2.type == "sbyte" then
            return Table.Copy(TDTModAPI_System_Bitwise.Types.sbyte);
        elseif binaryTable.type == "byte" or binaryTable2.type == "byte" then
            return Table.Copy(TDTModAPI_System_Bitwise.Types.byte);
        elseif binaryTable.type == "bool" or binaryTable2.type == "bool" then
            return Table.Copy(TDTModAPI_System_Bitwise.Types.bool);
        end
    end

    return nil;
end

--- Check if it is a valid binary table.
--- @overload fun(binaryTable:table):void
--- @param binaryTable table Binary bits in table representation.
--- @param acceptNull boolean Accept null value?
function TDTModAPI_System_Bitwise_Internal.AssertBinaryTable(binaryTable, acceptNull)
    if (not (acceptNull or true)) and binaryTable == nil then
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
end

--- Check if it is a valid integer value.
--- @overload fun(value:number):void
--- @param value number Value to check for valid integer value.
--- @param acceptNull boolean Accept null value?
function TDTModAPI_System_Bitwise_Internal.AssertIntegerValue(value, acceptNull)
    if (not (acceptNull or true)) and value == nil then
        error "ArgumentNullException: value is null.";
    elseif type(value) ~= "number" then
        error "ArgumentException: value is not a number.";
    elseif string.find(value, "%d+%.%d+") ~= nil then
        error "ArgumentException: value is not of a valid integer.";
    end
end

--- Check if it is a valid bitwise type.
--- @overload fun(valueType:table):void
--- @param valueType table Bitwise type information.
--- @param acceptNull boolean Accept null value?
function TDTModAPI_System_Bitwise_Internal.AssertBitwiseType(valueType, acceptNull)

    if (not (acceptNull or true)) and valueType == nil then
        error "ArgumentNullException: value is null.";
    elseif valueType ~= nil and type(valueType) ~= "table" then
        error "ArgumentException: valueType is not a table.";
    elseif valueType ~= nil and valueType ~= TDTModAPI_System_Bitwise.Types.bool and valueType ~= TDTModAPI_System_Bitwise.Types.byte and valueType ~= TDTModAPI_System_Bitwise.Types.sbyte and valueType ~= TDTModAPI_System_Bitwise.Types.short and valueType ~= TDTModAPI_System_Bitwise.Types.ushort and valueType ~= TDTModAPI_System_Bitwise.Types.int and valueType ~= TDTModAPI_System_Bitwise.Types.uint and valueType ~= TDTModAPI_System_Bitwise.Types.long and valueType ~= TDTModAPI_System_Bitwise.Types.ulong then
        error "ArgumentException: valueType is not of a valid type.";
    end
end

return TDTModAPI_System_Bitwise;