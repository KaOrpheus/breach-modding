-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: Vector.luac 

module("Vector", package.seeall)
require("ObjectOrientedParadigm")
local l_0_0 = function(l_1_0)
  if not l_1_0.x then
    return "<uninitialized Vec3>"
  else
    local l_1_1 = string.format
    local l_1_2 = "(%8.2f, %8.2f, %8.2f)"
    local l_1_3 = l_1_0.x
    local l_1_4 = l_1_0.y
    local l_1_5 = l_1_0.z
    return l_1_1(l_1_2, l_1_3, l_1_4, l_1_5)
  end
end

local l_0_1 = {}
l_0_1.Name = "Vec3"
l_0_1.Add = function(l_2_0, l_2_1)
  l_2_0.x = l_2_0.x + l_2_1.x
  l_2_0.y = l_2_0.y + l_2_1.y
  l_2_0.z = l_2_0.z + l_2_1.z
  return l_2_0
end

l_0_1.AddComponent = function(l_3_0, l_3_1, l_3_2, l_3_3)
  l_3_0.x = l_3_0.x + l_3_1
  l_3_0.y = l_3_0.y + l_3_2
  l_3_0.z = l_3_0.z + l_3_3
  return l_3_0
end

l_0_1.ArgsConstructor = function(l_4_0, ...)
  do
    local l_4_2 = ...
     -- DECOMPILER ERROR: Overwrote pending register.

    if l_4_2 then
      l_4_2(..., ...)
      l_4_2 = l_4_0:Set
    end
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

l_0_1.ComponentMul = function(l_5_0, l_5_1)
  l_5_0.x = l_5_0.x * l_5_1.x
  l_5_0.y = l_5_0.y * l_5_1.y
  l_5_0.z = l_5_0.z * l_5_1.z
  return l_5_0
end

l_0_1.ComponentDiv = function(l_6_0, l_6_1)
  l_6_0.x = l_6_0.x / l_6_1.x
  l_6_0.y = l_6_0.y / l_6_1.y
  l_6_0.z = l_6_0.z / l_6_1.z
  return l_6_0
end

l_0_1.Cross = function(l_7_0, l_7_1)
  local l_7_2, l_7_3, l_7_4 = nil, nil, nil
  l_7_2 = l_7_0.y * l_7_1.z - l_7_0.z * l_7_1.y
  l_7_3 = l_7_0.z * l_7_1.x - l_7_0.x * l_7_1.z
  l_7_4 = l_7_0.x * l_7_1.y - l_7_0.y * l_7_1.x
  l_7_0.x = l_7_2
  l_7_0.y = l_7_3
  l_7_0.z = l_7_4
  return l_7_0
end

l_0_1.Distance = function(l_8_0, l_8_1)
  local l_8_2 = l_8_0.x - l_8_1.x
   -- DECOMPILER ERROR: Overwrote pending register.

  local l_8_3 = l_8_2 * l_8_2 + (l_8_2) * (l_8_2) + (l_8_2) * (l_8_2)
  local l_8_4 = math.sqrt
  local l_8_5 = l_8_3
  return l_8_4(l_8_5)
  l_8_2 = l_8_0.y - l_8_1.y
end

l_0_1.DistanceSqr = function(l_9_0, l_9_1)
  local l_9_2 = l_9_0.x - l_9_1.x
   -- DECOMPILER ERROR: Overwrote pending register.

  return l_9_2 * l_9_2 + (l_9_2) * (l_9_2) + (l_9_2) * (l_9_2)
  l_9_2 = l_9_0.y - l_9_1.y
end

l_0_1.DistanceXY = function(l_10_0, l_10_1)
  local l_10_2 = 0
  local l_10_3 = l_10_0.x - l_10_1.x
  l_10_2 = l_10_2 + l_10_3 * l_10_3
  l_10_3 = l_10_0.y - l_10_1.y
  l_10_2 = l_10_2 + (l_10_3) * (l_10_3)
  local l_10_4 = math.sqrt
  local l_10_5 = l_10_2
  return l_10_4(l_10_5)
end

l_0_1.DistanceXYSqr = function(l_11_0, l_11_1)
  local l_11_2 = 0
  local l_11_3 = l_11_0.x - l_11_1.x
  l_11_2 = l_11_2 + l_11_3 * l_11_3
  l_11_3 = l_11_0.y - l_11_1.y
  l_11_2 = l_11_2 + (l_11_3) * (l_11_3)
  return l_11_2
