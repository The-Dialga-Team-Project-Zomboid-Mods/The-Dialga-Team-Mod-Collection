--- @type TheDialgaTeam.TDTCoreAPI.Lua.Table
local Table = require("TheDialgaTeam/TDTCoreAPI/Lua/Table");

--- @class TheDialgaTeam.TDTModAPI.System.Bitwise
--- @field Types TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types @Enum containing the different types of bitwise operation.
local TDTCoreAPI_System_Bitwise = {};
local TDTCoreAPI_System_Bitwise_Private = {};

TDTCoreAPI_System_Bitwise.Types = require("TheDialgaTeam/TDTCoreAPI/System/Bitwise/Types");

--- Bitwise operation NOT (~)
--- @param binaryTable TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types | number @Binary bits in table representation.
--- @return number @Numeric value of the binary bits representation.
function TDTCoreAPI_System_Bitwise.Not(binaryTable)
    local binaryBits = {};

    if type(binaryTable) == "table" then
        binaryBits = Table.Copy(binaryTable);
    else
        binaryBits = TDTCoreAPI_System_Bitwise.ConvertToBinaryTable(binaryTable);
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

    return TDTCoreAPI_System_Bitwise.ConvertToNumericValue(binaryBits);
end

--- Bitwise operation AND (&)
--- @param binaryTable TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types | number @Binary bits in table representation.
--- @param binaryTable2 TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types | number @Binary bits in table representation.
--- @return number @Numeric value of the binary bits representation.
function TDTCoreAPI_System_Bitwise.And(binaryTable, binaryTable2)
    local binaryBits = {};
    local binaryBits2 = {};

    if type(binaryTable) == "table" then
        binaryBits = binaryTable;
    else
        binaryBits = TDTCoreAPI_System_Bitwise.ConvertToBinaryTable(binaryTable);
    end

    if type(binaryTable2) == "table" then
        binaryBits2 = binaryTable2;
    else
        binaryBits2 = TDTCoreAPI_System_Bitwise.ConvertToBinaryTable(binaryTable2);
    end

    local index = 1;
    local maxIndex = #binaryBits.value;
    local binaryBits3 = TDTCoreAPI_System_Bitwise_Private.ResolveBestBinaryType(binaryBits, binaryBits2);

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

    return TDTCoreAPI_System_Bitwise.ConvertToNumericValue(binaryBits3);
end

--- Bitwise operation OR (|)
--- @param binaryTable TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types | number @Binary bits in table representation.
--- @param binaryTable2 TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types | number @Binary bits in table representation.
--- @return number @Numeric value of the binary bits representation.
function TDTCoreAPI_System_Bitwise.Or(binaryTable, binaryTable2)
    local binaryBits = {};
    local binaryBits2 = {};

    if type(binaryTable) == "table" then
        binaryBits = binaryTable;
    else
        binaryBits = TDTCoreAPI_System_Bitwise.ConvertToBinaryTable(binaryTable);
    end

    if type(binaryTable2) == "table" then
        binaryBits2 = binaryTable2;
    else
        binaryBits2 = TDTCoreAPI_System_Bitwise.ConvertToBinaryTable(binaryTable2);
    end

    local index = 1;
    local maxIndex = #binaryBits.value;
    local binaryBits3 = TDTCoreAPI_System_Bitwise_Private.ResolveBestBinaryType(binaryBits, binaryBits2);

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

    return TDTCoreAPI_System_Bitwise.ConvertToNumericValue(binaryBits3);
end

