--- @type TheDialgaTeam.TDTModAPI.Lua.Assert
local Assert = require "TheDialgaTeam/TDTModAPI/Lua/Assert";

--- @class TheDialgaTeam.TDTModAPI.Event
local TDTModAPI_Event = {};

--- Create a new instance of this event.
--- @return TheDialgaTeam.TDTModAPI.Event.Instance A new instance of this event.
function TDTModAPI_Event.new()
    --- @class TheDialgaTeam.TDTModAPI.Event.Instance
    local self = {};

    --- @type function[]
    self.__EventFunc = {};

    --- Subscribe to this specified event.
    --- @param luaFunction function Function to fire when this event invoke.
    function self:Add(luaFunction)
        local status, error = pcall(function ()
            Assert.AssertFunction(luaFunction, "luaFunction");
        end);

        if status then
            table.insert(self.__EventFunc, luaFunction);
        else
            print(error);
        end
    end

    --- Unsubscribe to this specified event.
    --- @param luaFunction function Function that fire this event.
    function self:Remove(luaFunction)
        local status, error = pcall(function ()
            Assert.AssertFunction(luaFunction, "luaFunction");
        end);

        if status then
            for i, v in ipairs(self.__EventFunc) do
                if v == luaFunction then
                    table.remove(self.__EventFunc, i);
                    break;
                end
            end
        else
            print(error);
        end
    end

    --- Fire this specified event with parameters.
    --- @overload fun():void
    --- @overload fun(param:any):void
    --- @overload fun(param:any, param2:any):void
    --- @overload fun(param:any, param2:any, param3:any):void
    --- @overload fun(param:any, param2:any, param3:any, param4:any):void
    --- @overload fun(param:any, param2:any, param3:any, param4:any, param5:any):void
    --- @param param any Parameter 1.
    --- @param param2 any Parameter 2.
    --- @param param3 any Parameter 3.
    --- @param param4 any Parameter 4.
    --- @param param5 any Parameter 5.
    function self:Invoke(param, param2, param3, param4, param5)
        local numberOfParams = 5;

        if param5 == nil then
            numberOfParams = numberOfParams - 1;
            if param4 == nil then
                numberOfParams = numberOfParams - 1;
                if param3 == nil then
                    numberOfParams = numberOfParams - 1;
                    if param2 == nil then
                        numberOfParams = numberOfParams - 1;
                        if param == nil then
                            numberOfParams = numberOfParams - 1;
                        end
                    end
                end
            end
        end

        for i, v in ipairs(self.__EventFunc) do
            if numberOfParams == 0 then
                v();
            elseif numberOfParams == 1 then
                v(param);
            elseif numberOfParams == 2 then
                v(param, param2);
            elseif numberOfParams == 3 then
                v(param, param2, param3);
            elseif numberOfParams == 4 then
                v(param, param2, param3, param4);
            elseif numberOfParams == 5 then
                v(param, param2, param3, param4, param5);
            end
        end
    end

    return self;
end

return TDTModAPI_Event;