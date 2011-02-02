-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: ObjectPool.luac 

module("ObjectPool", package.seeall)
OOP = require("ObjectOrientedParadigm")
local l_0_0 = {}
l_0_0.Name = "ObjectPoolTable"
l_0_0.Protected = true
l_0_0.Initialize = function(l_1_0)
  l_1_0.freeObjects = {}
  l_1_0.numFreeObjects = 0
end

l_0_0.CreateMore_PRIVATE = function(l_2_0, l_2_1, l_2_2)
  l_2_0.numFreeObjects = l_2_0.numFreeObjects + l_2_2
  for l_2_6 = 1, l_2_2 do
    table.insert(l_2_0.freeObjects, new(l_2_1))
  end
end

l_0_0.GetNumFree = function(l_3_0)
  return l_3_0.freeObjects
end

l_0_0.GetObject_PRIVATE = function(l_4_0, l_4_1)
  if l_4_0.numFreeObjects == 0 then
    local l_4_2 = new
    local l_4_3 = l_4_1
    return l_4_2(l_4_3)
  else
    l_4_0.numFreeObjects = l_4_0.numFreeObjects - 1
    local l_4_4 = table.remove
    local l_4_5 = l_4_0.freeObjects
    return l_4_4(l_4_5)
  end
end

l_0_0.GetObjects_PRIVATE = function(l_5_0, l_5_1, l_5_2, l_5_3)
  if l_5_0.numFreeObjects < l_5_2 then
    l_5_0:CreateMore_PRIVATE(l_5_1, l_5_2 - l_5_0.numFreeObjects)
  end
  l_5_0.numFreeObjects = l_5_0.numFreeObjects - l_5_2
  for l_5_7 = 1, l_5_2 do
    table.insert(l_5_3, table.remove(l_5_0.freeObjects))
  end
  return l_5_3
end

l_0_0.Recycle_PRIVATE = function(l_6_0, l_6_1)
  l_6_0.numFreeObjects = l_6_0.numFreeObjects + 1
  table.insert(l_6_0.freeObjects, l_6_1)
end

DeclareClass(l_0_0)
tables = {}
CreateObjectPool_PRIVATE = function(l_7_0)
  tables[l_7_0] = OOP.classes_PRIVATE.ObjectPoolTable:new()
  return tables[l_7_0]
end

Get = function(l_8_0)
  if not tables[l_8_0] or not tables[l_8_0]:GetObject_PRIVATE(l_8_0) then
    return CreateObjectPool_PRIVATE(l_8_0):GetObject_PRIVATE(l_8_0)
  end
end

Recycle = function(...)
  do
    local l_9_1 = (select("#", ...))
    for l_9_5 = 1, l_9_1 do
      local l_9_2 = nil
       -- DECOMPILER ERROR: Confused about usage of registers!

      l_9_2 = select(, ...)
      if l_9_2 then
        tables[l_9_2:GetClassName()]:Recycle_PRIVATE(l_9_2)
      end
    end
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

GetOrRecycle = function(...)
   -- DECOMPILER ERROR: Confused at declaration of local variable

   -- DECOMPILER ERROR: Confused at declaration of local variable

  if select("#", ...) == 1 and type(...) == "string" then
    return Get(...)
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  else
    Recycle(...)
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

if not getmetatable(ObjectPool) then
  setmetatable(ObjectPool, {})
end
getmetatable(ObjectPool).__call = function(l_11_0, ...)
  do
    local l_11_2 = GetOrRecycle
    return l_11_2(...)
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


