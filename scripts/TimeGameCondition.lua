-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: TimeGameCondition.luac 

module("TimeGameCondition", package.seeall)
require("GameCondition")
local l_0_0 = {}
l_0_0.ArgsConstructor = function(l_1_0, l_1_1)
  if l_1_1 then
    l_1_0.deltaTime = l_1_1.deltaTime
    l_1_0.repeating = l_1_1.repeating
    l_1_0.result = l_1_1.result
  end
end

l_0_0.Initialize = function(l_2_0)
  l_2_0.name = "Game Time Condition"
end

l_0_0.Update = function(l_3_0)
  if not l_3_0.startTime then
    l_3_0.startTime = gGameTime
  end
  local l_3_1 = gGameTime - l_3_0.startTime
  if l_3_0.deltaTime < l_3_1 and l_3_0.result then
    l_3_0.result()
    if l_3_0.repeating then
      l_3_0.startTime = gGameTime
    else
      l_3_0.triggered = true
    end
  end
end

l_0_0.Name = "TimeGameCondition"
l_0_0.Extends = "GameCondition"
DeclareClass(l_0_0)

