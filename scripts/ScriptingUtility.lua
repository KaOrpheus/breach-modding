-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: ScriptingUtility.luac 

module("ScriptingUtility", package.seeall)
require("Vector")
require("DEBugRendering")
table.append = function(l_1_0, l_1_1, l_1_2, l_1_3, ...)
  if l_1_0[l_1_1] then
    Class(l_1_2)[l_1_3](l_1_0[l_1_1], ...)
  else
    l_1_0[l_1_1] = new(l_1_2, ...)
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

table.contains = function(l_2_0, l_2_1)
  for l_2_5,l_2_6 in pairs(l_2_0) do
    if l_2_6 == l_2_1 then
      return true
    end
  end
  return false
end

table.count = function(l_3_0)
  local l_3_1 = 0
  for l_3_5 in pairs(l_3_0) do
    l_3_1 = l_3_1 + 1
  end
  return l_3_1
end

table.empty = function(l_4_0)
  for l_4_4,l_4_5 in pairs(l_4_0) do
    l_4_0[l_4_4] = nil
  end
end

table.emptyindexed = function(l_5_0)
  repeat
    if table.remove(l_5_0) ~= nil then
      do return end
    end
     -- Warning: missing end command somewhere! Added here
  end
end

table.findindex = function(l_6_0, l_6_1)
  for l_6_5,l_6_6 in pairs(l_6_0) do
    if rawequal(l_6_6, l_6_1) then
      return l_6_5
    end
  end
end

table.findremove = function(l_7_0, l_7_1)
  for l_7_5,l_7_6 in pairs(l_7_0) do
    if rawequal(l_7_6, l_7_1) then
      l_7_0[l_7_5] = nil
  else
    end
  end
end

table.getreadonly = function(l_8_0)
  local l_8_1 = {}
  local l_8_2 = {}
  l_8_2.__index = l_8_0
  l_8_2.__newindex = function(l_1_0, l_1_1, l_1_2)
    error("Cannot update read-only table!")
   end
  setmetatable(l_8_1, l_8_2)
  return l_8_1
end

table.shuffle = function(l_9_0)
  local l_9_1 = #l_9_0
  if l_9_1 > 1 then
    local l_9_2 = 0
    repeat
      l_9_2 = math.random(l_9_1)
      local l_9_3 = l_9_0[l_9_2]
      l_9_0[l_9_2] = l_9_0[l_9_1]
      l_9_0[l_9_1] = l_9_3
      l_9_1 = l_9_1 - 1
    until l_9_1 == 1
  end
end

_G.sortPos = new("Vec3")
_G.TRUE = function()
  return true
end

_G.FALSE = function()
  return false
end

_G.AgentSolo = function(l_12_0)
  for l_12_4,l_12_5 in pairs(aiman.agents) do
    if l_12_5 ~= l_12_0 then
      l_12_5:Deactivate()
      for l_12_4,l_12_5 in l_12_1 do
      end
      l_12_5:Activate()
    end
     -- Warning: missing end command somewhere! Added here
  end
end

_G.UnSolo = function()
  for l_13_3,l_13_4 in pairs(aiman.agents) do
    l_13_4:Activate()
  end
end

_G.AssignCallBackPayload = function(l_14_0, l_14_1)
  l_14_0.HitNode = l_14_1:GetHitNode()
  l_14_0.Entity = l_14_1:GetHitEntity()
  l_14_0.Flags = l_14_1:GetFlags()
  l_14_0.WorldImpact:Set(l_14_1:GetWorldImpact())
  l_14_0.WorldNormal:Set(l_14_1:GetWorldNormal())
  l_14_0.Distance = l_14_1:GetDistance()
end

cameraCasting = true
ccFlags = 1
ccDistance = 50000
_G.vCameraCastPos = new("Vec3")
_G.vCameraCastDir = new("Vec3")
_G.ccPayload = {}
ccPayload.WorldImpact = new("Vec3")
ccPayload.WorldNormal = new("Vec3")
ccPayload.Distance = math.huge
ccPayload.Flags = -1
ccPayload.Entity = {}
ccPayload.HitNode = {}
_G.ccDebug = false
_G.ccPrint = false
_G.maxraycastdist = 1000000
ccCallBack = function()
end

