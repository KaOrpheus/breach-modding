-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: DeathGameCondition.luac 

module("DeathGameCondition", package.seeall)
require("DeathGameCondition")
local l_0_0 = {}
l_0_0.ArgsConstructor = function(l_1_0, l_1_1)
  if l_1_1 then
    l_1_0.target = l_1_1.target
    l_1_0.result = l_1_1.result
    l_1_0.condition = function()
      if not sc.IsSpawnActive(l_1_0.deathTarget) and not sc.IsGroupActive(l_1_0.deathTarget) then
        local l_2_0 = not sc.IsRoleActive(l_1_0.deathTarget)
      else
        return false
      end
      end
    l_1_0.enableFunc = function()
      return not l_1_0.condition()
      end
  end
end

l_0_0.Initialize = function(l_2_0)
  l_2_0.name = "Game Death Condition"
end

l_0_0.Name = "DeathGameCondition"
l_0_0.Extends = "GameCondition"
DeclareClass(l_0_0)