--- Bitwise operation XOR (^)
--- @param binaryTable TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types | number @Binary bits in table representation.
--- @param binaryTable2 TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types | number @Binary bits in table representation.
--- @return number @Numeric value of the binary bits representation.
function TDTCoreAPI_System_Bitwise.Xor(binaryTable, binaryTable2)
    local binaryBits = {};
    local binaryBits2 = {};

    if type(binaryTable) == "table" then
        binaryBits = binaryTable;
    else
        binaryBits = TDTCoreAPI_System_Bitwise.ConvertToBinaryTable(binaryTable);
    end

    if type(binaryTable2) == "table" then
        binaryBits2 = binaryTable2;
    else
        binaryBits2 = TDTCoreAPI_System_Bitwise.ConvertToBinaryTable(binaryTable2);
    end

    local index = 1;
    local maxIndex = #binaryBits.value;
    local binaryBits3 = TDTCoreAPI_System_Bitwise_Private.ResolveBestBinaryType(binaryBits, binaryBits2);

    if #binaryBits2.value >= maxIndex then
        maxIndex = #binaryBits2.value;
    end

    while index <= maxIndex do
        if ((binaryBits.value[index] ~= nil and binaryBits.value[index] == 0) and (binaryBits2.value[index] ~= nil and binaryBits2.value[index] == 1)) or ((binaryBits.value[index] ~= nil and binaryBits.value[index] == 1) and (binaryBits2.value[index] ~= nil and binaryBits2.value[index] == 0)) or (binaryBits.value[index] == nil and (binaryBits2.value[index] ~= nil and binaryBits2.value[index] == 1)) or ((binaryBits.value[index] ~= nil and binaryBits.value[index] == 1) and binaryBits2.value[index] == nil) then
            binaryBits3.value[index] = 1;
        else
            binaryBits3.value[index] = 0;
        end

        index = index + 1;
    end

    return TDTCoreAPI_System_Bitwise.ConvertToNumericValue(binaryBits3);
end

--- Bitwise operation LShift (<<)
--- @param binaryTable TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types | number @Binary bits in table representation.
--- @param value number @Amount to shift.
--- @return number @Numeric value of the binary bits representation.
function TDTCoreAPI_System_Bitwise.LShift(binaryTable, value)
    local binaryBits = {};

    if type(binaryTable) == "table" then
        binaryBits = Table.Copy(binaryTable);
    else
        binaryBits = TDTCoreAPI_System_Bitwise.ConvertToBinaryTable(binaryTable);
    end

    for i = 1, value do
        table.insert(binaryBits.value, 1, 0);
    end

    if #binaryBits.value > binaryBits.bits then
        for i = binaryBits.bits + 1, #binaryBits.value do
            table.remove(binaryBits.value);
        end
    end

    return TDTCoreAPI_System_Bitwise.ConvertToNumericValue(binaryBits);
end

--- Bitwise operation RShift (>>)
--- @param binaryTable TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types | number @Binary bits in table representation.
--- @param value number @Amount to shift.
--- @return number @Numeric value of the binary bits representation.
function TDTCoreAPI_System_Bitwise.RShift(binaryTable, value)
    local binaryBits = {};

    if type(binaryTable) == "table" then
        binaryBits = Table.Copy(binaryTable);
    else
        binaryBits = TDTCoreAPI_System_Bitwise.ConvertToBinaryTable(binaryTable);
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

    return TDTCoreAPI_System_Bitwise.ConvertToNumericValue(binaryBits);
end

--- Convert value into binary bits representation.
--- @overload fun(value:number):table
--- @param value number @Value to convert into binary bits.
--- @param valueType TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types @Type of binary bits to convert into.
--- @return TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types @Binary bits in table representation.
function TDTCoreAPI_System_Bitwise.ConvertToBinaryTable(value, valueType)
    local targetType = valueType;
    local targetValue = value;

    if targetType == nil then
        targetType = TDTCoreAPI_System_Bitwise_Private.ResolveBestNumericType(value);
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
        return TDTCoreAPI_System_Bitwise.TrimPaddedZeros(binaryBits);
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

        return TDTCoreAPI_System_Bitwise.TrimPaddedZeros(binaryBits);
    end
end

