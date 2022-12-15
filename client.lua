function DisplayNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function DisplayHelpText(text, state)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

Citizen.CreateThread(function()
    for _, item in pairs(Config.Blips) do
        item.blip = AddBlipForCoord(item.x, item.y, item.z)
        SetBlipSprite(item.blip, 489)
        SetBlipScale(item.blip, 0.8)
        SetBlipColour(item.blip, 35)
        SetBlipDisplay(item.blip, 4)
        SetBlipAsShortRange(item.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Healing Pad")
        EndTextCommandSetBlipName(item.blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        ped = PlayerPedId()
        for _, item in pairs(Config.Blips) do
            distance = #(GetEntityCoords(ped) - vector3(item.x, item.y, item.z))
            if distance <= 15.0 then
                DrawMarker(23, item.x, item.y, item.z, 0, 0, 0, 0, 0, 0, 1.75, 1.75, 1.0, 248, 138, 138, 128)
                if distance <= 2.0 then
                    DisplayHelpText("Press ~INPUT_PICKUP~ to get treated by hospital staff", 0)
                    if (IsControlJustPressed(1, 38)) then
                        if (GetEntityHealth(ped) < 200) then                          
                            SetEntityHealth(ped, 200)
                            if Config.UsePrice == true then
                                price = math.random(Config.PriceMin, Config.PriceMax)
                                TriggerServerEvent('pay', price)
                                DisplayNotification("~g~You have been succesfully treated.~s~ Price: $" .. price)
                            else
                                DisplayNotification("~g~You have been succesfully treated.")
                            end
                        else
                            DisplayNotification("~r~You don't need treatment.")
                        end
                    end
                end
            end
        end
    end
end)
