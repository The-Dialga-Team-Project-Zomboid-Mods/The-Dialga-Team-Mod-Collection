--- @class zombie.characters.IsoPlayer
local IsoPlayer = {};

--- @overload fun(cell:zombie.iso.IsoCell):zombie.characters.IsoPlayer
--- @param cell zombie.iso.IsoCell
--- @param desc zombie.characters.SurvivorDesc
--- @param x number
--- @param y number
--- @param z number
--- @return zombie.characters.IsoPlayer
function IsoPlayer.new(cell, desc, x, y, z) end

--- @return boolean
function IsoPlayer:AttemptAttack() end

function IsoPlayer:Bitten() end

function IsoPlayer:CalculateAim() end

--- @overload fun(chargeDelta:number):boolean
--- @param chargeDelta number
--- @param forceShove boolean
--- @param clickSound string
--- @return boolean
function IsoPlayer:DoAttack(chargeDelta, forceShove, clickSound) end

--- @overload fun():boolean
--- @param str string
--- @param expected string
--- @return boolean
function IsoPlayer.DoChecksumCheck(str, expected) end

function IsoPlayer:InitSpriteParts() end

--- @return boolean
function IsoPlayer:IsAiming() end

--- @return boolean
function IsoPlayer:IsRunning() end

--- @return boolean
function IsoPlayer:IsSneaking() end

--- @return boolean
function IsoPlayer:IsUsingAimWeapon() end

function IsoPlayer:OnDeath() end

function IsoPlayer:Scratched() end

--- @param chr zombie.iso.IsoMovingObject
function IsoPlayer:TestZombieSpotPlayer(chr) end

--- @param itemid string
--- @param part zombie.vehicles.VehiclePart
--- @param milli number
function IsoPlayer:addMechanicsItem(itemid, part, milli) end

--- @deprecated
function IsoPlayer:addSmallInjuries() end

--- @return boolean
function IsoPlayer.allPlayersAsleep() end

--- @return boolean
function IsoPlayer.allPlayersDead() end

function IsoPlayer:calculateContext() end

--- @return boolean
function IsoPlayer:canSeePlayerStats() end

--- @param obj zombie.iso.IsoObject
--- @deprecated
function IsoPlayer:collideWith(obj) end

--- @param filename string
--- @return number[]
function IsoPlayer.createChecksum(filename) end

--- @param b zombie.core.network.ByteBufferWriter
--- @param adminUsername string
--- @return zombie.core.network.ByteBufferWriter
function IsoPlayer:createPlayerStats(b, adminUsername) end

