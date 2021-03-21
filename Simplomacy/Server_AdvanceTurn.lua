require('RelationsMatrix')
require('DiplomacyOrder')

function PrintProxyInfo(obj)
	print('type=' .. obj.proxyType .. ' readOnly=' .. tostring(obj.readonly) .. ' readableKeys=' .. table.concat(obj.readableKeys, ',') .. ' writableKeys=' .. table.concat(obj.writableKeys, ','));
  end



function Server_AdvanceTurn_Start (game,addNewOrder)
	playerGameData = Mod.PlayerGameData;
	publicGameData = Mod.PublicGameData;

	PrintProxyInfo(game.ServerGame.LatestTurnStanding);

    standing = game.ServerGame.LatestTurnStanding;


    -- standing = RemoveActiveDiploCardsFromMod(standing, publicGameData.ActiveDiploCardIDsFromMod, game.ServerGame.Game.TurnNumber);




Mod.PublicGameData = publicGameData;
Mod.PlayerGameData = playerGameData;

end




function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)

    playerGameData = Mod.PlayerGameData;
	publicGameData = Mod.PublicGameData;
    for _, entry in pairs(publicGameData.RelationsMatrix)do
        -- 1201687 is myself
        -- print(entry[1201687]);
    end
    local currentRelationMatrix = publicGameData.RelationsMatrix;

    --For testing purposes, relations can be changed to "Allied" by playing a Spy card.
    if(order.proxyType == 'GameOrderPlayCardSpy') then
        ProposeChange(currentRelationMatrix, order.PlayerID, order.TargetPlayerID, "Allied");
    end

    --For testing purposes, relations can be changed to "War" by playing a Gift card.
    if(order.proxyType == 'GameOrderPlayCardGift') then
        ProposeChange(currentRelationMatrix, order.PlayerID, order.GiftTo, "Peace");
    end

    --For testing purposes, relations can be changed to "Peace" by playing a Sanctions card.
    if(order.proxyType == 'GameOrderPlayCardSanctions') then
        ProposeChange(currentRelationMatrix, order.PlayerID, order.SanctionedPlayerID, "War");
    end



    Mod.PublicGameData = publicGameData;
	Mod.PlayerGameData = playerGameData;


end

function Server_AdvanceTurn_End (game,addNewOrder)

    playerGameData = Mod.PlayerGameData;
	publicGameData = Mod.PublicGameData;

    ValidateAndCorrectChangedRelations(publicGameData.RelationsMatrix, publicGameData.ProposedRelationChanges);

    EnforceAllModDiplomacies(WL, publicGameData.RelationsMatrix, addNewOrder, publicGameData.ActiveDiploCardIDsFromMod);

    Mod.PublicGameData = publicGameData;
	Mod.PlayerGameData = playerGameData;
    
    --print relations after turn:
    print('All relations:');
    for _, relation in pairs(publicGameData.RelationsMatrix) do
        print(tostring(relation[1]..' '..relation[2]..' '..relation[3]))
    end

end

