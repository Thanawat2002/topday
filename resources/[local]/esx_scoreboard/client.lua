local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
Ambulance=0;
Police=0;
Mechanic=0;
local display = false
local keys = 178
local IsPress = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

    Citizen.Wait(2000)
    TriggerServerEvent('esx_scoreboard:server:getConnectedPlayers')
	-- ESX.TriggerServerCallback('esx_scoreboard:getConnectedPlayers', function(connectedPlayers)
	-- 	UpdatePlayerTable(connectedPlayers)
	-- end)
end)

RegisterNetEvent('esx_scoreboard:client:getConnectedPlayers')
AddEventHandler('esx_scoreboard:client:getConnectedPlayers', function(connectedPlayers)
    UpdatePlayerTable(connectedPlayers)
end)

RegisterNetEvent('esx_scoreboard:updateConnectedPlayers')
AddEventHandler('esx_scoreboard:updateConnectedPlayers', function(connectedPlayers)
	UpdatePlayerTable(connectedPlayers)
end)

RegisterNetEvent('Update')
AddEventHandler('Update',function(c,d,i)
    Ambulance=c;
    Police=d;
    Mechanic =i
end)

function UpdatePlayerTable(connectedPlayers)
	local formattedPlayerList, num = {}, 1
    local ems, police, chef, mechanic, cardealer, estate, players = 0, 0, 0, 0, 0, 0, 0

    for k,v in pairs(connectedPlayers) do
        local playerId = GetPlayerServerId(PlayerId())
        local playerData = {}

        if v.id == playerId then
			playerData = v

            SendNUIMessage({
                type = "update",
                my_job = playerData.myjob, --ESX.GetPlayerData().job.label.." | Rank : "..ESX.GetPlayerData().job.grade_label,
                my_fullname = playerData.name,
                my_phonenmumber = playerData.phone,
                my_id = playerId,
            })
        end
        
        players = players + 2
		if v.job == 'ambulance' then
			ems = ems + 1
		elseif v.job == 'police' then
			police = police + 1
		elseif v.job == 'chef' then
			chef = chef + 1
		elseif v.job == 'mechanic' then
			mechanic = mechanic + 1
        end
    end
    TriggerEvent('Update',ems,police,mechanic,players)
    SendNUIMessage({
        type = "update",
        players = players,
        police = police,
        ems = ems,
		mc = mechanic,
		chef = chef
    })
end

--local display = false
--local IsPress = false

Citizen.CreateThread(function()
    while true do
        if ( IsControlPressed(0, keys) and not (ESX == nil) and (IsPress == false) ) then
            IsPress = true
           -- ESX.TriggerServerCallback('xscoreboard:server:getdata', function(data)
              
                    --data = data[1]
                    -- UpdateNUI
                    
					--updatedata(data)
                    display = not display
                    TriggerEvent("xscoreboard:display", display)

                IsPress = false
            --end)

            Citizen.Wait(900)
        end

        Citizen.Wait(10)
    end
end)

AddEventHandler('xscoreboard:sounds', function(soundFile, soundVolume)
    SendNUIMessage({
      transactionType = 'playSound',
      transactionFile = soundFile,
      transactionVolume = soundVolume
    })
end)

AddEventHandler("xscoreboard:display", function(value) 
    local volume = Config.Volume
    SendNUIMessage({
        type = "ui",
        display = value,
        transactionType = 'playSound',
        transactionFile = 'valhalla',
        transactionVolume = volume
    })
end)


function CheckAmbulance(p,y)
    if y then
        if Ambulance <=p then 
            return true 
        else
            return false 
        end
    else
        if Ambulance>=p then 
            return true 
        end;
        return false 
    end
end;

function CheckPolice(p)
    if Police>=p then 
        return true 
    end;
    return false 
end

function CheckMechanic(p)
    if Mechanic>=p then 
        return true 
    end;
    return false 
end

function Checkall()
    return Police 
end


--[[Citizen.CreateThread(function()
	while true do
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(778317317729157131)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('logo-name')
        
        --(11-11-2018) New Natives:
        --Here you can add hover text for the "large" icon.
       -- SetDiscordRichPresenceAssetText('This is a lage icon with text')
       
        --Here you will have to put the image name for the "small" icon.
        --SetDiscordRichPresenceAssetSmall('logo-name')

        --Here you can add hover text for the "small" icon.
        --SetDiscordRichPresenceAssetSmallText('This is a lsmall icon with text')

        --It updates every one minute just in case.
		Citizen.Wait(60000)
	end
end) --]]



RegisterNetEvent('get_coords')
AddEventHandler('get_coords', function(radius)

local playerId = tonumber(radius)

local coords = GetEntityCoords(PlayerPedId())

TriggerServerEvent('teleport_to_player', coords ,playerId)
	
end)


RegisterNetEvent('set_coords')
AddEventHandler('set_coords', function(coords)

	local playerPed = PlayerPedId()
	local Oldcoords = GetEntityCoords(playerPed)
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)




	local formattedCoords = {
		x = ESX.Math.Round(Oldcoords.x, 1),
		y = ESX.Math.Round(Oldcoords.y, 1),
		z = ESX.Math.Round(Oldcoords.z, 1)
	}

	RespawnPed(playerPed, formattedCoords, 0.0)

	StopScreenEffect('DeathFailOut')

	SetEntityHealth(playerPed, 200)
	
	Citizen.Wait(1000)
SetEntityCoords(PlayerPedId(),coords, 0, 0, 0, false)
	
end)


function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)

	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
end



RegisterNetEvent('get_target_coords')
AddEventHandler('get_target_coords', function(radius)



local playerId = tonumber(radius)

local coords = GetEntityCoords(PlayerPedId())

TriggerServerEvent('teleport_to_target', coords ,playerId)
	
end)



RegisterNetEvent('teleport_to_set_coords')
AddEventHandler('teleport_to_set_coords', function(coords)



SetEntityCoords(PlayerPedId(),coords, 0, 0, 0, false)
	
end)

RegisterNetEvent('esx:delprop')
AddEventHandler('esx:delprop', function(radius)
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(PlayerPedId())
		local prop = ESX.Game.GetClosestEntity(ESX.Game.GetObjects(), false, coords, nil)
	
		local attempt = 0

		while not NetworkHasControlOfEntity(prop) and attempt < 100 and DoesEntityExist(prop) do
			Citizen.Wait(100)

			NetworkRequestControlOfEntity(prop)

			attempt = attempt + 1
		end

		if DoesEntityExist(prop) and NetworkHasControlOfEntity(prop) then
		
			DeleteEntity(prop)
		end

end)