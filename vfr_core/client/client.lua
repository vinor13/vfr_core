local playerLoaded = false
VFR.PlayerData = {}

function VFR.StartFramework(self)
    CreateThread(function()
        if NetworkIsSessionStarted() then
            playerLoaded = true
            TriggerEvent('VFR:cl:start')
            TriggerServerEvent('VFR:sv:start')
            TriggerServerEvent('VFR:GetPlayerData')      
        end
    end) 
end

RegisterNetEvent('VFR:cl:start', function()    
    function VFR.IsPlayerLoaded()
        return playerLoaded
    end
    
    function VFR.GetPlayerSSN()
        return VFR.PlayerData.ssn
    end
    
    function VFR.GetPlayerIdentifier()
        return VFR.PlayerData.license
    end
    
    function VFR.GetPlayerGroup()
        return VFR.PlayerData.usergroup
    end
    
    function VFR.GetPlayerAccountMoney(account)
        local accountsData = json.decode(VFR.PlayerData.accounts)
        
        return accountsData[account]
    end

        
end)

VFR.StartFramework(VFR)

exports('sharedObject', function()
    return VFR
end)

RegisterNetEvent('VFR:updateActualPlayerData', function()
    
    TriggerEvent('VFR:updatePlayerData', VFR.PlayerData)
end)

RegisterNetEvent('VFR:loadPlayerData', function(playerData)
    
    VFR.PlayerData = playerData
    TriggerEvent('VFR:updatePlayerData', VFR.PlayerData)
end)

RegisterNetEvent('VFR:updatePlayerData', function()
    TriggerServerEvent('VFR:updatePlayerData', VFR.PlayerData)
    
end)
