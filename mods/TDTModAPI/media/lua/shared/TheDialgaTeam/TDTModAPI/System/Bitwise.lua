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