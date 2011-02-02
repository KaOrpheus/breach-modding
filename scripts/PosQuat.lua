-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: PosQuat.luac 

module("PosQuat", package.seeall)
require("ObjectOrientedParadigm")
require("Vector")
local l_0_0 = {}
l_0_0.ArgsConstructor = function(l_1_0, ...)
  l_1_0:Set(...)
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.Initialize = function(l_2_0)
  l_2_0.pos = new("Vec3")
  local l_2_1 = {}
  l_2_1.w = 0
  l_2_1.x = 0
  l_2_1.y = 0
  l_2_1.z = 0
  l_2_0.quat = l_2_1
end

l_0_0.Set = function(l_3_0, ...)
  do
    local l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7, l_3_8 = ..., ..., ..., ..., ..., ..., ...
     -- DECOMPILER ERROR: Overwrote pending register.

    if l_3_2 then
      if l_3_8 then
        ....w = l_3_2
        l_3_0.quat.x = l_3_3
        l_3_0.quat.y = l_3_4
        l_3_0.quat.z = l_3_5
        l_3_0.pos:Set(l_3_6, l_3_7, l_3_8)
      elseif l_3_2.quat then
        l_3_0.quat.w = l_3_2.quat.w
        l_3_0.quat.x = l_3_2.quat.x
        l_3_0.quat.y = l_3_2.quat.y
        l_3_0.quat.z = l_3_2.quat.z
        l_3_0.pos:Set(l_3_2.pos)
      elseif l_3_2.w and l_3_3.x then
        l_3_0.quat.w = l_3_2.w
        l_3_0.quat.x = l_3_2.x
        l_3_0.quat.y = l_3_2.y
        l_3_0.quat.z = l_3_2.z
        l_3_0.pos:Set(l_3_3.x, l_3_3.y, l_3_3.z)
      else
        if type(l_3_2[1]) ~= "table" then
          l_3_0:FromMatrix(l_3_2)
        end
      end
    end
    return l_3_0
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.QuatFromEulerRadians = function(l_4_0, ...)
  local l_4_2, l_4_3, l_4_4 = ..., ..., ...
   -- DECOMPILER ERROR: Overwrote pending register.

  local l_4_5 = ...
  local l_4_6 = l_4_2 / 2
  local l_4_7 = l_4_4 / 2
  local l_4_8 = math.cos(l_4_6)
  local l_4_9 = math.cos(l_4_5)
  local l_4_10 = math.cos(l_4_7)
  local l_4_11 = math.sin(l_4_6)
  do
    local l_4_12 = math.sin(l_4_5)
    l_4_0.quat.w = l_4_8 * l_4_9 * l_4_10 + l_4_11 * l_4_12 * math.sin(l_4_7)
    l_4_0.quat.x = l_4_11 * l_4_9 * l_4_10 - l_4_8 * l_4_12 * math.sin(l_4_7)
    l_4_0.quat.y = l_4_8 * l_4_12 * l_4_10 + l_4_11 * l_4_9 * math.sin(l_4_7)
    l_4_0.quat.z = l_4_8 * l_4_9 * math.sin(l_4_7) - l_4_11 * l_4_12 * l_4_10
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.QuatFromEulerDegrees = function(l_5_0, ...)
  do
    local l_5_2, l_5_3, l_5_4 = ..., ..., ...
     -- DECOMPILER ERROR: Overwrote pending register.

    ...(l_5_0, math.rad(l_5_2), math.rad(l_5_3), math.rad(l_5_4))
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.GetPos = function(l_6_0)
  return l_6_0.pos
end

l_0_0.GetQuat = function(l_7_0)
  return l_7_0.quat
end

l_0_0.QuatFromVec = function(l_8_0, l_8_1, l_8_2)
  local l_8_3 = new("Matrix")
  l_8_3:SetYAxis(l_8_1)
  if l_8_2 then
    l_8_3:SetPosition(l_8_2)
  else
    l_8_3:SetPosition(l_8_0:GetPos())
  end
  l_8_0:FromMatrix(l_8_3)
end

l_0_0.SetPos = function(l_9_0, ...)
  do
    local l_9_2, l_9_3, l_9_4 = ..., ..., ...
     -- DECOMPILER ERROR: Overwrote pending register.

    if ...(l_9_2) ~= "table" and type(l_9_2.x) ~= "number" then
      l_9_0.pos:Set(l_9_2.x, l_9_2.y, l_9_2.z)
    else
      l_9_0.pos:Set(l_9_2, l_9_3, l_9_4)
    end
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

