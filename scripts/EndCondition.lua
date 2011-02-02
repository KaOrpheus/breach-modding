-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: EndCondition.luac 

module("EndCondition", package.seeall)
local l_0_0 = {}
l_0_0.ArgsConstructor = function(l_1_0, l_1_1, l_1_2)
  if l_1_1 then
    l_1_0.name = l_1_1
  end
  if l_1_2 then
    l_1_0.IsSatisfied = IsSatisfied
  end
end

l_0_0.GetName = function(l_2_0)
  return l_2_0.name
end

l_0_0.GetReason = function(l_3_0)
  return l_3_0.reason
end

l_0_0.Initialize = function(l_4_0)
  l_4_0.enabled = true
end

l_0_0.IsSatisfied = function(l_5_0)
   -- DECOMPILER ERROR: Confused at declaration of local variable

   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

   -- DECOMPILER ERROR: Confused about usage of registers!

   -- DECOMPILER ERROR: Confused about usage of registers!

   -- DECOMPILER ERROR: Confused at declaration of local variable

  if l_5_0.conditionFunction then
    return l_5_0.conditionFunction()
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  else
    assert(false, "No condition function supplied for EndCondition:IsSatisfied!")
    return false
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

l_0_0.SetConditionFunction = function(l_6_0, l_6_1)
  l_6_0.conditionFunction = l_6_1
end

l_0_0.SetEnableFunction = function(l_7_0, l_7_1)
  l_7_0.enableFunction = l_7_1
end

l_0_0.EnableCheck = function(l_8_0)
  if l_8_0.enableFunction and l_8_0.enabled ~= l_8_0.enableFunction() then
    l_8_0.enabled = l_8_0.enableFunction()
  end
end

l_0_0.Name = "EndCondition"
DeclareAbstractClass(l_0_0)

