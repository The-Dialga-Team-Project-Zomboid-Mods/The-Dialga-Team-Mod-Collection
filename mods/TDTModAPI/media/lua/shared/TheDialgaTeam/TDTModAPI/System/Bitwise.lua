local TDTModAPI_System_Bitwise = {};

--- Convert 32 bit signed integer into binary bits in table form.
-- @param value 32 bit signed integer to convert.
-- @return Binary bits of the value in table form.
function TDTModAPI_System_Bitwise.ToSignedIntegerBits(value)
    if value == nil then
        error "ArgumentNullException: value is null.";
    elseif type(value) ~= "number" then
        error "ArgumentException: value is not a number.";
    elseif value > 2^31 - 1 then
        error "OverflowException: value is more than 32 bit value.";
    elseif value < -2^31 then
        error "OverflowException: value is less than 32 bit value.";
    end

    -- Short circuit values
    if value == 0 then
        return { 0 };
    elseif value == 2^31 - 1 then
        return { 1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1, 1,1,1,1 };
    elseif value == -2^31 then
        return { 1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0 };
    end

    local Bit32Result = {};
    local isNegative = false;
    local targetValue = value;
    local index = 31;

    if value < 0 then
        isNegative = true;
        targetValue = targetValue * -1;
    end

    while index >= 0 do
        if targetValue >= 2 ^ index then
            targetValue = targetValue - (2^index);
            table.insert(Bit32Result, 1);
        else
            table.insert(Bit32Result, 0);
        end

        index = index - 1;
    end

    if not isNegative then
        return TDTModAPI_System_Bitwise.TrimZeros(Bit32Result);
    else
        -- Do two's complement
        index = 32;

        while index > 0 do
            if Bit32Result[index] == 0 then
                Bit32Result[index] = 1;
            else
                Bit32Result[index] = 0;
            end

            index = index - 1;
        end

        -- Add 1 to the bits.
        index = 32;
        local shouldContinueFlipping = true;

        while index > 0 do
            if Bit32Result[index] == 0 then
                Bit32Result[index] = 1;
                shouldContinueFlipping = false;
            else
                Bit32Result[index] = 0;
            end

            if not shouldContinueFlipping then
                break;
            else
                index = index - 1;
            end
        end

        return TDTModAPI_System_Bitwise.TrimZeros(Bit32Result);
    end
end

--- Bitwise operation NOT (~)
-- @param value table containing binary bits to apply NOT operation.
-- @return The integer value of the bitwise operation.
function TDTModAPI_System_Bitwise.Not(value)
    if value == nil then
        error "ArgumentNullException: value is null.";
    elseif type(value) ~= "table" then
        error "ArgumentException: value is not a table.";
    end

    local index = 1;
    local maxIndex = #value;
    local result = {};

    while index <= maxIndex do
        if value[index] == 1 then
            table.insert(result, 0);
        else
            table.insert(result, 1);
        end

        index = index + 1;
    end

    return TDTModAPI_System_Bitwise.ToSignedIntegerValue(result);
end

--- Bitwise operation AND (&)
-- @param value table containing binary bits to apply AND operation.
-- @param value2 table containing binary bits to apply AND operation.
-- @return The integer value of the bitwise operation.
function TDTModAPI_System_Bitwise.And(value, value2)
    if value == nil then
        error "ArgumentNullException: value is null.";
    elseif value2 == nil then
        error "ArgumentNullException: value2 is null.";
    elseif type(value) ~= "table" then
        error "ArgumentException: value is not a table.";
    elseif type(value2) ~= "table" then
        error "ArgumentException: value2 is not a table.";
    end

    local index = #value;
    local index2 = #value2;
    local smallestIndex = index2;
    local result = {};

    if index <= index2 then
        smallestIndex = index;
    end

    while smallestIndex >= 1 do
        if value[index] == 1 and value2[index2] == 1 then
            result[smallestIndex] = 1;
        else
            result[smallestIndex] = 0;
        end

        index = index - 1;
        index2 = index2 - 1;
        smallestIndex = smallestIndex - 1;
    end

    return TDTModAPI_System_Bitwise.ToSignedIntegerValue(result);
end

--- Bitwise operation OR (|)
-- @param value table containing binary bits to apply OR operation.
-- @param value2 table containing binary bits to apply OR operation.
-- @return The integer value of the bitwise operation.
function TDTModAPI_System_Bitwise.Or(value, value2)
    if value == nil then
        error "ArgumentNullException: value is null.";
    elseif value2 == nil then
        error "ArgumentNullException: value2 is null.";
    elseif type(value) ~= "table" then
        error "ArgumentException: value is not a table.";
    elseif type(value2) ~= "table" then
        error "ArgumentException: value2 is not a table.";
    end

    local index = #value;
    local index2 = #value2;
    local biggestIndex = index2;
    local result = {};

    if index >= index2 then
        biggestIndex = index;
    end

    while biggestIndex >= 1 do
        if index >= 1 and value[index] == 1 then
            result[biggestIndex] = 1;
        elseif index2 >= 1 and value2[index2] == 1 then
            result[biggestIndex] = 1;
        else
            result[biggestIndex] = 0;
        end

        index = index - 1;
        index2 = index2 - 1;
        biggestIndex = biggestIndex - 1;
    end

    return TDTModAPI_System_Bitwise.ToSignedIntegerValue(result);
end

--- Convert binary bits into 32 bit signed integer.
-- @param value table containing binary bits to convert.
-- @return The integer value of the binary representation.
function TDTModAPI_System_Bitwise.ToSignedIntegerValue(value)
    if value == nil then
        error "ArgumentNullException: value is null.";
    elseif type(value) ~= "table" then
        error "ArgumentException: value is not a table.";
    elseif #value > 32 then
        error "OverflowException: value is more than 32 bit value.";
    end

    local Bit32Result = value;
    local isNegative = false;

    if #value == 32 and value[1] == 1 then
        isNegative = true;

        -- Two's complement.
        local index = 32;

        while index > 0 do
            if Bit32Result[index] == 0 then
                Bit32Result[index] = 1;
            else
                Bit32Result[index] = 0;
            end

            index = index - 1;
        end

        -- Add 1 to the bits.
        index = 32;
        local shouldContinueFlipping = true;

        while index > 0 do
            if Bit32Result[index] == 0 then
                Bit32Result[index] = 1;
                shouldContinueFlipping = false;
            else
                Bit32Result[index] = 0;
            end

            if not shouldContinueFlipping then
                break;
            else
                index = index - 1;
            end
        end
    end

    local index = #Bit32Result;
    local result = 0;

    while index > 0 do
        if Bit32Result[index] == 1 then
            result = result + (2^(#Bit32Result - index));
        end

        index = index - 1;
    end

    if isNegative then
        return result * -1;
    else
        return result;
    end
end

--- Shorten binary bits representation in a table form.
-- @param value table containing binary bits to shorten.
-- @return Binary bits of the value without padded zeros in table form.
function TDTModAPI_System_Bitwise.TrimZeros(value)
    if value == nil then
        error "ArgumentNullException: value is null.";
    elseif type(value) ~= "table" then
        error "ArgumentException: value is not a table.";
    end

    local index = 1;
    local maxIndex = #value;
    local result = {};
    local ignore = true;

    while index <= maxIndex do
        if value[index] == 1 then
            ignore = false;
        end

        if not ignore then
            table.insert(result, value[index]);
        end

        index = index + 1;
    end

    if #result == 0 then
        return { 0 };
    else
        return result;
    end
end

return TDTModAPI_System_Bitwise;