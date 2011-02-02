-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: Stronghold.luac 

module("Stronghold", package.seeall)
require("Gametype")
require("TimeGameCondition")
require("DeathScoringCondition")
require("ScoreEndCondition")
require("PlayersDeadEndCondition")
local l_0_0 = {}
l_0_0.ArgsConstructor = function(l_1_0, l_1_1)
  l_1_0:InitGameData()
end

l_0_0.UpdatePlayerGhosting = function()
  if SpawnConductor.GetActivePlayerCount() > 0 then
    for l_2_3,l_2_4 in pairs(SpawnConductor.deadPlayers) do
      local l_2_5 = DGPlayerManager.GetPlayerByID(l_2_4)
      local l_2_6 = l_2_5:GetFocusEntity()
      if (l_2_5 and not l_2_6) or l_2_6 and not l_2_6:IsActive() then
        l_2_5:SwitchFocus(SpawnConductor.GetActivePlayerEntity())
      end
    end
  end
end

l_0_0.InitGameData = function(l_3_0)
  l_3_0.controllers.MarineFaction = sc.spawnControllers.sc_marines
  sc.SetFactionController("MarineFaction", "sc_marines")
end

l_0_0.PostStartGame = function(l_4_0)
  local l_4_1 = new
  local l_4_2 = "TimeGameCondition"
  local l_4_3 = {}
  l_4_3.deltaTime = 120
  l_4_3.result = function()
    SpawnConductor.OrderAI("outer", "Assault")
   end
  l_4_1 = l_4_1(l_4_2, l_4_3)
  l_4_1.name = "Assault Game Condition"
  l_4_2, l_4_3 = l_4_0:AddGameCondition, l_4_0
  l_4_2(l_4_3, l_4_1)
  l_4_2 = new
  l_4_3 = "DeathScoringCondition"
  local l_4_4 = "Stronghold Death"
  local l_4_5 = {}
  l_4_5.deathTarget = "stronghold"
  l_4_5.scoreAmount = 50
  l_4_2 = l_4_2(l_4_3, l_4_4, l_4_5)
  l_4_3 = new
  l_4_4 = "DeathScoringCondition"
  l_4_5 = "Outer Forces Death"
  local l_4_6 = {}
  l_4_6.deathTarget = "outer"
  l_4_6.scoreAmount = 50
  l_4_3 = l_4_3(l_4_4, l_4_5, l_4_6)
  l_4_4, l_4_5 = l_4_0:AddScoringCondition, l_4_0
  l_4_6 = l_4_2
  l_4_4(l_4_5, l_4_6)
  l_4_4, l_4_5 = l_4_0:AddScoringCondition, l_4_0
  l_4_6 = l_4_3
  l_4_4(l_4_5, l_4_6)
  l_4_4 = new
  l_4_5 = "ScoreEndCondition"
  l_4_6 = 100
  l_4_4 = l_4_4(l_4_5, l_4_6)
  l_4_5, l_4_6 = l_4_0:AddEndCondition, l_4_0
  l_4_5(l_4_6, l_4_4)
  l_4_5 = new
  l_4_6 = "PlayersDeadEndCondition"
  l_4_5 = l_4_5(l_4_6)
  l_4_6(l_4_0, l_4_5)
  l_4_6 = l_4_0:AddEndCondition
  l_4_6 = ScriptManager
  l_4_6 = l_4_6.RegisterUpdateFunction
  l_4_6("Survival Ghosting Update", l_4_0.UpdatePlayerGhosting)
  l_4_6 = SpawnConductor
  l_4_6 = l_4_6.SetController
  l_4_6("sc_center", true)
  l_4_6 = delay
  l_4_6(function()
    SpawnConductor.SetController("sc_outer", true)
   end, 3)
end

l_0_0.Name = "Stronghold"
l_0_0.Extends = "Gametype"
DeclareClass(l_0_0)