CameraCastCallBack = function(l_16_0)
  if usePublish then
    ccPayload.WorldImpact:Set(l_16_0.WorldImpact)
    ccPayload.WorldNormal:Set(l_16_0.WorldNormal)
    ccPayload.Distance = l_16_0.Distance
    ccPayload.Flags = l_16_0.Flags
    ccPayload.Entity = l_16_0.Entity
    ccPayload.HitNode = l_16_0.HitNode
  else
    ccPayload.WorldImpact:Set(l_16_0:GetWorldImpact())
    ccPayload.WorldNormal:Set(l_16_0:GetWorldNormal())
    ccPayload.Distance = l_16_0:GetDistance()
    ccPayload.Flags = l_16_0:GetFlags()
    ccPayload.Entity = l_16_0:GetHitEntity()
    ccPayload.HitNode = l_16_0:GetHitNode()
  end
  if ccPrint then
    print("Impact: ", ccPayload.WorldImpact, "\nNormal: ", ccPayload.WorldNormal, "\nDistance: ", ccPayload.Distance, "\nNode: ", ccPayload.HitNode)
  end
  if ccDebug then
    DEBugRendering.DrawJack(ccPayload.WorldImpact, 10, "cyan")
    DEBugRendering.DrawBox(ccPayload.WorldImpact, 300, "cyan")
  end
  ccCallBack(ccPayload)
end

_G.CameraCastTesting = function(l_17_0, l_17_1, l_17_2)
  do
     -- DECOMPILER ERROR: Confused at declaration of local variable

    if not l_17_0 then
      ccCallBack = not cameraCasting or ccCallBack
    end
    if not l_17_1 then
      local l_17_4 = GetCollisionFlags
      l_17_4 = l_17_4({"Static", "Dynamic", "Transparent", "AllCollide"})
    end
    ccFlags = l_17_4
    ccDistance = l_17_2 or 10000
    ScriptManager.RegisterUpdateFunction("CameraCastTest", CameraCastTest)
    print("Flags: ", ccFlags, " Distance: ", ccDistance)
    cameraCasting = false
  end
  do return end
  ScriptManager.UnregisterUpdateFunction("CameraCastTest")
  cameraCasting = true
  ccDebug = true
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CameraCastTest = function(l_18_0, l_18_1)
  vCameraCastPos:Set(DGGameView.GetCameraPos())
  vCameraCastDir:Set(DGGameView.GetCameraLookDir())
  local l_18_2 = DEPhysics.CastRay
  local l_18_3 = vCameraCastPos
  local l_18_4 = vCameraCastDir
  local l_18_5 = ScriptingUtility.CameraCastCallBack
   -- DECOMPILER ERROR: Confused at declaration of local variable

  do
    local l_18_7 = l_18_0 or ccFlags
    if not l_18_1 then
      l_18_2(l_18_3, l_18_4, l_18_5, l_18_7, ccDistance)
    end
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

_G.CameraCast = function(l_19_0, l_19_1, l_19_2)
  local l_19_3 = 1
  if l_19_1 then
    l_19_3 = l_19_1
  end
  vCameraCastPos:Set(DGGameView.GetCameraPos())
  vCameraCastDir:Set(DGGameView.GetCameraLookDir())
  DEPhysics.CastRay(vCameraCastPos, vCameraCastDir, l_19_0, l_19_3, l_19_2)
end

