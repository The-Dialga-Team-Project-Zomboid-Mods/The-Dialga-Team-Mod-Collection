# TDTModAPI (The Dialga Team Mod API)
This mod contains basic modules required by all The Dialga Team mods. <br />
If you wish to use this mod for your own mods, feel free to do so.

# Requirements
This mod do not have requirements.

# Exposed Functions
#### TheDialgaTeam.TDTModAPI.Event
1. TheDialgaTeam.TDTModAPI.Event.Add(eventTable, luaFunction);
2. TheDialgaTeam.TDTModAPI.Event.Remove(eventTable, luaFunction);

#### TheDialgaTeam.TDTModAPI.Json
1. TheDialgaTeam.TDTModAPI.Json.Serialize(jsonTable, isPretty);
2. TheDialgaTeam.TDTModAPI.Json.Deserialize(text);

#### TheDialgaTeam.TDTModAPI.Lua
##### TheDialgaTeam.TDTModAPI.Lua.Assert
1. TheDialgaTeam.TDTModAPI.Lua.Assert.AssertBoolean(value, name, acceptNull);
2. TheDialgaTeam.TDTModAPI.Lua.Assert.AssertNumber(value, name, acceptNull);
3. TheDialgaTeam.TDTModAPI.Lua.Assert.AssertString(value, name, acceptNull);
4. TheDialgaTeam.TDTModAPI.Lua.Assert.AssertFunction(value, name, acceptNull);
5. TheDialgaTeam.TDTModAPI.Lua.Assert.AssertTable(value, name, acceptNull);

##### TheDialgaTeam.TDTModAPI.Lua.Table
1. TheDialgaTeam.TDTModAPI.Lua.Table.Copy(table);

#### TheDialgaTeam.TDTModAPI.PZ
##### TheDialgaTeam.TDTModAPI.PZ.Color
1. TheDialgaTeam.TDTModAPI.PZ.Color.ConvertToRGB(colorTable);
2. TheDialgaTeam.TDTModAPI.PZ.Color.ConvertToRGBA(colorTable);
3. TheDialgaTeam.TDTModAPI.PZ.Color.ConvertToPZRGB(colorTable);
4. TheDialgaTeam.TDTModAPI.PZ.Color.ConvertToPZRichTextRGB(colorTable);
5. TheDialgaTeam.TDTModAPI.PZ.Color.ConvertToPZRGBA(colorTable);
6. TheDialgaTeam.TDTModAPI.PZ.Color.ConvertToPZColorInfo(colorTable);

#### TheDialgaTeam.TDTModAPI.System
##### TheDialgaTeam.TDTModAPI.System.Bitwise
1. TheDialgaTeam.TDTModAPI.System.Bitwise.Types;
2. TheDialgaTeam.TDTModAPI.System.Bitwise.Not(binaryTable);
3. TheDialgaTeam.TDTModAPI.System.Bitwise.And(binaryTable, binaryTable2);
4. TheDialgaTeam.TDTModAPI.System.Bitwise.Or(binaryTable, binaryTable2);
5. TheDialgaTeam.TDTModAPI.System.Bitwise.Xor(binaryTable, binaryTable2);
6. TheDialgaTeam.TDTModAPI.System.Bitwise.LShift(binaryTable, value);
7. TheDialgaTeam.TDTModAPI.System.Bitwise.RShift(binaryTable, value);
8. TheDialgaTeam.TDTModAPI.System.Bitwise.ConvertToBinaryTable(value, valueType);
9. TheDialgaTeam.TDTModAPI.System.Bitwise.TrimPaddedZeros(binaryTable);
10. TheDialgaTeam.TDTModAPI.System.Bitwise.ConvertToNumericValue(binaryTable);

##### TheDialgaTeam.TDTModAPI.System.Random
1. TheDialgaTeam.TDTModAPI.System.Random.Next(minValue, maxValue);

# Credits & Disclaimer
This mod is made by jianmingyong (The Dialga Team owner).

Your regards, <br />
jianmingyong