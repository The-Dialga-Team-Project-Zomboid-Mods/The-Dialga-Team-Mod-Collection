--- @param sq zombie.iso.IsoGridSquare
--- @param radius number
--- @deprecated
function AddNoiseToken(sq, radius) end

--- @param player zombie.characters.IsoPlayer
--- @param radius number
function AddWorldSound(player, radius) end

--- @param itemId number
--- @param itemType string
--- @param player zombie.characters.IsoPlayer
function InvMngGetItem(itemId, itemType, player) end

--- @param itemId number
--- @param player zombie.characters.IsoPlayer
function InvMngRemoveItem(itemId, player) end

--- @param command string
function SendCommandToServer(command) end

--- @param player zombie.character.IsoPlayer
function SyncXp(player) end

--- @overload fun(max:number):number
--- @param min number
--- @param max number
--- @return number
function ZombRand(min, max) end

--- @param min number
--- @param max number
--- @return number
function ZombRandBetween(min, max) end

--- @param min number
--- @param max number
--- @return number
function ZombRandFloat(min, max) end

--- @param faction zombie.characters.Faction
--- @param host string
function acceptFactionInvite(faction, host) end

--- @param you zombie.character.IsoPlayer
--- @param other zombie.character.IsoPlayer
--- @param accept boolean
function acceptTrading(you, other, accept) end

--- @param url string
function activateSteamOverlayToWebPage(url) end

function activateSteamOverlayToWorkshop() end

--- @param itemID string
function activateSteamOverlayToWorkshopItem(itemID) end

function activateSteamOverlayToWorkshopUser() end

function addAllVehicles() end

function addCarCrash() end

--- @param player zombie.character.IsoPlayer
function addLevelUpPoint(player) end

--- @return zombie.vehicles.BaseVehicle
function addPhysicsObject() end

--- @param source zombie.iso.IsoObject
--- @param x number
--- @param y number
--- @param z number
--- @param radius number
--- @param volume number
function addSound(source, x, y, z, radius, volume) end

--- @param author string
--- @param message string
--- @param ticketID number
function addTicket(author, message, ticketID) end

--- @param user string
--- @param type string
--- @param text string
function addUserlog(user, type, text) end

--- @param script string
--- @return zombie.vehicles.BaseVehicle
function addVehicle(script) end

--- @param x number
--- @param y number
function addVirtualZombie(x, y) end

--- @param user string
--- @param reason string
--- @param amount number
function addWarningPoint(user, reason, amount) end

function assaultPlayer() end

function backToSinglePlayer() end

function breakpoint() end

--- @return boolean
function canInviteFriends() end

--- @return boolean
function canModifyPlayerScoreboard() end

--- @return boolean
function canModifyPlayerStats() end

--- @return boolean
function canSeePlayerStats() end

--- @param f string
--- @return boolean
function checkSaveFileExists(f) end

--- @param f string
--- @return boolean
function checkSaveFolderExists(f) end

--- @param newName string
--- @param oldName string
--- @return zombie.scripting.objects.Item
function cloneItemType(newName, oldName) end

--- @param darkStep number
function configureLighting(darkStep) end

--- @param button string
function connectToServerStateCallback(button) end

--- @param table table
--- @return table
function copyTable(table) end

--- @param spawnX number
--- @param spawnY number
--- @param targetX number
--- @param targetY number
--- @param count number
function createHordeFromTo(spawnX, spawnY, targetX, targetY, count) end

--- @param spawnX number
--- @param spawnY number
--- @param spawnW number
--- @param spawnH number
--- @param targetX number
--- @param targetY number
--- @param count number
function createHordeInAreaTo(spawnX, spawnY, spawnW, spawnH, targetX, targetY, count) end

--- @param base string
--- @param name string
--- @param display string
--- @param type string
--- @param icon string
--- @return zombie.scripting.objects.Item
function createNewScriptItem(base, name, display, type, icon) end

--- @return table
function createRegionFile() end

--- @param storyName string
function createStory(storyName) end

--- @param tile string
--- @param square zombie.iso.IsoGridSquare
function createTile(tile, square) end

--- @param worldName string
function createWorld(worldName) end

