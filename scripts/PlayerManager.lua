-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: PlayerManager.luac 

module("PlayerManager", package.seeall)
local l_0_0 = _G
local l_0_1 = {}
l_0_1.players = {}
l_0_1.playerCameras = {}
l_0_1.notifyDeathFunctions = {}
l_0_1.killUnsubscribeTickets = {}
l_0_1.deleteUnsubscribeTickets = {}
l_0_0.PlayerManager = l_0_1
l_0_0 = PlayerManager
l_0_1 = function(l_1_0, l_1_1)
  table.insert(l_1_0.players, l_1_1)
  l_1_0.killUnsubscribeTickets[l_1_1] = DEEventManager.SubscribeEvent("DGEventKill", PlayerManager.HandlePlayerKilled, l_1_1:GetSubjectString())
  l_1_0.deleteUnsubscribeTickets[l_1_1] = DEEventManager.SubscribeEvent("DGEventDeleteEntity", PlayerManager.HandleEntityDeleted, l_1_1:GetSubjectString())
end

l_0_0.AddPlayer = l_0_1
l_0_0 = PlayerManager
l_0_1 = function(l_2_0, l_2_1, l_2_2, l_2_3)
  if not l_2_2 then
    local l_2_4, l_2_6, l_2_7 = new("Vec3", DGGameView.GetCameraPos()), l_2_1
  end
   -- DECOMPILER ERROR: Confused about usage of registers!

  do
     -- DECOMPILER ERROR: Confused at declaration of local variable

  do
    end
     -- DECOMPILER ERROR: Confused about usage of registers!

    SpawnManager.Spawn(l_2_6 or "MarineAllWeapons", "DGHumanSpawnInfo", l_2_4, function(l_1_0, l_1_1)
    local l_3_2 = DGEntityManager.GetEntityByID(l_1_0, l_1_1)
    l_2_0:SetPlayer(l_1_0, l_1_1)
    SensorManager.SetEntityTag(l_3_2, l_2_3)
   end)
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.SpawnPlayer = l_0_1
l_0_0 = PlayerManager
l_0_1 = function(l_3_0, l_3_1, l_3_2, l_3_3)
  if not l_3_3 then
    l_3_3 = 0
  end
  local l_3_4 = DEEventManager.CreateEvent("DGEventSwitchFocusRequest")
  l_3_4.EntityBucket = l_3_1
  l_3_4.EntityID = l_3_2
  l_3_4.PlayerID = l_3_3
  local l_3_5 = DEEventManager.CreateEvent("DGEventSwitchControlRequest")
  l_3_5.EntityBucket = l_3_1
  l_3_5.EntityID = l_3_2
  l_3_5.PlayerID = l_3_3
  DEEventManager.AddEvent(l_3_4, "DGP" .. l_3_3)
  DEEventManager.AddEvent(l_3_5, "DGP" .. l_3_3)
  local l_3_6 = DGEntityManager.GetEntityByID(l_3_1, l_3_2)
  local l_3_7 = AIManager.GetAIByEntity(l_3_6)
  if l_3_7 then
    AIManager.NotifyAgentOfPlayerControlAcquired(l_3_7)
  end
  PlayerManager:AddPlayer(l_3_6)
end

l_0_0.SetPlayer = l_0_1
l_0_0 = PlayerManager
l_0_1 = function(l_4_0)
  local l_4_1 = DGEntityManager.GetEntityByID(l_4_0.Bucket, l_4_0.EntityID)
  for l_4_5,l_4_6 in pairs(PlayerManager.notifyDeathFunctions) do
    l_4_6(l_4_0)
  end
  PlayerManager.RemoveEntity(l_4_1)
end

l_0_0.HandleEntityDeleted = l_0_1
l_0_0 = PlayerManager
l_0_1 = function(l_5_0)
  local l_5_1 = DGEntityManager.GetEntityByID(l_5_0.EntityBucket, l_5_0.EntityID)
  for l_5_5,l_5_6 in pairs(PlayerManager.notifyDeathFunctions) do
    l_5_6(l_5_0)
  end
  PlayerManager.RemoveEntity(l_5_1)
end

l_0_0.HandlePlayerKilled = l_0_1
l_0_0 = PlayerManager
l_0_1 = function(l_6_0, l_6_1)
  if l_6_0 and l_6_1 then
    PlayerManager.notifyDeathFunctions[l_6_0] = l_6_1
  end
end

l_0_0.RegisterDeathFunction = l_0_1
l_0_0 = PlayerManager
l_0_1 = function(l_7_0)
  for l_7_4,l_7_5 in pairs(PlayerManager.players) do
    if l_7_0 == l_7_5 then
      PlayerManager.players[l_7_4] = nil
    end
  end
  DEEventManager.UnsubscribeEvent(PlayerManager.deleteUnsubscribeTickets[l_7_0])
  DEEventManager.UnsubscribeEvent(PlayerManager.killUnsubscribeTickets[l_7_0])
  PlayerManager.deleteUnsubscribeTickets[l_7_0] = nil
  PlayerManager.killUnsubscribeTickets[l_7_0] = nil
end

l_0_0.RemoveEntity = l_0_1
l_0_0 = PlayerManager
l_0_1 = function(l_8_0)
  if l_8_0 and PlayerManager.notifyDeathFunctions[l_8_0] then
    PlayerManager.notifyDeathFunctions[l_8_0] = nil
  end
end

l_0_0.UnregisterDeathFunction = l_0_1

