-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: UserTags.luac 

module("UserTags", package.seeall)
local l_0_0 = {}
l_0_0.Initialize = function(l_1_0)
  l_1_0.tags = {}
end

l_0_0.Add = function(l_2_0, l_2_1, l_2_2)
  l_2_0.tags[l_2_1] = l_2_2
end

l_0_0.Remove = function(l_3_0, l_3_1)
  l_3_0.tags[l_3_1] = nil
end

l_0_0.AddMany = function(l_4_0, l_4_1)
  for l_4_5,l_4_6 in pairs(l_4_1) do
    l_4_0.tags[l_4_5] = l_4_6
  end
end

l_0_0.RemoveMany = function(l_5_0, l_5_1)
  for l_5_5,l_5_6 in pairs(l_5_1) do
    l_5_0.tags[l_5_5] = nil
  end
end

l_0_0.Has = function(l_6_0, l_6_1, l_6_2)
  if l_6_0.tags[l_6_1] ~= nil or l_6_2 ~= l_6_0.tags[l_6_1] then
    return not l_6_2
  end
  return l_6_0.tags[l_6_1] == nil
end

l_0_0.HasMany = function(l_7_0, l_7_1)
  for l_7_5,l_7_6 in pairs(l_7_1) do
    if not l_7_0.tags[l_7_5] or l_7_0.tags[l_7_5] ~= l_7_6 then
      return false
    end
  end
  return true
end

l_0_0.GetValue = function(l_8_0, l_8_1)
  return l_8_0.tags[l_8_1]
end

l_0_0.PrintAll = function(l_9_0)
  local l_9_1 = {}
  local l_9_2 = 0
  for l_9_6,l_9_7 in pairs(l_9_0.tags) do
    table.insert(l_9_1, "   ")
    table.insert(l_9_1, tostring(l_9_6))
    table.insert(l_9_1, " = ")
    table.insert(l_9_1, tostring(l_9_7))
    table.insert(l_9_1, "\n")
    l_9_2 = l_9_2 + 1
  end
  print(table.concat(l_9_1))
  print("printed " .. l_9_2 .. " tags")
end

l_0_0.ConcatAll = function(l_10_0)
  local l_10_1 = {}
  local l_10_2 = 0
  for l_10_6,l_10_7 in pairs(l_10_0.tags) do
     -- DECOMPILER ERROR: Confused at declaration of local variable

    table.insert(l_10_1, "   ")
    table.insert(l_10_1, tostring())
    table.insert(l_10_1, " = ")
    do
       -- DECOMPILER ERROR: Confused at declaration of local variable

      table.insert(l_10_1, tostring())
       -- DECOMPILER ERROR: Confused at declaration of local variable

       -- DECOMPILER ERROR: Confused at declaration of local variable

       -- DECOMPILER ERROR: Confused at declaration of local variable

      table.insert(l_10_1, "\n")
      l_10_2 = l_10_2 + 1
    end
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
   -- DECOMPILER ERROR: Confused about usage of registers!

   -- DECOMPILER ERROR: Confused at declaration of local variable

   -- DECOMPILER ERROR: Confused at declaration of local variable

  print("concatenated " .. l_10_2 .. " tags")
   -- DECOMPILER ERROR: Confused at declaration of local variable

   -- DECOMPILER ERROR: Confused about usage of registers!

   -- DECOMPILER ERROR: Confused at declaration of local variable

  return table.concat(l_10_1)
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.PrintAll2 = function(l_11_0)
  local l_11_1 = 0
  for l_11_5,l_11_6 in ipairs(l_11_0.tags) do
    tempstring = "   " .. tostring(l_11_5) .. " = " .. tostring(l_11_6)
    print(tempstring)
    l_11_1 = l_11_1 + 1
  end
  print("printed " .. l_11_1 .. " tags")
end

l_0_0.Name = "UserTags"
DeclareClass(l_0_0)

