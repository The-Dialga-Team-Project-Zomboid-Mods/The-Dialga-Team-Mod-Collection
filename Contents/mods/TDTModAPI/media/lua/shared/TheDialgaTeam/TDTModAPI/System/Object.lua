--- @class TheDialgaTeam.TDTModAPI.System.Object
local TDTModAPI_System_Object = {};

--- Initializes a new instance of the Object class.
--- @return TheDialgaTeam.TDTModAPI.System.Object.Instance A new instance of the Object class.
function TDTModAPI_System_Object.new()
    --- @class TheDialgaTeam.TDTModAPI.System.Object.Instance
    local self = {};

    self.__Type = "TheDialgaTeam.TDTModAPI.System.Object";

    --- Determines whether the specified object is equal to the current object.
    --- @param obj TheDialgaTeam.TDTModAPI.System.Object.Instance The object to compare with the current object.
    --- @return boolean true if the specified object  is equal to the current object; otherwise, false.
    function self:Equals(obj)
        return self == obj;
    end

    --- Returns a string that represents the current object.
    --- @return string A string that represents the current object.
    function self:ToString()
        return self.__Type;
    end

    setmetatable(self, {
        __tostring = function (table)
            return table:ToString();
        end,

        __eq = function(obj, obj2)
            return obj:Equals(obj2);
        end
    });

    return self;
end

--- Determines whether the specified object instances are considered equal.
--- @param objA any The first object to compare.
--- @param objB any The second object to compare.
--- @return boolean true if the specified object  is equal to the current object; otherwise, false.
function TDTModAPI_System_Object.Equals(objA, objB)
    return objA == objB;
end

return TDTModAPI_System_Object;