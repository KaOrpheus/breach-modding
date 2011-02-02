-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: ScoreEndCondition.luac 

module("ScoreEndCondition", package.seeall)
require("EndCondition")
local l_0_0 = {}
l_0_0.ArgsConstructor = function(l_1_0, l_1_1)
  if l_1_1 then
    l_1_0.scoreLimit = l_1_1
    l_1_0:SetConditionFunction(function()
      return l_1_0.scoreLimit <= gameInfo:GetTopScore()
      end)
  end
end

l_0_0.Initialize = function(l_2_0)
  l_2_0.name = "Score End Condition"
  l_2_0.reason = "score_limit_reached"
end

l_0_0.Name = "ScoreEndCondition"
l_0_0.Extends = "EndCondition"
DeclareClass(l_0_0)