end

l_0_1.Dot = function(l_12_0, l_12_1)
  return l_12_0.x * l_12_1.x + l_12_0.y * l_12_1.y + l_12_0.z * l_12_1.z
end

l_0_1.Elements = function(l_13_0)
  return l_13_0.x, l_13_0.y, l_13_0.z
end

l_0_1.Equals = function(l_14_0, l_14_1)
  return rawequal(l_14_0, l_14_1) or (l_14_0.x == l_14_1.x and l_14_0.y == l_14_1.y and l_14_0.z == l_14_1.z)
end

l_0_1.Initialize = function(l_15_0)
  l_15_0.x = 0
  l_15_0.y = 0
  l_15_0.z = 0
end

l_0_1.IsFar = function(l_16_0, l_16_1, l_16_2)
  return l_16_2 * l_16_2 <= l_16_0:DistanceSqr(l_16_1)
end

l_0_1.IsFarXY = function(l_17_0, l_17_1, l_17_2)
  return l_17_2 * l_17_2 <= l_17_0:DistanceXYSqr(l_17_1)
end

l_0_1.IsNear = function(l_18_0, l_18_1, l_18_2)
  return l_18_0:DistanceSqr(l_18_1) <= l_18_2 * l_18_2
end

l_0_1.IsNearXY = function(l_19_0, l_19_1, l_19_2)
  return l_19_0:DistanceXYSqr(l_19_1) <= l_19_2 * l_19_2
end

l_0_1.IsValid = function(l_20_0)
  if math.isvalid(l_20_0.x) and math.isvalid(l_20_0.y) then
    return math.isvalid(l_20_0.z)
  end
end

l_0_1.Length = function(l_21_0)
  local l_21_1 = math.sqrt
  do
    local l_21_4 = l_21_0.x * l_21_0.x + l_21_0.y * l_21_0.y
    local l_21_3 = l_21_0.z * l_21_0.z
    l_21_4 = l_21_4 + l_21_3
     -- DECOMPILER ERROR: Confused at declaration of local variable

    return l_21_1(l_21_4)
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_1.LengthSqr = function(l_22_0)
  return l_22_0.x * l_22_0.x + l_22_0.y * l_22_0.y + l_22_0.z * l_22_0.z
end

l_0_1.LengthXY = function(l_23_0)
  local l_23_1 = math.sqrt
  do
    local l_23_4 = l_23_0.x * l_23_0.x
    local l_23_3 = l_23_0.y * l_23_0.y
    l_23_4 = l_23_4 + l_23_3
     -- DECOMPILER ERROR: Confused at declaration of local variable

    return l_23_1(l_23_4)
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_1.LengthXYSqr = function(l_24_0)
  return l_24_0.x * l_24_0.x + l_24_0.y * l_24_0.y
end

l_0_1.Negate = function(l_25_0)
  l_25_0.x = -l_25_0.x
  l_25_0.y = -l_25_0.y
  l_25_0.z = -l_25_0.z
  return l_25_0
end

l_0_1.Normalize = function(l_26_0)
  local l_26_1 = math.sqrt(l_26_0.x * l_26_0.x + l_26_0.y * l_26_0.y + l_26_0.z * l_26_0.z)
  l_26_0.x = l_26_0.x / l_26_1
  l_26_0.y = l_26_0.y / l_26_1
  l_26_0.z = l_26_0.z / l_26_1
  return l_26_1
end

l_0_1.Rotate = function(l_27_0, l_27_1)
  l_27_0:Set(l_27_0.x * l_27_1[1][1] + l_27_0.y * l_27_1[2][1] + l_27_0.z * l_27_1[3][1], l_27_0.x * l_27_1[1][2] + l_27_0.y * l_27_1[2][2] + l_27_0.z * l_27_1[3][2], l_27_0.x * l_27_1[1][3] + l_27_0.y * l_27_1[2][3] + l_27_0.z * l_27_1[3][3])
  return l_27_0
end

l_0_1.Scale = function(l_28_0, l_28_1)
  l_28_0.x = l_28_0.x * l_28_1
  l_28_0.y = l_28_0.y * l_28_1
  l_28_0.z = l_28_0.z * l_28_1
  return l_28_0
end

