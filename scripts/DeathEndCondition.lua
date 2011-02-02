-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: DeathEndCondition.luac 

module("DeathEndCondition", package.seeall)
require("EndCondition")
local l_0_0 = {}
l_0_0.ArgsConstructor = function(l_1_0, l_1_1, l_1_2)
  l_1_0.factionName = l_1_1
  l_1_0.callback = l_1_2
  l_1_0:SetConditionFunction(function()
    if not l_1_0.emptyFaction then
      local l_2_0 = not next(l_1_0.remainingPlayers)
    else
      return false
    end
   end)
  local l_1_3 = DGFactionManager.GetFaction(l_1_0.factionName)
  local l_1_4 = DGPlayerManager.GetPlayersOnFactionByID(l_1_3:GetFactionID())
  if l_1_4 then
    for l_1_8,l_1_9 in pairs(l_1_4) do
      if not l_1_9:IsJoiningInProgress() then
        l_1_0.remainingPlayers[l_1_9:GetPlayerID()] = true
      end
    end
  else
    l_1_0.emptyFaction = true
  end
  DEEventManager.SubscribeEvent("DGEventKill", function(l_2_0)
    l_1_0:HandleKill(l_2_0)
   end)
  DEEventManager.SubscribeEvent("DGEventPlayerAction", function(l_3_0)
    l_1_0:HandlePlayerAction(l_3_0)
   end)
end

l_0_0.Initialize = function(l_2_0)
  l_2_0.name = "DeathEndCondition"
  l_2_0.reason = "DeathEndCondition"
  l_2_0.enabled = true
  l_2_0.remainingPlayers = {}
end

l_0_0.HandleKill = function(l_3_0, l_3_1)
  local l_3_2 = DGEntityManager.GetEntityByID(l_3_1.EntityBucket, l_3_1.EntityID)
  l_3_0.remainingPlayers[l_3_2:GetPlayerID()] = nil
  if not next(l_3_0.remainingPlayers) then
    l_3_0:AddPointsToOpposingTeam()
  end
end

l_0_0.HandlePlayerAction = function(l_4_0, l_4_1)
  if l_4_1.Action == 1 then
    l_4_0.remainingPlayers[l_4_1.PlayerID] = nil
    if not next(l_4_0.remainingPlayers) then
      l_4_0:AddPointsToOpposingTeam()
    end
  end
end

l_0_0.AddPointsToOpposingTeam = function(l_5_0)
  local l_5_1 = {}
  l_5_1.BlackOps = "OpFor"
  l_5_1.OpFor = "BlackOps"
  gameInfo:SetTeamScore(100, l_5_1[l_5_0.factionName])
end

l_0_0.Name = "DeathEndCondition"
l_0_0.Extends = "EndCondition"
DeclareClass(l_0_0)