_G.delay = function(l_20_0, l_20_1)
  if l_20_0 and type(l_20_0) == "function" and l_20_1 > 0 then
    if not delayFuncs then
      delayFuncs = {}
    end
    local l_20_2 = table.insert
    local l_20_3 = delayFuncs
    local l_20_4 = {}
    l_20_4.func = l_20_0
    l_20_4.timer = gGameTime + l_20_1
    l_20_2(l_20_3, l_20_4)
    l_20_2 = delayUpdating
    if not l_20_2 then
      l_20_2 = true
      delayUpdating = l_20_2
      l_20_2 = ScriptManager
      l_20_2 = l_20_2.RegisterUpdateFunction
      l_20_3 = "delayShortcut"
      l_20_4 = delayUpdate
      l_20_2(l_20_3, l_20_4)
    end
  end
end

delayUpdate = function()
  for l_21_3,l_21_4 in pairs(delayFuncs) do
    if l_21_4.timer < gGameTime then
      l_21_4.func()
      table.remove(delayFuncs, l_21_3)
    end
  end
  if nintable(delayFuncs) == 0 then
    delayUpdating = false
    ScriptManager.UnregisterUpdateFunction("delayShortcut")
  end
end

_G.FrameSafeTime = function(l_22_0)
  if gDT * 30 < 1 then
    return l_22_0 * 1
  end
end

_G.getplayer = function()
   -- DECOMPILER ERROR: Confused at declaration of local variable

   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

   -- DECOMPILER ERROR: Confused at declaration of local variable

  return DGEntityManager.GetPlayerEntity()
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

_G.pp = getplayer
_G.cp = DGGameView.GetCameraPos
_G.cdir = DGGameView.GetCameraLookDir
_G.GetCollisionFlags = function(l_24_0)
  local l_24_1 = 0
  for l_24_5,l_24_6 in pairs(l_24_0) do
    l_24_1 = l_24_1 + 2 ^ DEPhysics.GetCollisionGroupByName(l_24_6)
  end
  return l_24_1
end

debugValidate = false
_G.ValidatePos = function(l_25_0, l_25_1)
  if not l_25_0 then
    return 
  end
  local l_25_2, l_25_3 = nil, nil
  if type(l_25_0) ~= "string" then
    l_25_3 = DGEntityManager.GetEntityByName(0, l_25_0)
    l_25_2 = DGDataNodeManager.GetNodeOfTypeByName("DGDataNodeLocation", l_25_0)
    if l_25_2 == nil then
      l_25_2 = DGDataNodeManager.GetNodeOfTypeByName("DGDataNodeCapturePoint", l_25_0)
    end
    if l_25_2 == nil then
      l_25_2 = DGDataNodeManager.GetNodeOfTypeByName("DGDataNodePath", l_25_0)
    end
    if l_25_2 == nil then
      l_25_2 = DGDataNodeManager.GetNodeOfTypeByName("DGDataNodeDefend", l_25_0)
    end
    if l_25_2 == nil then
      l_25_2 = DGDataNodeManager.GetNodeOfTypeByName("DGDataNodePlayerStart", l_25_0)
    end
    if l_25_2 == nil then
      l_25_2 = DGDataNodeManager.GetNodeOfTypeByName("DGDataNodeRallyPoint", l_25_0)
    end
    if l_25_2 == nil then
      l_25_2 = DGGameView:GetScene():GetNodeByName(l_25_0)
    end
  end
  local l_25_4 = nil
  if l_25_1 == "Vec3" then
    if IS_A(l_25_0, "PosQuat") then
      l_25_4 = l_25_0:GetPos()
    else
      if IS_A(l_25_0, "Vec3") then
        return l_25_0
      elseif l_25_3 then
        l_25_4 = new("Vec3", l_25_3:GetPos())
      elseif l_25_2 then
        l_25_4 = new("Vec3", l_25_2:GetWorldPosition())
      elseif l_25_1 == "PosQuat" then
        if IS_A(l_25_0, "PosQuat") then
          return l_25_0
        elseif l_25_3 then
          l_25_4 = new("PosQuat", l_25_3:GetTransformPQ())
        elseif l_25_2 then
          l_25_4 = new("PosQuat", l_25_2:GetWorldTransformPQ())
        else
          if IS_A(l_25_0, "Vec3") then
            l_25_4 = new("PosQuat")
            l_25_4:SetPos(l_25_0)
          elseif l_25_1 == "Matrix" and l_25_2 then
            l_25_4 = new("Matrix", l_25_2:GetWorldTransformMat())
          end
        end
      end
    end
  end
  return l_25_4
