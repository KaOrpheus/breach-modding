-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: Survival.luac 

module("Survival", package.seeall)
require("Gametype")
require("GameCondition")
require("DeathScoringCondition")
require("ScoreEndCondition")
require("PlayersDeadEndCondition")
local l_0_0 = {}
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
  end
  l_1_0.deadPlayers = {}
  l_1_0:InitGameData()
end

l_0_0.InitGameData = function(l_2_0)
  l_2_0.controllers.MarineFaction = sc.spawnControllers.sc_sr_marines
  sc.SetFactionController("MarineFaction", "sc_sr_marines")
  ScriptManager.RegisterTimerFunction("Survival Ghosting Update", function()
    l_2_0:UpdateGhosting()
   end, 5)
  AIManager.RegisterDeathFunction("Survival Death Counter", function(l_2_0)
    l_2_0:HandleDeath(l_2_0)
   end)
end

l_0_0.HandleDeath = function(l_3_0, l_3_1)
  if l_3_1.pid ~= -1 then
    local l_3_2 = DGPlayerManager.GetPlayerByID(l_3_1.pid):GetName()
    if not sc.respawns.individual[l_3_2] and not table.contains(l_3_0.deadPlayers, l_3_1.pid) then
      table.insert(l_3_0.deadPlayers, l_3_1.pid)
    end
  end
end

l_0_0.PostStartGame = function(l_4_0)
  for l_4_4 = 2, 10 do
    do
      if sc.spawnControllers.sc_sr_wave" .. l_4_ then
        local l_4_5 = new("GameCondition", "Wave " .. l_4_4 .. " Cond", function()
        return sc.spawnControllers.sc_sr_wave" .. l_4_4 - :GetRemainingCount() < 5
         end, function()
        sc.SetController("sc_sr_wave" .. l_4_4, true)
        if sc.spawnControllers.sc_sr_wave" .. l_4_4 .. "_sp then
          sc.SetController("sc_sr_wave" .. l_4_4 .. "_sp", true)
        end
        DGApp.DoMPLua("client:ScreenMessage(\"Wave " .. l_4_4 .. " Started\")")
        DGApp.DoMPLua("client:SetMusic(\"intense\")")
         end)
        l_4_5.enabled = true
        l_4_0:AddGameCondition(l_4_5)
      end
    end
  end
  local l_4_6 = new
  local l_4_7 = "DeathScoringCondition"
  local l_4_8 = "Survival Swarm Death"
  local l_4_9 = {}
  l_4_9.deathTarget = "sr_insurgents"
  l_4_9.scoreAmount = 100
  l_4_6 = l_4_6(l_4_7, l_4_8, l_4_9)
  l_4_7, l_4_8 = l_4_0:AddScoringCondition, l_4_0
  l_4_9 = l_4_6
  l_4_7(l_4_8, l_4_9)
  l_4_7 = new
  l_4_8 = "ScoreEndCondition"
  l_4_9 = 100
  l_4_7 = l_4_7(l_4_8, l_4_9)
  l_4_8, l_4_9 = l_4_0:AddEndCondition, l_4_0
  l_4_8(l_4_9, l_4_7)
  l_4_8 = new
  l_4_9 = "PlayersDeadEndCondition"
  l_4_8 = l_4_8(l_4_9)
  l_4_9(l_4_0, l_4_8)
  l_4_9 = l_4_0:AddEndCondition
  l_4_9 = sc
  l_4_9 = l_4_9.SetController
  l_4_9("sc_sr_wave1", true)
  l_4_9 = delay
  l_4_9(function()
    DGApp.DoMPLua("client:ScreenMessage(\"Wave 1 Started\")")
    DGApp.DoMPLua("client:SetMusic(\"intense\")")
   end, 5)
  l_4_9 = delay
  l_4_9(function()
    sc.SetController("sc_sr_rpg", true)
   end, 30)
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

l_0_0.Name = "Survival"
l_0_0.Extends = "Gametype"
DeclareClass(l_0_0)

