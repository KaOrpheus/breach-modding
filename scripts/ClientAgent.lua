-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: ClientAgent.luac 

module("ClientAgent", package.seeall)
local l_0_0 = {}
l_0_0.Name = "ClientAgent"
l_0_0.HandleInteract = function(l_1_0)
end

l_0_0.HandleRevive = function(l_2_0)
end

l_0_0.HandleScenarioLoaded = function(l_3_0)
end

l_0_0.HandleSwitchControl = function(l_4_0)
end

l_0_0.HandleEndMission = function(l_5_0)
end

l_0_0.Initialize = function(l_6_0)
  _G.localPlayer = DGPlayerManager.GetLocalPlayer()
  DEEventManager.SubscribeEvent("DGEventInteract", l_6_0.HandleInteract)
  DEEventManager.SubscribeEvent("DGEventRevive", l_6_0.HandleRevive)
  DEEventManager.SubscribeEvent("DGEventScenarioLoaded", l_6_0.HandleScenarioLoaded)
  DEEventManager.SubscribeEvent("DGEventSwitchControl", l_6_0.HandleSwitchControl)
  DEEventManager.SubscribeEvent("DGEventEndMission", l_6_0.HandleEndMission)
end

DeclareAbstractClass(l_0_0)

