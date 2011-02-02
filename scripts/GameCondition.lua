-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: GameCondition.luac 

module("GameCondition", package.seeall)
local l_0_0 = {}
l_0_0.ArgsConstructor = function(l_1_0, l_1_1, l_1_2, l_1_3)
  if l_1_1 and l_1_2 and l_1_3 then
    l_1_0.name = l_1_1
    l_1_0.condition = l_1_2
    l_1_0.result = l_1_3
  end
end

l_0_0.Initialize = function(l_2_0)
  l_2_0.triggered = false
end

l_0_0.Update = function(l_3_0)
  if l_3_0.enabled then
    if l_3_0.condition() and not l_3_0.triggered then
      l_3_0.triggered = true
      l_3_0.result()
    elseif l_3_0.triggered and not l_3_0.condition() then
      l_3_0:Reset()
    else
      if l_3_0.enableFunc() then
        l_3_0.enabled = true
      end
    end
  end
end

l_0_0.SetCondition = function(l_4_0, l_4_1)
  l_4_0.condition = l_4_1
end

l_0_0.SetResult = function(l_5_0, l_5_1)
  l_5_0.result = l_5_1
end

l_0_0.Reset = function(l_6_0, l_6_1)
  l_6_0.triggered = false
end

l_0_0.Name = "GameCondition"
DeclareClass(l_0_0)

