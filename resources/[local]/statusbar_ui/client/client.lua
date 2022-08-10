local status = nil
local isSpawned, isPaused, isDead, isTalking = false, false, false, false
local uiopen = false

AddEventHandler('playerSpawned', function()
    if not isSpawned then
        Citizen.Wait(5000)
        isSpawned = true
    end
end)

AddEventHandler('azael_statusbar:setDisplay', function(val)
	if val == 1 then
		valPause = 'none'
	elseif val == 2 then
		valPause = 'flex'
	elseif val == 3 then
		valDead = 'none'
	elseif val == 4 then
		valDead = 'flex'	
	end
	
	SendNUIMessage({
		setDisplay = true,
		displayPause = valPause,
		displayDead = valDead,
		id = GetPlayerServerId(PlayerId())
	})
end)

RegisterKeyMapping('closeuibar', 'CloseStatusUi', 'keyboard', 'PAGEUP')

RegisterCommand("closeuibar", function(source,args)
	if uiopen then
		TriggerEvent('azael_statusbar:setDisplay', 4)
		uiopen = false
	else
		TriggerEvent('azael_statusbar:setDisplay', 3)
		uiopen = true
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)
		local playerPed = GetPlayerPed(-1)
		
		if IsEntityDead(playerPed) and not isDead then
			isDead = true
			TriggerEvent('azael_statusbar:setDisplay', 3)
		elseif not IsEntityDead(playerPed) and isDead then
			isDead = false
			TriggerEvent('azael_statusbar:setDisplay', 4)
		end
		
		if IsPauseMenuActive() and not isPaused or not isSpawned then
			isPaused = true
			TriggerEvent('azael_statusbar:setDisplay', 1)
		elseif not IsPauseMenuActive() and isPaused and isSpawned then
			isPaused = false
			TriggerEvent('azael_statusbar:setDisplay', 2)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(300)
		
		local playerPed = GetPlayerPed(-1)
		local playerId = PlayerId()

		SetPedMaxTimeUnderwater(playerPed, 10.00) 	-- Set the underwater time to all players
		
		local playerHealth = GetEntityHealth(playerPed) - 100					-- Value SetPedMaxHealth X GetEntityHealth = 100
		local playerArmor = GetPedArmour(playerPed)
		local playerStamina = 100 - GetPlayerSprintStaminaRemaining(playerId)
		local playerDive = GetPlayerUnderwaterTimeRemaining(playerId) * 10.00	-- Value SetPedMaxTimeUnderwater X GetPlayerUnderwaterTimeRemaining = 100
		
		SendNUIMessage({
			health = playerHealth,
			armor = playerArmor,
			stamina = playerStamina,
			dive = playerDive,
			st = status
		})
    end
end)

RegisterNetEvent('azael_statusbar:updateStatus')
AddEventHandler('azael_statusbar:updateStatus', function(Status)
    status = Status
	
    SendNUIMessage({
        action = 'updateStatus',
        st = Status,
    })
end)
