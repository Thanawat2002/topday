ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local currentAnnouceID = 1

TriggerEvent('es:addGroupCommand', 'anm', 'admin', function(source, args, user)
    if args[1] == nil then
        TriggerClientEvent('chat:addMessage', source, {
            color = { 255, 43, 28 },
            args = {'การใช้', '/anm <ข้อความ>'}
        })
        return
    end

    TriggerClientEvent('annoucement_jdp:annouce', -1, table.concat(args, ' '))
end)


function autoAnnoucement()
    local message = Config.Annoucement[currentAnnouceID]
    TriggerClientEvent('annoucement_jdp:annouce', -1, message)

    SetTimeout(Config.AnnouceInterval, autoAnnoucement)

    if currentAnnouceID == #Config.Annoucement then 
        currentAnnouceID = 1 
        return
    end
    currentAnnouceID = currentAnnouceID + 1
end
SetTimeout(Config.AnnouceInterval, autoAnnoucement)