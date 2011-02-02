-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: PlayerSpawner.luac 

module("PlayerSpawner", package.seeall)
local l_0_0 = {}
l_0_0.Name = "PlayerSpawner"
l_0_0.UpdateWave = function(l_1_0)
  for l_1_4,l_1_5 in pairs(l_1_0.waveSets) do
    if currentGame and currentGame.gameOver then
      ScriptManager.UnregisterTimerFunction(l_1_4 .. " Wave Timer")
      for l_1_4,l_1_5 in l_1_1 do
      end
      l_1_5.waveCountdown = l_1_5.waveCountdown - 1
      if l_1_5.waveCountdown < l_1_5.waveBuffer then
        for l_1_9,l_1_10 in pairs(l_1_0.players[l_1_4]) do
          if l_1_5.waitingToSpawn[l_1_10] == nil then
            print("adding player ID: " .. l_1_10 .. " to waitingToSpawn table from players list")
          end
          l_1_5.waitingToSpawn[l_1_10] = true
        end
        if l_1_5.waveCountdown < 1 then
          if #l_1_5.waveBucket > 0 then
            print(tostring(l_1_4) .. " waveBucket is now the players list")
            print("waveBucket:")
            sprint(l_1_5.waveBucket)
            print("players lost because they were still in the players list:")
            sprint(l_1_0.players[l_1_4])
            l_1_0.players[l_1_4] = l_1_5.waveBucket
            l_1_5.waveCountdown = l_1_5.waveTime
            l_1_5.waveBucket = {}
            for l_1_4,l_1_5 in l_1_1 do
            end
            l_1_0.players[l_1_4] = {}
            l_1_5.waveCountdown = l_1_5.waveTime
            ScriptManager.UnregisterTimerFunction(l_1_4 .. " Wave Timer")
          end
        end
      end
       -- Warning: missing end command somewhere! Added here
    end
     -- Warning: missing end command somewhere! Added here
  end
end

l_0_0.HandlePlayerAction = function(l_2_0, l_2_1)
  local l_2_2 = 1
  local l_2_3 = l_2_1.PlayerID
  local l_2_4 = l_2_1.Action
  sprint("PS:Handle Player Action !! PID: " .. l_2_3 .. " Action: " .. l_2_4)
  if l_2_4 == l_2_2 then
    for l_2_8,l_2_9 in pairs(l_2_0.waveSets) do
      if l_2_9.waitingToSpawn[l_2_3] then
        print("PS: player ID:" .. l_2_3 .. " deleted, removed from " .. tostring(l_2_8) .. " waitingToSpawn table ")
        l_2_9.waitingToSpawn[l_2_3] = nil
      end
      local l_2_10 = nil
      for l_2_14,l_2_15 in pairs(l_2_9.waveBucket) do
        if l_2_15 == l_2_3 then
          l_2_10 = l_2_14
        end
      end
      if l_2_10 ~= nil then
        table.remove(l_2_9.waveBucket, l_2_10)
        print("PS: player ID:" .. l_2_3 .. " deleted, removed from " .. tostring(l_2_8) .. " waveBucket table.")
      end
    end
    for l_2_19,l_2_20 in pairs(l_2_0.players) do
      local l_2_21 = nil
      for l_2_25,l_2_26 in pairs(l_2_20) do
        if l_2_26 == l_2_3 then
          l_2_21 = l_2_25
        end
      end
      if l_2_21 ~= nil then
        table.remove(l_2_20, l_2_21)
        print("PS: player ID:" .. l_2_3 .. " deleted, removed from " .. l_2_19 .. " players table.")
      end
    end
  end
end

