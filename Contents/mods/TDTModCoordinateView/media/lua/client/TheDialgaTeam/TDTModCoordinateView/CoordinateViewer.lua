-- =============================================================================
-- COORDINATE VIEWER
-- by RoboMat & Turbotutone
-- 
-- Created: 07.08.13 - 21:31
--
-- Not my most elegant code, but it works :D
-- =============================================================================

local version = "0.7.2";
local author = "RoboMat & Turbotutone & Mist";
local modName = "Coordinate Viewer(Mist)";

local FONT_SMALL = UIFont.Medium;
local T_MANAGER = getTextManager();

local SCREEN_X = 20;
local SCREEN_Y = 350;

local flag = true;
local floor = math.floor;
local print = print;

local mouseX = 0;
local mouseY = 0;

-- ------------------------------------------------
-- Functions
-- ------------------------------------------------
---
-- Prints out the mod info on startup and initializes a new
-- trait.
local function initInfo()
	print("Mod Loaded: " .. modName .. " by " .. author .. " (v" .. version .. ")");
end

---
-- Checks if the P key is pressed to activate / deactivate the
-- debug menu.
-- @param _key - The key which was pressed by the player.
--
local function checkKey(_key)
	local key = _key;
	if key == 25 then
		flag = not flag; -- reverse flag
	end
end

---
-- Round up if decimal is higher than 0.5 and down if it is smaller.
-- @param _num
--
local function round(_num)
	local number = _num;
	return number <= 0 and floor(number) or floor(number + 0.5);
end

---
-- Creates a small overlay UI that shows debug info if the
-- P key is pressed.
local function showDebugger()
	local player = getSpecificPlayer(0);

	if player and flag then
		-- Absolute Coordinates.
		local absX = player:getX();
		local absY = player:getY();

		-- Relative Coordinates.
		local cellX = absX / 300;
		local cellY = absY / 300;
		local locX = absX % 300;
		local locY = absY % 300;

		-- Detect room.
		local currentSquare = player:getCurrentSquare();
		local roomTxt = "outside";
		
		if currentSquare ~= nil then
			local room = currentSquare:getRoom();
			
			if room then
				local roomName = player:getCurrentSquare():getRoom():getName();
				roomTxt = roomName;
			end
		end

		local strings = {
			"You are here:",
			"X: " .. round(absX),
			"Y: " .. round(absY),
			"",
			"",
			"Current Room: " .. roomTxt,
			"",
		};

		local txt;
		for i = 1, #strings do
			txt = strings[i];
			T_MANAGER:DrawString(FONT_SMALL, SCREEN_X, SCREEN_Y + (i * 10), txt, 1, 1, 1, 1);
		end
	end
end


---
-- @param x
-- @param y
--
local function readTile(_x, _y)
	mouseX, mouseY = ISCoordConversion.ToWorld(getMouseX(), getMouseY(), 0);
	mouseX = round(mouseX);
	mouseY = round(mouseY);

	local cell = getWorld():getCell();
	local sq = cell:getGridSquare(mouseX, mouseY, 0);
	
	if sq then
		local sqModData = sq:getModData();

		print("=====================================================");
		print("MODDATA SQUARE: ", mouseX, mouseY, "Params: ", _x, _y);
		for k, v in pairs(sqModData) do
			print(k, v);
		end
		local objs = sq:getObjects();
		local objs_size = objs:size();
		print("OBJECTS FOUND: ", objs_size - 1, "real", objs_size)
		if objs_size > 0 then
			for i = 0, objs_size - 1, 1 do
				print(" " .. tostring(i) .. "-", objs:get(i));
				if objs:get(i):getName() then
					print("  - ", objs:get(i):getName());
				else
					print("  - ", "unknown");
				end
			end
		end
		print("=====================================================");
	end
end


Events.OnKeyPressed.Add(checkKey);
Events.OnPostUIDraw.Add(showDebugger);

Events.OnGameBoot.Add(initInfo);
