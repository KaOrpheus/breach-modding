-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: RetrievalGameCondition.luac 

module("RetrievalGameCondition", package.seeall)
require("GameCondition")
local l_0_0 = {}
l_0_0.Name = "RetrievalGameCondition"
l_0_0.Extends = "GameCondition"
l_0_0.ArgsConstructor = function(l_1_0, l_1_1)
  l_1_0.radius = 80
  l_1_0.points = 50
  local l_1_2 = l_1_0.extPoints
  local l_1_3 = currentGame.base1owner
  l_1_2[l_1_3] = {}
  l_1_2 = l_1_0.extPoints
  l_1_3 = currentGame
  l_1_3 = l_1_3.base2owner
  l_1_2[l_1_3] = {}
  l_1_2 = pairs
  l_1_3 = DGDataNodeManager
  l_1_3 = l_1_3.EnumAllNodesOfType
  l_1_3 = l_1_3("DGDataNodeExtraction")
  l_1_2 = l_1_2(l_1_3)
  for i_1,i_2 in l_1_2 do
    if l_1_6.Faction == 0 then
      table.insert(l_1_0.extPoints.BlackOps, l_1_6)
      for l_1_5,l_1_6 in l_1_2 do
      end
      table.insert(l_1_0.extPoints.OpFor, l_1_6)
    end
    PlayerManager.RegisterDeathFunction("Retrieval Death", function(l_1_0)
      l_1_0:HandleDeath(l_1_0)
      end)
    l_1_0:SpawnIntel()
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

     -- Warning: missing end command somewhere! Added here
  end
end

l_0_0.DropObject = function(l_2_0)
  DGApp.DoMPLua("client:ScreenMessage(\"Player Dropped Object\")")
end

l_0_0.HandleDeath = function(l_3_0, l_3_1)
  local l_3_2 = l_3_0.canister:GetOwnerID()
  local l_3_3 = DGPlayerManager.GetPlayerByID(l_3_1.PlayerID)
  local l_3_4 = DGPlayerManager.GetPlayerByID(l_3_1.KillerPlayerID)
  if l_3_3 and l_3_4 and l_3_2 == l_3_1.EntityID and l_3_3:GetFactionID() ~= l_3_4:GetFactionID() then
    for l_3_8,l_3_9 in pairs(l_3_0.extPoints[l_3_3:GetFaction():GetName()]) do
      local l_3_10 = ObjectPool.Get("Vec3"):Set(l_3_0.canister:GetPos())
      local l_3_11 = ObjectPool.Get("Vec3"):Set(l_3_9:GetWorldPosition())
      if l_3_11:Distance(l_3_10) < l_3_0.bonusRadius and l_3_1.KillerPlayerID then
        DGApp.DoMPLua("client:AddXP(" .. l_3_1.KillerPlayerID .. ",15,\"xp_retrieval_stopped\")")
      end
      ObjectPool.Recycle(l_3_10)
      ObjectPool.Recycle(l_3_11)
    end
  end
end

l_0_0.HandleCanisterDrop = function(l_4_0, l_4_1)
  local l_4_2 = DGPlayerManager.GetPlayerByID(l_4_1.PlayerID)
  if l_4_2 then
    currentGame:ResetSpawns()
  end
end

l_0_0.HandleCanisterPickup = function(l_5_0, l_5_1)
  local l_5_2 = DGPlayerManager.GetPlayerByID(l_5_1.PlayerID)
  local l_5_3 = l_5_2:GetFaction():GetName()
  if l_5_2 and l_5_3 then
    ps:SetFactionLocus(l_5_3, l_5_2:GetControlEntity(), 200, 2000)
  end
end

l_0_0.Initialize = function(l_6_0)
  l_6_0.enabled = true
  l_6_0.retrieved = false
  l_6_0.objectLocs = {}
  l_6_0.extPoints = {}
  l_6_0.bonusRadius = 200
  l_6_0.consecutiveCarriedUpdates = 0
  for l_6_4 = 1, 10 do
    local l_6_5 = "loc_object" .. l_6_4
    if ValidatePos(l_6_5, "Vec3") then
      table.insert(l_6_0.objectLocs, l_6_5)
    end
  end
  DEEventManager.SubscribeEvent("DGEventCanisterDropped", function(l_1_0)
    l_6_0:HandleCanisterDrop(l_1_0)
   end)
  DEEventManager.SubscribeEvent("DGEventCanisterPickedUp", function(l_2_0)
    l_6_0:HandleCanisterPickup(l_2_0)
   end)
  l_6_0.deathEventTicket = DEEventManager.SubscribeEvent("DGEventKill", function(l_3_0)
    l_6_0:HandleDeath(l_3_0)
   end)
end

l_0_0.SyncJIPPlayer = function(l_7_0, l_7_1)
  local l_7_2 = DGPlayerManager.GetPlayerByID(l_7_1)
  if l_7_0.canister then
    if l_7_0.canister:GetOwnerID() ~= -1 then
      DGSpawnManager.JIPSpawn(l_7_1, l_7_0.canister, "DGInventoryObjectiveSpawnInfo")
    end
    local l_7_3 = DEEventManager.CreateEvent("DGEventCanisterAdded")
    l_7_3.BucketID = l_7_0.canister:GetBucketID()
    l_7_3.EntityID = l_7_0.canister:GetID()
    l_7_2:SendEvent(l_7_3, 0)
  end
