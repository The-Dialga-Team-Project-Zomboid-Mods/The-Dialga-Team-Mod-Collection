--- @type TheDialgaTeam.TDTModAPI.Lua.Assert
local Assert = require "TheDialgaTeam/TDTModAPI/Lua/Assert";

--- @type TheDialgaTeam.TDTModAPI.Lua.Table
local Table = require "TheDialgaTeam/TDTModAPI/Lua/Table";

--- @class TheDialgaTeam.TDTModAPI.System.Bitwise
--- @field public Types TheDialgaTeam.TDTModAPI.System.Bitwise.Types
local TDTModAPI_System_Bitwise = {};

local TDTModAPI_System_Bitwise_Private = {};

--- Bitwise types.
--- @class TheDialgaTeam.TDTModAPI.System.Bitwise.Types
--- @field public bool TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
--- @field public byte TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
--- @field public sbyte TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
--- @field public short TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
--- @field public ushort TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
--- @field public int TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
--- @field public uint TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
--- @field public long TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
--- @field public ulong TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
TDTModAPI_System_Bitwise.Types = {
    --- Boolean flag: false, true.
    --- @type TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
    bool = { type = "bool", minValue = 0, maxValue = 1, bits = 1, hasNegativeBits = false, value = { 0 } },

    --- Unsigned Byte: 0, 255.
    --- @type TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
    byte = { type = "byte", minValue = 0, maxValue = 255, bits = 8, hasNegativeBits = false, value = { 0 } },

    --- Signed Byte: -128, 127.
    --- @type TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
    sbyte = { type = "sbyte", minValue = -128, maxValue = 127, bits = 8, hasNegativeBits = true, value = { 0 } },

    --- Signed Short Integer: -32768, 32767.
    --- @type TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
    short = { type = "short", minValue = -32768, maxValue = 32767, bits = 16, hasNegativeBits = true, value = { 0 } },

    --- Unsigned Short Integer: 0, 65535.
    --- @type TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
    ushort = { type = "ushort", minValue = 0, maxValue = 65535, bits = 16, hasNegativeBits = false, value = { 0 } },

    --- Signed Integer: -2147483648, 2147483647.
    --- @type TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
    int = { type = "int", minValue = -2147483648, maxValue = 2147483647, bits = 32, hasNegativeBits = true, value = { 0 } },

    --- Unsigned Integer: 0, 4294967295.
    --- @type TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
    uint = { type = "uint", minValue = 0, maxValue = 4294967295, bits = 32, hasNegativeBits = false, value = { 0 } },

    --- Signed Long Integer: -9*10^18, 9*10^18.
    --- @type TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
    long = { type = "long", minValue = -9*10^18, maxValue = 9*10^18, bits = 64, hasNegativeBits = true, value = { 0 } },

    --- Unsigned Long Integer: 0, 1.8*10^19.
    --- @type TheDialgaTeam.TDTModAPI.System.Bitwise.Types | binaryTable
    ulong = { type = "ulong", minValue = 0, maxValue = 1.8*10^19, bits = 64, hasNegativeBits = false, value = { 0 } }
};

--- Bitwise operation NOT (~)
--- @param binaryTable binaryTable | number Binary bits in table representation.
--- @return number Numeric value of the binary bits representation.
function TDTModAPI_System_Bitwise.Not(binaryTable)
    local status, error = pcall(function ()
        if binaryTable == nil then
            error "ArgumentNullException: binaryTable is null.";
        elseif type(binaryTable) ~= "table" and type(binaryTable) ~= "number" then
            error "ArgumentException: binaryTable is not a table or a number.";
        elseif type(binaryTable) == "table" then
            TDTModAPI_System_Bitwise_Private.AssertBinaryTable(binaryTable, "binaryTable");
        elseif type(binaryTable) == "number" then
            Assert.AssertIntegerNumber(binaryTable, "binaryTable");
        end
    end);

    if status then
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
    else
        print(error);
        return nil;
    end
end