--- @param x number
--- @param y number
--- @param z number
--- @param desc zombie.characters.SurvivorDesc
--- @param palette number
--- @param dir zombie.iso.IsoDirections
--- @return zombie.characters.IsoZombie
function createZombie(x, y, z, desc, palette, dir) end

--- @param x number
--- @param y number
function debugFullyStreamedIn(x, y) end

--- @overload fun(param:any)
--- @param param any
--- @param depth number
function debugLuaTable(param, depth) end

--- @param gameMode string
function deleteAllGameModeSaves(gameMode) end

--- @param fileName string
function deletePlayerSave(fileName) end

--- @param name string
function deleteSandboxPreset(name) end

--- @param file string
function deleteSave(file) end

function disconnect() end

--- @param challenge table
function doChallenge(challenge) end

--- @param doIt boolean
function doKeyPress(doIt) end

--- @param tutorial table
function doTutorial(tutorial) end

--- @param ui zombie.ui.UIElement
--- @param zoom number
--- @param xpos number
--- @param ypos number
function drawOverheadMap(ui, zoom, xpos, ypos) end

function endFileInput() end

function endFileOutput() end

function endTextFileInput() end

--- @param query string
function executeQuery(query) end

--- @param filename string
--- @return boolean
function fileExists(filename) end

--- @param state zombie.gameStates.GameState
function forceChangeState(state) end

function forceDisconnect() end

function forceSnowCheck() end

--- @param f string
--- @return string
function getAbsoluteSaveFolderName(f) end

--- @return string
function getAccessLevel() end

--- @return java.util.ArrayList<String>
function getActivatedMods() end

--- @return java.util.ArrayList<Recipe>
function getAllRecipes() end

--- @return java.util.List<BufferedReader>
function getAllSavedPlayers() end

--- @return zombie.BaseAmbientStreamManager
function getAmbientStreamManager() end

--- @param joypad number
--- @return number
function getButtonCount(joypad) end

--- @param c coroutine
--- @return number
function getCallframeTop(c) end

--- @return number
function getCameraOffX() end

--- @return number
function getCameraOffY() end

--- @return zombie.iso.IsoCell
function getCell() end

--- @param o any
--- @param i number
--- @return java.lang.reflect.Field
function getClassField(o, i) end

--- @param o any
--- @param field java.lang.reflect.Field
--- @return any
function getClassFieldVal(o, field) end

--- @param o any
--- @param i number
--- @return java.lang.reflect.Method
function getClassFunction(o, i) end

--- @return string
function getClientUsername() end

--- @return java.util.ArrayList<zombie.characters.IsoPlayer>
function getConnectedPlayers() end

--- @param c number
--- @return number
function getControllerAxisCount(c) end

--- @param c number
--- @param axis number
--- @return number
function getControllerAxisValue(c, axis) end

--- @param c number
--- @return number
function getControllerButtonCount(c) end

--- @return number
function getControllerCount() end

--- @param c number
--- @param axis number
--- @return number
function getControllerDeadZone(c, axis) end

--- @param joypad number
--- @return string
function getControllerName(joypad) end

--- @param c number
--- @return number
function getControllerPovX(c) end

--- @param c number
--- @return number
function getControllerPovY(c) end

--- @return zombie.core.Core
function getCore() end

--- @param c coroutine
--- @param n number
--- @return se.krka.kahlua.vm.LuaCallFrame
function getCoroutineCallframeStack(c, n) end

--- @param c coroutine
--- @param n number
--- @return any
function getCoroutineObjStack(c, n) end

--- @param c coroutine
--- @param n number
--- @return any
function getCoroutineObjStackWithBase(c, n) end

--- @param c coroutine
--- @return number
function getCoroutineTop(c) end

--- @return coroutine
function getCurrentCoroutine() end

--- @return string
function getCurrentUserProfileName() end

--- @return string
function getCurrentUserSteamID() end

function getDBSchema() end

--- @return boolean
function getDebug() end

--- @return zombie.debug.DebugOptions
function getDebugOptions() end

--- @param chara zombie.characters.IsoGameCharacter
--- @param objTarget zombie.iso.IsoObject
--- @return zombie.iso.IsoDirections
function getDirectionTo(chara, objTarget) end

