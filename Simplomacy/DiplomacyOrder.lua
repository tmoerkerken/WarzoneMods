--Inserts diplomacy orders for alliances and peace.

function DiplomacyOrder(wl, addNewOrder, player1ID, player2ID, diploCardIDsFromMod)
    local cardinstance = wl.NoParameterCardInstance.Create(wl.CardID.Diplomacy);
    addNewOrder(wl.GameOrderReceiveCard.Create(player1ID, {cardinstance}));
    addNewOrder(wl.GameOrderPlayCardDiplomacy.Create(cardinstance.ID, player1ID, player1ID, player2ID));
    table.insert(diploCardIDsFromMod, cardinstance.ID);
    return diploCardIDsFromMod;

    -- to do: pass the game's standing and reduce the duration of this card instance to expire directly after this turn.
end

function EnforceAllModDiplomacies(wl, relationsMatrix, addNewOrder, activeDiploCardIDs)
    for _, relation in pairs(relationsMatrix) do
        if (relation[3] ~= "War") then
            activeDiploCardIDs = DiplomacyOrder(wl, addNewOrder, relation[1], relation[2], activeDiploCardIDs);
        end
    end
end

-- function RemoveActiveDiploCardsFromMod(standing, diploCardsFromMod, turnNumber)
--     for diploCard in ipairs(diploCardsFromMod) do
--         for activeCard in ipairs(standing.ActiveCards) do
--             print(tostring(diploCard.));
--             print(tostring(activeCard.Card.CardInstanceID));
--             if (diploCardID == activeCard.Card.CardInstanceID) then
--                 activeCard.ExpiresAfterTurn = turnNumber;
--                 activeCard.ExpiresAfterTurnForDisplay = turnNumber;
--             end
--         end
--     end
--     return standing;
-- end


