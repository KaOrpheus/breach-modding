-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: Gametype.luac 

module("Gametype", package.seeall)
require("GameScript")
require("GameInfo")
require("PlayerSpawner")
local l_0_0 = {}
l_0_0.Name = "Gametype"
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

l_0_1("GameScript")
l_0_0.Update, l_0_0.StartGame, l_0_0.PostStartGame, l_0_0.OnAddJoinInProgressPlayer, l_0_0.Initialize, l_0_0.InitGameData, l_0_0.EndGame, l_0_0.AddScoringCondition, l_0_0.AddJoinInProgressPlayer, l_0_0.AddGameCondition, l_0_0.AddEvent, l_0_0.AddEndCondition, l_0_1, l_0_0.Implements = l_0_1, l_0_1, l_0_1, l_0_1, l_0_1, l_0_1, l_0_1, l_0_1, l_0_1, l_0_1, l_0_1, l_0_1, function(l_1_0, l_1_1)
  assert(IS_A(l_1_1, "EndCondition"), "Problem with end condition: " .. (l_1_1.name or "unamed") .. ", it does not from EndCondition!")
  table.insert(l_1_0.endConditions, l_1_1)
end
, l_0_1

