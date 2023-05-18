Citizen.CreateThread(function()
    while Config.RemoveCops do
        Citizen.Wait(0)
        local loc = GetEntityCoords(PlayerPedId())
        ClearAreaOfCops(loc.x, loc.y, loc.z, 400.0)
    end

    while Config.Traffic.enabled do
        Citizen.Wait(0)
        SetPedDensityMultiplierThisFrame(Config.Traffic.ped)
        SetScenarioPedDensityMultiplierThisFrame(Config.Traffic.ped, Config.Traffic.ped)
        SetRandomVehicleDensityMultiplierThisFrame(Config.Traffic.vehicles)
        SetParkedVehicleDensityMultiplierThisFrame(Config.Traffic.vehicles)
        SetVehicleDensityMultiplierThisFrame(Config.Traffic.vehicles)
    end

    while Config.DisableWantedLevel do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if GetPlayerWantedLevel(ped) ~= 0 then
            SetPlayerWantedLevel(ped, 0, false)
            SetPlayerWantedLevelNow(ped, false)
        end
    end
end)