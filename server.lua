Core = exports['rsg-core']:GetCoreObject()
local registeredInventories = {}

exports("canCarryItem", function(source, item, amount, callback)
    if callback then
        callback(true) 
    else
        return true    
    end
end)

exports("canCarryItems", function(source, item, amount, callback)
    if callback then
        callback(true) 
    else
        return true    
    end
end)

exports("canCarryAmountItem", function(player, amount, cb)
    if cb then
        cb(true) 
    else
        return true    
    end
end)

exports("getUserInventoryItems", function(source, callback)
    local Player = Core.Functions.GetPlayer(source) 
    local citizenId = Player.PlayerData.citizenid   

    local items = exports['rsg-inventory']:LoadInventory(source, citizenId)

    if callback then
        callback(items) 
    else
        return items  
    end
end) 

exports("getUserInventoryWeapons", function(source, callback)
    local Player = Core.Functions.GetPlayer(source) 
    local citizenId = Player.PlayerData.citizenid   

    local items = exports['rsg-inventory']:LoadInventory(source, citizenId)
    local weapons = {}

    for _, item in pairs(items) do
        if item.type == "weapon" then 
            table.insert(weapons, item)
        end
    end

    if callback then
        callback(weapons) 
    else
        return weapons  
    end
end)

exports("RegisterUsableItem", function(item, callback)
    if not Core.Functions.CreateUseableItem then
        print("Erro: CreateUseableItem não está disponível!")
        return
    end

    Core.Functions.CreateUseableItem(item, function(source, itemData)

        if not itemData then
            print("Erro: itemData está vazio ou nulo.")
            return
        end

        local itemMetadata = itemData.info or {}
        local itemMainID = itemData.mainid or "unknown"
        local itemDescription = itemData.description or "No description"
        local itemID = itemData.id or 0
        local itemLabel = itemData.label or "Unknown Item"

        local itemdata = {
            source = source,
            item = {
                metadata = itemMetadata,
                mainid = itemMainID,
                description = itemDescription
            },
            id = itemID,
            label = itemLabel 
        }

        if callback then
            callback(itemdata)
        else
            print("Erro: Callback não fornecido.")
        end
    end)
end)

exports("getItemCount", function(source, item, callback)
    if source then
        print(item)
        local itemCount = exports['rsg-inventory']:GetItemCount(source, item)
        local amount = itemCount or 0 
        if callback then
            callback(amount)
        else
            return amount
        end
    end
end)

exports("getItemByName", function(source, callback, item, metadata)
    if source then
        local item = exports['rsg-inventory']:GetItemByName(source, item)
        
        if callback then
            callback(item) 
        else
            return item  
        end
    end
end)

exports("getItemContainingMetadata", function(source, callback, item, metadata)
    if source then
        local item = exports['rsg-inventory']:GetItemByName(source, item)
        
        if callback then
            callback(item.info) 
        else
            return item  
        end
    end
end) 

exports("getItemDB", function(item, callback)
    local itemData = Core.Shared.Items[item]

    if callback then
        callback(itemData)
        return
    end

    return itemData
end)

exports("addItem", function(source, item, amount, metadata, callback)
    if source then
        return exports['rsg-inventory']:AddItem(source, item, amount, false, metadata, nil)
    end
end)

exports("subItem", function(source, item, amount, metadata, callback)
    if source then
        return exports['rsg-inventory']:RemoveItem(source, item, amount)
    end
end)

exports("setItemMetadata", function(source, itemId, metadata, amount, callback)
    if source then
        local success = exports['rsg-inventory']:SetItemData(source, itemId, 'info', metadata)
    end
end)

exports("getItem", function(source, item, callback, metadata)
    if source then
        local item = exports['rsg-inventory']:GetItemByName(source, item)

        local data = {
            item = item.name,
            count = item.amount,
            metadata = item.info,
            slot = item.slot
        }

        if callback then
            callback(data) 
        else
            return data  
        end
    end
end)

local registeredInventories = {}

exports("registerInventory", function(data)
    registeredInventories[data.id] = data
end)

exports("openInventory", function(source, invId)
    local data = registeredInventories[invId]
    if data then
        local Weight = data.limit * 1000
        local stashName = 'Stash_'..data.id
        exports['rsg-inventory']:OpenInventory(source, stashName, { maxweight = Weight, slots = data.limit })
    else
        print("Inventário não registrado: " .. tostring(invId))
    end
end)

exports("setCustomInventoryItemLimit", function(invId, item, limit)
    return true
end)

exports("setCustomInventoryWeaponLimit", function(invId, item, limit)
    return true
end)

---------- WEAPONS ----------

exports("canCarryWeapons", function(source, amount,callback, weaponName)
    if callback then
        callback(true) 
    else
        return true  
    end
end) 

exports("createWeapon", function(source, weaponName, ammo, components, comps, callback, serial, label, desc)
    if source then
        exports['rsg-inventory']:AddItem(source, weaponName, 1, false, nil, nil)
    end
end)  

exports("createWeapon", function(source, weaponName, ammo, components, comps, callback, serial, label, desc)
    if source then
        exports['rsg-inventory']:AddItem(source, weaponName, 1, false, nil, nil)
    end
end) 

exports("closeInventory", function(source, invId)
    if source then
        TriggerClientEvent("rsg-inventory:client:closeInv", source)
    end
end) 