end

_G.ValidatePosList = function(l_26_0, l_26_1)
  if not l_26_0 then
    return 
  end
  newPosList = {}
  for l_26_5,l_26_6 in pairs(l_26_0) do
    newPosList[l_26_5] = ValidatePos(l_26_6, l_26_1)
  end
  return newPosList
end

_G.TakeTopdown = function()
  local l_27_0 = ValidatePos("loc_map_edge1", "Vec3")
  local l_27_1 = ValidatePos("loc_map_edge2", "Vec3")
  local l_27_2 = new("Vec3", l_27_0)
  local l_27_3 = new("Vec3", l_27_0)
  local l_27_4 = new("Vec3", l_27_1)
  l_27_3.z = l_27_3.z + 500
  l_27_4.z = l_27_4.z + 500
  local l_27_5 = l_27_0:Distance(l_27_1)
  local l_27_6 = new("Matrix")
  l_27_6:SetRotationX(math.rad(-90))
  l_27_2:Add(l_27_1)
  l_27_2.z = l_27_5
  l_27_6:SetPosition(l_27_2)
  DGGameView.SetCameraMode(0)
  DGGameView.SetCameraTransform(l_27_6)
  DEBugRendering.AddBox(l_27_0, 50, "red")
  DEBugRendering.AddBox(l_27_1, 50, "red")
  DEBugRendering.AddLine(l_27_0, l_27_3, "red")
  DEBugRendering.AddLine(l_27_1, l_27_4, "red")
  fx(0)
  delay(function()
    DGApp.CaptureScreen()
   end, 3)
end

_G.cc = function(l_28_0)
  DGApp.ConsoleCommand(l_28_0)
end

_G.rld = function()
  DGApp.ConsoleCommand("reload")
end

_G.ld = function(l_30_0)
  DGApp.ConsoleCommand("load " .. l_30_0)
end

_G.fx = function(l_31_0)
  if l_31_0 then
    DGApp.ConsoleCommand("fx(" .. l_31_0 .. ")")
  else
    DGApp.ConsoleCommand("fx(0)")
  end
end

_G.savect = function()
  global_cpmat = new("Matrix", DGGameView.GetCameraTransform())
end

_G.resetct = function()
  DGGameView.SetCameraTransform(global_cpmat)
end

_G.printsetct = function()
  local l_34_0 = ObjectPool.Get("Matrix")
  l_34_0:Set(DGGameView.GetCameraTransform())
  print("DGGameView.SetCameraTransform(new(\"Matrix\"," .. l_34_0 .. "))")
  ObjectPool.Recycle(l_34_0)
end

_G.nintable = function(l_35_0)
  local l_35_1 = 0
  for l_35_5 in pairs(l_35_0) do
    l_35_1 = l_35_1 + 1
  end
  return l_35_1
end

_G.togset = function(l_36_0, l_36_1)
  if l_36_1 == nil then
    return not l_36_0
  else
    return l_36_1
  end
end

_G.dostring = function(l_37_0)
  local l_37_1 = loadstring(l_37_0)
  assert(l_37_1, "dostring failed")
  l_37_1()
end

_G._printTab = 0
_G.DebugPrint = function(l_38_0)
  local l_38_1 = ""
  if _printTab > 0 then
    for l_38_5 = 0, _printTab do
      l_38_1 = l_38_1 .. "  "
    end
  end
  print(l_38_1 .. l_38_0)
end

_G.DebugPrintTab = function(l_39_0)
  DebugPrint(l_39_0)
  _printTab = _printTab + 1
end

_G.DebugPrintUntab = function(l_40_0)
  if _printTab > 0 then
    _printTab = _printTab - 1
  end
  DebugPrint(l_40_0)