--- @return java.util.Stack<zombie.scripting.objects.EvolvedRecipe>
function getEvolvedRecipes() end

--- @return fmod.fmod.BaseSoundBank
function getFMODSoundBank() end

--- @param filename string
--- @return java.io.DataInputStream
function getFileInput(filename) end

--- @param filename string
--- @return java.io.DataOutputStream
function getFileOutput(filename) end

--- @param filename string
--- @param createIfNull boolean
--- @return java.io.BufferedReader
function getFileReader(filename, createIfNull) end

--- @return string
function getFileSeparator() end

--- @param filename string
--- @param createIfNull boolean
--- @param append boolean
--- @return zombie.Lua.LuaFileWriter
function getFileWriter(filename, createIfNull, append) end

--- @param c se.krka.kahlua.vm.LuaCallFrame
--- @return string
function getFilenameOfCallframe(c) end

--- @param c se.krka.kahlua.vm.LuaClosure
--- @return string
function getFilenameOfClosure(c) end

--- @param c se.krka.kahlua.vm.LuaClosure
--- @return number
function getFirstLineOfClosure(c) end

--- @return table
function getFriendsList() end

--- @return table
function getFullSaveDirectoryTable() end

--- @return zombie.network.GameClient
function getGameClient() end

--- @param filename string
--- @return java.io.DataInputStream
function getGameFilesInput(filename) end

--- @param filename string
--- @return java.io.BufferedReader
function getGameFilesTextInput(filename) end

--- @return number
function getGameSpeed() end

--- @return zombie.GameTime
function getGameTime() end

--- @return number
function getGametimeTimestamp() end

--- @return string
function getHourMinute() end

--- @param txt string
--- @return string
function getItemText(txt) end

--- @param joypad number
--- @return number
function getJoypadAButton(joypad) end

--- @param joypad number
--- @return number
function getJoypadAimingAxisX(joypad) end

--- @param joypad number
--- @return number
function getJoypadAimingAxisY(joypad) end

--- @param joypad number
--- @return number
function getJoypadBButton(joypad) end

--- @param joypad number
--- @return number
function getJoypadBackButton(joypad) end

--- @param joypad number
--- @return number
function getJoypadLBumper(joypad) end

--- @param joypad number
--- @return number
function getJoypadMovementAxisX(joypad) end

--- @param joypad number
--- @return number
function getJoypadMovementAxisY(joypad) end

--- @param joypad number
--- @return number
function getJoypadRBumper(joypad) end

--- @param joypad number
--- @return number
function getJoypadStartButton(joypad) end

--- @param joypad number
--- @return number
function getJoypadXButton(joypad) end

--- @param joypad number
--- @return number
function getJoypadYButton(joypad) end

--- @param filename string
--- @return string
function getLastPlayedDate(filename) end

--- @return table
function getLatestSave() end

--- @param c se.krka.kahlua.vm.LuaCallFrame
--- @return number
function getLineNumber(c) end

--- @param command string
--- @return string
function getListOfCommands(command) end

--- @param n number
--- @return string
function getLoadedLua(n) end

--- @return number
function getLoadedLuaCount() end

--- @param c coroutine
--- @return number
function getLocalVarCount(c) end

--- @param c coroutine
--- @param n number
--- @return string
function getLocalVarName(c, n) end

--- @param c coroutine
--- @param n number
--- @return number
function getLocalVarStack(c, n) end

--- @return java.util.ArrayList<string>
function getLotDirectories() end

--- @return table
function getMapDirectoryTable() end

--- @param modId string
--- @return java.util.ArrayList<string>
function getMapFoldersForMod(modId) end

--- @param mapDir string
--- @return table
function getMapInfo(mapDir) end

--- @return number
function getMaxActivePlayers() end

--- @param o java.lang.reflect.Method
--- @param i number
--- @return string
function getMethodParameter(o, i) end

--- @param o java.lang.reflect.Method
--- @return number
function getMethodParameterCount(o) end

--- @return table
function getModDirectoryTable() end

--- @param modId string
--- @param filename string
--- @param createIfNull boolean
--- @return java.io.BufferedReader
function getModFileReader(modId, filename, createIfNull) end