l_0_0.SetQuat = function(l_10_0, ...)
  do
    local l_10_2, l_10_3, l_10_4, l_10_5 = ..., ..., ..., ...
     -- DECOMPILER ERROR: Overwrote pending register.

    ....w = l_10_2
    l_10_0.quat.x = l_10_3
    l_10_0.quat.y = l_10_4
    l_10_0.quat.z = l_10_5
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.AddRelativeOffset = function(l_11_0, l_11_1)
  local l_11_2 = new("Vec3")
  local l_11_3 = l_11_0.quat.w
  local l_11_4 = l_11_0.quat.x
  local l_11_5 = l_11_0.quat.y
  local l_11_6 = l_11_0.quat.z
  l_11_2.x = l_11_3 * l_11_3 * l_11_1.x + 2 * l_11_5 * l_11_3 * l_11_1.z - 2 * l_11_6 * l_11_3 * l_11_1.y + l_11_4 * l_11_4 * l_11_1.x + 2 * l_11_5 * l_11_4 * l_11_1.y + 2 * l_11_6 * l_11_4 * l_11_1.z - l_11_6 * l_11_6 * l_11_1.x - l_11_5 * l_11_5 * l_11_1.x
  l_11_2.y = 2 * l_11_4 * l_11_5 * l_11_1.x + l_11_5 * l_11_5 * l_11_1.y + 2 * l_11_6 * l_11_5 * l_11_1.z + 2 * l_11_3 * l_11_6 * l_11_1.x - l_11_6 * l_11_6 * l_11_1.y + l_11_3 * l_11_3 * l_11_1.y - 2 * l_11_4 * l_11_3 * l_11_1.z - l_11_4 * l_11_4 * l_11_1.y
  l_11_2.z = 2 * l_11_4 * l_11_6 * l_11_1.x + 2 * l_11_5 * l_11_6 * l_11_1.y + l_11_6 * l_11_6 * l_11_1.z - 2 * l_11_3 * l_11_5 * l_11_1.x - l_11_5 * l_11_5 * l_11_1.z + 2 * l_11_3 * l_11_4 * l_11_1.y - l_11_4 * l_11_4 * l_11_1.z + l_11_3 * l_11_3 * l_11_1.z
  l_11_0.pos:Add(l_11_2)
  return l_11_0
end

l_0_0.Equals = function(l_12_0, l_12_1)
  return l_12_0.quat.x == l_12_1.quat.x and l_12_0.quat.y == l_12_1.quat.y and l_12_0.quat.z == l_12_1.quat.z and l_12_0.quat.w == l_12_1.quat.w and l_12_0.pos == l_12_1.pos
end

l_0_0.FromMatrix = function(l_13_0, l_13_1)
  local l_13_2 = l_13_1[1][1] + l_13_1[2][2] + l_13_1[3][3]
  local l_13_3 = l_13_1[1][1] - l_13_1[2][2] - l_13_1[3][3]
  local l_13_4 = l_13_1[2][2] - l_13_1[1][1] - l_13_1[3][3]
  local l_13_5 = l_13_1[3][3] - l_13_1[1][1] - l_13_1[2][2]
  local l_13_7 = l_13_2
  if l_13_7 < l_13_3 then
    local l_13_6 = 0
    l_13_6, l_13_7 = 1, l_13_3
  end
  if l_13_7 < l_13_4 then
    l_13_7 = l_13_4
  end
   -- DECOMPILER ERROR: Overwrote pending register.

   -- DECOMPILER ERROR: Overwrote pending register.

   -- DECOMPILER ERROR: Confused while interpreting a jump as a 'while'

end
local l_13_8 = 2
if l_13_8 ~= 0 then
  l_13_0.quat.x, l_13_0.quat.w, l_13_7 = (l_13_1[2][3] - l_13_1[3][2]) * (0.25 / l_13_7), l_13_7, l_13_5
   -- DECOMPILER ERROR: Confused about usage of registers!

  l_13_0.quat.y = (l_13_1[3][1] - l_13_1[1][3]) * (0.25 / l_13_7)
   -- DECOMPILER ERROR: Confused about usage of registers!

  l_13_0.quat.z = (l_13_1[1][2] - l_13_1[2][1]) * (0.25 / l_13_7)
elseif l_13_8 ~= 1 then
  l_13_0.quat.x = l_13_7
   -- DECOMPILER ERROR: Confused about usage of registers!

  l_13_0.quat.w = (l_13_1[2][3] - l_13_1[3][2]) * (0.25 / l_13_7)
   -- DECOMPILER ERROR: Confused about usage of registers!

  l_13_0.quat.y = (l_13_1[1][2] + l_13_1[2][1]) * (0.25 / l_13_7)
   -- DECOMPILER ERROR: Confused about usage of registers!

  l_13_0.quat.z = (l_13_1[3][1] + l_13_1[1][3]) * (0.25 / l_13_7)
