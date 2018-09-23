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

local font = UIFont.Medium;
local textManager = getTextManager();

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

		-- Detect room.
		local currentSquare = player:getCurrentSquare();
		local roomTxt = "outside";
		
		if currentSquare ~= nil then
			local room = currentSquare:getRoom();
			
			if room then
				roomTxt = player:getCurrentSquare():getRoom():getName();
			end
		end

		local strings = {
			"You are here:",
			"X: " .. round(absX),
			"Y: " .. round(absY),
			"",
			"Current Room: " .. roomTxt,
		};

		local txt;
		for i = 1, #strings do
			txt = strings[i];
			textManager:DrawString(font, SCREEN_X, SCREEN_Y + (i * textManager:getFontFromEnum(font):getLineHeight()), txt, 1, 1, 1, 1);
		end
	end
end

Events.OnKeyPressed.Add(checkKey);
Events.OnPostUIDraw.Add(showDebugger);
Events.OnGameBoot.Add(initInfo);