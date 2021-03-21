--A relations matrix holds the relations between all players (allied, peace, war).


function RelationsMatrix(game, startRelation)
    local relationsMatrix = {};
    local playingPlayers = game.ServerGame.Game.PlayingPlayers;

    for player1ID, player1 in pairs(playingPlayers) do
        for player2ID, player2 in pairs(playingPlayers) do
            if (player1ID~=player2ID) then
                table.insert(relationsMatrix, {player1ID, player2ID, startRelation});
            end
        end      
    end
    -- to print all relations: 
    for _, relation in pairs(relationsMatrix) do
        print(tostring(relation[1]..' '..relation[2]..' '..relation[3]))
    end
    return relationsMatrix;
end

function ProposeChange(currentRelationMatrix, playerSelfID, playerOtherID, newRelation)
    for _, relation in pairs(currentRelationMatrix) do
        if (relation[1]==playerSelfID and relation[2]==playerOtherID) then
            relation[3]=newRelation;
        end
    end
end

function ValidateAndCorrectChangedRelations(relationsMatrix)
    for _, relationProposed in pairs(relationsMatrix) do
        for _, relationReaction in pairs(relationsMatrix) do
            -- find the relationReaction to the relationProposed:
            if (relationProposed[1]==relationReaction[2] and relationProposed[2]==relationReaction[1])then
                -- validate if peace offer is accepted:
                if (relationProposed[3]=="Peace" and relationReaction[3]=="War") then
                    -- if true, it isn't accepted and proposal is reverted. Possible feature for later: specify in settings whether peace offers remain valid over turns.
                    relationProposed[3]="War";
                    print("Peace offer declined. Relation between "..relationProposed[1].." and "..relationProposed[2].." remains "..relationProposed[3]);
                end
                --validate if alliance offer is accepted:
                if (relationProposed[3]=="Allied" and relationReaction[3]~="Allied") then
                    -- if true, it isn't accepted and proposal is reverted to "War" or "Peace", depending on actions of receiver of the alliance offer.
                    relationProposed[3] = relationReaction[3];
                    print("Alliance offer declined. Relation between "..relationProposed[1].." and "..relationProposed[2].." is "..relationProposed[3]);
                end
                --apply war declarations:
                if (relationProposed[3]=="War" and relationReaction[3]~="Allied") then
                    relationProposed[3] = "War";
                    relationReaction[3] = "War";
                    print("Relation between "..relationProposed[1].." and "..relationProposed[2].." changed to "..relationProposed[3])
                end
                -- apply alliance cancellations:
                if (relationProposed[3]=="Peace" and relationReaction[3]=="Allied") then
                    relationProposed[3] = "Peace";
                    relationReaction[3] = "Peace";
                    print("Relation between "..relationProposed[1].." and "..relationProposed[2].." changed to "..relationProposed[3])
                end
            end
        end
    end
end


