-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: Convoy.luac 

module("Convoy", package.seeall)
require("Gametype")
require("DeathEndCondition")
require("TimeEndCondition")
require("ScoreEndCondition")
require("ConvoyGameCondition")
require("CaptureGameCondition")
require("CaptureScoringCondition")
require("TimeScoringCondition")
local l_0_0 = {}
l_0_0.Name = "Convoy"
l_0_0.Extends = "Gametype"
l_0_0.ArgsConstructor = function(l_1_0, l_1_1)
  l_1_0.timeLimit = toseconds(l_1_1.time_limit)
  l_1_0.spawnDelay = tonumber(l_1_1.respawn_interval)
  l_1_0.spawnBonus = 2
  l_1_0.spawnThreshold = 6
  l_1_0.reversed = toboolean(l_1_1.switch_teams)
  l_1_0:InitGameData()
end

l_0_0.GetNextRespawn = function(l_2_0, l_2_1, l_2_2, l_2_3)
  local l_2_4 = math.huge
  local l_2_5 = nil
  do
    local l_2_6 = l_2_0.capPointTable[l_2_1]
    if l_2_6 and l_2_6.nextCap and l_2_0.capPointTable[l_2_6.nextCap] then
      l_2_5 = l_2_0.capPointTable[l_2_6.nextCap]
    else
      for l_2_10,l_2_11 in pairs(l_2_0.capPointTable) do
        if l_2_11.team == l_2_3 then
          local l_2_12 = l_2_2:Distance(l_2_11.pos)
          if l_2_12 < l_2_4 and l_2_11.spawnAdvancing then
            l_2_5 = l_2_11
            l_2_4 = l_2_12
          end
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
  l_3_0.capPointTable = {}
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

l_0_0.Initialize = function(l_4_0)
  l_4_0.name = "Convoy"
end

l_0_0.OnAddJoinInProgressPlayer = function(l_5_0, l_5_1, l_5_2)
  l_5_0.convoyCond:SyncJIPPlayer(l_5_1)
end

l_0_0.StartGame = function(l_6_0)
  for l_6_4,l_6_5 in pairs(DGDataNodeManager.EnumAllNodesOfType("DGDataNodeCapturePoint")) do
    do
      local l_6_6 = new
      local l_6_7 = "CaptureGameCondition"
      local l_6_8 = {}
      l_6_8.datanode = l_6_5
      l_6_8.id = l_6_4
      l_6_8.targetAgent = "convoy"
      l_6_8.targetFaction = l_6_0.base1owner
      l_6_8.owner = l_6_0.base2owner
      l_6_8.captureCallback = function()
        l_6_0.timeScoringCond:AddTime(l_6_5.ExtendedTime)
        print("New timelimit", l_6_0.timeScoringCond.timeleft)
         end
      l_6_6 = l_6_6(l_6_7, l_6_8)
      l_6_7, l_6_8 = l_6_0:AddGameCondition, l_6_0
      l_6_7(l_6_8, l_6_6)
      l_6_7 = l_6_0.capPointTable
      l_6_8 = l_6_6.name
      l_6_7[l_6_8] = l_6_6
    end
  end
  ps:SetFactionLocus(l_6_0.base2owner, l_6_0:GetNextRespawn(l_6_0.name, ValidatePos("loc_cv_spawn", "Vec3"), l_6_0.base2owner))
  ps:StartGame()
  l_6_0.gameStarted = true
end

l_0_0.PostStartGame = function(l_7_0)
  local l_7_1 = new
  local l_7_2 = "CaptureScoringCondition"
  local l_7_3 = "Cap Point Scoring"
  local l_7_4 = {}
  l_7_4.capPoints = l_7_0.capPointTable
  l_7_4.singlecap = true
  l_7_4.interval = 1
  l_7_4.faction = l_7_0.base1owner
  l_7_4.amount = 100 / nintable(l_7_0.capPointTable)
  l_7_1 = l_7_1(l_7_2, l_7_3, l_7_4)
  l_7_2, l_7_3 = l_7_0:AddScoringCondition, l_7_0
  l_7_4 = l_7_1
  l_7_2(l_7_3, l_7_4)
  l_7_2 = new
  l_7_3 = "TimeScoringCondition"
  l_7_4 = "Times up Scoring"
  local l_7_5 = {}
  l_7_5.scoreTime = l_7_0.timeLimit
  l_7_5.faction = l_7_0.base2owner
  l_7_5.clientDisplay = true
  l_7_5.amount = 100
  l_7_2 = l_7_2(l_7_3, l_7_4, l_7_5)
  l_7_0.timeScoringCond = l_7_2
  l_7_2, l_7_3 = l_7_0:AddScoringCondition, l_7_0
  l_7_4 = l_7_0.timeScoringCond
  l_7_2(l_7_3, l_7_4)
  l_7_2 = new
  l_7_3 = "ConvoyGameCondition"
  l_7_4 = {name = "Convoy Condition", startDelay = 5}
  l_7_2 = l_7_2(l_7_3, l_7_4)
  l_7_0.convoyCond = l_7_2
  l_7_2, l_7_3 = l_7_0:AddGameCondition, l_7_0
  l_7_4 = l_7_0.convoyCond
  l_7_2(l_7_3, l_7_4)
  l_7_2 = new
  l_7_3 = "ScoreEndCondition"
  l_7_4 = 100
  l_7_2 = l_7_2(l_7_3, l_7_4)
  l_7_3, l_7_4 = l_7_0:AddEndCondition, l_7_0
  l_7_5 = l_7_2
  l_7_3(l_7_4, l_7_5)
end

DeclareClass(l_0_0)