end

_G.makeDebug = function(l_41_0)
  _G.oldDebugfunc = l_41_0
  return function(...)
    print(debug.traceback())
    do
      local l_42_1 = l_41_0
      return l_42_1(...)
    end
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

   end
end

_G.PerformanceTest = function(l_42_0, l_42_1)
  local l_42_2 = DETime.GetSeconds()
  local l_42_3 = DETime.GetSeconds()
  for l_42_7,l_42_8 in pairs(l_42_1) do
    l_42_2 = DETime.GetSeconds()
    for l_42_12 = 1, l_42_0 do
      l_42_8()
    end
    l_42_3 = DETime.GetSeconds()
    print("Total time for ", l_42_0, " iterations of ", l_42_7, ": ", l_42_3 - l_42_2)
  end
end

_G.rerequire = function(l_43_0)
  if package.loaded[l_43_0] then
    package.loaded[l_43_0] = nil
  end
  local l_43_1 = require
  local l_43_2 = l_43_0
  return l_43_1(l_43_2)
end

_G.printf = function(l_44_0, ...)
  print(string.format(l_44_0, ...))
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

_G.sprintf = function(l_45_0, ...)
  local l_45_2 = string.format
  do
    local l_45_3 = l_45_0
    return l_45_2(l_45_3, ...)
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

_G.cprintf = function(l_46_0, l_46_1, ...)
  if l_46_0 then
    print(string.format(l_46_1, ...))
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

_G.dprint = function(l_47_0, l_47_1)
   -- DECOMPILER ERROR: Confused at declaration of local variable

   -- DECOMPILER ERROR: Confused about usage of registers!

  if l_47_1 == nil then
    local l_47_3 = 0
  end
  if type(l_47_0) == "nil" then
    function(l_1_0, l_1_1)
    local l_48_2 = ""
    for l_48_6 = 0, l_1_1 do
      l_48_2 = l_48_2 .. "  "
    end
    print(l_48_2 .. l_1_0)
   end("nil", l_47_3)
   -- DECOMPILER ERROR: Confused about usage of registers!

  else
    if type(l_47_0) == "function" then
      function(l_1_0, l_1_1)
    local l_48_2 = ""
    for l_48_6 = 0, l_1_1 do
      l_48_2 = l_48_2 .. "  "
    end
    print(l_48_2 .. l_1_0)
   end("function()", l_47_3)
     -- DECOMPILER ERROR: Confused about usage of registers!

    else
      if type(l_47_0) == "string" then
        function(l_1_0, l_1_1)
    local l_48_2 = ""
    for l_48_6 = 0, l_1_1 do
      l_48_2 = l_48_2 .. "  "
    end
    print(l_48_2 .. l_1_0)
   end("\"" .. l_47_0 .. "\"", l_47_3)
       -- DECOMPILER ERROR: Confused about usage of registers!

      else
        if type(l_47_0) ~= "table" then
          function(l_1_0, l_1_1)
    local l_48_2 = ""
    for l_48_6 = 0, l_1_1 do
      l_48_2 = l_48_2 .. "  "
    end
    print(l_48_2 .. l_1_0)
   end(tostring(l_47_0), l_47_3)
         -- DECOMPILER ERROR: Confused about usage of registers!

        elseif l_47_0.debugvisited == nil then
          function(l_1_0, l_1_1)
    local l_48_2 = ""
    for l_48_6 = 0, l_1_1 do
      l_48_2 = l_48_2 .. "  "
    end
    print(l_48_2 .. l_1_0)
   end("{", l_47_3)
          l_47_3 = l_47_3 + 1
          l_47_0.debugvisited = 1
          for l_47_7,l_47_8 in pairs(l_47_0) do
            do
               -- DECOMPILER ERROR: Confused at declaration of local variable

               -- DECOMPILER ERROR: Confused about usage of registers!

               -- DECOMPILER ERROR: Confused about usage of registers!

              if type("\"") == "function" then
                function(l_1_0, l_1_1)
    local l_48_2 = ""
    for l_48_6 = 0, l_1_1 do
      l_48_2 = l_48_2 .. "  "
    end
    print(l_48_2 .. l_1_0)
   end("function() = ", l_47_3 + 1)
                for i_1,i_2 in pairs(l_47_0) do
                end
                if i_1 ~= "debugvisited" then
                  if type(i_2) == "number" or type(i_2) == "string" then
                    dprint(i_1 .. " = " .. i_2, l_47_3)
                    for i_1,i_2 in pairs(l_47_0) do
                    end
                    dprint(i_1 .. " = ")
                    dprint(i_2, l_47_3)
                  end
                   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

                end
              end
               -- DECOMPILER ERROR: Confused about usage of registers!

               -- DECOMPILER ERROR: Confused about usage of registers!

              function(l_1_0, l_1_1)
    local l_48_2 = ""
    for l_48_6 = 0, l_1_1 do
      l_48_2 = l_48_2 .. "  "
    end
    print(l_48_2 .. l_1_0)
   end("}", l_47_3 - 1)
               -- DECOMPILER ERROR: Confused about usage of registers!

              l_47_0.debugvisited = nil
               -- DECOMPILER ERROR: Confused about usage of registers for local variables.

            end
          end
        end
      end
       -- Warning: missing end command somewhere! Added here
    end
     -- Warning: missing end command somewhere! Added here
  end
