--- @class zombie.ui.UIFont
--- @field Small number
--- @field Medium number
--- @field Large number
--- @field Massive number
--- @field MainMenu1 number
--- @field MainMenu2 number
--- @field Cred1 number
--- @field Cred2 number
--- @field NewSmall number
--- @field NewMedium number
--- @field NewLarge number
--- @field Code number
--- @field MediumNew number
--- @field AutoNormSmall number
--- @field AutoNormMedium number
--- @field AutoNormLarge number
--- @field Dialogue number
--- @field Intro number
--- @field Handwritten number
local UIFont = {};

UIFont.Small = 0;
UIFont.Medium = 1;
UIFont.Large = 2;
UIFont.Massive = 3;
UIFont.MainMenu1 = 4;
UIFont.MainMenu2 = 5;
UIFont.Cred1 = 6;
UIFont.Cred2 = 7;
UIFont.NewSmall = 8;
UIFont.NewMedium = 9;
UIFont.NewLarge = 10;
UIFont.Code = 11;
UIFont.MediumNew = 12;
UIFont.AutoNormSmall = 13;
UIFont.AutoNormMedium = 14;
UIFont.AutoNormLarge = 15;
UIFont.Dialogue = 16;
UIFont.Intro = 17;
UIFont.Handwritten = 18;

--- @param str string
--- @return zombie.ui.UIFont
function UIFont.FromString(str) end

--- @param value string
--- @return zombie.ui.UIFont
function UIFont.valueOf(value) end

--- @return zombie.ui.UIFont[]
function UIFont.values() end