l_0_0.HandleRoleSwitch = function(l_3_0, l_3_1)
  local l_3_2 = l_3_1.PlayerID
  local l_3_3 = DGPlayerManager.GetPlayerByID(l_3_2)
  local l_3_4 = l_3_3:GetFaction():GetName()
  sprint("PS:HandleRoleSwitch !! PID: " .. l_3_2 .. " Faction: " .. l_3_4)
  if l_3_0.waveSets[l_3_4].waitingToSpawn[l_3_2] then
    print("Spawning Player " .. l_3_2)
    local l_3_5 = l_3_0:SpawnPlayer(l_3_2, nil, nil, nil)
    if l_3_5 and l_3_5 >= 0 then
      l_3_0.waveSets[l_3_4].waitingToSpawn[l_3_2] = nil
      print("removed player ID: " .. l_3_2 .. " from " .. tostring(l_3_4) .. " waitingToSpawn table")
    else
      print("SpawnPlayer returned an invalid ticket: " .. tostring(l_3_5) .. " when spawning player " .. l_3_2)
    end
  else
    print("Player " .. tostring(l_3_2) .. " on faction " .. tostring(l_3_4) .. " tried to spawn, but isn't in the -waitingToSpawn- table for the faction")
  end
end

l_0_0.SpawnPlayer = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4)
  do
    local l_4_5 = DGPlayerManager.GetPlayerByID(l_4_1)
    if l_4_5 then
      local l_4_6 = l_4_5:GetFaction():GetName()
      if not l_4_2 or not l_4_3 or not l_4_4 then
        print("GetValidSpawns in SpawnPlayer for player ID " .. l_4_1)
        l_4_2 = l_4_0:GetValidSpawns(l_4_6, 1)[1]
        l_4_3 = l_4_0[1]
        l_4_4 = l_4_6[1]
      end
      local l_4_7 = gameType:GetFaction(l_4_5:GetFactionID()):GetRole(l_4_5:GetRoleDataIndex()).SpawnInfo
      local l_4_9 = function(l_1_0, l_1_1)
      PlayerManager:SetPlayer(l_1_0, l_1_1, l_4_1)
      local l_5_2 = DGEntityManager.GetEntityByID(l_1_0, l_1_1)
      l_5_2:SetInvincible(true)
      ScriptManager.RegisterDelayFunction("Making " .. l_4_5:GetName() .. " with ID:" .. l_4_5:GetPlayerID() .. " Mortal", function()
        l_1_2:SetInvincible(false)
         end, 5)
      end
      local l_4_10 = SpawnManager.Spawn
      local l_4_11 = l_4_7
      local l_4_12 = "DGHumanSpawnInfo"
      local l_4_13 = l_4_2
      local l_4_14 = l_4_9
      local l_4_15 = nil
      local l_4_16 = l_4_1
      local l_4_17 = l_4_3
      return l_4_10(l_4_11, l_4_12, l_4_13, l_4_14, l_4_15, l_4_16, l_4_17, l_4_4)
    else
      print("Failed to spawn player with ID " .. l_4_1)
    end
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

l_0_0.HandlePlayerDeath = function(l_5_0, l_5_1)
  local l_5_2 = l_5_1.PlayerID
  local l_5_3 = DGPlayerManager.GetPlayerByID(l_5_2)
  if l_5_3 then
    print("Respawning player ID: " .. l_5_2)
    l_5_0:RespawnPlayer(l_5_2, l_5_3:GetFaction():GetName())
  else
    print("couldn't find player ID: " .. l_5_2 .. " in player manager, HandlePlayerDeath will fail!!!")
  end
end

