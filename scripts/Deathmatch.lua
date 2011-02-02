-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: Deathmatch.luac 

module("Deathmatch", package.seeall)
require("Gametype")
require("ScoreEndCondition")
require("TimeEndCondition")
require("DeathScoringCondition")
local l_0_0 = {}
l_0_0.Name = "Deathmatch"
l_0_0.Extends = "Gametype"
l_0_0.ArgsConstructor = function(l_1_0, l_1_1)
  l_1_0.timeLimit = toseconds(l_1_1.time_limit)
  l_1_0.scoreLimit = 50
  l_1_0.reversed = toboolean(l_1_1.switch_teams)
  l_1_0:InitGameData()
end

l_0_0.InitGameData = function(l_2_0)
  l_2_0.factionBases = {}
  if l_2_0.reversed then
    l_2_0.base1owner = "OpFor"
    l_2_0.base2owner = "BlackOps"
  else
    l_2_0.base1owner = "BlackOps"
    l_2_0.base2owner = "OpFor"
  end
  l_2_0.factionBases[l_2_0.base1owner] = "loc_base1"
  l_2_0.factionBases[l_2_0.base2owner] = "loc_base2"
  if DGDataNodeManager.EnumAllNodesOfType("DGDataNodeTeamBase") then
    for l_2_4,l_2_5 in pairs(DGDataNodeManager.EnumAllNodesOfType("DGDataNodeTeamBase")) do
      if l_2_5.BaseID == 1 then
        l_2_0.factionBases[l_2_0.base1owner] = l_2_5
        for l_2_4,l_2_5 in l_2_1 do
        end
        if l_2_5.BaseID == 2 then
          l_2_0.factionBases[l_2_0.base2owner] = l_2_5
        end
      end
    end
    ps:SetFactionLocus(l_2_0.base1owner, l_2_0.factionBases[l_2_0.base1owner])
    ps:SetFactionLocus(l_2_0.base2owner, l_2_0.factionBases[l_2_0.base2owner])
    ps:SetRespawnTime(l_2_0.base1owner, l_2_0.spawnDelay)
    ps:SetRespawnTime(l_2_0.base2owner, l_2_0.spawnDelay)
     -- Warning: missing end command somewhere! Added here
  end
end

l_0_0.Initialize = function(l_3_0)
  l_3_0.name = "Deathmatch"
end

l_0_0.HQChatter = function(l_4_0)
  DGApp.DoMPLua("client:HQRadioChatter(\"HQ_Radio_Message_General\", \"HQ_Deathmatch_Start\", 0)")
  DGApp.DoMPLua("client:HQRadioChatter(\"HQ_Radio_Message_General\", \"HQ_Deathmatch_Start\", 1)")
end

l_0_0.OnAddJoinInProgressPlayer = function(l_5_0, l_5_1, l_5_2)
  for l_5_6,l_5_7 in pairs(gameInfo.teamInfo) do
    DGFactionManager.GetFaction(l_5_6):SetScore(l_5_7.score)
  end
end

l_0_0.PostStartGame = function(l_6_0)
  local l_6_1 = new("ScoreEndCondition", l_6_0.scoreLimit)
  l_6_0:AddEndCondition(l_6_1)
  local l_6_2 = new("TimeEndCondition", l_6_0.timeLimit)
  l_6_0:AddEndCondition(l_6_2)
  local l_6_3, l_6_4 = l_6_0:AddScoringCondition, l_6_0
  local l_6_5 = new
  local l_6_6 = "DeathScoringCondition"
  local l_6_7 = "DM Kill Count"
  l_6_5 = l_6_5(l_6_6, l_6_7, {teamPunish = true})
  do
     -- DECOMPILER ERROR: Confused at declaration of local variable

    l_6_3(l_6_4, l_6_5, l_6_6, l_6_7)
    l_6_3 = delay
    l_6_4 = function()
    l_6_0:HQChatter()
   end
    l_6_5 = 10
    l_6_3(l_6_4, l_6_5)
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.Validate = function(l_7_0)
end

DeclareClass(l_0_0)

