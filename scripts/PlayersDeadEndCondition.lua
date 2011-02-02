-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: PlayersDeadEndCondition.luac 

module("PlayersDeadEndCondition", package.seeall)
require("EndCondition")
local l_0_0 = {}
l_0_0.ArgsConstructor = function(l_1_0)
  l_1_0:SetConditionFunction(function()
    return SpawnConductor.GetActivePlayerCount() == 0
   end)
  l_1_0:SetEnableFunction(function()
    return not l_1_0.conditionFunction()
   end)
end

l_0_0.Initialize = function(l_2_0)
  l_2_0.name = "PlayersDeadEndCondition"
  l_2_0.reason = "PlayersDeadEndCondition"
  l_2_0.enabled = false
end

l_0_0.Name = "PlayersDeadEndCondition"
l_0_0.Extends = "EndCondition"
DeclareClass(l_0_0)