l_0_0.RespawnPlayer = function(l_6_0, l_6_1, l_6_2)
  print("Respawning Player " .. tostring(l_6_1) .. ", faction: " .. tostring(l_6_2))
  if #l_6_0.players[l_6_2] == 0 then
    local l_6_3 = DGPlayerManager.GetNumPlayers()
    if currentGame.spawnThreshold and currentGame.spawnThreshold < l_6_3 then
      l_6_0.waveSets[l_6_2].waveTime = currentGame.spawnDelay + currentGame.spawnBonus
    end
    l_6_0.waveSets[l_6_2].waveCountdown = l_6_0.waveSets[l_6_2].waveTime
    print("Registering Wave Update")
    ScriptManager.RegisterTimerFunction(l_6_0.name .. " Wave Timer", function()
      l_6_0:UpdateWave()
      end, 1)
  end
  if l_6_0.waveSets[l_6_2].waveCountdown <= l_6_0.waveSets[l_6_2].waveBuffer then
    print("adding player ID: " .. l_6_1 .. " to waveBucket table for " .. tostring(l_6_2))
    table.insert(l_6_0.waveSets[l_6_2].waveBucket, l_6_1)
    local l_6_4 = l_6_0.waveSets[l_6_2].waveCountdown + l_6_0.waveSets[l_6_2].waveTime
    print("Sending Countdown of " .. tostring(l_6_4) .. " to PID:" .. tostring(l_6_1))
    DGApp.DoMPLua("client:SetRespawnCountdown(" .. l_6_1 .. ", " .. l_6_0.waveSets[l_6_2].waveCountdown + l_6_0.waveSets[l_6_2].waveTime .. ")")
  else
    print("adding player ID: " .. l_6_1 .. " to players table for " .. tostring(l_6_2))
    table.insert(l_6_0.players[l_6_2], l_6_1)
    local l_6_5 = l_6_0.waveSets[l_6_2].waveCountdown
    print("Sending Countdown of " .. tostring(l_6_5) .. " to PID:" .. tostring(l_6_1))
    DGApp.DoMPLua("client:SetRespawnCountdown(" .. l_6_1 .. ", " .. l_6_0.waveSets[l_6_2].waveCountdown .. ")")
  end
end

