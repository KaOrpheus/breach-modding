-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: Siege.luac 

module("Siege", package.seeall)
require("Gametype")
require("TimeEndCondition")
require("CaptureGameCondition")
require("ScoreEndCondition")
require("CaptureScoringCondition")
require("SiegeEndCondition")
local l_0_0 = {}
l_0_0.Name = "Siege"
l_0_0.Extends = "Gametype"
l_0_0.ArgsConstructor = function(l_1_0, l_1_1)
  if l_1_1 then
    l_1_0.timeLimit = toseconds(l_1_1.time_limit)
    l_1_0.playerRespawns = tonumber(l_1_1.lives_limit)
    l_1_0.teamRespawns = tonumber(l_1_1.lives_limit_per_faction)
    l_1_0.spawnDelay = tonumber(l_1_1.respawn_interval)
    if l_1_0.playerRespawns then
      l_1_0.playerRespawns = l_1_0.playerRespawns - 1
    else
      l_1_0.playerRespawns = -1
    end
  end
  l_1_0.scoreLimit = 250
  l_1_0:InitGameData()
end

l_0_0.InitGameData = function(l_2_0)
  l_2_0.factionBases = {}
  if l_2_0.reversed then
    l_2_0.factionBases.MarineFaction = "loc_base2"
    l_2_0.factionBases.InsurgentFaction = "loc_base1"
  else
    l_2_0.factionBases.MarineFaction = "loc_base1"
    l_2_0.factionBases.InsurgentFaction = "loc_base2"
  end
  ps:SetFactionLocus("MarineFaction", l_2_0.factionBases.MarineFaction)
  ps:SetFactionLocus("InsurgentFaction", l_2_0.factionBases.InsurgentFaction)
end

l_0_0.Initialize = function(l_3_0)
  l_3_0.name = "Siege"
end

l_0_0.ProcessEvent = function(l_4_0, l_4_1)
  if l_4_1.name == "capped" then
    for l_4_5,l_4_6 in pairs(l_4_0.capPointTable) do
      if l_4_6 ~= l_4_1.capPoint and (not l_4_6.destroyed or not l_4_6.team) then
        l_4_6:SetEnabled(false)
      end
    end
    if l_4_1.capPoint.team == "MarineFaction" then
      ps:SetFactionLocus("InsurgentFaction", l_4_1.capPoint.name, 1500, 3000)
    else
      ps:SetFactionLocus("MarineFaction", l_4_1.capPoint.name, 1500, 3000)
    end
    ps:SetFactionLocus(l_4_1.capPoint.team, l_4_1.capPoint.name)
    ps:SetRespawnTime(l_4_1.capPoint.team, 15)
  elseif l_4_1.name == "destroyed" then
    for l_4_10,l_4_11 in pairs(l_4_0.capPointTable) do
      if not l_4_11.destroyed then
        l_4_11:SetEnabled(true)
      end
    end
    ps:SetFactionLocus("InsurgentFaction", l_4_0.factionBases.InsurgentFaction)
    ps:SetFactionLocus("MarineFaction", l_4_0.factionBases.MarineFaction)
    ps:SetRespawnTime("InsurgentFaction", 10)
    ps:SetRespawnTime("MarineFaction", 10)
  end
end

l_0_0.PostStartGame = function(l_5_0)
  l_5_0.capPointTable = {}
  for l_5_4,l_5_5 in pairs(DGDataNodeManager.EnumAllNodesOfType("DGDataNodeCapturePoint")) do
    local l_5_6 = new
    local l_5_7 = "CaptureGameCondition"
    local l_5_8 = {}
    l_5_8.datanode = l_5_5
    l_5_8.id = l_5_4
    l_5_8.targetNode = "cap_" .. l_5_4 + 1 .. "_intel"
    l_5_6 = l_5_6(l_5_7, l_5_8)
    l_5_7, l_5_8 = l_5_0:AddGameCondition, l_5_0
    l_5_7(l_5_8, l_5_6)
    l_5_7 = l_5_0.capPointTable
    l_5_8 = l_5_6.name
    l_5_7[l_5_8] = l_5_6
  end
  local l_5_9, l_5_13 = new
  l_5_13 = "CaptureScoringCondition"
   -- DECOMPILER ERROR: Confused at declaration of local variable

  local l_5_11, l_5_15 = "Cap Point Scoring"
  do
     -- DECOMPILER ERROR: Confused at declaration of local variable

    l_5_15 = {capPoints = l_5_0.capPointTable, allcap = false, scoreLimit = l_5_0.scoreLimit, interval = 1}
    l_5_9 = l_5_9(l_5_13, l_5_11, l_5_15)
    l_5_13, l_5_11 = l_5_0:AddScoringCondition, l_5_0
    l_5_15 = l_5_9
    l_5_13(l_5_11, l_5_15)
    l_5_13 = l_5_0.timeLimit
    if l_5_13 then
      l_5_13 = l_5_0.timeLimit
      if l_5_13 > 0 then
        l_5_13 = new
        l_5_11 = "TimeEndCondition"
        l_5_15 = l_5_0.timeLimit
        l_5_13 = l_5_13(l_5_11, l_5_15)
        l_5_11, l_5_15 = l_5_0:AddEndCondition, l_5_0
        l_5_11(l_5_15, l_5_13)
      end
    end
    l_5_13 = new
    l_5_11 = "SiegeEndCondition"
    l_5_15 = l_5_0.capPointTable
    l_5_13 = l_5_13(l_5_11, l_5_15)
    l_5_11, l_5_15 = l_5_0:AddEndCondition, l_5_0
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

   -- DECOMPILER ERROR: Confused about usage of registers!

   -- DECOMPILER ERROR: Confused about usage of registers!

  l_5_11(l_5_15, l_5_13)
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

DeclareClass(l_0_0)

