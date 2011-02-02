-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: AIComponent.luac 

module("AIComponent", package.seeall)
require("ScriptingUtility")
require("DebugDisplayObject")
require("DebugDisplayInterface")
local l_0_0 = {}
l_0_0.Name = "AIComponent"
l_0_0.Abstract = {}
l_0_0.Abstract.AttachToAgent = function(l_1_0, l_1_1)
end

l_0_0.Update = function(l_2_0)
  l_2_0:CriticalUpdate()
  l_2_0:NonCriticalUpdate()
end

l_0_0.Abstract.CriticalUpdate = function(l_3_0)
end

l_0_0.Abstract.NonCriticalUpdate = function(l_4_0)
end

local l_0_1 = {}
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1("DebugDisplayInterface")
l_0_0.UpdateDebugWindow, l_0_0.UnregisterEventHandler, l_0_0.RegisterEventHandler, l_0_0.IsActive, l_0_0.Initialize, l_0_0.GetAgent, l_0_0.Destroy, l_0_0.DebugRender, l_0_0.DebugDisplay, l_0_0.Debug, l_0_0.Deactivate, l_0_0.AddShared, l_0_0.Activate, l_0_1, l_0_0.Implements = l_0_1, l_0_1, l_0_1, l_0_1, l_0_1, l_0_1, l_0_1, l_0_1, l_0_1, l_0_1, l_0_1, l_0_1, l_0_1, function(l_5_0)
  l_5_0.active = true
end
, l_0_1