l_0_0.GetValidSpawns = function(l_7_0, l_7_1, l_7_2)
  local l_7_3 = {}
  local l_7_4 = {}
  local l_7_5 = {}
  local l_7_6 = {}
  if l_7_0.factionLocus[l_7_1].locSet and table.count(l_7_0.factionLocus[l_7_1].locSet) > 0 then
    for l_7_10,l_7_11 in pairs(l_7_0.factionLocus[l_7_1].locSet) do
      if l_7_0:IsSpawnValid(l_7_11, l_7_1) then
        table.insert(l_7_5, l_7_11)
      end
    end
  else
    local l_7_12 = 0
    local l_7_13 = l_7_0.factionLocus[l_7_1].outerRadius
    local l_7_14 = {}
    for l_7_18,l_7_19 in pairs(l_7_0.spawnLocations) do
      local l_7_20 = (new("PosQuat", l_7_19:GetWorldTransformPQ()))
      local l_7_21 = nil
      if l_7_0.factionLocus[l_7_1].loc then
        l_7_21 = l_7_20:GetPos():Distance(l_7_0.factionLocus[l_7_1].loc)
      else
        if l_7_0.factionLocus[l_7_1].entity then
          l_7_21 = l_7_20:GetPos():Distance(new("Vec3", l_7_0.factionLocus[l_7_1].entity:GetPos()))
        end
      end
      if l_7_0.factionLocus[l_7_1].innerRadius < l_7_21 and l_7_21 < l_7_0.factionLocus[l_7_1].outerRadius and l_7_0:IsSpawnValid(l_7_19, l_7_1) then
        if l_7_0.factionLocus[l_7_1].entity then
          local l_7_22 = table.insert
          local l_7_23 = l_7_14
          do
            local l_7_24 = {}
            l_7_22(l_7_23, l_7_24)
          end
          for l_7_18,l_7_19 in l_7_15 do
          end
          table.insert(l_7_5, l_7_19)
        end
      end
      if l_7_0.factionLocus[l_7_1].entity then
        local l_7_25 = 0
        if #l_7_14 > 0 then
          table.sort(l_7_14, function(l_1_0, l_1_1)
          return l_1_0[2] < l_1_1[2]
            end)
          for l_7_29,l_7_30 in pairs(l_7_14) do
            if l_7_30 and l_7_25 < 4 then
              table.insert(l_7_5, l_7_30[1])
            end
          end
        end
      end
    end
     -- DECOMPILER ERROR: Overwrote pending register.

    if l_7_12 > 0 then
      for l_7_34 = l_7_12, l_7_13, l_7_14 do
         -- DECOMPILER ERROR: Confused at declaration of local variable

        table.shuffle(l_7_5)
         -- DECOMPILER ERROR: Confused at declaration of local variable

         -- DECOMPILER ERROR: Confused about usage of registers!

         -- DECOMPILER ERROR: Confused about usage of registers!

        if l_7_4[l_7_5[1]] then
          do return end
        end
         -- DECOMPILER ERROR: Confused about usage of registers!

      end
     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

    else
      for l_7_39 = l_7_12, l_7_13.factionBases[l_7_1].LinkedSpawns:GetNumItems() do
         -- DECOMPILER ERROR: Confused at declaration of local variable

         -- DECOMPILER ERROR: Confused about usage of registers!

         -- DECOMPILER ERROR: Confused at declaration of local variable

        do
           -- DECOMPILER ERROR: Confused at declaration of local variable

           -- DECOMPILER ERROR: Confused about usage of registers!

           -- DECOMPILER ERROR: Confused about usage of registers!

          if l_7_0:IsSpawnValid(l_7_0.spawnLocations[currentGame.factionBases[l_7_1].LinkedSpawns[l_7_25]], l_7_1) then
            table.insert(l_7_5, l_7_0.spawnLocations[currentGame.factionBases[l_7_1].LinkedSpawns[l_7_25]])
          end
           -- DECOMPILER ERROR: Confused about usage of registers for local variables.

        end
      end
       -- DECOMPILER ERROR: Confused about usage of registers!

       -- DECOMPILER ERROR: Confused about usage of registers!

      if #l_7_5 > 0 then
        for l_7_45 = 1, l_7_2 do
           -- DECOMPILER ERROR: Confused at declaration of local variable

           -- DECOMPILER ERROR: Confused about usage of registers!

          table.shuffle(l_7_5)
           -- DECOMPILER ERROR: Confused about usage of registers!

           -- DECOMPILER ERROR: Confused at declaration of local variable

           -- DECOMPILER ERROR: Confused about usage of registers!

           -- DECOMPILER ERROR: Confused about usage of registers!

           -- DECOMPILER ERROR: Confused about usage of registers!

           -- DECOMPILER ERROR: Confused about usage of registers!

           -- DECOMPILER ERROR: Confused about usage of registers!

          if l_7_4[l_7_5[1]] then
            do return end
          end
           -- DECOMPILER ERROR: Confused about usage of registers!

           -- DECOMPILER ERROR: Confused about usage of registers!

           -- DECOMPILER ERROR: Confused about usage of registers for local variables.

        end
       -- DECOMPILER ERROR: Confused about usage of registers!

      else
        for l_7_50 = 1, currentGame.factionBases[l_7_1].LinkedSpawns:GetNumItems() do
           -- DECOMPILER ERROR: Confused at declaration of local variable

           -- DECOMPILER ERROR: Confused about usage of registers!

           -- DECOMPILER ERROR: Confused about usage of registers!

           -- DECOMPILER ERROR: Confused at declaration of local variable

           -- DECOMPILER ERROR: Confused about usage of registers!

           -- DECOMPILER ERROR: Confused about usage of registers!

          table.insert(l_7_5, l_7_0.spawnLocations[currentGame.factionBases[l_7_1].LinkedSpawns[l_7_25]])
           -- DECOMPILER ERROR: Confused about usage of registers for local variables.

        end
         -- DECOMPILER ERROR: Confused about usage of registers!

        table.shuffle(l_7_5)
         -- DECOMPILER ERROR: Confused about usage of registers!

         -- DECOMPILER ERROR: Confused about usage of registers!

         -- DECOMPILER ERROR: Confused about usage of registers!

      end
    end
     -- DECOMPILER ERROR: Confused at declaration of local variable

     -- DECOMPILER ERROR: Confused about usage of registers!

    for l_7_56,l_7_57 in pairs(l_7_4) do
       -- DECOMPILER ERROR: Confused at declaration of local variable

       -- DECOMPILER ERROR: Confused about usage of registers!

       -- DECOMPILER ERROR: Confused at declaration of local variable

       -- DECOMPILER ERROR: Confused about usage of registers!

       -- DECOMPILER ERROR: Confused about usage of registers!

       -- DECOMPILER ERROR: Confused at declaration of local variable

      table.insert({}, new("PosQuat", currentGame.factionBases[l_7_1].LinkedSpawns[l_7_25]:GetWorldTransformPQ()))
      for l_7_63,l_7_64 in pairs(DGSpawnManager.GetSpawnInAreaLocList(new("PosQuat", currentGame.factionBases[l_7_1].LinkedSpawns[l_7_25]:GetWorldTransformPQ()), currentGame.factionBases[l_7_1].LinkedSpawns[l_7_25].SpawnAreaRadius, table.insert)) do
         -- DECOMPILER ERROR: Confused at declaration of local variable

         -- DECOMPILER ERROR: Overwrote pending register.

         -- DECOMPILER ERROR: Confused about usage of registers!

         -- DECOMPILER ERROR: Overwrote pending register.

         -- DECOMPILER ERROR: Confused about usage of registers!

        l_7_19.insert(l_7_21, l_7_19)
         -- DECOMPILER ERROR: Attempted to generate an assignment, but got confused about usage of registers

         -- DECOMPILER ERROR: Confused about usage of registers!

         -- DECOMPILER ERROR: Confused about usage of registers!

        table.insert(l_7_6, currentGame.factionBases[l_7_1].LinkedSpawns[l_7_25].SpawnAreaRadius)
         -- DECOMPILER ERROR: Attempted to generate an assignment, but got confused about usage of registers

         -- DECOMPILER ERROR: Confused about usage of registers for local variables.

      end
       -- DECOMPILER ERROR: Attempted to generate an assignment, but got confused about usage of registers

    end
     -- DECOMPILER ERROR: Attempted to generate an assignment, but got confused about usage of registers

     -- DECOMPILER ERROR: Confused about usage of registers!

     -- DECOMPILER ERROR: Confused about usage of registers!

     -- DECOMPILER ERROR: Confused about usage of registers!

     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

    return l_7_3, l_7_6, {}
     -- DECOMPILER ERROR: Attempted to generate an assignment, but got confused about usage of registers

     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

     -- DECOMPILER ERROR: Attempted to generate an assignment, but got confused about usage of registers

     -- Warning: missing end command somewhere! Added here
  end
