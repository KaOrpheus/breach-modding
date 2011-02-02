-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: Rescue.luac 

module("Rescue", package.seeall)
require("Gametype")
require("DeathEndCondition")
require("ZoneScoringCondition")
require("ScoreEndCondition")
require("PlayersDeadEndCondition")
local l_0_0 = {}
l_0_0.Name = "Rescue"
l_0_0.Extends = "Gametype"
l_0_0.ArgsConstructor = function(l_1_0, l_1_1)
  if l_1_1 then
    l_1_0.timeLimit = toseconds(l_1_1.time_limit)
    l_1_0.playerRespawns = tonumber(l_1_1.lives_limit)
    l_1_0.teamRespawns = tonumber(l_1_1.lives_limit_per_faction)
    l_1_0.spawnDelay = tonumber(l_1_1.respawn_interval)
    if l_1_0.playerRespawns then
      l_1_0.playerRespawns = l_1_0.playerRespawns - 1
    else
      l_1_0.playerRespawns = -1
    end
  else
    l_1_0.timeLimit = 600
  end
  l_1_0.deadPlayers = {}
  l_1_0:InitGameData()
end

l_0_0.HostageCheck = function(l_2_0)
  if not l_2_0.hostage then
    l_2_0.hostage = AIManager.GetAgentByName("sc_rs_hostage1")
  end
  if l_2_0.hostage and l_2_0.hostage.behavior and l_2_0.hostage.behavior.rescuer then
    DGApp.DoMPLua("client:AddIndicator(ValidatePos(\"loc_escape1\", \"Vec3\"), \"Extraction Point\")")
    DGApp.DoMPLua("client:RemoveIndicator(\"Captured Journalist\")")
    DGApp.DoMPLua("client:ScreenMessage(\"Get to the Choppa!\")")
    DGApp.DoMPLua("escapeflare:SetWorldTransformPQ(ValidatePos(\"loc_escape1\", \"PosQuat\"))")
    DGApp.DoMPLua("escapeflare:Start()")
    DGApp.DoMPLua("client:SetMusic(\"intense\")")
    sc.OrderAI("insurgents", "Assault", "sc_rs_hostage1")
    ScriptManager.UnregisterTimerFunction("Hostage Update")
  end
end

l_0_0.InitGameData = function(l_3_0)
  l_3_0.controllers.MarineFaction = sc.spawnControllers.sc_base1
  sc.SetFactionController("MarineFaction", "sc_base1")
  sc.SetController("sc_rs_hostage", true)
  DGApp.DoMPLua("escapeflare = DEEffectPlayerNode.Load(\"signal_smoke_blue\")")
  local l_3_1 = DGPlayerManager.GetNumPlayers()
  local l_3_2 = 2
  local l_3_3 = nil
  if l_3_1 > 2 then
    if l_3_1 >= 4 then
      l_3_2 = 3
    end
    l_3_3 = l_3_1 - 2
  end
  l_3_0:SetDifficulty(l_3_2, l_3_3)
  ScriptManager.RegisterTimerFunction("Hostage Update", function()
    l_3_0:HostageCheck()
   end, 1)
  ScriptManager.RegisterTimerFunction("Rescue Ghosting Update", function()
    l_3_0:UpdateGhosting()
   end, 5)
end

l_0_0.PostStartGame = function(l_4_0)
  for l_4_4 = 1, 10 do
    if sc.spawnControllers.sc_mission" .. l_4_ then
      sc.SetController("sc_mission" .. l_4_4, true)
    end
  end
  local l_4_5 = new
  local l_4_6 = "ZoneScoringCondition"
  local l_4_7 = {}
  l_4_7.sensor = "sens_escape1"
  l_4_7.sensorTag = "Hostage"
  l_4_7.scoreDelay = 1
  l_4_7.scoreAmount = 100
  l_4_5 = l_4_5(l_4_6, l_4_7)
  l_4_6, l_4_7 = l_4_0:AddScoringCondition, l_4_0
  l_4_6(l_4_7, l_4_5)
  l_4_6 = new
  l_4_7 = "DeathEndCondition"
  l_4_6 = l_4_6(l_4_7, "sc_rs_hostage1")
  l_4_7(l_4_0, l_4_6)
  l_4_7 = l_4_0:AddEndCondition
  l_4_7 = new
  l_4_7 = l_4_7("ScoreEndCondition", 100)
  l_4_0:AddEndCondition(l_4_7)
  local l_4_8 = new("PlayersDeadEndCondition")
  l_4_0:AddEndCondition(l_4_8)
  DGApp.DoMPLua("client:ScreenMessage(\"Rescue the captured journalist\")")
  delay(function()
    DGApp.DoMPLua("client:AddIndicator(ValidatePos(\"Hostage\", \"Vec3\"), \"Captured Journalist\")")
   end, 1)
end

l_0_0.UpdateGhosting = function(l_5_0)
  for l_5_4,l_5_5 in pairs(l_5_0.deadPlayers) do
    local l_5_6 = DGPlayerManager.GetPlayerByID(l_5_5)
    local l_5_7 = l_5_6:GetFocusEntity()
    if (l_5_6 and not l_5_7) or l_5_7 and not l_5_7:IsActive() then
      local l_5_8 = SpawnConductor.GetActivePlayerEntity()
      if l_5_8 then
        l_5_6:SwitchFocus(l_5_8)
      end
    end
  end
end

DeclareClass(l_0_0)