--- Bitwise operation AND (&)
--- @param binaryTable binaryTable | number Binary bits in table representation.
--- @param binaryTable2 binaryTable | number Binary bits in table representation.
--- @return number Numeric value of the binary bits representation.
function TDTModAPI_System_Bitwise.And(binaryTable, binaryTable2)
    local status, error = pcall(function ()
        if binaryTable == nil then
            error "ArgumentNullException: binaryTable is null.";
        elseif binaryTable2 == nil then
            error "ArgumentNullException: binaryTable2 is null.";
        elseif type(binaryTable) ~= "table" and type(binaryTable) ~= "number" then
            error "ArgumentException: binaryTable is not a table or a number.";
        elseif type(binaryTable2) ~= "table" and type(binaryTable2) ~= "number" then
            error "ArgumentException: binaryTable2 is not a table or a number.";
        elseif type(binaryTable) == "table" then
            TDTModAPI_System_Bitwise_Private.AssertBinaryTable(binaryTable, "binaryTable");
        elseif type(binaryTable) == "number" then
            Assert.AssertIntegerNumber(binaryTable, "binaryTable");
        elseif type(binaryTable2) == "table" then
            TDTModAPI_System_Bitwise_Private.AssertBinaryTable(binaryTable2, "binaryTable2");
        elseif type(binaryTable2) == "number" then
            Assert.AssertIntegerNumber(binaryTable2, "binaryTable2");
        end
    end);

    if status then
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
        local binaryBits3 = TDTModAPI_System_Bitwise_Private.ResolveBestBinaryType(binaryBits, binaryBits2);

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
    else
        print(error);
        return nil;
    end
end

--- Bitwise operation OR (|)
--- @param binaryTable binaryTable | number Binary bits in table representation.
--- @param binaryTable2 binaryTable | number Binary bits in table representation.
--- @return number Numeric value of the binary bits representation.
function TDTModAPI_System_Bitwise.Or(binaryTable, binaryTable2)
    local status, error = pcall(function ()
        if binaryTable == nil then
            error "ArgumentNullException: binaryTable is null.";
        elseif binaryTable2 == nil then
            error "ArgumentNullException: binaryTable2 is null.";
        elseif type(binaryTable) ~= "table" and type(binaryTable) ~= "number" then
            error "ArgumentException: binaryTable is not a table or a number.";
        elseif type(binaryTable2) ~= "table" and type(binaryTable2) ~= "number" then
            error "ArgumentException: binaryTable2 is not a table or a number.";
        elseif type(binaryTable) == "table" then
            TDTModAPI_System_Bitwise_Private.AssertBinaryTable(binaryTable, "binaryTable");
        elseif type(binaryTable) == "number" then
            Assert.AssertIntegerNumber(binaryTable, "binaryTable");
        elseif type(binaryTable2) == "table" then
            TDTModAPI_System_Bitwise_Private.AssertBinaryTable(binaryTable2, "binaryTable2");
        elseif type(binaryTable2) == "number" then
            Assert.AssertIntegerNumber(binaryTable2, "binaryTable2");
        end
    end);

    if status then
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
        local binaryBits3 = TDTModAPI_System_Bitwise_Private.ResolveBestBinaryType(binaryBits, binaryBits2);

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
    else
        print(error);
        return nil;
    end
end

--- Bitwise operation XOR (^)
--- @param binaryTable binaryTable | number Binary bits in table representation.
--- @param binaryTable2 binaryTable | number Binary bits in table representation.
--- @return number Numeric value of the binary bits representation.
function TDTModAPI_System_Bitwise.Xor(binaryTable, binaryTable2)
    local status, error = pcall(function ()
        if binaryTable == nil then
            error "ArgumentNullException: binaryTable is null.";
        elseif binaryTable2 == nil then
            error "ArgumentNullException: binaryTable2 is null.";
        elseif type(binaryTable) ~= "table" and type(binaryTable) ~= "number" then
            error "ArgumentException: binaryTable is not a table or a number.";
        elseif type(binaryTable2) ~= "table" and type(binaryTable2) ~= "number" then
            error "ArgumentException: binaryTable2 is not a table or a number.";
        elseif type(binaryTable) == "table" then
            TDTModAPI_System_Bitwise_Private.AssertBinaryTable(binaryTable, "binaryTable");
        elseif type(binaryTable) == "number" then
            Assert.AssertIntegerNumber(binaryTable, "binaryTable");
        elseif type(binaryTable2) == "table" then
            TDTModAPI_System_Bitwise_Private.AssertBinaryTable(binaryTable2, "binaryTable2");
        elseif type(binaryTable2) == "number" then
            Assert.AssertIntegerNumber(binaryTable2, "binaryTable2");
        end
    end);

    if status then
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
        local binaryBits3 = TDTModAPI_System_Bitwise_Private.ResolveBestBinaryType(binaryBits, binaryBits2);

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
    else
        print(error);
        return nil;
    end