--- @param modId string
--- @param filename string
--- @param createIfNull boolean
--- @param append boolean
--- @return zombie.Lua.LuaFileWriter
function getModFileWriter(modId, filename, createIfNull, append) end

--- @param modDir string
--- @return zombie.gameStates.ChooseGameInfo.Mod
function getModInfo(modDir) end

--- @param modId string
--- @return zombie.gameStates.ChooseGameInfo.Mod
function getModInfoByID(modId) end

--- @return java.util.List<string>
function getMods() end

--- @return number
function getMouseX() end

--- @return number
function getMouseXScaled() end

--- @return number
function getMouseY() end

--- @return number
function getMouseYScaled() end

--- @return string
function getMyDocumentFolder() end

--- @return number
function getNumActivePlayers() end

--- @param o any
--- @return number
function getNumClassFields(o) end

--- @param o any
--- @return number
function getNumClassFunctions(o) end

--- @return java.util.ArrayList<zombie.characters.IsoPlayer>
function getOnlinePlayers() end

--- @return string
function getOnlineUsername() end

--- @param category number
--- @return table
function getPacketCounts(category) end

--- @return zombie.core.PerformanceSettings
function getPerformance() end

--- @return zombie.characters.IsoPlayer
function getPlayer() end

--- @param id number
--- @return zombie.characters.IsoPlayer
function getPlayerByOnlineID(id) end

--- @param username string
--- @return zombie.characters.IsoPlayer
function getPlayerFromUsername(username) end

--- @param player number
--- @return number
function getPlayerScreenHeight(player) end

--- @param player number
--- @return number
function getPlayerScreenLeft(player) end

--- @param player number
--- @return number
function getPlayerScreenTop(player) end

--- @param player number
--- @return number
function getPlayerScreenWidth(player) end

--- @return table
function getPublicServersList() end

--- @return zombie.radio.RadioAPI
function getRadioAPI() end

--- @param language zombie.core.Language
--- @return java.util.ArrayList<string>
function getRadioTranslators(language) end

--- @return string
function getRandomUUID() end

--- @param name string
--- @return string
function getRecipeDisplayName(name) end

--- @return zombie.core.SpriteRenderer
function getRenderer() end

--- @return zombie.radio.StorySounds.SLSoundManager
--- @deprecated
function getSLSoundManager() end

--- @param filename string
--- @param createIfNull boolean
--- @param append boolean
--- @return zombie.Lua.LuaFileWriter
function getSandboxFileWriter(filename, createIfNull, append) end

--- @return zombie.SandboxOptions
function getSandboxOptions() end

--- @return java.util.List<string>
function getSandboxPresets() end

--- @param folder string
--- @return java.util.ArrayList<java.io.File>
function getSaveDirectory(folder) end

--- @return table
function getSaveDirectoryTable() end

--- @param saveDir string
--- @return table
function getSaveInfo(saveDir) end

--- @param file java.io.File
--- @return string
function getSaveName(file) end

--- @return zombie.scripting.ScriptManager
function getScriptManager() end

--- @return string
function getServerAddressFromArgs() end

--- @return table
function getServerList() end

--- @return string
function getServerListFile() end

--- @deprecated
function getServerModData() end

--- @return string
function getServerName() end

--- @return zombie.network.ServerOptions
function getServerOptions() end

--- @return string
function getServerPasswordFromArgs() end

--- @param saveFolder string
--- @return number
function getServerSavedWorldVersion(saveFolder) end

--- @return zombie.network.ServerSettingsManager
function getServerSettingsManager() end

--- @return table
function getServerSpawnRegions() end

--- @param str string
--- @return string
function getShortenedFilename(str) end

--- @return zombie.ai.sadisticAIDirector.SleepingEvent
function getSleepingEvent() end

--- @return zombie.BaseSoundManager
function getSoundManager() end

--- @param player number
--- @return zombie.characters.IsoPlayer
function getSpecificPlayer(player) end

--- @param sprite string
--- @return zombie.iso.sprite.IsoSprite
function getSprite(sprite) end

--- @param steamID string
--- @return zombie.core.textures.Texture
function getSteamAvatarFromSteamID(steamID) end

--- @param username string
--- @return zombie.core.textures.Texture
function getSteamAvatarFromUsername(username) end

