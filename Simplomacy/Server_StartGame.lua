require('RelationsMatrix')


function Server_StartGame(game, standing)
	playerGameData = Mod.PlayerGameData;
	publicGameData = Mod.PublicGameData;


	--"Peace" is now passed as a placeholder. Starting relation can later be configured in settings.
	InitialRelationsMatrix = RelationsMatrix(game, "Peace");

	publicGameData.RelationsMatrix = InitialRelationsMatrix;
	publicGameData.ActiveDiploCardIDsFromMod = {};

	-- for _, relation in pairs(publicGameData.RelationsMatrix) do
	-- 	local cardinstance = WL.NoParameterCardInstance.Create(WL.CardID.Diplomacy);
	-- 	local diploCard = WL.GameOrderPlayCardDiplomacy.Create(cardinstance.ID, relation[1], relation[1], relation[2]);
	-- 	standing.ActiveCards[1] = {diploCard, 1, 1};
	-- 	-- print(standing.ActiveCards[1]);
	-- end

	Mod.PublicGameData = publicGameData;
	Mod.PlayerGameData = playerGameData;
end