-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: CaptureScoringCondition.luac 

module("CaptureScoringCondition", package.seeall)
require("ScoringCondition")
local l_0_0 = {}
l_0_0.Name = "CaptureScoringCondition"
l_0_0.Extends = "ScoringCondition"
l_0_0.ArgsConstructor = function(l_1_0, l_1_1, l_1_2)
  l_1_0.name = l_1_1
  l_1_0.capPoints = l_1_2.capPoints
  l_1_0.faction = l_1_2.faction
  l_1_0.interval = l_1_2.interval or 5
  l_1_0.amount = l_1_2.amount or 1
  l_1_0.scoreLimit = l_1_2.scoreLimit or 100
  l_1_0.allcap = l_1_2.allcap
  l_1_0.singlecap = l_1_2.singlecap
  ScriptManager.RegisterTimerFunction(l_1_1 .. " Capture Scoring", function()
    l_1_0:UpdateScoring()
   end, l_1_0.interval)
end

l_0_0.GetCapNum = function(l_2_0, l_2_1)
  local l_2_2 = 0
  for l_2_6,l_2_7 in pairs(l_2_0.capPoints) do
    if l_2_7.team == l_2_1 and l_2_7.points == 100 then
      l_2_2 = l_2_2 + 1
    end
  end
  return l_2_2
end

l_0_0.UpdateScoring = function(l_3_0)
  if currentGame and currentGame.gameOver then
    ScriptManager.UnregisterTimerFunction(l_3_0.name .. " Capture Scoring")
  else
    for l_3_4,l_3_5 in pairs(l_3_0.capPoints) do
      if l_3_5.team then
        local l_3_6 = l_3_0:GetCapNum(l_3_5.team)
         -- DECOMPILER ERROR: unhandled construct in 'if'

        if l_3_0.allcap and l_3_6 == nintable(l_3_0.capPoints) and (not l_3_0.faction or l_3_0.faction == l_3_5.team) then
          gameInfo:SetTeamScore(l_3_0.scoreLimit, l_3_5.team)
          for l_3_4,l_3_5 in l_3_1 do
            if l_3_0.singlecap and l_3_5.enabled and l_3_5.team == l_3_5.targetFaction then
              l_3_5.enabled = false
              gameInfo:AddPoints(l_3_0.amount, l_3_5.team)
              for l_3_4,l_3_5 in l_3_1 do
              end
              if not l_3_0.faction and gameInfo:GetTopScore() < l_3_0.scoreLimit then
                if not l_3_5.amount then
                  gameInfo:AddPoints(l_3_0.amount, l_3_5.team)
                end
              end
            end
          end
        end
      end
       -- Warning: missing end command somewhere! Added here
    end
     -- Warning: missing end command somewhere! Added here
  end
end

DeclareClass(l_0_0)

