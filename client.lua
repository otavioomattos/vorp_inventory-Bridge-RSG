RegisterNetEvent("vorp_inventory:OpenInventory", function(invId, options)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", invId, options)
    TriggerEvent("inventory:client:SetCurrentStash", invId)
end)

RegisterNetEvent("vorp_inventory:OpenstealInventory", function(title, invID)
    title = "otherplayer"
    TriggerServerEvent("inventory:server:OpenInventory", title, invID)
end)
