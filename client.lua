RegisterNetEvent("vorp_inventory:OpenInventory", function(invId, options)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", invId, options)
    TriggerEvent("inventory:client:SetCurrentStash", invId)
end)