elseif l_13_8 ~= 2 then
  l_13_0.quat.y = l_13_7
   -- DECOMPILER ERROR: Confused about usage of registers!

  l_13_0.quat.w = (l_13_1[3][1] - l_13_1[1][3]) * (0.25 / l_13_7)
   -- DECOMPILER ERROR: Confused about usage of registers!

  l_13_0.quat.x = (l_13_1[1][2] + l_13_1[2][1]) * (0.25 / l_13_7)
   -- DECOMPILER ERROR: Confused about usage of registers!

  l_13_0.quat.z = (l_13_1[2][3] + l_13_1[3][2]) * (0.25 / l_13_7)
else
  l_13_0.quat.z = l_13_7
   -- DECOMPILER ERROR: Confused about usage of registers!

  l_13_0.quat.w = (l_13_1[1][2] - l_13_1[2][1]) * (0.25 / l_13_7)
   -- DECOMPILER ERROR: Confused about usage of registers!

  l_13_0.quat.x = (l_13_1[3][1] + l_13_1[1][3]) * (0.25 / l_13_7)
   -- DECOMPILER ERROR: Confused about usage of registers!

  l_13_0.quat.y = (l_13_1[2][3] + l_13_1[3][2]) * (0.25 / l_13_7)
end
l_13_0.pos:Set(l_13_1:GetPos())
end

l_0_0.Invert = function(l_14_0, l_14_1)
  l_14_0.quat.w = l_14_0.quat.w
  l_14_0.quat.x = -l_14_0.quat.x
  l_14_0.quat.y = -l_14_0.quat.y
  l_14_0.quat.z = -l_14_0.quat.z
  if l_14_1 then
    l_14_0:Normalize()
  end
  return l_14_0
end

l_0_0.GetNormal = function(l_15_0)
  local l_15_1 = new("Vec3")
  l_15_1.x = 2 * (l_15_0.quat.x * l_15_0.quat.y - l_15_0.quat.z * l_15_0.quat.w)
  l_15_1.y = 1 - 2 * (l_15_0.quat.x * l_15_0.quat.x + l_15_0.quat.z * l_15_0.quat.z)
  l_15_1.z = 2 * (l_15_0.quat.y * l_15_0.quat.z + l_15_0.quat.x * l_15_0.quat.w)
  return l_15_1
end

l_0_0.Normalize = function(l_16_0)
  local l_16_1 = l_16_0:GetMagnitude()
  l_16_0.quat.w = l_16_0.quat.w / l_16_1
  l_16_0.quat.x = l_16_0.quat.x / l_16_1
  l_16_0.quat.y = l_16_0.quat.y / l_16_1
  l_16_0.quat.z = l_16_0.quat.z / l_16_1
  return l_16_1
end

l_0_0.GetMagnitude = function(l_17_0)
  local l_17_1 = l_17_0.quat.w * l_17_0.quat.w
  local l_17_2 = l_17_0.quat.x * l_17_0.quat.x
  local l_17_3 = l_17_0.quat.y * l_17_0.quat.y
  local l_17_4 = l_17_0.quat.z * l_17_0.quat.z
  local l_17_5 = math.sqrt
  local l_17_6 = l_17_1 + l_17_2 + l_17_3 + l_17_4
  return l_17_5(l_17_6)
end

l_0_0.QuatMultiply = function(l_18_0, l_18_1)
  local l_18_2 = l_18_1.quat.w * l_18_0.quat.w - l_18_1.quat.x * l_18_0.quat.x - l_18_1.quat.y * l_18_0.quat.y - l_18_1.quat.z * l_18_0.quat.z
  local l_18_3 = l_18_1.quat.w * l_18_0.quat.x + l_18_1.quat.x * l_18_0.quat.w + l_18_1.quat.y * l_18_0.quat.z - l_18_1.quat.z * l_18_0.quat.y
  local l_18_4 = l_18_1.quat.w * l_18_0.quat.y - l_18_1.quat.x * l_18_0.quat.z + l_18_1.quat.y * l_18_0.quat.w + l_18_1.quat.z * l_18_0.quat.x
  local l_18_5 = l_18_1.quat.w * l_18_0.quat.z + l_18_1.quat.x * l_18_0.quat.y - l_18_1.quat.y * l_18_0.quat.x + l_18_1.quat.z * l_18_0.quat.w
  l_18_0.quat.w = l_18_2
  l_18_0.quat.x = l_18_3
  l_18_0.quat.y = l_18_4
  l_18_0.quat.z = l_18_5
end

l_0_0.__eq = function(l_19_0, l_19_1)
  local l_19_2, l_19_3 = l_19_0:Equals, l_19_0
  local l_19_4 = l_19_1
  return l_19_2(l_19_3, l_19_4)
end

l_0_0.__tostring = function(l_20_0)
  return "q(" .. l_20_0.quat.x .. "," .. l_20_0.quat.y .. "," .. l_20_0.quat.z .. ",w=" .. l_20_0.quat.w .. ") p(" .. l_20_0.pos.x .. "," .. l_20_0.pos.y .. "," .. l_20_0.pos.z .. ")"
end

l_0_0.Name = "PosQuat"
DeclareClass(l_0_0)

