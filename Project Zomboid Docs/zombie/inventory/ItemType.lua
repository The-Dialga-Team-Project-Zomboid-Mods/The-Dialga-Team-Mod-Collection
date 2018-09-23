--- @class zombie.inventory.ItemType
--- @field None number
--- @field Weapon number
--- @field Food number
--- @field Literature number
--- @field Drainable number
--- @field Clothing number
--- @field Key number
--- @field KeyRing number
--- @field Moveable number
--- @field AlarmClock number
local ItemType = {};

ItemType.None = 0;
ItemType.Weapon = 1;
ItemType.Food = 2;
ItemType.Literature = 3;
ItemType.Drainable = 4;
ItemType.Clothing = 5;
ItemType.Key = 6;
ItemType.KeyRing = 7;
ItemType.Moveable = 8;
ItemType.AlarmClock = 9;

--- @param value number
--- @return zombie.inventory.ItemType
function ItemType.fromIndex(value) end

--- @return number
function ItemType:index() end

--- @param value string
--- @return zombie.inventory.ItemType
function ItemType.valueOf(value) end

--- @return zombie.inventory.ItemType[]
function ItemType.values() end