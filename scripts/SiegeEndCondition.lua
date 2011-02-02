-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: SiegeEndCondition.luac 

module("SiegeEndCondition", package.seeall)
require("EndCondition")
local l_0_0 = {}
l_0_0.ArgsConstructor = function(l_1_0, l_1_1)
  l_1_0.capTable = l_1_1
  l_1_0:SetConditionFunction(function()
    local l_2_0 = {}
    for l_2_4,l_2_5 in pairs(l_1_0.capTable) do
      if not l_2_5.destroyed then
        table.insert(l_2_0, l_2_5)
      end
    end
    if table.count(l_2_0) == 0 then
      return true
    else
      if table.count(l_2_0) == 1 and l_2_0[1].team == gameInfo:GetTopTeam() then
        return true
      end
    end
    return false
   end)
end

l_0_0.Initialize = function(l_2_0)
  l_2_0.name = "SiegeEndCondition"
  l_2_0.reason = "score_limit_reached"
end

l_0_0.Name = "SiegeEndCondition"
l_0_0.Extends = "EndCondition"
DeclareClass(l_0_0)

