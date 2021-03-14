function PrintProxyInfo(obj)
    print('type=' .. obj.proxyType .. ' readOnly=' .. tostring(obj.readonly) .. ' readableKeys=' .. table.concat(obj.readableKeys, ',') .. ' writableKeys=' .. table.concat(obj.writableKeys, ','));
end

function RandomizeWastelands(game, standing)
	for _, territory in pairs(standing.Territories) do
        -- if (territory.OwnerPlayerID ~= 0) then
        --     print(territory.OwnerPlayerID);
        -- end
        if (territory.IsNeutral == false) then
            
        end
    end
end