end

l_0_0.ArgsConstructor = function(l_8_0, l_8_1, l_8_2)
  do
     -- DECOMPILER ERROR: Confused at declaration of local variable

    l_8_0.name = l_8_1 or "No Name"
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.Initialize = function(l_9_0)
  local l_9_1 = {}
  l_9_1.BlackOps = {}
  l_9_1.OpFor = {}
  l_9_0.players = l_9_1
  local l_9_2 = {}
  l_9_2.loc = ValidatePos("loc_base1", "Vec3")
  l_9_2 = {loc = ValidatePos("loc_base2", "Vec3")}
  l_9_1 = {BlackOps = l_9_2, OpFor = l_9_2}
  l_9_0.factionLocus = l_9_1
  l_9_1 = {}
  l_9_0.factionCap = l_9_1
  l_9_1 = {}
  l_9_0.waveSets = l_9_1
  l_9_1 = l_9_0.waveSets
  l_9_2 = {waveTime = 10, waveBuffer = 3, waveCountdown = 0, waveBucket = {}, waitingToSpawn = {}}
  l_9_1.BlackOps = l_9_2
  l_9_1 = l_9_0.waveSets
  l_9_2 = {waveTime = 10, waveBuffer = 3, waveCountdown = 0, waveBucket = {}, waitingToSpawn = {}}
  l_9_1.OpFor = l_9_2
  l_9_1 = {}
  l_9_0.spawnLocations = l_9_1
  l_9_0.respawnEnabled = true
  l_9_1 = pairs
  l_9_2 = DGDataNodeManager
  l_9_2 = l_9_2.EnumAllNodesOfType
  l_9_2 = l_9_2("DGDataNodeSpawnLocation")
  l_9_1 = l_9_1(l_9_2)
  for i_1,i_2 in l_9_1 do
    l_9_0.spawnLocations[l_9_5.Name] = l_9_5
  end
  PlayerManager.RegisterDeathFunction("PS: Handle Player Death", function(l_1_0)
    l_9_0:HandlePlayerDeath(l_1_0)
   end)
  DEEventManager.SubscribeEvent("DGNetEventSwitchFactionResult", function(l_2_0)
    l_9_0:HandleRoleSwitch(l_2_0)
   end)
  DEEventManager.SubscribeEvent("DGEventPlayerAction", function(l_3_0)
    l_9_0:HandlePlayerAction(l_3_0)
   end)
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.IsFactionActive = function(l_10_0, l_10_1)
  local l_10_2 = DGFactionManager.GetFaction(l_10_1)
  if l_10_2 then
    local l_10_3 = l_10_2:GetMembers()
    if l_10_3 then
      for l_10_7,l_10_8 in pairs(l_10_3) do
        if l_10_8:IsActive() then
          return true
        end
      end
    end
  end
  l_10_3 = false
  return l_10_3