end

--- Bitwise operation LShift (<<)
--- @param binaryTable binaryTable | number Binary bits in table representation.
--- @param value number Amount to shift.
--- @return number Numeric value of the binary bits representation.
function TDTModAPI_System_Bitwise.LShift(binaryTable, value)
    local status, error = pcall(function ()
        if binaryTable == nil then
            error "ArgumentNullException: binaryTable is null.";
        elseif type(binaryTable) ~= "table" and type(binaryTable) ~= "number" then
            error "ArgumentException: binaryTable is not a table or a number.";
        elseif type(binaryTable) == "table" then
            TDTModAPI_System_Bitwise_Private.AssertBinaryTable(binaryTable, "binaryTable");
        elseif type(binaryTable) == "number" then
            Assert.AssertIntegerNumber(binaryTable, "binaryTable");
        end
    end);

    if status then
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
    else
        print(error);
        return nil;
    end
end

--- Bitwise operation RShift (>>)
--- @param binaryTable binaryTable | number Binary bits in table representation.
--- @param value number Amount to shift.
--- @return number Numeric value of the binary bits representation.
function TDTModAPI_System_Bitwise.RShift(binaryTable, value)
    local status, error = pcall(function ()
        if binaryTable == nil then
            error "ArgumentNullException: binaryTable is null.";
        elseif type(binaryTable) ~= "table" and type(binaryTable) ~= "number" then
            error "ArgumentException: binaryTable is not a table or a number.";
        elseif type(binaryTable) == "table" then
            TDTModAPI_System_Bitwise_Private.AssertBinaryTable(binaryTable, "binaryTable");
        elseif type(binaryTable) == "number" then
            Assert.AssertIntegerNumber(binaryTable, "binaryTable");
        end
    end);

    if status then
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
    else
        print(error);
        return nil;
    end
end

--- Convert value into binary bits representation.
--- @overload fun(value:number):table
--- @param value number Value to convert into binary bits.
--- @param valueType TheDialgaTeam.TDTModAPI.System.Bitwise.Type Type of binary bits to convert into.
--- @return binaryTable Binary bits in table representation.
function TDTModAPI_System_Bitwise.ConvertToBinaryTable(value, valueType)
    local status, error = pcall(function ()
        Assert.AssertIntegerNumber(value, "value");
        TDTModAPI_System_Bitwise_Private.AssertBitwiseType(valueType, "valueType", true);

        if valueType ~= nil and (value < valueType.minValue or value > valueType.maxValue) then
            error("OverflowException: value is not within the range of " .. valueType.minValue .. " to " .. valueType.maxValue .. ".");
        end
    end);

    if status then
        local targetType = valueType;
        local targetValue = value;

        if targetType == nil then
            targetType = TDTModAPI_System_Bitwise_Private.ResolveBestNumericType(value);
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
    else
        print(error);
        return nil;
    end
end

--- Trim padded zeros in the binary bits.
--- @param binaryTable binaryTable Binary bits in table representation.
--- @return binaryTable Trimmed binary bits in table representation.
function TDTModAPI_System_Bitwise.TrimPaddedZeros(binaryTable)
    local status, error = pcall(function ()
        TDTModAPI_System_Bitwise_Private.AssertBinaryTable(binaryTable, "binaryTable");
    end);

    if status then
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
    else
        print(error);
        return nil;
    end
end

