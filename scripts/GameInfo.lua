-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: GameInfo.luac 

module("GameInfo", package.seeall)
require("GameInfo")
local l_0_0 = {}
l_0_0.Name = "GameInfo"
l_0_0.AddPoints = function(l_1_0, l_1_1, l_1_2)
  if l_1_1 and l_1_2 then
    l_1_0:SetTeamScore(l_1_0.teamInfo[l_1_2].score + l_1_1, l_1_2)
  end
end

l_0_0.GetTopScore = function(l_2_0)
  return l_2_0.topScore
end

l_0_0.GetTopTeam = function(l_3_0)
  return l_3_0.topTeam
end

l_0_0.GetWinningFaction = function(l_4_0)
  local l_4_1 = DGFactionManager.GetFaction
  local l_4_2 = l_4_0.topTeam
  return l_4_1(l_4_2)
end

l_0_0.GetSpawnParams = function(l_5_0, l_5_1)
  return l_5_0.teamInfo[l_5_1]
end

l_0_0.Initialize = function(l_6_0)
  l_6_0.teamInfo = {}
  l_6_0.gameInfo = {}
  l_6_0.factionNum = 0
  l_6_0.topScore = 0
  l_6_0.topTeam = "None"
  l_6_0.scoreLimit = 0
  l_6_0:InitGameData()
end

l_0_0.InitGameData = function(l_7_0)
  l_7_0.factionNum = gameType:GetNumFactions()
  for l_7_4 = 1, l_7_0.factionNum do
    local l_7_5 = gameType:GetFaction(l_7_4 - 1)
    local l_7_6 = l_7_0.teamInfo
    local l_7_7 = l_7_5.Name
    l_7_6[l_7_7] = {}
    l_7_6, l_7_7 = l_7_0:SetTeamScore, l_7_0
    l_7_6(l_7_7, 0, l_7_5.Name)
  end
end

l_0_0.RemovePoints = function(l_8_0, l_8_1, l_8_2)
  if l_8_1 and l_8_2 then
    l_8_0.teamInfo[l_8_2].score = l_8_0.teamInfo[l_8_2].score - l_8_1
  end
end

l_0_0.SetGameParams = function(l_9_0, l_9_1, l_9_2)
  for l_9_6 = 1, l_9_0.factionNum do
    local l_9_7 = gameType:GetFaction(l_9_6 - 1)
    if not l_9_2[l_9_7.Name].respawnType then
      l_9_0.teamInfo[l_9_7.Name].respawnType = not l_9_2 or not l_9_2[l_9_7.Name] or "Infinite"
    end
    l_9_0.teamInfo[l_9_7.Name].respawnNum = l_9_2[l_9_7.Name].respawnNum or 0
    l_9_0.teamInfo[l_9_7.Name].score = l_9_2[l_9_7.Name].score or 0
  end
end

l_0_0.SetScoreLimit = function(l_10_0, l_10_1)
  l_10_0.scoreLimit = l_10_1
end

l_0_0.SetTeamScore = function(l_11_0, l_11_1, l_11_2)
  if l_11_1 and l_11_2 then
    if l_11_0.scoreLimit > 0 and l_11_0.scoreLimit < l_11_1 then
      l_11_1 = l_11_0.scoreLimit
    end
    l_11_0.teamInfo[l_11_2].score = l_11_1
    DGFactionManager.GetFaction(l_11_2):SetScore(l_11_1)
    if l_11_0.topScore < l_11_0.teamInfo[l_11_2].score then
      l_11_0.topScore = l_11_0.teamInfo[l_11_2].score
      l_11_0.topTeam = l_11_2
    else
      if l_11_0.teamInfo[l_11_2].score == l_11_0.topScore then
        l_11_0.topTeam = "None"
      end
    end
  end
end

l_0_0.SubtractPoints = function(l_12_0, l_12_1, l_12_2)
  if l_12_1 and l_12_2 then
    l_12_0.teamInfo[l_12_2].score = l_12_0.teamInfo[l_12_2].score - l_12_1
    DGFactionManager.GetFaction(l_12_2):SetScore(l_12_0.teamInfo[l_12_2].score)
    for l_12_6,l_12_7 in pairs(l_12_0.teamInfo) do
      if l_12_0.teamInfo[l_12_2] ~= l_12_7 and l_12_0.teamInfo[l_12_2].score < l_12_7.score then
        l_12_0.topScore = l_12_7.score
        l_12_0.topTeam = l_12_6
      end
    end
  end
end

DeclareClass(l_0_0)

