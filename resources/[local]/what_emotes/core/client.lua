Citizen.CreateThread(function()
    while true do
        local w = 300
        if IsPedShooting(PlayerPedId()) and IsInAnimation then
            EmoteCancel()
        end
    
        if PtfxPrompt then
            w = 0
            if not PtfxNotif then
                SimpleNotify(PtfxInfo)
                PtfxNotif = true
            end
            if IsControlPressed(0, 47) then
            PtfxStart()
            Wait(PtfxWait)
            PtfxStop()
            end
        end
        if IsInAnimation then
            w = 0
            if Config.EnableXtoCancel then if IsControlPressed(0, 73) then EmoteCancel() end end
        end
        Citizen.Wait(w)
    end
end)



AddEventHandler("what_core:ClearMemoryCl", function()
	Citizen.CreateThread(function()
		local rdm = math.random(100, 2000)
		Wait(rdm)
		collectgarbage()
	end)
end)




RegisterNetEvent("SyncPlayEmote")
AddEventHandler("SyncPlayEmote", function(emote, player)
    EmoteCancel()
    Wait(300)
    -- wait a little to make sure animation shows up right on both clients after canceling any previous emote
    if DP.Shared[emote] ~= nil then
      if OnEmotePlay(DP.Shared[emote]) then end return
    elseif DP.Dances[emote] ~= nil then
      if OnEmotePlay(DP.Dances[emote]) then end return
    end
end)

RegisterNetEvent("SyncPlayEmoteSource")
AddEventHandler("SyncPlayEmoteSource", function(emote, player)
    -- Thx to Poggu for this part!
    local pedInFront = GetPlayerPed(GetClosestPlayer())
    local heading = GetEntityHeading(pedInFront)
    local coords = GetOffsetFromEntityInWorldCoords(pedInFront, 0.0, 1.0, 0.0)
    if (DP.Shared[emote]) and (DP.Shared[emote].AnimationOptions) then
      local SyncOffsetFront = DP.Shared[emote].AnimationOptions.SyncOffsetFront
      if SyncOffsetFront then
          coords = GetOffsetFromEntityInWorldCoords(pedInFront, 0.0, SyncOffsetFront, 0.0)
      end
    end
    SetEntityHeading(PlayerPedId(), heading - 180.1)
    SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, coords.z, 0)
    EmoteCancel()
    Wait(300)
    if DP.Shared[emote] ~= nil then
      if OnEmotePlay(DP.Shared[emote]) then end return
    elseif DP.Dances[emote] ~= nil then
      if OnEmotePlay(DP.Dances[emote]) then end return
    end
end)

RegisterNetEvent("ClientEmoteRequestReceive")
AddEventHandler("ClientEmoteRequestReceive", function(emotename, etype)
    isRequestAnim = true
    requestedemote = emotename

    if etype == 'Dances' then
        _,_,remote = table.unpack(DP.Dances[requestedemote])
    else
        _,_,remote = table.unpack(DP.Shared[requestedemote])
    end

    PlaySound(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 0, 0, 1)
    SimpleNotify(Config.Languages[lang]['doyouwanna']..remote..")",10)
end)

Citizen.CreateThread(function()
    while true do
        local w = 300
        if isRequestAnim then
            w = 5
          if IsControlJustPressed(1, 201) and isRequestAnim then
                target, distance = GetClosestPlayer()
                if(distance ~= -1 and distance < 3) then
                    if DP.Shared[requestedemote] ~= nil then
                        _,_,_,otheremote = table.unpack(DP.Shared[requestedemote])
                    elseif DP.Dances[requestedemote] ~= nil then
                        _,_,_,otheremote = table.unpack(DP.Dances[requestedemote])
                    end
                    if otheremote == nil then otheremote = requestedemote end
                    TriggerServerEvent("ServerValidEmote", GetPlayerServerId(target), requestedemote, otheremote)
                    isRequestAnim = false
                else
                    SimpleNotify(Config.Languages[lang]['nobodyclose'])
                end
            elseif IsControlJustPressed(1, 182) and isRequestAnim then
                SimpleNotify(Config.Languages[lang]['refuseemote'])
                isRequestAnim = false
            end
        end
        Citizen.Wait(w)
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        DestroyAllProps()
        ClearPedTasksImmediately(GetPlayerPed(-1))
        ResetPedMovementClipset(PlayerPedId())
    end
end)