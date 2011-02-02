-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: Escort.luac 

module("Escort", package.seeall)
require("Gametype")
require("DeathEndCondition")
require("TimeEndCondition")
require("ScoreEndCondition")
require("DeathScoringCondition")
require("ZoneScoringCondition")
local l_0_0 = {}
l_0_0.Name = "Escort"
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
  l_1_0:InitGameData()
  DGApp.DoMPLua("escapeflare = DEEffectPlayerNode.Load(\"signal_smoke_blue\")")
end

l_0_0.InitGameData = function(l_2_0)
  local l_2_1 = {}
  for l_2_5 = 1, 5 do
    if ValidatePos("loc_escape" .. l_2_5, "Vec3") then
      table.insert(l_2_1, l_2_5)
    end
  end
  table.shuffle(l_2_1)
  l_2_0.index = l_2_1[math.random(#l_2_1)]
  l_2_0.controllers.MarineFaction = sc.spawnControllers.sc_es_marines" .. l_2_0.inde
  sc.SetFactionController("MarineFaction", "sc_es_marines" .. l_2_0.index)
  l_2_0.controllers.InsurgentFaction = sc.spawnControllers.sc_es_insurgents
  sc.SetFactionController("InsurgentFaction", "sc_es_insurgents")
end

l_0_0.Initialize = function(l_3_0)
  l_3_0.name = "Escort"
end

l_0_0.PostStartGame = function(l_4_0)
  DGApp.DoMPLua("escapeflare:SetWorldTransformPQ(ValidatePos(\"loc_escape" .. l_4_0.index .. "\", \"PosQuat\"))")
  DGApp.DoMPLua("escapeflare:Start()")
  DGApp.DoMPLua("client:AddIndicator(ValidatePos(\"loc_escape" .. l_4_0.index .. "\", \"Vec3\"), \"Extraction Point\")")
  if timeLimit then
    local l_4_1 = new("TimeEndCondition", 600)
    l_4_0:AddEndCondition(l_4_1)
  end
  local l_4_2 = new
  local l_4_3 = "ZoneScoringCondition"
  local l_4_4 = {}
  l_4_4.sensor = "sens_escape" .. l_4_0.index
  l_4_4.sensorTag = "MarineVIP"
  l_4_4.scoreDelay = 1
  l_4_4.scoreAmount = 100
  l_4_2 = l_4_2(l_4_3, l_4_4)
  l_4_3, l_4_4 = l_4_0:AddScoringCondition, l_4_0
  l_4_3(l_4_4, l_4_2)
  l_4_3 = new
  l_4_4 = "DeathScoringCondition"
  local l_4_5 = "VIP Death"
  local l_4_6 = {}
  l_4_6.deathTarget = "MarineVIP"
  l_4_6.teamPunish = true
  l_4_6.scoreAmount = 100
  l_4_3 = l_4_3(l_4_4, l_4_5, l_4_6)
  l_4_4, l_4_5 = l_4_0:AddScoringCondition, l_4_0
  l_4_6 = l_4_3
  l_4_4(l_4_5, l_4_6)
  l_4_4 = new
  l_4_5 = "ScoreEndCondition"
  l_4_6 = 100
  l_4_4 = l_4_4(l_4_5, l_4_6)
  l_4_5, l_4_6 = l_4_0:AddEndCondition, l_4_0
  l_4_5(l_4_6, l_4_4)
  l_4_5 = ScriptManager
  l_4_5 = l_4_5.RegisterTimerFunction
  l_4_6 = "VIP check"
  l_4_5(l_4_6, function()
    l_4_0:VIPCheck()
   end, 1)
end

l_0_0.VIPCheck = function(l_5_0)
  if DGPlayerManager.GetPlayerByID(sc.GetPlayersByRole("MarineVIP")[1]):GetControlEntity() then
    l_5_0.controllers.MarineFaction.trackingLocus:Track(DGPlayerManager.GetPlayerByID(sc.GetPlayersByRole("MarineVIP")[1]):GetControlEntity())
    ScriptManager.UnregisterTimerFunction("VIP check")
  end
end

DeclareClass(l_0_0)

