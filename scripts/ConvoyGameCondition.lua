-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: ConvoyGameCondition.luac 

module("ConvoyGameCondition", package.seeall)
require("GameCondition")
require("VehicleComponent")
local l_0_0 = {}
l_0_0.Name = "ConvoyGameCondition"
l_0_0.Extends = "GameCondition"
local l_0_1 = function(l_1_0)
  return l_1_0 * 60 * 60 * 0.98425197601318 * 0.08333333581686 * 0.00018939393339679
end

l_0_0.ArgsConstructor = function(l_2_0, l_2_1)
  l_2_0.name = l_2_1.name
  l_2_0.spawnLoc = l_2_1.spawnLoc or "loc_cv_spawn"
  l_2_0.spawnLoc2 = l_2_1.spawnLoc2 or "loc_cv_spawn_1"
  l_2_0.startDelay = l_2_1.startDelay or 5
  l_2_0.voDelay = l_2_1.voDelay or 10
  l_2_0.radius = l_2_1.radius or 300
  l_2_0.faction = currentGame.base1owner
  l_2_0.otherFaction = currentGame.base2owner
  l_2_0.vehicleMaxSpeed = l_0_1(115)
  l_2_0.vehicleMinSpeed = l_0_1(25)
  local l_2_2 = 0
  if ValidatePos(l_2_0.spawnLoc2, "PosQuat") then
    l_2_0.path[1] = l_2_0.spawnLoc2
    l_2_2 = l_2_2 + 1
  end
  if ValidatePos(l_2_0.spawnLoc, "PosQuat") then
    local l_2_3 = l_2_0.path
    local l_2_4 = 1 + (l_2_2)
    l_2_3[l_2_4] = l_2_0.spawnLoc
    l_2_2 = l_2_2 + 1
  end
  for l_2_8 = 1, 100 do
    local l_2_9 = ValidatePos("loc_cv_path" .. l_2_8, "Vec3")
    if l_2_9 then
      local l_2_10 = l_2_0.path
      local l_2_11 = l_2_8 + (l_2_2)
      l_2_10[l_2_11] = "loc_cv_path" .. l_2_8
    end
  end
  local l_2_12 = DGGameView.GetScene()
  for l_2_16 = 1, 100 do
    local l_2_17 = DGDataNodeManager.GetNodeOfTypeByName("DGDataNodePath", "loc_cv_path" .. l_2_16)
    if l_2_17 and l_2_17.BlockingNode then
      local l_2_18 = l_2_12:GetNodeByName(l_2_17.BlockingNode)
      if l_2_18 then
        local l_2_19 = l_2_18:GetModelSwapper(true).Index
        local l_2_20 = {}
        l_2_20.nodeName = l_2_17.BlockingNode
        l_2_20.level = l_2_17.SwapperLevel
        l_2_20.isBlocked = true
        l_2_0.blockersBySwapperIndex[l_2_19] = l_2_20
        l_2_0.blockersByPathIndex[l_2_16 + (l_2_2)] = l_2_20
      end
    end
  end
  local l_2_21 = "DozerB"
  local l_2_22 = "DozerB_rear"
  if l_2_0.faction == "OpFor" then
    l_2_21 = "M_ATV"
    l_2_22 = "M_ATV_rear"
  end
  l_2_0.vehicles = {}
  local l_2_23 = new("Agent", "convoy")
  local l_2_24 = new("Agent", "convoy1")
  vehSpawnCallback = function(l_1_0, l_1_1)
    local l_3_2 = DGEntityManager.GetEntityByID(l_1_0, l_1_1)
    local l_3_3 = l_3_2:GetSensor()
    if l_3_3 and sensorTagName then
      local l_3_4 = DGEditorTagList.FindTagIDByName(sensorTagName)
      l_3_3:SetTag(l_3_4)
    end
    l_2_6:SetEntity(l_3_2)
    l_2_6:SetSpawnPos(ValidatePos(l_2_0.spawnLoc, "Vec3"))
    l_2_6:AddComponent(new("VehicleComponent"), true, true)
    AIManager.AddAgent(l_2_6)
   end
  vehSpawnCallback2 = function(l_2_0, l_2_1)
    local l_4_2 = DGEntityManager.GetEntityByID(l_2_0, l_2_1)
    local l_4_3 = l_4_2:GetSensor()
    if l_4_3 and sensorTagName then
      local l_4_4 = DGEditorTagList.FindTagIDByName(sensorTagName)
      l_4_3:SetTag(l_4_4)
    end
    l_2_7:SetEntity(l_4_2)
    l_2_7:SetSpawnPos(ValidatePos(l_2_0.spawnLoc2, "Vec3"))
    l_2_7:AddComponent(new("VehicleComponent"), true, true)
    AIManager.AddAgent(l_2_7)
   end
  local l_2_25 = 0
  local l_2_26 = ValidatePos(l_2_0.spawnLoc, "PosQuat")
  if l_2_26 ~= nil then
    table.insert(l_2_0.vehicles, l_2_23)
    SpawnManager.Spawn(l_2_21, "DGVehicleSpawnInfo", l_2_26, vehSpawnCallback, nil, nil, l_2_25, l_2_26)
  end
  l_2_26 = ValidatePos(l_2_0.spawnLoc2, "PosQuat")
  if l_2_26 ~= nil then
    table.insert(l_2_0.vehicles, l_2_24)
    SpawnManager.Spawn(l_2_22, "DGVehicleSpawnInfo", l_2_26, vehSpawnCallback2, nil, nil, l_2_25, l_2_26)
  end
  l_2_0.lastConvoyAdvancingTime = gGameTime
  delay(function()
    l_2_0:StartConvoy()
   end, l_2_0.startDelay)
