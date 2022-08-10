ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function sendToDiscord(name, text, id, gachaname, count)
    local connect = {
        {
            ["color"] = 16777215,
            ["title"] = '��������� : '..name,
            ["description"] = '**ID** : '..id..'\n**COUNT** : '..count..' ���������\n**TEXT** : ������������������������������������������������������ '..gachaname..' ������������������\n\n'..'[ITEM]\n'..text,
            ["footer"] = {
                ["text"] = "�� NC Community ".. os.date ("%X") .." - ".. os.date ("%x") .."",
            }, 
        }
    }
    PerformHttpRequest(Config.WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = 'mowtod', embeds = connect, avatar_url = '', tts = false}), {['Content-Type'] = 'application/json'})
end

RegisterServerEvent('gacha:additem')
AddEventHandler('gacha:additem', function(gift, token, gacha, count)
    if token == 'afa545af45af6' then
        local xPlayer = ESX.GetPlayerFromId(source)
        local text = ''
        for i=1, #gift do 
            if gift[i].name == 'money' or gift[i].name == 'black_money' then
                xPlayer.addAccountMoney(gift[i].name, gift[i].count)
                text = text..'��� '..gift[i].name..' ��������������� '..gift[i].count..' ���������\n'
            elseif gift[i].type == 'vehicle' then
                text = text..'��� '..gift[i].name..' ��������������� '..gift[i].count..' ���������\n'
            else
                xPlayer.addInventoryItem(gift[i].name, gift[i].count)
                text = text..'��� '..gift[i].name..' ��������������� '..gift[i].count..' ������������\n'
            end
        end

        local result = MySQL.Sync.fetchAll("SELECT users.firstname, users.lastname FROM users WHERE users.identifier = @identifier", {
            ['@identifier'] = xPlayer.identifier
        })
        local name = result[1].firstname..' '..result[1].lastname
        local id = xPlayer.identifier
        sendToDiscord(name, text, id, gacha, count)
    end
end)

RegisterServerEvent('gacha:remove')
AddEventHandler('gacha:remove', function(gacha, count, token)
    if token == 'afa5sfg5s6g5sg' then
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeInventoryItem(gacha, count)
    end
end)

RegisterServerEvent('gacha:setVehicle')
AddEventHandler('gacha:setVehicle', function(vehicleProps, token)
    if token == 'afa56596dd9f89f' then
        local xPlayer = ESX.GetPlayerFromId(source)
        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, stored, type) VALUES (@owner, @plate, @vehicle, @stored, @type)', {
            ['@owner']   = xPlayer.identifier,
            ['@plate']   = vehicleProps.plate,
            ['@vehicle'] = json.encode(vehicleProps),
            ['@stored']  = 1,
            ['type'] = 'car'
        }, function()
        end)
    end
end)