--- Convert binary bits into numeric representation.
--- @param binaryTable binaryTable Binary bits in table representation.
--- @return number Binary bits into numeric representation.
function TDTModAPI_System_Bitwise.ConvertToNumericValue(binaryTable)
    local status, error = pcall(function ()
        TDTModAPI_System_Bitwise_Private.AssertBinaryTable(binaryTable, "binaryTable");
    end);

    if status then
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
    else
        print(error);
        return nil;
    end
end

--- Get the best numeric type from the value.
--- @param value TheDialgaTeam.TDTModAPI.System.Bitwise.Types Value to get the best numeric type.
--- @return binaryTable Best numeric type option.
function TDTModAPI_System_Bitwise_Private.ResolveBestNumericType(value)
    local status, error = pcall(function ()
        Assert.AssertIntegerNumber(value, "value")
    end);

    if status then
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
    else
        print(error);
        return nil;
    end
end

--- Get the biggest binary type from two binary values.
--- @param binaryTable binaryTable Binary bits in table representation.
--- @param binaryTable2 binaryTable Binary bits in table representation.
--- @return binaryTable Binary type table.
function TDTModAPI_System_Bitwise_Private.ResolveBestBinaryType(binaryTable, binaryTable2)
    local status, error = pcall(function ()
        TDTModAPI_System_Bitwise_Private.AssertBinaryTable(binaryTable, "binaryTable");
        TDTModAPI_System_Bitwise_Private.AssertBinaryTable(binaryTable2, "binaryTable2");
    end);

    if status then
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
    else
        print(error);
        return nil;
    end
end

--- Check if it is a valid binary table.
--- @overload fun(binaryTable:binaryTable, name:string):void
--- @param binaryTable binaryTable Binary bits in table representation.
--- @param acceptNull boolean Check if it accept null.
function TDTModAPI_System_Bitwise_Private.AssertBinaryTable(binaryTable, name, acceptNull)
    if name == nil then
        error "ArgumentNullException: name is null.";
    elseif type(name) ~= "string" then
        error "ArgumentException: name is not a string.";
    end

    Assert.AssertTable(binaryTable, name, acceptNull);
    Assert.AssertString(binaryTable.type, name .. ".type", acceptNull);
    Assert.AssertNumber(binaryTable.minValue, name .. ".minValue", acceptNull);
    Assert.AssertNumber(binaryTable.maxValue, name .. ".maxValue", acceptNull);
    Assert.AssertNumber(binaryTable.bits, name .. ".bits", acceptNull);
    Assert.AssertBoolean(binaryTable.hasNegativeBits, name .. ".hasNegativeBits", acceptNull);
    Assert.AssertTable(binaryTable.value, name .. ".value", acceptNull);
end

--- Check if it is a valid bitwise type.
--- @overload fun(valueType:TheDialgaTeam.TDTModAPI.System.Bitwise.Types, name:string):void
--- @param valueType TheDialgaTeam.TDTModAPI.System.Bitwise.Types Bitwise type information.
--- @param acceptNull boolean Check if it accept null.
function TDTModAPI_System_Bitwise_Private.AssertBitwiseType(valueType, name, acceptNull)
    if name == nil then
        error "ArgumentNullException: name is null.";
    elseif type(name) ~= "string" then
        error "ArgumentException: name is not a string.";
    end

    Assert.AssertTable(valueType, name, acceptNull);

    if valueType ~= nil and valueType ~= TDTModAPI_System_Bitwise.Types.bool and valueType ~= TDTModAPI_System_Bitwise.Types.byte and valueType ~= TDTModAPI_System_Bitwise.Types.sbyte and valueType ~= TDTModAPI_System_Bitwise.Types.short and valueType ~= TDTModAPI_System_Bitwise.Types.ushort and valueType ~= TDTModAPI_System_Bitwise.Types.int and valueType ~= TDTModAPI_System_Bitwise.Types.uint and valueType ~= TDTModAPI_System_Bitwise.Types.long and valueType ~= TDTModAPI_System_Bitwise.Types.ulong then
        error("ArgumentException: " .. name .. " is not of a valid type.");
    end
end

return TDTModAPI_System_Bitwise;