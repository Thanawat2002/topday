ESX = nil
local connectedPlayers = {}
local resultFromUser = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_scoreboard:getConnectedPlayers', function(source, cb)
	cb(connectedPlayers)
end)

RegisterServerEvent('esx_scoreboard:server:getConnectedPlayers')
AddEventHandler('esx_scoreboard:server:getConnectedPlayers', function()
	TriggerClientEvent('esx_scoreboard:client:getConnectedPlayers', source, connectedPlayers)
end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
	local jobName = {
		mechanic = 'Mechanic',
		ambulance = 'Medic',
		police = 'Police',
		-- unemployed = 'Unemployed',
	}
	connectedPlayers[playerId].job = job.name
	if jobName[job.name] then
		connectedPlayers[playerId].myjob = ('%s | %s'):format(jobName[job.name],job.grade_label) 
	else
		connectedPlayers[playerId].myjob = ('%s'):format(job.grade_label) 
	end

	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	Citizen.CreateThread(function()
		Citizen.Wait(1000)
		AddPlayerToScoreboard(xPlayer, true)
	end)
end)

AddEventHandler('esx:playerDropped', function(playerId)
	connectedPlayers[playerId] = nil
	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end)

function AddPlayerToScoreboard(xPlayer, update)
	local playerId = xPlayer.source

	local jobName = {
		mechanic = 'Mechanic',
		ambulance = 'Medic',
		police = 'Police',
		-- unemployed = 'Unemployed',
	}

	connectedPlayers[playerId] = {}
	connectedPlayers[playerId].id = playerId
	connectedPlayers[playerId].name = xPlayer.getName()
	connectedPlayers[playerId].phone = resultFromUser[xPlayer.identifier] or getNumberPhone(xPlayer.identifier, true) or '000-0000'
	connectedPlayers[playerId].job = xPlayer.job.name

	if jobName[xPlayer.job.name] then
		connectedPlayers[playerId].myjob = ('%s | %s'):format(jobName[xPlayer.job.name],xPlayer.job.grade_label) 
	else
		connectedPlayers[playerId].myjob = ('%s'):format(xPlayer.job.grade_label) 
	end

	if update then
		TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
	end
end

function getNumberPhone(identifier, re)
    local result = MySQL.Sync.fetchAll("SELECT phone_number FROM users WHERE identifier = @identifier", {
        ['@identifier'] = identifier
	})
	if result then
		resultFromUser[identifier] = result[1].phone_number
	end
	if re and result then
		return result[1].phone_number
	end
end





---------------------------------
----- xD onResourceStart !! -----
---------------------------------

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1000)
			AddPlayersToScoreboard()
		end)
	end
end)

function AddPlayersToScoreboard()
	local players = ESX.GetPlayers()

	for i=1, #players, 1 do
		local xPlayer = ESX.GetPlayerFromId(players[i])
		AddPlayerToScoreboard(xPlayer, false)
	end
	TriggerClientEvent('esx_scoreboard:updateConnectedPlayers', -1, connectedPlayers)
end


ESX.RegisterCommand('s', 'moderator', function(xPlayer, args, showError)
		
	xPlayer.triggerEvent('get_coords', args.radius)

	
end, false, {help = 'Summon Player', validate = false, arguments = {
	{name = 'radius', help ='Summon Player', type = 'any'}
}})




RegisterNetEvent('teleport_to_player')
AddEventHandler('teleport_to_player', function(coords ,playerId)

	local TargetxPlayer = ESX.GetPlayerFromId(playerId)

	TargetxPlayer.triggerEvent('set_coords', coords)

end)


ESX.RegisterCommand('tp', 'moderator', function(xPlayer, args, showError)


args.playerId.triggerEvent('get_target_coords',xPlayer.source)

end, true, {help = 'revive_help', validate = true, arguments = {
	{name = 'playerId', help = 'The player id', type = 'player'}
}})


RegisterNetEvent('teleport_to_target')
AddEventHandler('teleport_to_target', function(coords ,playerId)

	local TargetxPlayer = ESX.GetPlayerFromId(playerId)

	TargetxPlayer.triggerEvent('set_coords', coords)

end)



ESX.RegisterCommand('dp', 'moderator', function(xPlayer, args, showError)
	xPlayer.triggerEvent('esx:delprop', args.radius)
end, false, {help = 'command_cardel', validate = false, arguments = {
	{name = 'radius', help = 'command_cardel_radius', type = 'any'}
}})