end

l_0_0.GetConvoyMod = function(l_3_0)
  local l_3_1 = 0
  local l_3_2 = 0
  local l_3_3 = DGFactionManager.GetFaction(l_3_0.otherFaction)
  local l_3_4 = DGFactionManager.GetFaction(l_3_0.faction)
  local l_3_5 = DGPlayerManager.GetPlayersOnFactionByID(l_3_4:GetFactionID())
  local l_3_6 = ObjectPool.Get("Vec3")
  if l_3_5 then
    for l_3_10,l_3_11 in pairs(l_3_5) do
      local l_3_12 = l_3_11:GetControlEntity()
      if l_3_12 then
        l_3_6:Set(l_3_12:GetPos())
        if next(l_3_0.vehicles) and l_3_0.vehicles[1]:GetPos():Distance(l_3_6) < l_3_0.radius then
          l_3_1 = l_3_1 + 1
          if not l_3_0.nearPlayers[l_3_11:GetName()] then
            l_3_0.nearPlayers[l_3_11:GetName()] = true
            DGApp.DoMPLua("client:NearConvoy(" .. l_3_11:GetPlayerID() .. ", true )")
          else
            if l_3_0.nearPlayers[l_3_11:GetName()] then
              l_3_0.nearPlayers[l_3_11:GetName()] = false
              DGApp.DoMPLua("client:NearConvoy(" .. l_3_11:GetPlayerID() .. ", false )")
            end
          end
        end
      end
      l_3_2 = l_3_2 + 1
    end
  end
  if l_3_0.convoyBlocked then
    ObjectPool.Recycle(l_3_6)
    return 0
  end
  for l_3_16,l_3_17 in ipairs(l_3_0.vehicles) do
    if not l_3_17.entity:IsAlive() then
      ObjectPool.Recycle(l_3_6)
      return 0
    end
  end
  local l_3_18 = l_3_3:GetMembers()
  if l_3_18 and next(l_3_0.vehicles) then
    for l_3_22,l_3_23 in pairs(l_3_18) do
      l_3_6:Set(l_3_23:GetPos())
      if l_3_0.vehicles[1]:GetPos():Distance(l_3_6) < l_3_0.radius then
        ObjectPool.Recycle(l_3_6)
        return 0
      end
    end
  end
  ObjectPool.Recycle(l_3_6)
  if l_3_1 > 0 then
    l_3_0.lastConvoyAdvancingTime = gGameTime
    l_3_0.convoyStalled = false
  else
    if l_3_0.convoyStalledTime < gGameTime - l_3_0.lastConvoyAdvancingTime and not l_3_0.convoyStalled then
      l_3_0.convoyStalled = true
      local l_3_24 = DGFactionManager.GetFaction(l_3_0.faction)
      do
        local l_3_25, l_3_26 = l_3_24 and l_3_24:GetFactionID() or -1
      end
       -- DECOMPILER ERROR: Confused about usage of registers!

      DGApp.DoMPLua("client:HQRadioChatter(\"HQ_Radio_Message_General\", \"HQ_Convoy_Stalled\", " .. tostring(l_3_25) .. ")")
    end
  end
  if l_3_2 > 0 then
    return (l_3_1) / (l_3_2)
  else
    return 0
  end