l_0_1.SetNoAssert = function(l_29_0, ...)
  do
    local l_29_2, l_29_3, l_29_4 = ..., ..., ...
    if l_29_3 then
      do return end
    end
     -- DECOMPILER ERROR: Overwrote pending register.

    if l_29_2 then
      l_29_0.x, l_29_0.z, l_29_0.y, l_29_0.x = ..., l_29_4, l_29_3, l_29_2
      l_29_0.y = l_29_2.y
      l_29_0.z = l_29_2.z
    end
    return l_29_0
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_1.SetWithAssert = function(l_30_0, ...)
  do
    local l_30_2, l_30_3, l_30_4 = ..., ..., ...
     -- DECOMPILER ERROR: Overwrote pending register.

    if l_30_3 then
      local l_30_5 = ...
      l_30_5(not l_30_3 or not l_30_3 or l_30_4, "bad data in Vec3")
      l_30_0.x = l_30_2
      l_30_0.y = l_30_3
      l_30_0.z = l_30_4
    elseif l_30_2 then
      if l_30_2.x and l_30_2.y then
        assert(l_30_2.z, "bad data in Vec3")
      end
      l_30_0.x = l_30_2.x
      l_30_0.y = l_30_2.y
      l_30_0.z = l_30_2.z
    else
      error("bad data in Vec3")
    end
    return l_30_0
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if DGApp.IsDebug() then
  print("Vec3.Set == set with assert!")
  l_0_1.Set = l_0_1.SetWithAssert
else
  print("Vec3.Set == set with NO assert!")
  l_0_1.Set = l_0_1.SetNoAssert
end
l_0_1.Subtract = function(l_31_0, l_31_1)
  l_31_0.x = l_31_0.x - l_31_1.x
  l_31_0.y = l_31_0.y - l_31_1.y
  l_31_0.z = l_31_0.z - l_31_1.z
  return l_31_0
end

l_0_1.Transform = function(l_32_0, l_32_1)
  l_32_0:Set(l_32_0.x * l_32_1[1][1] + l_32_0.y * l_32_1[2][1] + l_32_0.z * l_32_1[3][1] + l_32_1[4][1], l_32_0.x * l_32_1[1][2] + l_32_0.y * l_32_1[2][2] + l_32_0.z * l_32_1[3][2] + l_32_1[4][2], l_32_0.x * l_32_1[1][3] + l_32_0.y * l_32_1[2][3] + l_32_0.z * l_32_1[3][3] + l_32_1[4][3])
  return l_32_0
end

l_0_1.WithinBounds = function(l_33_0, l_33_1, l_33_2)
  return l_33_1.x <= l_33_0.x and l_33_0.x <= l_33_2.x and l_33_1.y <= l_33_0.y and l_33_0.y <= l_33_2.y and l_33_1.z <= l_33_0.z and l_33_0.z <= l_33_2.z
end

l_0_1.Distance = function(l_34_0, l_34_1)
  local l_34_2 = math.sqrt
  do
    local l_34_6 = (l_34_0.x - l_34_1.x) * (l_34_0.x - l_34_1.x) + (l_34_0.y - l_34_1.y) * (l_34_0.y - l_34_1.y)
    local l_34_5 = l_34_0.z - l_34_1.z
    l_34_5 = l_34_5 * (l_34_0.z - l_34_1.z)
     -- DECOMPILER ERROR: Confused at declaration of local variable

    l_34_6 = l_34_6 + l_34_5
     -- DECOMPILER ERROR: Confused at declaration of local variable

    return l_34_2(l_34_6)
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_1.DistanceSqr = function(l_35_0, l_35_1)
  return (l_35_0.x - l_35_1.x) * (l_35_0.x - l_35_1.x) + (l_35_0.y - l_35_1.y) * (l_35_0.y - l_35_1.y) + (l_35_0.z - l_35_1.z) * (l_35_0.z - l_35_1.z)
end

