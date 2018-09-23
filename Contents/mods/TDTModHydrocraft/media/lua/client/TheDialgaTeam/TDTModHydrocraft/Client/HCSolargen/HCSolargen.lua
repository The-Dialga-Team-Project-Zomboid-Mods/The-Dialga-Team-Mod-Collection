function HCSetSolarGen(items, result, player)
    if player:isOutside() then
        for i = 0, items:size() - 1 do
            if items:get(i):getType() == "HCSolargen" then
                local generator = IsoGenerator.new(nil, player:getCell(), player:getCurrentSquare());
                generator:setConnected(true);
                generator:setFuel(100);
                generator:setCondition(100);
                generator:setActivated(true);
                generator:setSurroundingElectricity();
                generator:setSpriteFromName("Item_HCSolargen2");

                local generatorData = {
                    TheDialgaTeam = {

                    }
                };

                generator:setTable(generatorData);

                generator:transmitUpdatedSpriteToServer();
                generator:transmitModData();

                break;
            end
        end
    else
        player:Say("Must set Outside");
        player:getInventory():AddItem("Hydrocraft.HCSolargen");
    end
end