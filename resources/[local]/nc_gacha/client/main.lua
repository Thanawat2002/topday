local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["Enter"] = 191
}

ESX         = nil

local Npc = {}
local UI = false
local blur = "MinigameEndNeutral"
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	PlayerData = ESX.GetPlayerData()
	TriggerScreenblurFadeOut(0)
	StopScreenEffect(blur)
	-- sendToDiscord(discord_webhook)
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.3, 0.3)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 700
    DrawRect(_x, _y + 0.0115, 0.015 + factor, 0.03, 0, 0, 0, 20)
end

Citizen.CreateThread(function()
	for k,v in pairs(Config.Npcs) do
		RequestModel(GetHashKey(v.Model))
		while not HasModelLoaded(GetHashKey(v.Model)) do
			Wait(1)
		end

		Npc[#Npc+1] = CreatePed(4, v.Model, v.Pos.x, v.Pos.y, v.Pos.z-1.0, v.Pos.h, false, true)

		FreezeEntityPosition(Npc[#Npc], true)
		SetEntityInvincible(Npc[#Npc], true)
		SetBlockingOfNonTemporaryEvents(Npc[#Npc], true)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		local ck = 0
		for i=1, #Config.warp do
			if GetDistanceBetweenCoords(coords, Config.warp[i].go.x, Config.warp[i].go.y, Config.warp[i].go.z, true) < 15 then 
				if Config.warp[i].type == 'enter' then
					local Marker = Config.Marker.enter
					DrawMarker(Marker.id, Config.warp[i].go.x, Config.warp[i].go.y, Config.warp[i].go.z+0.1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.scaleX, Marker.scaleY, Marker.scaleZ, Marker.r, Marker.g, Marker.b, 80, false, true, 2, false, false, false, false)
					DrawText3Ds(Config.warp[i].go.x, Config.warp[i].go.y, Config.warp[i].go.z+0.1, Config.pressEnter)
				else
					local Marker = Config.Marker.exit
					DrawMarker(Marker.id, Config.warp[i].go.x, Config.warp[i].go.y, Config.warp[i].go.z+0.1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Marker.scaleX, Marker.scaleY, Marker.scaleZ, Marker.r, Marker.g, Marker.b, 80, false, true, 2, false, false, false, false)
					DrawText3Ds(Config.warp[i].go.x, Config.warp[i].go.y, Config.warp[i].go.z+0.1, Config.pressExit)
				end
				if GetDistanceBetweenCoords(coords, Config.warp[i].go.x, Config.warp[i].go.y, Config.warp[i].go.z, true) < 1.5 then 
					if IsControlJustPressed(0, 38) then 
						DoScreenFadeOut(1000)
						Citizen.Wait(1000)
						SetEntityCoords(GetPlayerPed(-1), Config.warp[i].to.x, Config.warp[i].to.y, Config.warp[i].to.z)
						Citizen.Wait(500)
						DoScreenFadeIn(1000)
					end
				end
			else 
				ck = ck+1
			end
		end
		if ck == #Config.warp then 
			Citizen.Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(0)
		for i=1, #Npc do 
			local NpcCoords = GetEntityCoords(Npc[i]) 
			local coords = GetEntityCoords(GetPlayerPed(-1))
			if GetDistanceBetweenCoords(coords, NpcCoords, true) < 1.5 then 
				ESX.ShowHelpNotification(Config.pressGacha)
				if IsControlJustPressed(0, 38) and not UI then 
					UI = true
					local inventory = ESX.GetPlayerData().inventory
					local gacha = {}
					for k,v in pairs(inventory) do 
						if checkgacha(v.name) then 
							if v.count ~= 0 then
								table.insert(gacha, {name = v.name, label = v.label, count = v.count, items = itemgacha(v.name)})
							end
						end
					end
					if #gacha ~= 0 then
						SendNUIMessage({
							action = "open",
							gacha = gacha,
							limit = Config.limitgacha,
							sound = Config.volume,
							spin = Config.volumespin,
							img = Config.imglocal,
							time = Config.time
						})
						SetNuiFocus(true, true)
						TriggerScreenblurFadeIn(0)
					else 
						UI = false
						print('no gacha')
					end
				end
			end
		end
	end
end)

function itemgacha(item)
	for k,v in pairs(Config.AllGacha) do 
		if item == k then 
			return v.items
		end
	end
end

function checkgacha(item)
	for k,v in pairs(Config.AllGacha) do 
		if item == k then 
			return true 
		end
	end
	return false
end

RegisterNUICallback('success', function(data)
    local gift = {}
	local token = 'afa545af45af6'
	local check = true
	for i=1, #data.item do 
		local check = true
		for i2=1, #gift do 
			if gift[i2].name == data.item[i].name then 
				check = false
				break
			end
		end
        if data.item[i].count ~= 0 and check then
            if vehicle(data.item[i].name) then 
				table.insert(gift, {name = data.item[i].name, count = 0, type = 'vehicle'})
            elseif data.item[i].name == 'money' or data.item[i].name == 'black_money' then
                table.insert(gift, {name = data.item[i].name, count = 0, type = 'account'})
            else
                table.insert(gift, {name = data.item[i].name, count = 0, type = 'item'})
            end
        end
		
    end
    for i=1, #data.item do
        if data.item[i].count ~= 0 then
            if vehicle(data.item[i].name) then 
                for i2=1, (Config.AllGacha[data.gacha].items[i].count*data.item[i].count) do
                    TriggerEvent('gacha:spawnVehicle', data.item[i].name)
                    Citizen.Wait(10)
                end
            end

			for i2=1, #gift do 
				if gift[i2].name == data.item[i].name then 
					gift[i2].count = gift[i2].count +  (Config.AllGacha[data.gacha].items[i].count*data.item[i].count)
					break
				end
			end
        end
    end

    TriggerServerEvent('gacha:additem', gift ,token, data.gacha, data.count)
    SetNuiFocus(false, false)
    TriggerScreenblurFadeOut()
    Citizen.Wait(50)
    StartScreenEffect(blur)
    UI = false
end)

RegisterNUICallback('remove', function(data)
	local token = 'afa5sfg5s6g5sg'
	TriggerServerEvent('gacha:remove', data.gacha, data.count, token)
end)

RegisterNUICallback('close', function()
	SetNuiFocus(false, false)
	TriggerScreenblurFadeOut()
	Citizen.Wait(50)
	StartScreenEffect(blur)
	UI = false
end)

function vehicle(name)
    for i=1, #Config.vehicles do 
        if name == Config.vehicles[i] then 
            return true 
        end
    end
    return false
end

RegisterNetEvent('gacha:spawnVehicle')
AddEventHandler('gacha:spawnVehicle', function(model)
	local token = 'afa56596dd9f89f'
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local carExist  = false
	ESX.Game.SpawnVehicle(model, coords, 0.0, function(vehicle) --get vehicle info
		if DoesEntityExist(vehicle) then
			carExist = true
			SetEntityVisible(vehicle, false, false)
			SetEntityCollision(vehicle, false)
			local newPlate     = exports.esx_vehicleshop:GeneratePlate()
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			vehicleProps.plate = newPlate
			TriggerServerEvent('gacha:setVehicle', vehicleProps, token)
			ESX.Game.DeleteVehicle(vehicle)				
		end
	end)
end)