end

l_0_0.ConvoyHQChatter = function(l_4_0)
  local l_4_1 = DGFactionManager.GetFaction(l_4_0.faction)
  do
    local l_4_2, l_4_3 = l_4_1 and l_4_1:GetFactionID() or -1
  end
   -- DECOMPILER ERROR: Confused about usage of registers!

  DGApp.DoMPLua("client:HQRadioChatter(\"HQ_Radio_Message_General\", \"HQ_Convoy_Start\", " .. tostring(l_4_2) .. ")")
end

l_0_0.Initialize = function(l_5_0)
  l_5_0.path = {}
  l_5_0.capPoints = {}
  l_5_0.blockersBySwapperIndex = {}
  l_5_0.blockersByPathIndex = {}
  l_5_0.nearPlayers = {}
  l_5_0.convoyBlocked = false
  l_5_0.convoyStalled = false
  l_5_0.lastConvoyAdvancingTime = gGameTime
  l_5_0.convoyStalledTime = 60
  l_5_0.mostRecentNonZeroCruiseControlMPH = 0
  l_5_0.modelSwappedSubscription = DEEventManager.SubscribeEvent("DEEventModelSwapped", function(l_1_0)
    l_5_0:HandleModelSwapped(l_1_0)
   end)
end

l_0_0.HandleModelSwapped = function(l_6_0, l_6_1)
  local l_6_2 = l_6_0.blockersBySwapperIndex[l_6_1.SwapperIndex]
  if l_6_2 and l_6_2.level < l_6_1.SwapperLevel then
    l_6_2.isBlocked = false
  end
end

l_0_0.StartConvoy = function(l_7_0)
  for l_7_4,l_7_5 in ipairs(l_7_0.vehicles) do
    l_7_5:Get("VehicleComponent"):FollowPath(l_7_0.path)
    l_7_5.entity:ActivateCruiseControl()
    l_7_5.entity:SetCruiseControlMPH(0)
    local l_7_6 = DEEventManager.CreateEvent("DGEventVehicleIgnition")
    l_7_6.Start = true
    DEEventManager.AddEvent(l_7_6, l_7_5.entity:GetSubjectString())
  end
  if next(l_7_0.vehicles) then
    local l_7_7 = DEEventManager.CreateEvent("DGEventConvoyStarted")
    l_7_7:AddVehicleID(l_7_0.vehicles[1].entity:GetID())
    l_7_7:AddVehicleID(l_7_0.vehicles[2].entity:GetID())
    l_7_7.TimeLimit = currentGame.timeLimit
    DEEventManager.AddEvent(l_7_7, 0)
  end
  l_7_0.lastConvoyAdvancingTime = gGameTime
  delay(function()
    l_7_0:ConvoyHQChatter()
   end, l_7_0.voDelay)
end

