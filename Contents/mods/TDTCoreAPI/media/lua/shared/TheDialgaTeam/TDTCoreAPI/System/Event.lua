--- @class TheDialgaTeam.TDTCoreAPI.System.Event @Events enable a class or object to notify other classes or objects when something of interest occurs. The class that sends (or raises) the event is called the publisher and the classes that receive (or handle) the event are called subscribers.
--- @field __eventFunctions @Event subscribers.
local TDTCoreAPI_System_Event = {};

--- Create a new event object.
--- @return TheDialgaTeam.TDTCoreAPI.System.Event @A new object that handles an event.
function TDTCoreAPI_System_Event.new()
    local o = {};
    o.__eventFunctions = {};
    setmetatable(o, { __index = TDTCoreAPI_System_Event });
    return o;
end

--- Subscribe to this event.
--- @param luaFunction function @A function to subscribe to this event.
function TDTCoreAPI_System_Event:Add(luaFunction)
    table.insert(self.__eventFunctions, luaFunction);
end

--- Unsubscribe from this event.
--- @param luaFunction function @A function that has subscribed to this event.
function TDTCoreAPI_System_Event:Remove(luaFunction)
    for i, v in ipairs(self.__eventFunctions) do
        if v == luaFunction then
            table.remove(self.__eventFunctions, i);
            break;
        end
    end
end

--- Invoke this event with 5 parameters.
--- @overload fun():void @Invoke this event.
--- @overload fun(param:any):void @Invoke this event with 1 parameter.
--- @overload fun(param:any, param2:any):void @Invoke this event with 2 parameters.
--- @overload fun(param:any, param2:any, param3:any):void @Invoke this event with 3 parameters.
--- @overload fun(param:any, param2:any, param3:any, param4:any):void @Invoke this event with 4 parameters.
--- @param param any @Parameter 1.
--- @param param2 any @Parameter 2.
--- @param param3 any @Parameter 3.
--- @param param4 any @Parameter 4.
--- @param param5 any @Parameter 5.
function TDTCoreAPI_System_Event:Invoke(param, param2, param3, param4, param5)
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

    for i, v in ipairs(self.__eventFunc) do
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

return TDTCoreAPI_System_Event;