local INV = {
    canCarryItem = function(source, item, amount, callback)
        if callback then
            callback(true) 
        else
            return true    
        end
    end,

    canCarryItems = function(source, item, amount, callback)
        if callback then
            callback(true) 
        else
            return true    
        end
    end,

    canCarryAmountItem = function(player, amount, cb)
        if cb then
            cb(true) 
        else
            return true    
        end
    end,

    getUserInventoryItems = function(source, callback)
        local Player = Core.Functions.GetPlayer(source) 
        local citizenId = Player.PlayerData.citizenid   
        
        local items = exports['rsg-inventory']:LoadInventory(source, citizenId)
        
        if callback then
            callback(items) 
        else
            return items  
        end
    end,

    getUserInventoryWeapons = function(source, callback)
        local Player = Core.Functions.GetPlayer(source) 
        local citizenId = Player.PlayerData.citizenid   
    
        local items = exports['rsg-inventory']:LoadInventory(source, citizenId)
        local weapons = {}
    
        for _, item in pairs(items) do
            if item.type == "weapon" then 
                table.insert(weapons, item)
            end
        end
    
        if callback then
            callback(weapons) 
        else
            return weapons  
        end
    end,

    RegisterUsableItem = function(item, callback)
        if not Core.Functions.CreateUseableItem then
            print("Erro: CreateUseableItem não está disponível!")
            return
        end

        Core.Functions.CreateUseableItem(item, function(source, itemData)

            if not itemData then
                print("Erro: itemData está vazio ou nulo.")
                return
            end

            local itemMetadata = itemData.info or {}
            local itemMainID = itemData.mainid or "unknown"
            local itemDescription = itemData.description or "No description"
            local itemID = itemData.id or 0
            local itemLabel = itemData.label or "Unknown Item"

            local itemdata = {
                source = source,
                item = {
                    metadata = itemMetadata,
                    mainid = itemMainID,
                    description = itemDescription
                },
                id = itemID,
                label = itemLabel 
            }

            if callback then
                callback(itemdata)
            else
                print("Erro: Callback não fornecido.")
            end
        end)
    end,

    getItemCount = function(source, item, metadata, callback)
        if source then
            local itemCount = exports['rsg-inventory']:GetItemCount(source, item)
            local amount = itemCount or 0 
            if callback then
                callback(amount)
            else
                return amount
            end
        end
    end,

    getItemByName = function(source, item, metadata, callback)
        if source and exports['rsg-inventory']:HasItem(source, item) then
            local item = exports['rsg-inventory']:GetItemByName(source, item)

            if callback then
                callback(item) 
            else
                return item 
            end
        end
    end,

    getItemContainingMetadata = function(source, item, metadata, callback)
        if source then
            local item = exports['rsg-inventory']:GetItemByName(source, item)

            if callback then
                callback(item.metadata) 
            else
                return item  
            end
        end
    end,

    getItemDB = function(item, callback)
        local itemData = Core.Shared.Items[item]

        if callback then
            callback(itemData)
            return
        end

        return itemData
    end,

    addItem = function(source, item, amount, metadata, callback)
        if source then
            return exports['rsg-inventory']:AddItem(source, item, amount, false, metadata, nil)
        end
    end,

    subItem = function(source, item, amount, metadata, callback)
        if source then
            return exports['rsg-inventory']:RemoveItem(source, item, amount)
        end
    end,

    setItemMetadata = function(source, itemId, metadata, amount, callback)
        if source then
            exports['rsg-inventory']:SetItemData(source, itemId, 'info', metadata)
        end
    end,

    getItem = function(source, item, callback, metadata)
        if source then
            local item = exports['rsg-inventory']:GetItemByName(source, item)

            local data = {
                item = item.name,
                count = item.amount,
                metadata = item.info,
                slot = item.slot
            }

            if callback then
                callback(data) 
            else
                return data  
            end
        end
    end,

    registerInventory = function(data)
        registeredInventories[data.id] = data
    end,

    openInventory = function(source, invId)
        local data = registeredInventories[invId]
        if data then
            local Weight = data.limit * 1000
            local stashName = 'Stash_'..data.id
            exports['rsg-inventory']:OpenInventory(source, stashName, { maxweight = Weight, slots = data.limit })
        else
            print("Inventário não registrado: " .. tostring(invId))
        end
    end,

    setCustomInventoryItemLimit = function(invId, item, limit)
        return true
    end,

    setCustomInventoryWeaponLimit =  function(invId, item, limit)
        return true
    end,

    ---------- WEAPONS ----------

    canCarryWeapons = function(source, amount,callback, weaponName)
        if callback then
            callback(true) 
        else
            return true  
        end
    end,

    createWeapon = function(source, weaponName, ammo, components, comps, callback, serial, label, desc)
        if source then
            exports['rsg-inventory']:AddItem(source, weaponName, 1, false, nil, nil)
        end
    end, 

    closeInventory = function(source, invId)
        if source then
            TriggerClientEvent("rsg-inventory:client:closeInv", source)
        end
    end, 

    CloseInv = function(source)
        if source then
            TriggerClientEvent("rsg-inventory:client:closeInv", source)
        end
    end, 
}

AddEventHandler("vorpCore:canCarryItems", INV.canCarryAmountItem)
AddEventHandler("vorpCore:canCarryItem", INV.canCarryItem)

exports("vorp_inventoryApi", function()
    return INV
end)

-- © 2024 otavioomattos 