--- @param username string
--- @return string
function getSteamIDFromUsername(username) end

--- @return boolean
function getSteamModeActive() end

--- @param steamID string
--- @return string
function getSteamProfileNameFromSteamID(steamID) end

--- @param username string
--- @return string
function getSteamProfileNameFromUsername(username) end

--- @return boolean
function getSteamScoreboard() end

--- @return java.util.ArrayList<string>
function getSteamWorkshopItemIDs() end

--- @return java.util.ArrayList<zombie.gameStates.ChooseGameInfo.Mod>
function getSteamWorkshopItemMods(itemIdStr) end

--- @return java.util.ArrayList<zombie.core.znet.SteamWorkshopItem>
function getSteamWorkshopStagedItems() end

--- @return java.util.List<string>
function getStories() end

--- @return table
function getStoryDirectoryTable() end

--- @param storyName string
--- @return zombie.gameStates.ChooseGameInfo.Story
function getStoryInfo(storyName) end

--- @return table
function getStorySavedTable() end

--- @param tableName string
--- @param numberPerPages number
function getTableResult(tableName, numberPerPages) end

--- @param txt string
--- @param ... any
--- @return string
function getText(txt, ...) end

--- @return zombie.ui.TextManager
function getTextManager() end

--- @param txt string
--- @param ... any
--- @return string
function getTextOrNull(txt, ...) end

--- @param filename string
--- @return zombie.core.textures.Texture
function getTexture(filename) end

--- @param filename string
--- @param saveName string
--- @return zombie.core.textures.Texture
function getTextureFromSaveDir(filename, saveName) end

--- @param author string
function getTickets(author) end

--- @return number
function getTimeInMillis() end

--- @return number
function getTimestamp() end

--- @return number
function getTimestampMs() end

--- @param url string
--- @return java.io.DataInputStream
function getUrlInputStream(url) end

--- @param id number
--- @return zombie.vehicles.BaseVehicle
function getVehicleById(id) end

--- @param vehicle zombie.vehicles.BaseVehicle
--- @return table
function getVehicleInfo(vehicle) end

--- @return zombie.iso.IsoWorld
function getWorld() end

--- @return zombie.WorldSoundManager
function getWorldSoundManager() end

--- @return zombie.radio.ZomboidRadio
function getZomboidRadio() end

--- @param x number
--- @param y number
--- @param z number
--- @return zombie.iso.IsoMetaGrid.Zone
function getZone(x, y, z) end

--- @param x number
--- @param y number
--- @param z number
--- @return java.util.ArrayList<zombie.iso.IsoMetaGrid.Zone>
function getZones(x, y, z) end

--- @param file string
--- @param line number
--- @return boolean
function hasBreakpoint(file, line) end

--- @param table table
--- @param key any
--- @return boolean
function hasDataBreakpoint(table, key) end

--- @param table table
--- @param key any
--- @return boolean
function hasDataReadBreakpoint(table, key) end

function initUISystem() end

--- @param item string|zombie.scripting.objects.Item
--- @return zombie.inventory.InventoryItem
function instanceItem(item) end

--- @param obj any
--- @param name string
--- @return boolean
function instanceof(obj, name) end

--- @param steamID string
function inviteFriend(steamID) end

--- @return boolean
function is64bit() end

--- @param accessLevel string
--- @return boolean
function isAccessLevel(accessLevel) end

--- @return boolean
function isAdmin() end

--- @return boolean
function isClient() end

--- @return boolean
function isCoopHost() end

--- @return boolean
function isCtrlKeyDown() end

--- @param file string
--- @param line number
--- @return boolean
function isCurrentExecutionPoint(file, line) end

--- @return boolean
function isDebugEnabled() end

--- @return boolean
function isDemo() end

--- @return boolean
function isIngameState() end

--- @param joypad number
--- @return boolean
function isJoypadDown(joypad) end

--- @param joypad number
--- @return boolean
function isJoypadLeft(joypad) end

--- @param joypad number
--- @param button number
--- @return boolean
function isJoypadPressed(joypad, button) end

--- @param joypad number
--- @return boolean
function isJoypadRight(joypad) end

--- @param joypad number
--- @return boolean
function isJoypadUp(joypad) end

