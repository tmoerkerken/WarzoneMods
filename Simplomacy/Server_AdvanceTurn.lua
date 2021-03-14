require('RandomizeWastelands')


function Server_AdvanceTurn_End(game, addNewOrder)
	if(game.Settings.Cards[WL.CardID.Diplomacy] ~= nil) then
		for _,pid in pairs(game.ServerGame.Game.Players)do
			if (pid.ID == 0) then
				pid.ID = 22;
			end
			for _,pid2 in pairs(game.ServerGame.Game.Players)do
				if (pid ~= pid2) then
					local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.Diplomacy);
					addNewOrder(WL.GameOrderReceiveCard.Create(pid.ID, {cardinstance}));
					addNewOrder(WL.GameOrderPlayCardDiplomacy.Create(cardinstance.ID, pid.ID, pid.ID, 22));			
				end
			end
		end
	end
end