end

_G.sprint = function(l_48_0)
  if type(l_48_0) ~= "table" then
    print(tostring(l_48_0))
  else
    local l_48_1 = {}
    for l_48_5,l_48_6 in pairs(l_48_0) do
      table.insert(l_48_1, tostring(l_48_5) .. ": " .. tostring(l_48_6))
    end
    table.sort(l_48_1)
    for l_48_10,l_48_11 in pairs(l_48_1) do
      print(l_48_11)
    end
  end
end

_G.cprint = function(l_49_0, l_49_1)
  if l_49_0 and (type(l_49_0) ~= "function" or l_49_0()) then
    print(tostring(gGameTime) .. " " .. l_49_1)
  end
end

_G.tprint = function(l_50_0)
  print(type(l_50_0))
end

_G.help = function(l_51_0)
  if type(l_51_0) == "table" then
    if l_51_0.Help and type(l_51_0.Help) == "function" then
      l_51_0:Help()
    else
      local l_51_1 = {}
      for l_51_5,l_51_6 in pairs(l_51_0) do
        if type(l_51_6) == "function" then
          table.insert(l_51_1, l_51_5)
        end
      end
      if table.getn(l_51_1) == 0 then
        print("No functions in table.")
      else
        table.sort(l_51_1)
        for l_51_10,l_51_11 in pairs(l_51_1) do
          print(".." .. l_51_11)
        end
      end
    else
      print("Item is not a table.")
    end
  end
end
end

_G.resupplyplayer = function()
  local l_52_0 = getplayer()
  if l_52_0 then
    local l_52_1 = DEEventManager.CreateEvent("DGEventResupply")
    DEEventManager.AddEvent(l_52_1, l_52_0:GetSubjectString())
  end
end

_G.reviveplayer = function()
  local l_53_0 = getplayer()
  if l_53_0 then
    local l_53_1 = DEEventManager.CreateEvent("DGEventRevive")
    l_53_1.RevivedPlayerID = l_53_0:GetPlayerID()
    DEEventManager.AddEvent(l_53_1, l_53_0:GetSubjectString())
  end
end

_G.webhelp = function(l_54_0)
  if type(l_54_0) == "string" then
    io.popen("start http://www.lua.org/manual/5.1/manual.html#pdf-" .. l_54_0)
  else
    print("Please put the item you're seeking help on in quotes!")
  end
end

