-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: LevelStats.luac 

module("LevelStats", package.seeall)
local l_0_0 = function(l_1_0)
  if ((DGMultiplayer.IsRunning() and not DGMultiplayer.IsHost()) or not gameType or DGPlayerManager.GetNumPlayers() < 4) then
    return 
  end
  local l_1_1 = {}
  l_1_1.MapName = DGApp.GetScenarioName()
  l_1_1.DeathType = l_1_0.DeathType
  l_1_1.DamageOrigin = l_1_0.DamageOrigin
  if l_1_0.KillerID == -1 and l_1_0.KillerPlayerID then
    local l_1_2 = DGPlayerManager.GetPlayerByID(l_1_0.KillerPlayerID)
    if l_1_2 then
      l_1_1.KillerEntityName = gameType:GetFaction(l_1_2:GetFactionID()):GetRole(l_1_2:GetRoleDataIndex()).SpawnInfo
    else
      l_1_1.KillerEntityName = "NonPlayer"
    end
  end
  if l_1_0.WeaponID == -1 then
    local l_1_3 = DGEntityManager.GetEntityByID(DGEntityManager.eInventoryBucket, l_1_0.WeaponID)
    if l_1_3 then
      l_1_1.Weapon = l_1_3:GetActiveMod():GetDescription()
    else
      l_1_1.Weapon = ""
    end
  end
  local l_1_4 = DGEntityManager.GetEntityByID(l_1_0.EntityBucket, l_1_0.EntityID)
  l_1_1.KilledEntityName = l_1_4:GetSpawnName()
  l_1_1.DeathLocation = new("Vec3", l_1_4:GetPos())
  l_1_1.GameTime = gGameTime
  DEDevStats.RecordStat("Death", 1, l_1_1)
end

local l_0_1 = function(l_2_0)
  if ((DGMultiplayer.IsRunning() and not DGMultiplayer.IsHost()) or not gameType or DGPlayerManager.GetNumPlayers() < 4) then
    return 
  end
  local l_2_1 = {}
  l_2_1.MapName = DGApp.GetScenarioName()
  l_2_1.GameTime = gGameTime
  l_2_1.SpawnName = l_2_0.SpawnInfo.Name
  DEDevStats.RecordStat("Spawn", 1, l_2_1)
end

if DEDevStats then
  DEEventManager.SubscribeEvent("DGEventKill", l_0_0)
  DEEventManager.SubscribeEvent("DGEventSpawn", l_0_1)
end