--- Trim padded zeros in the binary bits.
--- @param binaryTable TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types @Binary bits in table representation.
--- @return TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types @Trimmed binary bits in table representation.
function TDTCoreAPI_System_Bitwise.TrimPaddedZeros(binaryTable)
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
--- @param binaryTable TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types @Binary bits in table representation.
--- @return number @Binary bits into numeric representation.
function TDTCoreAPI_System_Bitwise.ConvertToNumericValue(binaryTable)
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
--- @param value TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types @Value to get the best numeric type.
--- @return TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types @Best numeric type option.
function TDTCoreAPI_System_Bitwise_Private.ResolveBestNumericType(value)
    if value >= 0 and value <= 1 then
        return Table.Copy(TDTCoreAPI_System_Bitwise.Types.bool);
    elseif value >= 0 and value <= 255 then
        return Table.Copy(TDTCoreAPI_System_Bitwise.Types.byte);
    elseif value >= -128 and value <= 127 then
        return Table.Copy(TDTCoreAPI_System_Bitwise.Types.sbyte);
    elseif value >= -32768 and value <= 32767 then
        return Table.Copy(TDTCoreAPI_System_Bitwise.Types.short);
    elseif value >= 0 and value <= 65535 then
        return Table.Copy(TDTCoreAPI_System_Bitwise.Types.ushort);
    elseif value >= -2147483648 and value <= 2147483647 then
        return Table.Copy(TDTCoreAPI_System_Bitwise.Types.int);
    elseif value >= 0 and value <= 4294967295 then
        return Table.Copy(TDTCoreAPI_System_Bitwise.Types.uint);
    elseif value >= -9*10^18 and value <= 9*10^18 then
        return Table.Copy(TDTCoreAPI_System_Bitwise.Types.long);
    elseif value >= 0 and value <= 1.8*10^19 then
        return Table.Copy(TDTCoreAPI_System_Bitwise.Types.ulong);
    else
        return nil;
    end
end

--- Get the biggest binary type from two binary values.
--- @param binaryTable TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types @Binary bits in table representation.
--- @param binaryTable2 TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types @Binary bits in table representation.
--- @return TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types @Binary type table.
function TDTCoreAPI_System_Bitwise_Private.ResolveBestBinaryType(binaryTable, binaryTable2)
    if binaryTable.hasNegativeBits or binaryTable2.hasNegativeBits then
        -- long, int, short, sbyte
        if binaryTable.type == "long" or binaryTable2.type == "long" then
            return Table.Copy(TDTCoreAPI_System_Bitwise.Types.long);
        elseif binaryTable.type == "int" or binaryTable2.type == "int" then
            return Table.Copy(TDTCoreAPI_System_Bitwise.Types.int);
        elseif binaryTable.type == "short" or binaryTable2.type == "short" then
            return Table.Copy(TDTCoreAPI_System_Bitwise.Types.short);
        elseif binaryTable.type == "sbyte" or binaryTable2.type == "sbyte" then
            return Table.Copy(TDTCoreAPI_System_Bitwise.Types.sbyte);
        end
    else
        -- ulong, long, uint, int, ushort, short, sbyte, byte, bool
        if binaryTable.type == "ulong" or binaryTable2.type == "ulong" then
            return Table.Copy(TDTCoreAPI_System_Bitwise.Types.ulong);
        elseif binaryTable.type == "long" or binaryTable2.type == "long" then
            return Table.Copy(TDTCoreAPI_System_Bitwise.Types.long);
        elseif binaryTable.type == "uint" or binaryTable2.type == "uint" then
            return Table.Copy(TDTCoreAPI_System_Bitwise.Types.uint);
        elseif binaryTable.type == "int" or binaryTable2.type == "int" then
            return Table.Copy(TDTCoreAPI_System_Bitwise.Types.int);
        elseif binaryTable.type == "ushort" or binaryTable2.type == "ushort" then
            return Table.Copy(TDTCoreAPI_System_Bitwise.Types.ushort);
        elseif binaryTable.type == "short" or binaryTable2.type == "short" then
            return Table.Copy(TDTCoreAPI_System_Bitwise.Types.short);
        elseif binaryTable.type == "sbyte" or binaryTable2.type == "sbyte" then
            return Table.Copy(TDTCoreAPI_System_Bitwise.Types.sbyte);
        elseif binaryTable.type == "byte" or binaryTable2.type == "byte" then
            return Table.Copy(TDTCoreAPI_System_Bitwise.Types.byte);
        elseif binaryTable.type == "bool" or binaryTable2.type == "bool" then
            return Table.Copy(TDTCoreAPI_System_Bitwise.Types.bool);
        end
    end

    return nil;
end

return TDTCoreAPI_System_Bitwise;