_G.warp = function(l_55_0, l_55_1, l_55_2, l_55_3)
  do
    if not l_55_3 then
      local l_55_4, l_55_5, l_55_6, l_55_7 = DGEntityManager.GetPlayerEntity()
  end
   -- DECOMPILER ERROR: Confused about usage of registers!

  elseif l_55_3 then
    DGEntity.SetPos(l_55_3, new("Vec3", l_55_0, l_55_1, l_55_2))
  end
end

_G.warpd = function(l_56_0, l_56_1, l_56_2, l_56_3)
  do
    if not l_56_3 then
      local l_56_4, l_56_5, l_56_6, l_56_7 = DGEntityManager.GetPlayerEntity()
  end
   -- DECOMPILER ERROR: Confused about usage of registers!

   -- DECOMPILER ERROR: Confused at declaration of local variable

  do
     -- DECOMPILER ERROR: Confused at declaration of local variable

    elseif l_56_3 then
      new("Vec3", DGEntity.GetPos(l_56_3)):Add(new("Vec3", l_56_0, l_56_1, l_56_2))
       -- DECOMPILER ERROR: Confused about usage of registers!

      DGEntity.SetPos(l_56_3, new("Vec3", DGEntity.GetPos(l_56_3)))
    end
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

_G.warpdir = function(l_57_0, l_57_1)
  do
    if not l_57_1 then
      local l_57_2, l_57_3, l_57_4, l_57_5 = DGEntityManager.GetPlayerEntity()
  end
   -- DECOMPILER ERROR: Confused about usage of registers!

   -- DECOMPILER ERROR: Confused at declaration of local variable

   -- DECOMPILER ERROR: Confused at declaration of local variable

   -- DECOMPILER ERROR: Confused at declaration of local variable

  do
     -- DECOMPILER ERROR: Confused at declaration of local variable

    elseif l_57_1 then
      new("Vec3", DGGameView.GetCameraLookDir()):Scale(l_57_0 or 10)
      new("Vec3", DGEntity.GetPos(l_57_1)):Add(new("Vec3", DGGameView.GetCameraLookDir()))
      new("Vec3", DGGameView.GetCameraLookDir()).z = 0
       -- DECOMPILER ERROR: Confused about usage of registers!

      DGEntity.SetPos(l_57_1, new("Vec3", DGEntity.GetPos(l_57_1)))
    end
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

_G.phash = function(l_58_0)
  print(DGApp.GenerateHash(l_58_0))
end

_G.showlog = function()
  io.popen("notepad ConsoleView_Lua.txt")
end

_G.toboolean = function(l_60_0)
  if l_60_0 and l_60_0 == "true" then
    return true
  else
    return false
  end
end

_G.toseconds = function(l_61_0)
  local l_61_1 = {}
  local l_61_2 = 0
  for l_61_6 in string.gmatch(l_61_0, "%d+") do
    table.insert(l_61_1, l_61_6)
    l_61_2 = l_61_2 + 1
  end
  if l_61_2 == 0 then
    return nil
  end
   -- DECOMPILER ERROR: Confused about usage of registers!

  if l_61_2 >= 3 then
    local l_61_7 = 1 + 1
  end
   -- DECOMPILER ERROR: Confused about usage of registers!

   -- DECOMPILER ERROR: Confused about usage of registers!

  if l_61_2 >= 2 then
    local l_61_8 = l_61_7 + 1
  end
   -- DECOMPILER ERROR: Confused about usage of registers!

   -- DECOMPILER ERROR: Confused about usage of registers!

  if l_61_2 >= 1 then
    return 0 + tonumber(l_61_1[1]) * 360 + tonumber(l_61_1[l_61_7]) * 60 + tonumber(l_61_1[l_61_8])
  end
   -- Warning: undefined locals caused missing assignments!
end

watchcp = function()
  if _G.camwatch then
    unwatch(_G.camwatch)
  else
    if not _G.camwatch then
      _G.camwatch = function()
     -- DECOMPILER ERROR: Confused at declaration of local variable

     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

     -- DECOMPILER ERROR: Confused at declaration of local variable

    return cp()
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

   end
    end
    watch(_G.camwatch)
  end
end


