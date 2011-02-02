-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: SpawnManager.luac 

module("SpawnManager", package.seeall)
pendingTickets = {}
Spawn = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7)
  local l_1_8 = assert
  l_1_8(type(l_1_0) == "string")
  l_1_8 = assert
  l_1_8(type(l_1_1) == "string")
  l_1_8 = assert
  l_1_8(l_1_3 == nil or type(l_1_3) == "function")
  l_1_8 = l_1_5 or -1
  local l_1_15 = DGSpawnManager.Spawn(l_1_0, l_1_1, l_1_2, l_1_8, l_1_6, l_1_7)
  if l_1_15 >= 0 then
    local l_1_16 = {}
    l_1_16.spawnTicketNumber = l_1_15
    l_1_16.callback = l_1_3
    l_1_16.userData = l_1_4
    pendingTickets[l_1_15] = l_1_16
  end
  print("Spawn Ticket: " .. l_1_15 .. " for player " .. (l_1_8) .. " with spawntype: " .. l_1_0)
  return l_1_15
end

HandleSpawnResult = function(l_2_0)
  local l_2_1 = l_2_0.Ticket
  if pendingTickets[l_2_1] then
    pendingTickets[l_2_1].callback(l_2_0.BucketID, l_2_0.EntityID, pendingTickets[l_2_1].userData)
    pendingTickets[l_2_1] = nil
    return 
  end
end

HandleEntityCallback = function(l_3_0, l_3_1, l_3_2)
  l_3_2.entity = DGEntityManager.GetEntityByID(l_3_0, l_3_1)
end

DEEventManager.SubscribeEvent("DGEventSpawnResult", HandleSpawnResult)

