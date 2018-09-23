--- @class TheDialgaTeam.TDTCoreAPI.System.Bitwise.Types @Enum containing the different types of bitwise operation.
--- @field bool { type:string, minValue:number, maxValue:number, bits:number, hasNegativeBits:boolean, value:number[] } @Boolean flag: false, true.
--- @field byte { type:string, minValue:number, maxValue:number, bits:number, hasNegativeBits:boolean, value:number[] } @Unsigned Byte: 0, 255.
--- @field sbyte { type:string, minValue:number, maxValue:number, bits:number, hasNegativeBits:boolean, value:number[] } @Signed Byte: -128, 127.
--- @field short { type:string, minValue:number, maxValue:number, bits:number, hasNegativeBits:boolean, value:number[] } @Signed Short Integer: -32768, 32767.
--- @field ushort { type:string, minValue:number, maxValue:number, bits:number, hasNegativeBits:boolean, value:number[] } @Unsigned Short Integer: 0, 65535.
--- @field int { type:string, minValue:number, maxValue:number, bits:number, hasNegativeBits:boolean, value:number[] } @Signed Integer: -2147483648, 2147483647.
--- @field uint { type:string, minValue:number, maxValue:number, bits:number, hasNegativeBits:boolean, value:number[] } @Unsigned Integer: 0, 4294967295.
--- @field long { type:string, minValue:number, maxValue:number, bits:number, hasNegativeBits:boolean, value:number[] } @Signed Long Integer: -9*10^18, 9*10^18.
--- @field ulong { type:string, minValue:number, maxValue:number, bits:number, hasNegativeBits:boolean, value:number[] } @Unsigned Long Integer: 0, 1.8*10^19.
local TDTCoreAPI_System_Bitwise_Types = {};

TDTCoreAPI_System_Bitwise_Types.bool = { type = "bool", minValue = 0, maxValue = 1, bits = 1, hasNegativeBits = false, value = { 0 } };
TDTCoreAPI_System_Bitwise_Types.byte = { type = "byte", minValue = 0, maxValue = 255, bits = 8, hasNegativeBits = false, value = { 0 } };
TDTCoreAPI_System_Bitwise_Types.sbyte = { type = "sbyte", minValue = -128, maxValue = 127, bits = 8, hasNegativeBits = true, value = { 0 } };
TDTCoreAPI_System_Bitwise_Types.short = { type = "short", minValue = -32768, maxValue = 32767, bits = 16, hasNegativeBits = true, value = { 0 } };
TDTCoreAPI_System_Bitwise_Types.ushort = { type = "ushort", minValue = 0, maxValue = 65535, bits = 16, hasNegativeBits = false, value = { 0 } };
TDTCoreAPI_System_Bitwise_Types.int = { type = "int", minValue = -2147483648, maxValue = 2147483647, bits = 32, hasNegativeBits = true, value = { 0 } };
TDTCoreAPI_System_Bitwise_Types.uint = { type = "uint", minValue = 0, maxValue = 4294967295, bits = 32, hasNegativeBits = false, value = { 0 } };
TDTCoreAPI_System_Bitwise_Types.long = { type = "long", minValue = -9*10^18, maxValue = 9*10^18, bits = 64, hasNegativeBits = true, value = { 0 } };
TDTCoreAPI_System_Bitwise_Types.ulong = { type = "ulong", minValue = 0, maxValue = 1.8*10^19, bits = 64, hasNegativeBits = false, value = { 0 } };

return TDTCoreAPI_System_Bitwise_Types;