--- @param key number
--- @return boolean
function isKeyDown(key) end

--- @param mod zombie.gameStates.ChooseGameInfo.Mod
--- @return boolean
function isModActive(mod) end

--- @param number number
--- @return boolean
function isMouseButtonDown(number) end

--- @return boolean
function isPublicServerListAllowed() end

--- @return boolean
function isServer() end

--- @return boolean
function isShiftKeyDown() end

--- @param sound any
--- @return boolean
function isSoundPlaying(sound) end

--- @return boolean
function isSteamOverlayEnabled() end

--- @param obj any
--- @param name string
--- @return boolean
function isType(obj, name) end

--- @param s string
--- @return boolean
function isValidSteamID(s) end

--- @param user string
--- @return boolean
function isValidUserName(user) end

--- @return boolean
function isXBOXController() end

--- @param player number
--- @param x number
--- @param y number
--- @param z number
--- @return number
function isoToScreenX(player, x, y, z) end

--- @param player number
--- @param x number
--- @param y number
--- @param z number
--- @return number
function isoToScreenY(player, x, y, z) end

--- @param name string
--- @param loc string
--- @param tex string
--- @return zombie.core.skinnedmodel.model.Model
function loadSkinnedZomboidModel(name, loc, tex) end

--- @param name string
--- @param loc string
--- @param tex string
--- @return zombie.core.skinnedmodel.model.Model
function loadStaticZomboidModel(name, loc, tex) end

--- @param name string
--- @param loc string
--- @param tex string
--- @param bStatic boolean
--- @return zombie.core.skinnedmodel.model.Model
function loadZomboidModel(name, loc, tex, bStatic) end

--- @param c coroutine
--- @param n number
--- @return string
function localVarName(c, n) end

--- @param x number
--- @param y number
function navigateMouseMove(x, y) end

--- @param url string
function openURl(url) end

function pauseSoundAndMusic() end

--- @param username string
--- @param pwd string
--- @param ip string
--- @param port string
function ping(username, pwd, ip, port) end

--- @param sound string
--- @param sq zombie.iso.IsoGridSquare
function playServerSound(sound, sq) end

--- @param itemIDs java.util.ArrayList<string>
--- @param functionObj se.krka.kahlua.vm.LuaClosure
--- @param arg1 any
function querySteamWorkshopItemDetails(itemIDs, functionObj, arg1) end

--- @param cmd string
--- @param arg number
function rainConfig(cmd, arg) end

--- @return boolean
function reactivateJoypadAfterResetLua() end

function reloadControllerConfigFiles() end

--- @param filename string
function reloadLuaFile(filename) end

--- @param filename string
function reloadServerLuaFile(filename) end

--- @param scriptName string
function reloadVehicleTextures(scriptName) end

function reloadVehicles() end

--- @param ticketID number
function removeTicket(ticketID) end

--- @param user string
--- @param type string
--- @param text string
function removeUserlog(user, type, text) end

--- @param x number
--- @param y number
--- @param z number
--- @param radius number
--- @param r number
--- @param g number
--- @param b number
--- @param a number
--- @param thickness number
function renderIsoCircle(x, y, z, radius, r, g, b, a, thickness) end

--- @param toReplace string
--- @param regex string
--- @param by string
--- @return string
function replaceWith(toReplace, regex, by) end

function requestPacketCounts() end

--- @param you zombie.characters.IsoPlayer
--- @param other zombie.characters.IsoPlayer
function requestTrading(you, other) end

--- @param user string
function requestUserlog(user) end

--- @param f string
--- @return any
function require(f) end

function resetRegionFile() end

function resumeSoundAndMusic() end

--- @param worldName string
--- @return string
function sanitizeWorldName(worldName) end

--- @param doCharacter boolean
function save(doCharacter) end

--- @param c number
function saveControllerSettings(c) end

function saveGame() end

function saveModsFile() end

function scoreboardUpdate() end

--- @deprecated
function screenZoomIn() end

--- @deprecated
function screenZoomOut() end

--- @param player zombie.characters.IsoPlayer
--- @param perk zombie.characters.skills.PerkFactory.Perks
--- @param amount number
--- @param doGlobalXP boolean
--- @param onlyGlobalXP boolean
function sendAddXp(player, perk, amount, doGlobalXP, onlyGlobalXP) end

