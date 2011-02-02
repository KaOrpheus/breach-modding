-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: DeathScoringCondition.luac 

module("DeathScoringCondition", package.seeall)
require("ScoringCondition")
local l_0_0 = {}
l_0_0.Name = "DeathScoringCondition"
l_0_0.Extends = "ScoringCondition"
l_0_0.ArgsConstructor = function(l_1_0, l_1_1, l_1_2)
   -- DECOMPILER ERROR: Confused at declaration of local variable

  l_1_0.name = l_1_1 or "No Name"
  l_1_0.enabled = false
  if not l_1_2.scoreAmount then
    l_1_0.scoreAmount = not l_1_2 or 1
  end
  l_1_0.teamPunish = l_1_2.teamPunish
  l_1_0.scoreAllDeaths = l_1_2.scoreAllDeaths
  if l_1_0.teamPunish then
    local l_1_4 = assert
  end
  l_1_4(not l_1_0.scoreAllDeaths, "teamPunish and scoreAllDeaths are incompatible")
  do return end
  l_1_0.scoreAmount = 1
  l_1_4 = DEEventManager
  l_1_4 = l_1_4.SubscribeEvent
  l_1_4("DGEventKill", function(l_1_0)
    l_1_0:HandleDeath(l_1_0)
   end)
end

l_0_0.HandleDeath = function(l_2_0, l_2_1)
  if l_2_1.KillerPlayerID > -1 and l_2_1.PlayerID > -1 then
    local l_2_2 = DGPlayerManager.GetPlayerByID(l_2_1.KillerPlayerID)
    local l_2_3 = DGPlayerManager.GetPlayerByID(l_2_1.PlayerID)
    if l_2_2 and l_2_2:GetFaction() ~= l_2_3:GetFaction() then
      local l_2_4 = l_2_2:GetFaction():GetName()
      gameInfo:AddPoints(l_2_0.scoreAmount, l_2_4)
    elseif l_2_0.scoreAllDeaths then
      local l_2_5 = DGPlayerManager.GetPlayerByID(l_2_1.PlayerID)
      local l_2_6 = {}
      l_2_6.BlackOps = "OpFor"
      l_2_6.OpFor = "BlackOps"
      gameInfo:AddPoints(l_2_0.scoreAmount, l_2_6[l_2_5:GetFaction():GetName()])
    elseif l_2_0.teamPunish and l_2_2 and l_2_2:GetFaction() == l_2_3:GetFaction() then
      gameInfo:SubtractPoints(l_2_0.scoreAmount, killerTeam)
    elseif l_2_0.scoreAllDeaths and l_2_1.PlayerID > -1 then
      local l_2_7 = DGPlayerManager.GetPlayerByID(l_2_1.PlayerID)
      local l_2_8 = {}
      l_2_8.BlackOps = "OpFor"
      l_2_8.OpFor = "BlackOps"
      gameInfo:AddPoints(l_2_0.scoreAmount, l_2_8[l_2_7:GetFaction():GetName()])
    end
  end
end

DeclareClass(l_0_0)

