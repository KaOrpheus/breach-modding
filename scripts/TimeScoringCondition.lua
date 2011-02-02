-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: TimeScoringCondition.luac 

module("TimeScoringCondition", package.seeall)
require("ScoringCondition")
local l_0_0 = {}
l_0_0.Name = "TimeScoringCondition"
l_0_0.Extends = "ScoringCondition"
l_0_0.AddTime = function(l_1_0, l_1_1)
  l_1_0.timeleft = l_1_0.timeleft + l_1_1
  if l_1_0.clientDisplay and l_1_1 > 0 then
    DGApp.DoMPLua("client:ScreenLocMessage(\"ui_messages_timeadded\"," .. l_1_1 .. " ,1, 3000)")
  end
end

l_0_0.ArgsConstructor = function(l_2_0, l_2_1, l_2_2)
  l_2_0.name = l_2_1
  l_2_0.faction = l_2_2.faction
  l_2_0.timeleft = l_2_2.scoreTime
  l_2_0.amount = l_2_2.amount
  l_2_0.clientDisplay = l_2_2.clientDisplay
  ScriptManager.RegisterTimerFunction(l_2_0.name, function()
    l_2_0:UpdateTime()
   end, 1)
end

l_0_0.GetTimeLeft = function(l_3_0)
  return l_3_0.timeleft
end

l_0_0.UpdateScoring = function(l_4_0)
  if not currentGame.gameOver then
    ScriptManager.UnregisterTimerFunction(l_4_0.name)
    gameInfo:SetTeamScore(l_4_0.amount, l_4_0.faction)
  end
end

l_0_0.UpdateTime = function(l_5_0)
  if currentGame and currentGame.gameOver then
    ScriptManager.UnregisterTimerFunction(l_5_0.name)
    return 
  end
  if l_5_0.timeleft > 0 then
    l_5_0.timeleft = l_5_0.timeleft - 1
    local l_5_1 = DEEventManager.CreateEvent("DGEventGameTypeTimeLeft")
    l_5_1.TimeLeft = l_5_0.timeleft
    DEEventManager.AddEvent(l_5_1, 0)
  else
    l_5_0:UpdateScoring()
  end
end

DeclareClass(l_0_0)

