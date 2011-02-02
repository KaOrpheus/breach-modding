-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: SensorManager.luac 

module("SensorManager", package.seeall)
SensorFunctions = {}
RegisteredSensors = {}
local l_0_0 = {}
l_0_0.OnEnter = true
l_0_0.OnExit = true
l_0_0.OnLook = true
SensorTypes = l_0_0
l_0_0 = function(l_1_0)
  local l_1_1 = l_1_0.Sensor.Name
  do
    local l_1_2 = l_1_0.OtherSensor
    if not SensorFunctions[l_1_1] then
      return 
    end
    for l_1_6,l_1_7 in pairs(SensorFunctions[l_1_1]) do
      if l_1_7 and l_1_2 then
        local l_1_8 = l_1_2:GetTag()
        local l_1_9 = DGEditorTagList.FindTagIDByName(l_1_7.tagFilter)
         -- DECOMPILER ERROR: unhandled construct in 'if'

         -- DECOMPILER ERROR: unhandled construct in 'if'

        if (l_1_9 == "allTags" or l_1_8 == l_1_9 or DGEditorTagList.IsSuperClassOf(l_1_9, l_1_8)) and l_1_7.sensorType ~= "OnExit" and l_1_0.Entering and (l_1_7.lastTriggerTime == nil or l_1_7.triggerDelay < gGameTime - l_1_7.lastTriggerTime) then
          if l_1_7.triggersLeft ~= 0 then
            if l_1_7.resultFunc then
              l_1_7.resultFunc(l_1_0)
              l_1_7.lastTriggerTime = gGameTime
            end
            if l_1_7.triggersLeft > 0 then
              l_1_7.triggersLeft = l_1_7.triggersLeft - 1
            end
          end
          if l_1_7.triggersLeft == 0 then
            SensorFunctions[l_1_1] = nil
            for l_1_6,l_1_7 in l_1_3 do
              if l_1_7.sensorType == "OnExit" and not l_1_0.Entering and (l_1_7.lastTriggerTime == nil or l_1_7.triggerDelay < gGameTime - l_1_7.lastTriggerTime) then
                if l_1_7.triggersLeft ~= 0 then
                  if l_1_7.resultFunc then
                    l_1_7.resultFunc(l_1_0)
                    l_1_7.lastUnTouchUseTime = gGameTime
                  end
                  if l_1_7.triggersLeft > 0 then
                    l_1_7.triggersLeft = l_1_7.triggersLeft - 1
                  end
                end
                if l_1_7.triggersLeft == 0 then
                  SensorFunctions[l_1_1] = nil
                end
              end
            end
          end
        end
      end
    end
     -- Warning: missing end command somewhere! Added here
  end
end

HandleSensorEvent = l_0_0
l_0_0 = function(l_2_0, l_2_1)
  if not RegisteredSensors[l_2_1] then
    RegisteredSensors[l_2_1] = DGSensor.GetSensorByName(l_2_1)
  end
  local l_2_2 = RegisteredSensors[l_2_1]
  if not l_2_2 then
    return false
  end
  local l_2_3, l_2_4 = l_2_2:ContainsPoint, l_2_2
  local l_2_5 = l_2_0
  return l_2_3(l_2_4, l_2_5)
end

IsPointWithinSensor = l_0_0
l_0_0 = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
  if not RegisteredSensors[l_3_1] then
    RegisteredSensors[l_3_1] = DGSensor.GetSensorByName(l_3_1)
  end
  local l_3_5 = RegisteredSensors[l_3_1]
  if not SensorTypes[l_3_0] then
    print("Bad Sensor Type " .. l_3_0)
    return false
  end
  if l_3_5 and l_3_0 and l_3_3 then
    if not l_3_2 then
      tag = "allTags"
    else
      tag = DGEditorTagList.FindTagIDByName(l_3_2)
    end
    if not SensorFunctions[l_3_1] then
      SensorFunctions[l_3_1] = {}
    end
    local l_3_6 = {}
    l_3_6.sensorType = l_3_0
    l_3_6.resultFunc = l_3_3
    l_3_6.tagFilter = l_3_2
    if not l_3_4 then
      l_3_4 = {}
    end
    l_3_6.maxTrigger = l_3_4.maxTrigger or -1
    l_3_6.triggerDelay = l_3_4.triggerDelay or 1
    l_3_6.triggersLeft = l_3_4.maxTrigger or 1
    if l_3_0 == "OnLook" then
      l_3_5:EnableLookAtCheck(true)
      if l_3_4.maxDist and l_3_4.minDist then
        l_3_5:EnableRangeCheck(true)
        l_3_5:SetDistanceRange(l_3_4.minDist, l_3_4.maxDist)
      end
    end
    l_3_6.lastTriggerTime = nil
    table.insert(SensorFunctions[l_3_1], l_3_6)
    return true
  else
    return false
  end
end

RegisterSensorFunction = l_0_0
l_0_0 = function(l_4_0)
  if not RegisteredSensors[l_4_0] then
    return 
  end
  RegisteredSensors[l_4_0]:EnableLookAtCheck(false)
  RegisteredSensors[l_4_0]:EnableRangeCheck(false)
  if SensorFunctions[l_4_0] then
    SensorFunctions[l_4_0] = nil
  end
end

UnregisterSensorFunction = l_0_0
l_0_0 = function(l_5_0, l_5_1)
  local l_5_2 = DGEditorTagList.FindTagIDByName(l_5_1)
  local l_5_3 = l_5_0:GetSensor()
  l_5_3:SetTag(l_5_2)
end

SetEntityTag = l_0_0
l_0_0 = SensorTouchEventTicket
if l_0_0 then
  l_0_0 = DEEventManager
  l_0_0 = l_0_0.UnsubscribeEvent
  l_0_0(SensorTouchEventTicket)
end
l_0_0 = SensorLookAtEventTicket
if l_0_0 then
  l_0_0 = DEEventManager
  l_0_0 = l_0_0.UnsubscribeEvent
  l_0_0(SensorLookAtEventTicket)
end
l_0_0 = DEEventManager
l_0_0 = l_0_0.SubscribeEvent
l_0_0 = l_0_0("DGSignalEventSense", HandleSensorEvent)
SensorTouchEventTicket = l_0_0
l_0_0 = DEEventManager
l_0_0 = l_0_0.SubscribeEvent
l_0_0 = l_0_0("DGEventLookAt", HandleSensorEvent)
SensorLookAtEventTicket = l_0_0

