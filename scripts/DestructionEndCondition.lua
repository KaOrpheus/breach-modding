-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: DestructionEndCondition.luac 

module("DestructionEndCondition", package.seeall)
require("EndCondition")
local l_0_0 = {}
l_0_0.ArgsConstructor = function(l_1_0, l_1_1)
  if l_1_1 then
    l_1_0.eventTriggered = false
    l_1_0.sensor = DEAssetTracker.AcquireResource("DGSensor", l_1_1)
    l_1_0:SetConditionFunction(function()
      return l_1_0.eventTriggered
      end)
    DEEventManager.SubscribeEvent("DEEventCollapseNotification", function(l_2_0)
      l_1_0:handleCollapse(l_2_0)
      end)
  end
end

l_0_0.handleCollapse = function(l_2_0, l_2_1)
  print("Collapse Event")
  if l_2_1 and l_2_1:IntersectsSensor(l_2_0.sensor) then
    l_2_0.eventTriggered = true
  end
end

l_0_0.Initialize = function(l_3_0)
  l_3_0.name = "DestructionEndCondition"
  l_3_0.reason = "DestructionEndCondition"
end

l_0_0.Name = "DestructionEndCondition"
l_0_0.Extends = "EndCondition"
DeclareClass(l_0_0)

