-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: ZoneScoringCondition.luac 

module("ZoneScoringCondition", package.seeall)
require("ScoringCondition")
local l_0_0 = {}
l_0_0.Name = "ZoneScoringCondition"
l_0_0.Extends = "ScoringCondition"
l_0_0.ArgsConstructor = function(l_1_0, l_1_1)
  local l_1_2 = {}
  l_1_2.maxTrigger = -1
  l_1_2.minTrigger = 0
  l_1_2.triggerDelay = 1
  l_1_0.sensor = l_1_1.sensor
  l_1_0.scoreAmount = l_1_1.scoreAmount or 1
  if l_1_0.sensor then
    SensorManager.RegisterSensorFunction("OnEnter", l_1_0.sensor, l_1_1.sensorTag, function(l_1_0)
    l_1_0:HandleSensorFunction(l_1_0)
   end, l_1_2)
  end
  ScriptManager.RegisterTimerFunction("Zone Scoring", function()
    l_1_0:UpdateScoring()
   end, l_1_1.scoreDelay or 1)
end

l_0_0.HandleSensorFunction = function(l_2_0, l_2_1)
  local l_2_2 = l_2_1.OtherSensor:GetOwner()
  if l_2_2 then
    table.insert(l_2_0.watchEntities, l_2_2)
  end
end

l_0_0.Initialize = function(l_3_0)
  l_3_0.watchEntities = {}
end

l_0_0.UpdateScoring = function(l_4_0)
  if currentGame.gameOver then
    ScriptManager.UnregisterTimerFunction("Zone Scoring")
  else
    for l_4_4,l_4_5 in ipairs(l_4_0.watchEntities) do
      if l_4_5 and l_4_5:IsActive() then
        local l_4_6 = ObjectPool.Get("Vec3"):Set(l_4_5:GetPos())
        if SensorManager.IsPointWithinSensor(l_4_6, l_4_0.sensor) then
          local l_4_7 = l_4_5:GetFaction():GetName()
          gameInfo:AddPoints(l_4_0.scoreAmount, l_4_7)
        else
          table.remove(l_4_0.watchEntities, l_4_4)
        end
        ObjectPool.Recycle(l_4_6)
      end
    end
  end
end

DeclareClass(l_0_0)

