-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: GameManager.luac 

module("GameManager", package.seeall)
local l_0_0 = {}
l_0_0.Initialize = function(l_1_0)
  _G.session = DGApp.GetSession()
  _G.missionInfo = session:GetActiveMissionInfo()
  _G.gameType = missionInfo.MissionType
  local l_1_1 = gameType:GetMissionOptions()
  local l_1_2 = gameType.GameScript
  print("GameScript: " .. l_1_2)
  _G.currentGame = new(l_1_2, l_1_1)
  ScriptManager.RegisterPostLoadFunction("GMPostLoad", l_1_0.DoPostLoad)
  ScriptManager.RegisterPreUnloadFunction("GMPreUnload", l_1_0.DoPreUnload)
  ScriptManager.RegisterUpdateFunction("GMUpdate", l_1_0.DoUpdate)
  DEEventManager.SubscribeEvent("DGEventScenarioLoaded", l_1_0.HandleScenarioLoaded)
  DEEventManager.SubscribeEvent("DGEventResetGameType", l_1_0.ResetGameType)
end

l_0_0.ResetGameType = function(l_2_0)
  ScriptManager.Reset()
  _G.session = DGApp.GetSession()
  _G.missionInfo = session:GetActiveMissionInfo()
  _G.gameType = missionInfo.MissionType
  local l_2_1 = gameType:GetMissionOptions()
  local l_2_2 = gameType.GameScript
  _G.currentGame = new(l_2_2, l_2_1)
end

l_0_0.DoPostLoad = function(l_3_0)
  if currentGame then
    DGApp.SetEntitySpawningComplete()
  end
end

l_0_0.HandleScenarioLoaded = function(l_4_0)
  if currentGame then
    currentGame:StartGame()
    currentGame:PostStartGame()
  end
end

l_0_0.DoPreUnload = function(l_5_0)
end

l_0_0.DoUpdate = function(l_6_0)
  if currentGame then
    currentGame:Update()
  end
end

l_0_0.Name = "GameManager"
DeclareClass(l_0_0)

