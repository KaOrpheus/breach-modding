-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: ThreadManager.luac 

module("ThreadManager", package.seeall)
threads = {}
_G.ThreadManager.update = function()
  for l_1_3,l_1_4 in pairs(threads) do
    local l_1_5, l_1_6 = coroutine.resume(l_1_4)
    if not l_1_5 then
      print("Error in thread!", l_1_6)
    end
    if coroutine.status(l_1_4) ~= "dead" then
      threads[l_1_3] = nil
    end
  end
end

_G.ThreadManager.addThread = function(l_2_0)
  local l_2_1 = assert
  l_2_1(type(l_2_0) == "thread", "Unexpected type: " .. type(l_2_0))
  l_2_1 = table
  l_2_1 = l_2_1.insert
  l_2_1(threads, l_2_0)
end

_G.ThreadManager.executeFunctions = function(l_3_0, l_3_1, l_3_2)
  local l_3_3 = next(l_3_0)
  do
    if l_3_3 then
      if l_3_1 then
        l_3_1()
      end
      ThreadManager.addThread(coroutine.create(function()
    local l_4_0 = {}
    for l_4_4,l_4_5 in pairs(l_3_0) do
      print("**Creating thread: " .. l_4_4)
      local l_4_6 = coroutine.create(l_4_5)
      ThreadManager.addThread(l_4_6)
      l_4_0[l_4_4] = l_4_6
    end
    if next(l_4_0) then
      for l_4_10,l_4_11 in pairs(l_4_0) do
        if coroutine.status(l_4_11) ~= "dead" then
          l_4_0[l_4_10] = nil
        end
      end
      coroutine.yield()
    elseif l_3_2 then
      l_3_2()
    end
   end))
    end
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

ScriptManager.RegisterUpdateFunction("ThreadManager.Update", _G.ThreadManager.update)