l_0_0.SyncJIPPlayer = function(l_8_0, l_8_1)
  local l_8_2 = DGPlayerManager.GetPlayerByID(l_8_1)
  if next(l_8_0.vehicles) then
    ScriptManager.RegisterDelayFunction("ConvoyJIP" .. tostring(l_8_1), function()
    local l_9_0 = DEEventManager.CreateEvent("DGEventConvoyStarted")
    l_9_0:AddVehicleID(l_8_0.vehicles[1].entity:GetID())
    l_9_0:AddVehicleID(l_8_0.vehicles[2].entity:GetID())
    l_9_0.TimeLimit = currentGame.timeLimit
    l_8_2:SendEvent(l_9_0, 0)
   end, 0)
    local l_8_3 = l_8_0.blockersByPathIndex[l_8_0.vehicles[1]("VehicleComponent").currentPathNodeIndex]
    do
      if l_8_3 and l_8_0.convoyBlocked then
        ScriptManager.RegisterDelayFunction("ConvoyJIPBlocked" .. tostring(l_8_1), function()
        local l_10_0 = DEEventManager.CreateEvent("DGEventConvoyBlocked")
        l_10_0.Blocked = l_8_0.convoyBlocked
        if l_8_3 and l_8_3.isBlocked and not ValidatePos(l_8_3.nodeName, "Vec3") then
          l_10_0.WorldPos = l_8_0.vehicles[1]:GetPos()
        end
        l_8_2:SendEvent(l_10_0, 0)
         end, 0)
      end
    end
  end
end

l_0_0.Update = function(l_9_0)
  l_9_0:UpdateBlockers()
  l_9_0:UpdateVehicle()
end

l_0_0.UpdateBlockers = function(l_10_0)
  if nintable(l_10_0.vehicles) > 0 then
    local l_10_1 = l_10_0.blockersByPathIndex[l_10_0.vehicles[1]("VehicleComponent").currentPathNodeIndex]
    local l_10_2 = l_10_0.convoyBlocked
    if l_10_1 and l_10_1.isBlocked then
      l_10_0.convoyBlocked = true
    else
      l_10_0.convoyBlocked = false
    end
    if l_10_2 ~= l_10_0.convoyBlocked then
      local l_10_3 = DEEventManager.CreateEvent("DGEventConvoyBlocked")
      l_10_3.Blocked = l_10_0.convoyBlocked
      if l_10_1 and l_10_1.isBlocked and not ValidatePos(l_10_1.nodeName, "Vec3") then
        l_10_3.WorldPos = l_10_0.vehicles[1]:GetPos()
      end
      DEEventManager.AddEvent(l_10_3, 0)
    end
  end
end

l_0_0.UpdateVehicle = function(l_11_0)
  do
    local l_11_1 = 0
    if next(l_11_0.vehicles) then
      local l_11_2 = l_11_0:GetConvoyMod()
      if l_11_2 > 0 then
        l_11_1 = l_11_0.vehicleMinSpeed + (l_11_0.vehicleMaxSpeed - l_11_0.vehicleMinSpeed) * l_11_2
      end
    end
    if l_11_1 > 0 then
      l_11_0.mostRecentNonZeroCruiseControlMPH = l_11_1
    end
    for l_11_6,l_11_7 in ipairs(l_11_0.vehicles) do
      local l_11_8 = l_11_7.VehicleComponent.pathProgress
      local l_11_9 = l_11_7.VehicleComponent.desiredPathProgress
      if l_11_1 > 0 then
        l_11_9 = (math.floor((l_11_8 + 0.012500000186265) * 40) + 1) / 40
        l_11_7.VehicleComponent.desiredPathProgress = l_11_9
      elseif l_11_8 < l_11_9 and not l_11_0.convoyBlocked then
        l_11_1 = l_11_0.mostRecentNonZeroCruiseControlMPH
      end
      if l_11_6 > 1 and l_11_7:GetPos():Distance(l_11_0.vehicles[l_11_6 - 1]:GetPos()) < 450 then
        l_11_7.entity:SetCruiseControlMPH(0)
        for l_11_6,l_11_7 in l_11_3 do
        end
        if l_11_6 > 1 and l_11_7:GetPos():Distance(l_11_0.vehicles[l_11_6 - 1]:GetPos()) > 600 then
          l_11_7.entity:SetCruiseControlMPH(l_11_1 + 5)
          for l_11_6,l_11_7 in l_11_3 do
          end
          l_11_7.entity:SetCruiseControlMPH(l_11_1)
        end
      end
       -- Warning: missing end command somewhere! Added here
    end
     -- Warning: missing end command somewhere! Added here
  end
end

DeclareClass(l_0_0)

