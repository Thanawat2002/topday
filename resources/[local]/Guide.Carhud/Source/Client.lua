Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)
        Citizen.Wait(0)
    end
    Citizen.Wait(500)

end)

local timeText = ""
local locationText = ""
local position, heading, zoneNameFull, locationText
local seatbeltIsOn = false

Citizen.CreateThread(function()
    local currSpeed = 0.0
    local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}
    local inveh = false
    local hasBelt = false
    
    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        if IsPedInAnyVehicle(player, false) then
            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleClass = GetVehicleClass(vehicle)
            local engineHealth = GetVehicleEngineHealth(vehicle)
            local isDriver = (GetPedInVehicleSeat(vehicle, -1) == player)
            if vehicleClass ~= 13 then
                if not inveh then
                    inveh = true
                    
                    hasBelt = isVehicleClassHasBelt(vehicleClass)
                    Citizen.CreateThread(function()
                        while inveh do
                            Citizen.Wait(0)
                            if IsControlJustReleased(0, Dynamic.Setting.Input) and hasBelt then
                                seatbeltIsOn = not seatbeltIsOn
                                
                                if seatbeltIsOn then
                                    TriggerEvent("Sound", Dynamic.Setting.AddName, Dynamic.Setting.Volume)
                                else
                                    TriggerEvent("Sound", Dynamic.Setting.RemoveName, Dynamic.Setting.Volume)
                                end
                            end
                            
                            local prevSpeed = currSpeed
                            currSpeed = GetEntitySpeed(vehicle)
                            
                            if (not seatbeltIsOn or not hasBelt) then
                                local vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
                                local vehAcc = (prevSpeed - currSpeed) / GetFrameTime()
                                if (vehIsMovingFwd and
                                    (prevSpeed > (Dynamic.Setting.EjectSpeed / 2.237)) and
                                    (vehAcc > (Dynamic.Setting.EjectAccel * 9.81))) then
                                    SetEntityCoords(player, position.x, position.y, position.z - 0.47, true, true, true)
                                    SetEntityVelocity(player, prevVelocity.x, prevVelocity.y, prevVelocity.z)
                                    Citizen.Wait(1)
                                    SetPedToRagdoll(player, 1000, 1000, 0, 0, 0, 0)
                                else
                                    prevVelocity = GetEntityVelocity(vehicle)
                                end
                            else
                                DisableControlAction(0, 75)
                            end
                            SetPedConfigFlag(player, 32, true)
                        end
                    end)
                end
                local speed = GetEntitySpeed(vehicle) * 3.6 -- KMH
                local fuel = GetVehicleFuelLevel(vehicle)
                local gear = GetVehicleCurrentGear(vehicle)
                
                if not hasBelt then
                    seatbeltIsOn = false
                end
                
                
                if (IsVehicleTyreBurst(vehicle, 0) and GetTyreHealth(vehicle, 0) < 1) then tyres1 = '1'
                elseif (IsVehicleTyreBurst(vehicle, 0) ~= 1) then tyres1 = '0' end
                if (IsVehicleTyreBurst(vehicle, 1) and GetTyreHealth(vehicle, 1) < 1) then tyres2 = '2'
                elseif (IsVehicleTyreBurst(vehicle, 1) ~= 1) then tyres2 = '0' end
                if (IsVehicleTyreBurst(vehicle, 4) and GetTyreHealth(vehicle, 4) < 1) then tyres3 = '3'
                elseif (IsVehicleTyreBurst(vehicle, 4) ~= 1) then tyres3 = '0' end
                if (IsVehicleTyreBurst(vehicle, 5) and GetTyreHealth(vehicle, 5) < 1) then tyres4 = '4'
                elseif (IsVehicleTyreBurst(vehicle, 5) ~= 1) then tyres4 = '0' end
                
                position = GetEntityCoords(player)
                streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z));
                heading = Dynamic.Directions[math.floor((GetEntityHeading(player) + 22.5) / 45.0)]
                locationText = heading
                locationText = (streetName == "" or streetName == nil) and (streetName) or (locationText .. streetName);
                

                if vehicleClass == 8 then
                    name = "Bike"
                    class = "bike"
                elseif vehicleClass == 15 or vehicleClass == 16 then
                    name = "Plane"
                    class = "Planes"
                elseif vehicleClass == 14 then
                    name = "Boat"
                    class = "Boat"
                else
                    name = "Car"
                    class = "another"
                end
                
                    triggerNui({
                        message = "show",
                        clear = true,
                        speed = speed,
                        gear = gear,
                        fuel = fuel,
                        tyres1 = tyres1,
                        tyres2 = tyres2,
                        tyres3 = tyres3,
                        tyres4 = tyres4,                
                        scale = Dynamic.Setting.Scale,
                        streetName = locationText,
                        engineHealth = engineHealth/10,
                        name = name ,
                        class = class ,
                        hasBelt = hasBelt,
                        beltOn = seatbeltIsOn,
                        
                    })
                
            end
        else
            inveh = false
            seatbeltIsOn = false
            triggerNui({message = "hide", clear = true})
        end
        Citizen.Wait(300)
    
    end
end)

function isVehicleClassHasBelt(class)
    if (not class or class == nil) then return false end
    
    local hasBelt = Config.BeltClass[class]
    if (not hasBelt or hasBelt == nil) then return false end
    
    return hasBelt
end


AddEventHandler('Sound', function(soundFile, soundVolume)
    debug('ONE', 'Sound', soundFile, soundVolume)
    triggerNui({
        Class = 'playSound',
        FileName = soundFile,
        Volume = soundVolume
    })
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedInAnyVehicle(PlayerPedId(), true) then
            DisplayRadar(true)
        else
            DisplayRadar(false)
        end
    end
end)