end

l_0_0.IsSpawnValid = function(l_11_0, l_11_1, l_11_2)
  local l_11_3 = DGPlayerManager.GetNumPlayers()
  if l_11_3 < l_11_1.MinPlayers or l_11_1.MaxPlayers < l_11_3 then
    return false
  end
  if l_11_1.TeamID > 0 and l_11_0.baseIndexes[l_11_1.TeamID] ~= l_11_2 then
    return false
  end
  local l_11_4 = ObjectPool.Get("Vec3"):Set(l_11_1:GetWorldPosition())
  for l_11_8,l_11_9 in pairs(DGFactionManager.GetFactions()) do
    if l_11_2 ~= l_11_9:GetName() then
      local l_11_10 = l_11_9:GetMembers()
      if l_11_10 then
        for l_11_14,l_11_15 in pairs(l_11_10) do
          local l_11_16 = ObjectPool.Get("Vec3"):Set(l_11_15:GetPos())
          if l_11_15 and l_11_4:Distance(l_11_16) < l_11_1.DisableRadius and math.abs(l_11_16.z - l_11_4.z) < 150 then
            ObjectPool.Recycle(l_11_16)
            ObjectPool.Recycle(l_11_4)
            return false
          end
          ObjectPool.Recycle(l_11_16)
        end
      end
    end
  end
  ObjectPool.Recycle(l_11_4)
  return true
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.SetFactionLocus = function(l_12_0, l_12_1, l_12_2, l_12_3, l_12_4)
  if IS_A(l_12_2, "CaptureGameCondition") then
    l_12_0.factionLocus[l_12_1].loc = l_12_2.pos
    l_12_0.factionLocus[l_12_1].innerRadius = l_12_2.radius or 0
    l_12_0.factionLocus[l_12_1].outerRadius = l_12_2.spawnRadius
    l_12_0.factionLocus[l_12_1].locSet = {}
    for l_12_8,l_12_9 in pairs(l_12_2.spawnLocs) do
      if l_12_0.spawnLocations[l_12_9] then
        table.insert(l_12_0.factionLocus[l_12_1].locSet, l_12_0.spawnLocations[l_12_9])
      end
    end
    sprint("Setting " .. l_12_1 .. " Locus: " .. l_12_2.name)
  else
    if type(l_12_2) == "<DGDataNodeTeamBase>" then
      l_12_0.factionLocus[l_12_1].locSet = {}
      for l_12_13 = 1, l_12_2.LinkedSpawns:GetNumItems() do
        table.insert(l_12_0.factionLocus[l_12_1].locSet, l_12_0.spawnLocations[l_12_2.LinkedSpawns[l_12_13]])
      end
    else
      if type(l_12_2) == "<DGHumanEntity>" then
        l_12_0.factionLocus[l_12_1].loc = nil
        l_12_0.factionLocus[l_12_1].entity = l_12_2
      else
        local l_12_14 = ValidatePos(l_12_2, "Vec3")
        if l_12_14 then
          l_12_0.factionLocus[l_12_1].entity = nil
          l_12_0.factionLocus[l_12_1].loc = l_12_14
          sprint("Setting " .. l_12_1 .. " Locus: " .. l_12_2)
        end
      end
      local l_12_15 = l_12_0.factionLocus[l_12_1]
      do
         -- DECOMPILER ERROR: Confused at declaration of local variable

        l_12_15.innerRadius = l_12_3 or 0
        l_12_15 = l_12_0.factionLocus
        l_12_15 = l_12_15[l_12_1]
        l_12_15.outerRadius = l_12_4 or 1500
        l_12_15 = l_12_0.factionLocus
        l_12_15 = l_12_15[l_12_1]
        l_12_15.locSet = {}
      end
       -- DECOMPILER ERROR: Confused about usage of registers for local variables.

    end
  end