--- @param onlineID number
--- @param i number
--- @param level number
function sendAdditionalPain(onlineID, i, level) end

--- @param onlineID number
--- @param i number
--- @param bandaged boolean
--- @param bandageLife number
--- @param isAlcoholic boolean
--- @param bandageType string
function sendBandage(onlineID, i, bandaged, bandageLife, isAlcoholic, bandageType) end

--- @param onlineID number
--- @param i number
--- @param plantainFactor number
--- @param comfreyFactor number
--- @param garlicFactor number
function sendCataplasm(onlineID, i, plantainFactor, comfreyFactor, garlicFactor) end

--- @param onlineID number
--- @param i number
function sendCleanBurn(onlineID, i) end

--- @overload fun(module:string, command:string, args:table)
--- @param player zombie.characters.IsoPlayer
--- @param module string
--- @param command string
--- @param args table
function sendClientCommand(player, module, command, args) end

--- @param onlineID number
--- @param i number
--- @param level number
function sendDisinfect(onlineID, i, level) end

--- @param faction zombie.characters.Faction
--- @param host zombie.characters.IsoPlayer
--- @param invited string
function sendFactionInvite(faction, host, invited) end

--- @param sender zombie.characters.IsoPlayer
--- @param items java.util.ArrayList<zombie.inventory.InventoryItem>
--- @param receiver zombie.characters.IsoPlayer
--- @param transferID string
--- @param custom string
function sendItemListNet(sender, items, receiver, transferID, custom) end

--- @param obj zombie.iso.IsoObject
--- @param container zombie.inventory.ItemContainer
function sendItemsInContainer(obj, container) end

--- @param player zombie.characters.IsoPlayer
function sendPersonalColor(player) end

function sendPing() end

--- @param player zombie.characters.IsoPlayer
function sendPlayerStatsChange(player) end

--- @param onlineID number
--- @param i number
--- @param doctorLevel number
function sendRemoveBullet(onlineID, i, doctorLevel) end

--- @param onlineID number
--- @param i number
function sendRemoveGlass(onlineID, i) end

--- @param player zombie.characters.IsoPlayer
function sendRequestInventory(player) end

--- @overload fun(module:string, command:string, args:table)
--- @param player zombie.characters.IsoPlayer
--- @param module string
--- @param command string
--- @param args table
function sendServerCommand(player, module, command, args) end

--- @param onlineID number
--- @param i number
--- @param doIt boolean
--- @param factor number
--- @param splintItem string
function sendSplint(onlineID, i, doIt, factor, splintItem) end

--- @param onlineID number
--- @param i number
--- @param stitched boolean
--- @param stitchLevel number
function sendStitch(onlineID, i, stitched, stitchLevel) end

--- @param message string
function sendWorldMessage(message) end

--- @param onlineID number
--- @param i number
--- @param infected boolean
function sendWoundInfection(onlineID, i, infected) end

--- @param user string
--- @param pass string
--- @param server string
--- @param localIP string
--- @param port string
--- @param serverPassword string
function serverConnect(user, pass, server, localIP, port, serverPassword) end

--- @param serverSteamID string
function serverConnectCoop(serverSteamID) end

--- @param filename string
--- @return boolean
function serverFileExists(filename) end

--- @param id number
function setActivePlayer(id) end

function setAdmin() end

--- @param id number
--- @param x number
--- @param y number
function setAggroTarget(id, x, y) end

--- @param c number
--- @param axis number
--- @param value number
function setControllerDeadZone(c, axis, value) end

--- @param NewSpeed number
function setGameSpeed(NewSpeed) end

--- @param x number
--- @param y number
function setMouseXY(x, y) end

--- @param x number
--- @param y number
--- @param lshift boolean
function setNavigateXY(x, y, lshift) end

--- @param player number
--- @param joypad number
--- @param playerObj zombie.characters.IsoPlayer
--- @param username string
function setPlayerJoypad(player, joypad, playerObj, username) end

--- @param playerObj zombie.characters.IsoPlayer
function setPlayerMouse(playerObj) end