l_0_1.ToString = l_0_0
l_0_1.__add = function(l_36_0, l_36_1)
  local l_36_2 = new
  local l_36_3 = "Vec3"
  local l_36_4 = l_36_0.x + l_36_1.x
  local l_36_5 = l_36_0.y + l_36_1.y
  do
    local l_36_7 = l_36_0.z
    l_36_7 = l_36_7 + l_36_1.z
     -- DECOMPILER ERROR: Confused at declaration of local variable

    return l_36_2(l_36_3, l_36_4, l_36_5, l_36_7)
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_1.__concat = ObjectOrientedParadigm.toStringConcat
l_0_1.__div = function(l_37_0, l_37_1)
  local l_37_2 = new
  local l_37_3 = "Vec3"
  local l_37_4 = l_37_0.x / l_37_1
  local l_37_5 = l_37_0.y / l_37_1
  local l_37_6 = l_37_0.z / l_37_1
  return l_37_2(l_37_3, l_37_4, l_37_5, l_37_6)
end

l_0_1.__mul = function(l_38_0, l_38_1)
  local l_38_2 = new
  local l_38_3 = "Vec3"
  local l_38_4 = l_38_0.x * l_38_1
  local l_38_5 = l_38_0.y * l_38_1
  local l_38_6 = l_38_0.z * l_38_1
  return l_38_2(l_38_3, l_38_4, l_38_5, l_38_6)
end

l_0_1.__sub = function(l_39_0, l_39_1)
  local l_39_2 = new
  local l_39_3 = "Vec3"
  local l_39_4 = l_39_0.x - l_39_1.x
  local l_39_5 = l_39_0.y - l_39_1.y
  do
    local l_39_7 = l_39_0.z
    l_39_7 = l_39_7 - l_39_1.z
     -- DECOMPILER ERROR: Confused at declaration of local variable

    return l_39_2(l_39_3, l_39_4, l_39_5, l_39_7)
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_1.__tostring = l_0_0
l_0_1.__unm = function(l_40_0)
  local l_40_1 = new
  local l_40_2 = "Vec3"
  local l_40_3 = -l_40_0.x
  local l_40_4 = -l_40_0.y
  local l_40_5 = -l_40_0.z
  return l_40_1(l_40_2, l_40_3, l_40_4, l_40_5)
end

l_0_1.__eq = function(l_41_0, l_41_1)
  return rawequal(l_41_0, l_41_1) or (l_41_0.x == l_41_1.x and l_41_0.y == l_41_1.y and l_41_0.z == l_41_1.z)
end

DeclareClass(l_0_1)
v3Scratch = new("Vec3")
_G.v3 = new("Vec3")
local l_0_2 = function(l_42_0)
  return "(" .. l_42_0.x .. ", " .. l_42_0.y .. ")"
end

local l_0_3 = {}
l_0_3.Name = "Vec2"
l_0_3.Add = function(l_43_0, l_43_1)
  l_43_0.x = l_43_0.x + l_43_1.x
  l_43_0.y = l_43_0.y + l_43_1.y
  return l_43_0
end

l_0_3.ArgsConstructor = function(l_44_0, ...)
  do
    local l_44_2, l_44_3 = ..., ...
    if not l_44_2 or not l_44_2 then
      l_44_0.x = l_44_0.x
    end
    if not l_44_3 or not l_44_3 then
      l_44_0.y = l_44_0.y
    end
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

l_0_3.Distance = function(l_45_0, l_45_1)
  v2Scratch:Set(l_45_0)
  local l_45_4 = v2Scratch:Subtract
  l_45_4(v2Scratch, l_45_1)
  l_45_4 = v2Scratch
  local l_45_2, l_45_3 = l_45_4
  return l_45_4(l_45_2)
  l_45_4 = l_45_4:Length
end

l_0_3.DistanceSqr = function(l_46_0, l_46_1)
  v2Scratch:Set(l_46_0)
  local l_46_4 = v2Scratch:Subtract
  l_46_4(v2Scratch, l_46_1)
  l_46_4 = v2Scratch
  local l_46_2, l_46_3 = l_46_4
  return l_46_4(l_46_2)
  l_46_4 = l_46_4:LengthSqr
end

l_0_3.Dot = function(l_47_0, l_47_1)
  return l_47_0.x * l_47_1.x + l_47_0.y * l_47_1.y
end

l_0_1.Elements = function(l_48_0)
  return l_48_0.x, l_48_0.y
end

l_0_3.Equals = function(l_49_0, l_49_1)
  return l_49_0.x == l_49_1.x and l_49_0.y == l_49_1.y
end

l_0_3.Initialize = function(l_50_0)
  l_50_0.x = 0
  l_50_0.y = 0
end

