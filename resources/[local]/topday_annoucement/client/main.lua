local annoucement_queue = {}

RegisterNetEvent('annoucement_jdp:annouce')
AddEventHandler('annoucement_jdp:annouce', function(message)
    table.insert(annoucement_queue, message)

    if #annoucement_queue <= 1 then
        pushAnnoucement()
    end
end)

function pushAnnoucement(message)
    local message = annoucement_queue[1]

    SendNUIMessage({
        action = 'annouce',
        message = message
    })

    Citizen.Wait(Config.AnnouceTimer)
    SendNUIMessage({ action = 'close' })
    table.remove(annoucement_queue, 1)

    if #annoucement_queue > 0 then
        Citizen.SetTimeout(1000, function()
            pushAnnoucement()
        end)
    end
end

RegisterNetEvent('nc_electric:annouce')
AddEventHandler('nc_electric:annouce', function(message)
    table.insert(annoucement_queue, message)

    if #annoucement_queue <= 1 then
        pushAnnoucement()
    end
end)