--- @param id number
--- @param bActive boolean
function setPlayerMovementActive(id, bActive) end

--- @param player zombie.characters.IsoPlayer
--- @param value number
function setProgressBarValue(player, value) end

--- @param b boolean
function setShowPausedMessage(b) end

--- @param scale number
function setVehicleModelCameraHack(scale) end

--- @param zombie.iso.IsoObject
function sledgeDestroy(object) end

--- @param x number
--- @param y number
--- @param x2 number
--- @param y2 number
--- @param z number
--- @param count number
function spawnHorde(x, y, x2, y2, z, count) end

--- @param modID string
--- @param mapFolder string
--- @return boolean
function spawnpointsExistsForMod(modID, mapFolder) end

--- @param index number
--- @return zombie.network.Server
function steamGetInternetServerDetails(index) end

--- @deprecated
function steamReleaseInternetServersRequest() end

--- @return number
function steamRequestInternetServersCount() end

--- @deprecated
function steamRequestInternetServersList() end

--- @param host string
--- @param port number
--- @return boolean
function steamRequestServerDetails(host, port) end

--- @param host string
--- @param port number
--- @return boolean
function steamRequestServerRules(host, port) end

function stopPing() end

--- @param sound number
function stopSound(sound) end

--- @param a string
--- @param tabX number
--- @return string
function tabToX(a, tabX) end

--- @overload fun()
function takeScreenshot(fileName) end

function testHelicopter() end

function testSound() end

--- @param val number
--- @return number
function toInt(val) end

--- @param table table
--- @param key any
function toggleBreakOnChange(table, key) end

--- @param table table
--- @param key any
function toggleBreakOnRead(table, key) end

--- @param file string
--- @param line number
function toggleBreakpoint(file, line) end

--- @param mod zombie.gameStates.ChooseGameInfo.Mod
--- @param activate boolean
function toggleModActive(mod, activate) end

--- @param player zombie.characters.IsoPlayer
function toggleSafetyServer(player) end

--- @param you zombie.characters.IsoPlayer
--- @param other zombie.characters.IsoPlayer
--- @param i zombie.inventory.InventoryItem
function tradingUISendAddItem(you, other, i) end

--- @param you zombie.characters.IsoPlayer
--- @param other zombie.characters.IsoPlayer
--- @param index number
function tradingUISendRemoveItem(you, other, index) end

--- @param you zombie.characters.IsoPlayer
--- @param other zombie.characters.IsoPlayer
--- @param state number
function tradingUISendUpdateState(you, other, state) end

--- @param map java.util.HashMap<any, any>
--- @return table
function transformIntoKahluaTable(map) end

--- @param x number
--- @param ui zombie.ui.UIElement
--- @param zoom number
--- @param xpos number
--- @return number
function translatePointXInOverheadMapToWindow(x, ui, zoom, xpos) end

--- @param x number
--- @param ui zombie.ui.UIElement
--- @param zoom number
--- @param xpos number
--- @return number
function translatePointXInOverheadMapToWorld(x, ui, zoom, xpos) end

--- @param y number
--- @param ui zombie.ui.UIElement
--- @param zoom number
--- @param ypos number
--- @return number
function translatePointYInOverheadMapToWindow(y, ui, zoom, ypos) end

--- @param y number
--- @param ui zombie.ui.UIElement
--- @param zoom number
--- @param ypos number
--- @return number
function translatePointYInOverheadMapToWorld(y, ui, zoom, ypos) end

--- @param event string
--- @param ... any
function triggerEvent(event, ...) end

--- @deprecated
function updateFire() end

--- @param bUse boolean
function useTextureFiltering(bUse) end

--- @return boolean
function wasMouseActiveMoreRecentlyThanJoypad() end

--- @param loggerName string
--- @param logs string
function writeLog(loggerName, logs) end

--- @param cellX number
--- @param cellY number
function zpopClearZombies(cellX, cellY) end

--- @return zombie.ZombiePopulationManager.ZombiePopulationRenderer
function zpopNewRenderer() end

--- @param cellX number
--- @param cellY number
function zpopSpawnNow(cellX, cellY) end

--- @param cellX number
--- @param cellY number
function zpopSpawnTimeToZero(cellX, cellY) end