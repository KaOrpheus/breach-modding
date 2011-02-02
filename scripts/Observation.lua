-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: Observation.luac 

module("Observation", package.seeall)
local l_0_0 = {}
l_0_0.Name = "Observer"
l_0_0.Notify = function(l_1_0, l_1_1, ...)
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

DeclareInterface(l_0_0)
local l_0_1 = {}
l_0_1.AddObserver = function(l_2_0, l_2_1, l_2_2)
  if l_2_2 and l_2_0:KnowsOf(l_2_1) then
    assert(l_2_2:ACTS_AS("Observer"))
    table.insert(l_2_0.observedSubjects[l_2_1], l_2_2)
  end
end

l_0_1.AddSubject = function(l_3_0, l_3_1)
  if not l_3_0:KnowsOf(l_3_1) then
    l_3_0.observedSubjects[l_3_1] = {}
  end
end

l_0_1.AddSubjects = function(l_4_0, ...)
  for l_4_5,i_2 in ipairs({}) do
    l_4_0:AddSubject(i_2)
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_1.ArgsConstructor = function(l_5_0, ...)
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

   -- Warning: undefined locals caused missing assignments!
end

l_0_1.Destroy = function(l_6_0)
  for l_6_4,l_6_5 in pairs(l_6_0.observedSubjects) do
    table.empty(l_6_5)
    l_6_0.observedSubjects[l_6_4] = nil
  end
  l_6_0.observedSubjects = nil
end

l_0_1.KnowsOf = function(l_7_0, l_7_1)
  return l_7_0.observedSubjects[l_7_1] ~= nil
end

l_0_1.Initialize = function(l_8_0)
  l_8_0.observedSubjects = {}
end

l_0_1.NotifyObservers = function(l_9_0, l_9_1, ...)
  if l_9_0:KnowsOf(l_9_1) then
    for l_9_6,i_2 in pairs(l_9_0.observedSubjects[l_9_1]) do
      i_2:Notify(l_9_1, ...)
    end
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

l_0_1.RemoveObserver = function(l_10_0, l_10_1, l_10_2)
  if l_10_0.observedSubjects[l_10_1] then
    for l_10_6,l_10_7 in pairs(l_10_0.observedSubjects[l_10_1]) do
      if l_10_7 == l_10_2 then
        l_10_0.observedSubjects[l_10_1][l_10_6] = nil
    else
      end
    end
     -- Warning: missing end command somewhere! Added here
  end
end

l_0_1.RemoveObservers = function(l_11_0, l_11_1)
  l_11_0.observedSubjects[l_11_1] = nil
end

l_0_1.Name = "Observable"
DeclareClass(l_0_1)

