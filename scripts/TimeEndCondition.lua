-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: TimeEndCondition.luac 

module("TimeEndCondition", package.seeall)
require("EndCondition")
local l_0_0 = {}
local l_0_1 = 0
l_0_0.ArgsConstructor = function(l_1_0, l_1_1)
  if l_1_1 then
    l_1_0.startTime = gGameTime
    l_1_0.timeLimit = l_1_1
    l_1_0:SetConditionFunction(function()
      return l_1_0:GetTimeLeft() < 0
      end)
    DGApp.GetSession():SetTimeRemaining(l_1_0.timeLimit * 1000)
  else
    l_1_0.enabled = false
  end
end

l_0_0.GetTimeLeft = function(l_2_0)
  local l_2_1 = l_2_0.timeLimit - (gGameTime - l_2_0.startTime)
  if l_0_1 ~= math.floor(l_2_1) then
    local l_2_2 = DEEventManager.CreateEvent("DGEventGameTypeTimeLeft")
    l_2_2.TimeLeft = l_2_1
    DEEventManager.AddEvent(l_2_2, 0)
    l_0_1 = math.floor(l_2_1)
  end
  return l_2_1
end

l_0_0.Initialize = function(l_3_0)
  l_3_0.name = "Time End Condition"
  l_3_0.reason = "time_expired"
end

l_0_0.Name = "TimeEndCondition"
l_0_0.Extends = "EndCondition"
DeclareClass(l_0_0)