l_0_3.IsValid = function(l_51_0)
  if math.isvalid(l_51_0.x) then
    return math.isvalid(l_51_0.y)
  end
end

l_0_3.Length = function(l_52_0)
  local l_52_1 = math.sqrt
  do
    local l_52_4 = l_52_0.x * l_52_0.x
    local l_52_3 = l_52_0.y * l_52_0.y
    l_52_4 = l_52_4 + l_52_3
     -- DECOMPILER ERROR: Confused at declaration of local variable

    return l_52_1(l_52_4)
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_3.LengthSqr = function(l_53_0)
  return l_53_0.x * l_53_0.x + l_53_0.y * l_53_0.y
end

l_0_3.Negate = function(l_54_0)
  l_54_0.x = -l_54_0.x
  l_54_0.y = -l_54_0.y
  return l_54_0
end

l_0_3.Normalize = function(l_55_0)
  local l_55_1 = l_55_0:Length()
  l_55_0.x = l_55_0.x / l_55_1
  l_55_0.y = l_55_0.y / l_55_1
  return l_55_1
end

l_0_3.Scale = function(l_56_0, l_56_1)
  l_56_0.x = l_56_0.x * l_56_1
  l_56_0.y = l_56_0.y * l_56_1
  return l_56_0
end

l_0_3.Set = function(l_57_0, ...)
  do
    local l_57_2, l_57_3 = ..., ...
    if l_57_3 then
      do return end
    end
     -- DECOMPILER ERROR: Overwrote pending register.

    if l_57_2 then
      l_57_0.x, l_57_0.y, l_57_0.x = ..., l_57_3, l_57_2
      l_57_0.y = l_57_2.y
    end
    return l_57_0
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_3.Subtract = function(l_58_0, l_58_1)
  l_58_0.x = l_58_0.x - l_58_1.x
  l_58_0.y = l_58_0.y - l_58_1.y
  return l_58_0
end

l_0_3.ToString = l_0_2
l_0_3.__add = function(l_59_0, l_59_1)
  local l_59_2 = new
  local l_59_3 = "Vec2"
  local l_59_4 = l_59_0.x + l_59_1.x
  do
    local l_59_6 = l_59_0.y
    l_59_6 = l_59_6 + l_59_1.y
     -- DECOMPILER ERROR: Confused at declaration of local variable

    return l_59_2(l_59_3, l_59_4, l_59_6)
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_3.__concat = ObjectOrientedParadigm.toStringConcat
l_0_3.__div = function(l_60_0, l_60_1)
  local l_60_2 = new
  local l_60_3 = "Vec2"
  local l_60_4 = l_60_0.x / l_60_1
  local l_60_5 = l_60_0.y / l_60_1
  return l_60_2(l_60_3, l_60_4, l_60_5)
end

l_0_3.__mul = function(l_61_0, l_61_1)
  local l_61_2 = new
  local l_61_3 = "Vec2"
  local l_61_4 = l_61_0.x * l_61_1
  local l_61_5 = l_61_0.y * l_61_1
  return l_61_2(l_61_3, l_61_4, l_61_5)
end

l_0_3.__sub = function(l_62_0, l_62_1)
  local l_62_2 = new
  local l_62_3 = "Vec2"
  local l_62_4 = l_62_0.x - l_62_1.x
  do
    local l_62_6 = l_62_0.y
    l_62_6 = l_62_6 - l_62_1.y
     -- DECOMPILER ERROR: Confused at declaration of local variable

    return l_62_2(l_62_3, l_62_4, l_62_6)
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_3.__tostring = l_0_2
l_0_3.__eq = function(l_63_0, l_63_1)
  return rawequal(l_63_0, l_63_1) or (l_63_0.x == l_63_1.x and l_63_0.y == l_63_1.y)
end

DeclareClass(l_0_3)
v2Scratch = new("Vec2")
_G.origin = new("Vec3", 0, 0, 0)
local l_0_4 = _G
local l_0_5 = {}
l_0_5.posZ = new("Vec3", 0, 0, 1)
l_0_5.negZ = new("Vec3", 0, 0, -1)
l_0_5.posX = new("Vec3", 1, 0, 0)
l_0_5.negX = new("Vec3", -1, 0, 0)
l_0_5.posY = new("Vec3", 0, 1, 0)
l_0_5.negY = new("Vec3", 0, -1, 0)
l_0_4.WorldAxes = l_0_5