end

l_0_0.SetRespawnEnabled = function(l_13_0, l_13_1)
  l_13_0.respawnEnabled = l_13_1
  if not l_13_0.respawnEnabled then
    PlayerManager.UnregisterDeathFunction("PS: Handle Player Death")
  end
end

l_0_0.SetRespawnTime = function(l_14_0, l_14_1, l_14_2)
  if l_14_0.waveSets[l_14_1] and l_14_2 then
    l_14_0.waveSets[l_14_1].waveTime = l_14_2
  end
end

l_0_0.SetRespawns = function(l_15_0, l_15_1, l_15_2)
  if l_15_1 then
    l_15_0.respawnType = l_15_1
  end
  if l_15_2 > 0 then
    l_15_0.respawnNum = l_15_2
  end
end

l_0_0.SpawnTeam = function(l_16_0, l_16_1)
  print("SpawnTeam for faction " .. l_16_1)
  local l_16_2 = DGFactionManager.GetFactionByID(l_16_1)
  if l_16_2 then
    local l_16_3 = l_16_2:GetName()
    local l_16_4 = DGPlayerManager.GetPlayersOnFactionByID(l_16_1)
    if l_16_4 then
      local l_16_5, l_16_6, l_16_7 = l_16_0:GetValidSpawns(l_16_3, table.count(l_16_4))
      for l_16_11,l_16_12 in pairs(l_16_4) do
        l_16_0:SpawnPlayer(l_16_12:GetPlayerID(), l_16_5[l_16_11 + 1], l_16_6[l_16_11 + 1], l_16_7[l_16_11 + 1])
      end
    end
  end
end

l_0_0.StartGame = function(l_17_0)
  local l_17_1 = DGPlayerManager.GetPlayers()
  local l_17_2 = DGDataNodeManager.EnumAllNodesOfType("DGDataNodeScriptedCamera")
  do
    local l_17_3 = {}
    l_17_3.BlackOps = 0
    l_17_3.OpFor = 0
    if l_17_1 then
      for l_17_7,l_17_8 in pairs(l_17_1) do
        local l_17_9 = l_17_8:GetFaction():GetName()
        l_17_0.waveSets[l_17_9].waitingToSpawn[l_17_8:GetPlayerID()] = true
        print("adding player ID: " .. l_17_8:GetPlayerID() .. " to waitingToSpawn table for " .. tostring(l_17_9))
        l_17_3[l_17_9] = l_17_3[l_17_9] + 1
        DGApp.DoMPLua("client:SetRespawnCountdown(" .. l_17_8:GetPlayerID() .. ", 2)")
        if l_17_2 then
          table.shuffle(l_17_2)
          DGApp.DoMPLua("client:SetCameraFocus(" .. l_17_8:GetPlayerID() .. ",\"" .. l_17_2[0].Name .. "\")")
        end
      end
    end
    do
      local l_17_10 = {}
    end
     -- DECOMPILER ERROR: Confused about usage of registers!

  end
   -- Warning: undefined locals caused missing assignments!
end

l_0_0.TestSpawning = function(l_18_0, l_18_1, l_18_2)
  local l_18_3 = l_18_0:GetValidSpawns(l_18_1, l_18_2)
  for l_18_7 = 1, l_18_2 do
    local l_18_8 = {}
    local l_18_9 = {}
     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

    l_18_9, l_18_8.BlackOps = {"Team1Rifleman", "Team1Gunner", "Team1Sniper", "Team1Support", "Team1Recon"}, l_18_9
    l_18_8.OpFor = l_18_9
    l_18_9 = l_18_8[l_18_1]
    l_18_9 = l_18_9[math.random(5)]
    local l_18_10 = SpawnManager.Spawn(l_18_9, "DGHumanSpawnInfo", l_18_3[l_18_7], function()
      end)
    sprint("Tried Spawning: " .. l_18_9 .. " Ticket: " .. l_18_10 .. " Location: " .. l_18_3[l_18_7]:GetPos())
  end
end

DeclareClass(l_0_0)