end

l_0_0.SpawnIntel = function(l_8_0)
  if l_8_0.objectLocs and nintable(l_8_0.objectLocs) > 0 then
    local l_8_1 = l_8_0.objectLocs[1]
    table.shuffle(l_8_0.objectLocs)
    if l_8_1 == l_8_0.objectLocs[1] and l_8_0.objectLocs[2] then
      local l_8_2, l_8_3 = l_8_0.objectLocs[2]
    end
     -- DECOMPILER ERROR: Confused about usage of registers!

     -- DECOMPILER ERROR: Confused at declaration of local variable

    print("Retrieval: Spawning Intel Canister")
    do
       -- DECOMPILER ERROR: Confused at declaration of local variable

      SpawnManager.Spawn("intel_canister", "DGInventoryObjectiveSpawnInfo", ValidatePos(l_8_2, "PosQuat"), function(l_1_0, l_1_1)
      local l_9_2 = DEEventManager.CreateEvent("DGEventCanisterAdded")
      l_9_2.BucketID = l_1_0
      l_9_2.EntityID = l_1_1
      DEEventManager.AddEvent(l_9_2, 0)
      print("Releasing Event for: eID " .. l_1_0 .. " bID " .. l_1_1)
      l_8_0.canister = DGEntityManager.GetEntityByID(l_1_0, l_1_1)
      end, nil, nil, 0, ValidatePos(l_8_2, "PosQuat"))
    end
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

l_0_0.Update = function(l_9_0)
  if l_9_0.canister and l_9_0.canister:GetPos() then
    local l_9_1 = ObjectPool.Get("Vec3"):Set(l_9_0.canister:GetPos())
    local l_9_2 = l_9_0.canister:GetFaction()
    if l_9_0.canisterFaction ~= l_9_2 then
      if l_9_2 ~= nil then
        DGApp.DoMPLua("client:HQRadioChatter(" .. "\"HQ_Radio_Message_Capturing\", " .. "\"HQ_Retrieval_Canister_Picked_Up_Friendly\", " .. tostring(l_9_2:GetFactionID()) .. ")")
        local l_9_3 = l_9_2:GetEnemyFactions()
        for l_9_7,l_9_8 in pairs(l_9_3) do
          DGApp.DoMPLua("client:HQRadioChatter(" .. "\"HQ_Radio_Message_Losing\", " .. "\"HQ_Retrieval_Canister_Picked_Up_Enemy\", " .. tostring(l_9_8:GetFactionID()) .. ")")
        end
      end
      l_9_0.canisterFaction = l_9_2
    end
    if l_9_2 then
      l_9_3 = DGPlayerManager
      l_9_3 = l_9_3.GetPlayerByEntityID
      l_9_3 = l_9_3(l_9_0.canister:GetOwnerID())
       -- DECOMPILER ERROR: Confused at declaration of local variable

      if l_9_3 and not l_9_3:GetControlEntity():GetEntityState():IsInState("Pickup") then
        l_9_0.consecutiveCarriedUpdates = l_9_0.consecutiveCarriedUpdates + 1
        if l_9_0.consecutiveCarriedUpdates > 4 then
          for l_9_13,l_9_14 in pairs(l_9_0.extPoints[l_9_2:GetName()]) do
            local l_9_15 = ObjectPool.Get("Vec3"):Set(l_9_14:GetWorldPosition())
            if l_9_15:Distance(l_9_1) < l_9_14.Radius then
              DGApp.DoMPLua("client:AddXP(" .. l_9_3:GetPlayerID() .. ",50,\"xp_retrieval\")")
              for l_9_19,l_9_20 in pairs(l_9_2:GetMembers()) do
                if l_9_20 ~= l_9_0.canister then
                  local l_9_21 = ObjectPool.Get("Vec3"):Set(l_9_20:GetPos())
                  if l_9_20:GetPlayerID() ~= l_9_3:GetPlayerID() and l_9_21:Distance(l_9_1) < l_9_0.bonusRadius then
                    DGApp.DoMPLua("client:AddXP(" .. l_9_20:GetPlayerID() .. ",15,\"xp_retrieval_assist\")")
                  end
                  ObjectPool.Recycle(l_9_21)
                end
              end
              do
                local l_9_22 = DEEventManager.CreateEvent("DGEventCanisterRetrieved")
                l_9_22.Faction = l_9_14.Faction
                DEEventManager.AddEvent(l_9_22, l_9_0.canister:GetSubjectString())
                currentGame:ResetSpawns()
                DGApp.DoMPLua("client:HQRadioChatter(" .. "\"HQ_Radio_Message_Capturing\", " .. "\"HQ_Retrieval_Canister_Retrieved\", " .. tostring(l_9_2:GetFactionID()) .. ")")
                gameInfo:AddPoints(l_9_0.points, DGFactionManager.GetFactionByID(l_9_14.Faction):GetName())
                ScriptManager.RegisterDelayFunction("Canister Spawning", function()
                l_9_0:SpawnIntel()
                     end, 3)
              end
              l_9_0.canister = nil
            end
            ObjectPool.Recycle(l_9_15)
          end
        else
          l_9_0.consecutiveCarriedUpdates = 0
        end
      end
    end
    ObjectPool.Recycle(l_9_1)
  end
end

DeclareClass(l_0_0)

