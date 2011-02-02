-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: Conquest.luac 

module("Conquest", package.seeall)
require("Gametype")
require("TimeEndCondition")
require("CaptureGameCondition")
require("ScoreEndCondition")
require("CaptureScoringCondition")
local l_0_0 = {}
l_0_0.Name = "Conquest"
l_0_0.Extends = "Gametype"
l_0_0.ArgsConstructor = function(l_1_0, l_1_1)
  l_1_0.timeLimit = toseconds(l_1_1.time_limit)
  l_1_0.spawnDelay = tonumber(l_1_1.respawn_interval)
  l_1_0.spawnBonus = 2
  l_1_0.spawnThreshold = 6
  l_1_0.reversed = toboolean(l_1_1.switch_teams)
  l_1_0.scoreLimit = 250
  gameInfo:SetScoreLimit(l_1_0.scoreLimit)
  l_1_0:InitGameData()
end

l_0_0.GetNextRespawn = function(l_2_0, l_2_1, l_2_2, l_2_3)
  local l_2_4 = math.huge
  do
    local l_2_5 = nil
    for l_2_9,l_2_10 in pairs(l_2_0.capPointTable) do
      if l_2_10.team == l_2_3 and l_2_10.spawnAdvancing then
        local l_2_11 = l_2_2:Distance(l_2_10.pos)
        if l_2_11 < l_2_4 then
          l_2_5 = l_2_10
          l_2_4 = l_2_11
        end
      end
    end
    do
       -- DECOMPILER ERROR: Confused at declaration of local variable

    end
    if not l_2_5 then
      return l_2_0.factionBases[l_2_3]
    end
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

l_0_0.InitGameData = function(l_3_0)
  l_3_0.factionBases = {}
  if l_3_0.reversed then
    l_3_0.base1owner = "OpFor"
    l_3_0.base2owner = "BlackOps"
  else
    l_3_0.base1owner = "BlackOps"
    l_3_0.base2owner = "OpFor"
  end
  l_3_0.factionBases[l_3_0.base1owner] = "loc_base1"
  l_3_0.factionBases[l_3_0.base2owner] = "loc_base2"
  if DGDataNodeManager.EnumAllNodesOfType("DGDataNodeTeamBase") then
    for l_3_4,l_3_5 in pairs(DGDataNodeManager.EnumAllNodesOfType("DGDataNodeTeamBase")) do
      if l_3_5.BaseID == 1 then
        l_3_0.factionBases[l_3_0.base1owner] = l_3_5
        for l_3_4,l_3_5 in l_3_1 do
        end
        if l_3_5.BaseID == 2 then
          l_3_0.factionBases[l_3_0.base2owner] = l_3_5
        end
      end
    end
    ps:SetFactionLocus(l_3_0.base1owner, l_3_0.factionBases[l_3_0.base1owner])
    ps:SetFactionLocus(l_3_0.base2owner, l_3_0.factionBases[l_3_0.base2owner])
    ps:SetRespawnTime(l_3_0.base1owner, l_3_0.spawnDelay)
    ps:SetRespawnTime(l_3_0.base2owner, l_3_0.spawnDelay)
     -- Warning: missing end command somewhere! Added here
  end
end

l_0_0.HQChatter = function(l_4_0)
  DGApp.DoMPLua("client:HQRadioChatter(\"HQ_Radio_Message_General\", \"HQ_Conquest_Start\", 0)")
  DGApp.DoMPLua("client:HQRadioChatter(\"HQ_Radio_Message_General\", \"HQ_Conquest_Start\", 1)")
end

l_0_0.OnAddJoinInProgressPlayer = function(l_5_0, l_5_1, l_5_2)
  for l_5_6,l_5_7 in pairs(gameInfo.teamInfo) do
    DGFactionManager.GetFaction(l_5_6):SetScore(l_5_7.score)
  end
end

l_0_0.Initialize = function(l_6_0)
  l_6_0.name = "Conquest"
end

l_0_0.PostStartGame = function(l_7_0)
  l_7_0.capPointTable = {}
  for l_7_4,l_7_5 in pairs(DGDataNodeManager.EnumAllNodesOfType("DGDataNodeCapturePoint")) do
    local l_7_6 = new
    local l_7_7 = "CaptureGameCondition"
    local l_7_8 = {}
    l_7_8.datanode = l_7_5
    l_7_8.id = l_7_4
    l_7_6 = l_7_6(l_7_7, l_7_8)
    l_7_7, l_7_8 = l_7_0:AddGameCondition, l_7_0
    l_7_7(l_7_8, l_7_6)
    l_7_7 = l_7_0.capPointTable
    l_7_8 = l_7_6.name
    l_7_7[l_7_8] = l_7_6
  end
  local l_7_9, l_7_13 = new
  l_7_13 = "CaptureScoringCondition"
   -- DECOMPILER ERROR: Confused at declaration of local variable

  local l_7_11, l_7_15 = "Cap Point Scoring"
  do
     -- DECOMPILER ERROR: Confused at declaration of local variable

    l_7_15 = {capPoints = l_7_0.capPointTable, allcap = false, scoreLimit = l_7_0.scoreLimit}
    l_7_9 = l_7_9(l_7_13, l_7_11, l_7_15)
    l_7_13, l_7_11 = l_7_0:AddScoringCondition, l_7_0
    l_7_15 = l_7_9
    l_7_13(l_7_11, l_7_15)
    l_7_13 = new
    l_7_11 = "ScoreEndCondition"
    l_7_15 = l_7_0.scoreLimit
    l_7_13 = l_7_13(l_7_11, l_7_15)
    l_7_11, l_7_15 = l_7_0:AddEndCondition, l_7_0
    l_7_11(l_7_15, l_7_13)
    l_7_11 = new
    l_7_15 = "TimeEndCondition"
    l_7_11 = l_7_11(l_7_15, l_7_0.timeLimit)
    l_7_15(l_7_0, l_7_11)
    l_7_15 = l_7_0:AddEndCondition
    l_7_15 = delay
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

   -- DECOMPILER ERROR: Confused about usage of registers!

  l_7_15(function()
    l_7_0:HQChatter()
   end, 10)
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

DeclareClass(l_0_0)

