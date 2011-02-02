-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: Math.luac 

module("Math", package.seeall)
require("Vector")
require("Matrix")
require("ObjectPool")
math._v1 = new("Vec3")
math._v2 = new("Vec3")
math._v3 = new("Vec3")
math._v4 = new("Vec3")
math._ve3d = new("Vec3")
math._vf3d = new("Vec3")
math._vg3d = new("Vec3")
math._vA2D = new("Vec2")
math._vB2D = new("Vec2")
math._vC2D = new("Vec2")
math._vD2D = new("Vec2")
math._vE2D = new("Vec2")
math._vF2D = new("Vec2")
math._vG2D = new("Vec2")
math._vH2D = new("Vec2")
math._vI2D = new("Vec2")
math._vJ2D = new("Vec2")
math._vK2D = new("Vec2")
math._vL2D = new("Vec2")
math._transform1 = new("Matrix")
math.maxnumber = 3.4028234663853e+038
math.minnumber = 1.1754943508223e-038
math.isfinite = function(l_1_0)
  do
     -- DECOMPILER ERROR: Confused at declaration of local variable

    return not l_1_0 or (l_1_0 < math.huge and -math.huge < l_1_0)
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

math.isdefined = function(l_2_0)
  do
     -- DECOMPILER ERROR: Confused at declaration of local variable

    return not l_2_0 or l_2_0 == l_2_0
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

math.isvalid = function(l_3_0)
  do
     -- DECOMPILER ERROR: Confused at declaration of local variable

    return not l_3_0 or (l_3_0 == l_3_0 and l_3_0 < math.huge and -math.huge < l_3_0)
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

math.clamp = function(l_4_0, l_4_1, l_4_2)
  if l_4_2 < l_4_0 then
    return l_4_2
  elseif l_4_0 < l_4_1 then
    return l_4_1
  else
    return l_4_0
  end
end

math.FindNearestObject = function(l_5_0, l_5_1, l_5_2, l_5_3)
  local l_5_4 = math.huge
  local l_5_5 = nil
  local l_5_6 = math._v1
  local l_5_7 = nil
  for l_5_11,l_5_12 in pairs(l_5_0) do
    local l_5_13, l_5_14, l_5_15 = l_5_1(l_5_12)
    if l_5_13 then
      l_5_6:Set(l_5_13, l_5_14, l_5_15)
      l_5_7 = l_5_6:DistanceSqr(l_5_2)
      if l_5_7 < l_5_4 and (not l_5_3 or not l_5_3(l_5_12)) then
        l_5_4 = l_5_7
        l_5_5 = l_5_12
      end
    end
  end
  return l_5_5
end

_G.TO_RADIANS = math.pi / 180
_G.TO_DEGREES = 180 / math.pi
math.degreesToRadians = function(l_6_0)
  return l_6_0 * _G.TO_RADIANS
end

math.radiansToDegress = function(l_7_0)
  return l_7_0 * _G.TO_DEGREES
end

math.CollectObjectsInRange = function(l_8_0, l_8_1, l_8_2, l_8_3, l_8_4)
  local l_8_5 = {}
  local l_8_6 = l_8_3 * l_8_3
  local l_8_7 = l_8_4 * l_8_4
  local l_8_8 = math._v1
  local l_8_9 = nil
  for l_8_13,l_8_14 in pairs(l_8_0) do
    local l_8_15, l_8_16, l_8_17 = l_8_1(l_8_14)
    if l_8_15 then
      l_8_8:Set(l_8_15, l_8_16, l_8_17)
      l_8_9 = l_8_8:DistanceSqr(l_8_2)
      if l_8_6 <= l_8_9 and l_8_9 <= l_8_7 then
        table.insert(l_8_5, l_8_14)
      end
    end
  end
  return l_8_5
end

math.CollectObjectsInRangeAndHalfplane = function(l_9_0, l_9_1, l_9_2, l_9_3, l_9_4, l_9_5)
  local l_9_6 = {}
  local l_9_7 = l_9_3 * l_9_3
  local l_9_8 = l_9_4 * l_9_4
  local l_9_9 = ObjectPool.Get("Vec3")
  local l_9_10 = 0
  local l_9_11 = nil
  for l_9_15,l_9_16 in pairs(l_9_0) do
    l_9_11 = l_9_1(l_9_16)
    l_9_10 = l_9_11:DistanceSqr(l_9_2)
    if l_9_7 <= l_9_10 and l_9_10 <= l_9_8 then
      l_9_9:Set(l_9_11)
      l_9_9:Subtract(l_9_2)
      if l_9_9:Dot(l_9_5) > 0 then
        table.insert(l_9_6, l_9_16)
      end
    end
  end
  ObjectPool.Recycle(l_9_9)
  return l_9_6
end

math.FindNearestPointOnLine = function(l_10_0, l_10_1, l_10_2)
  local l_10_3 = ObjectPool.Get("Vec3")
  l_10_3:Set(l_10_2)
  l_10_3:Subtract(l_10_0)
  local l_10_4 = ObjectPool.Get("Vec3")
  l_10_4:Set(l_10_1)
  l_10_4:Subtract(l_10_0)
  l_10_4:Normalize()
  local l_10_5 = l_10_4:Dot(l_10_3)
  local l_10_6 = new("Vec3", l_10_4)
  l_10_6:Scale(l_10_5)
  l_10_6:Add(l_10_0)
  ObjectPool.Recycle(l_10_3)
  ObjectPool.Recycle(l_10_4)
  return l_10_6, l_10_5
end

math.FindNearestPointOnSegment = function(l_11_0, l_11_1, l_11_2, l_11_3)
  local l_11_4 = math._v1
  local l_11_5 = math._v2
  local l_11_6 = math._v3
  local l_11_7 = math._v4
  l_11_4:Set(l_11_2.x - l_11_0.x, l_11_2.y - l_11_0.y, l_11_2.z - l_11_0.z)
  l_11_5:Set(l_11_1.x - l_11_0.x, l_11_1.y - l_11_0.y, l_11_1.z - l_11_0.z)
  if l_11_5:Dot(l_11_4) <= 0 then
    l_11_3:Set(l_11_0)
    return "a"
  else
    l_11_6:Set(-l_11_5.x, -l_11_5.y, -l_11_5.z)
    l_11_7:Set(l_11_2.x - l_11_1.x, l_11_2.y - l_11_1.y, l_11_2.z - l_11_1.z)
    if l_11_6:Dot(l_11_7) <= 0 then
      l_11_3:Set(l_11_1)
      return "b"
    else
      l_11_5:Normalize()
      local l_11_8 = l_11_5:Dot(l_11_4)
      l_11_3:Set(l_11_5.x, l_11_5.y, l_11_5.z)
      l_11_3:Scale(l_11_8)
      l_11_3.x = l_11_3.x + l_11_0.x
      l_11_3.y = l_11_3.y + l_11_0.y
      l_11_3.z = l_11_3.z + l_11_0.z
      return "c"
    end
  end
end

math.FindNearestPointOnSegment_NormDir = function(l_12_0, l_12_1, l_12_2, l_12_3, l_12_4)
  local l_12_5 = math._v1
  local l_12_6 = l_12_4
  local l_12_7 = math._v3
  local l_12_8 = math._v4
  l_12_5:Set(l_12_2.x - l_12_0.x, l_12_2.y - l_12_0.y, l_12_2.z - l_12_0.z)
  if l_12_6:Dot(l_12_5) <= 0 then
    l_12_3:Set(l_12_0)
    return "a"
  else
    l_12_7:Set(-l_12_6.x, -l_12_6.y, -l_12_6.z)
    l_12_8:Set(l_12_2.x - l_12_1.x, l_12_2.y - l_12_1.y, l_12_2.z - l_12_1.z)
    if l_12_7:Dot(l_12_8) <= 0 then
      l_12_3:Set(l_12_1)
      return "b"
    else
      l_12_3:Set(l_12_6.x, l_12_6.y, l_12_6.z)
      local l_12_9 = l_12_6:Dot(l_12_5)
      l_12_3:Scale(l_12_9)
      l_12_3.x = l_12_3.x + l_12_0.x
      l_12_3.y = l_12_3.y + l_12_0.y
      l_12_3.z = l_12_3.z + l_12_0.z
      return "c", l_12_9
    end
  end
end

math.FindNearestObjectToRay = function(l_13_0, l_13_1, l_13_2, l_13_3)
  local l_13_4 = math.huge
  local l_13_5 = nil
  local l_13_6 = ObjectPool.Get("Vec3")
  local l_13_7 = ObjectPool.Get("Vec3")
  local l_13_8 = 0
  local l_13_9 = 0
  for l_13_13,l_13_14 in pairs(l_13_0) do
    local l_13_15 = l_13_1(l_13_14)
    l_13_7:Set(l_13_15)
    l_13_7:Subtract(l_13_2)
    l_13_8 = l_13_3:Dot(l_13_7)
    if l_13_8 > 0 then
      l_13_6:Set(l_13_2)
      l_13_6:Add(l_13_3)
      local l_13_16 = math.FindNearestPointOnLine(l_13_2, l_13_6, l_13_15)
      l_13_9 = l_13_16:DistanceSqr(l_13_15)
      if l_13_9 < l_13_4 then
        l_13_4 = l_13_9
        l_13_5 = l_13_14
      end
    end
  end
  ObjectPool.Recycle(l_13_6)
  ObjectPool.Recycle(l_13_7)
  return l_13_5, l_13_4
end

math.SegmentsIntersect2D = function(l_14_0, l_14_1, l_14_2, l_14_3, l_14_4, l_14_5, l_14_6)
  local l_14_7 = l_14_1.x * l_14_4.y - l_14_1.y * l_14_4.x
  if l_14_7 < 0 and l_14_7 > 0 then
    return false
  end
  math._vA2D:Set(l_14_0.x - l_14_3.x, l_14_0.y - l_14_3.y)
  local l_14_8 = (math._vA2D.y * l_14_4.x - math._vA2D.x * l_14_4.y) / (l_14_2 * l_14_7)
  if l_14_8 < 0 or l_14_8 > 1 then
    return false
  end
  local l_14_9 = (math._vA2D.y * l_14_1.x - math._vA2D.x * l_14_1.y) / (l_14_5 * l_14_7)
  if l_14_9 < 0 or l_14_9 > 1 then
    return false
  end
  local l_14_10 = l_14_5 * l_14_9
  l_14_6:Set(l_14_4.x, l_14_4.y, 0)
  l_14_6:Scale(l_14_10)
  l_14_6:Add(l_14_3)
  return true
end

math.IntersectLinesXY = function(l_15_0, l_15_1, l_15_2, l_15_3)
  local l_15_4 = l_15_1.y - l_15_0.y
  local l_15_5 = l_15_0.x - l_15_1.x
  local l_15_6 = l_15_1.x * l_15_0.y - l_15_0.x * l_15_1.y
  local l_15_7 = l_15_3.y - l_15_2.y
  local l_15_8 = l_15_2.x - l_15_3.x
  local l_15_9 = l_15_3.x * l_15_2.y - l_15_2.x * l_15_3.y
  local l_15_10 = l_15_4 * l_15_8 - l_15_7 * l_15_5
  if l_15_10 ~= 0 then
    local l_15_11 = (l_15_5 * l_15_9 - l_15_8 * l_15_6) / l_15_10
    local l_15_12 = (l_15_7 * l_15_6 - l_15_4 * l_15_9) / l_15_10
    local l_15_13 = new
    local l_15_14 = "Vec3"
    local l_15_15 = l_15_11
    local l_15_16 = l_15_12
    local l_15_17 = 0
    return l_15_13(l_15_14, l_15_15, l_15_16, l_15_17)
  end
end

math.Vec3Rotate = function(l_16_0, l_16_1)
  local l_16_2 = l_16_0.x * l_16_1[1][1] + l_16_0.y * l_16_1[2][1] + l_16_0.z * l_16_1[3][1]
  local l_16_3 = l_16_0.x * l_16_1[1][2] + l_16_0.y * l_16_1[2][2] + l_16_0.z * l_16_1[3][2]
  l_16_0.z, l_16_0.y, l_16_0.x = l_16_0.x * l_16_1[1][3] + l_16_0.y * l_16_1[2][3] + l_16_0.z * l_16_1[3][3], l_16_3, l_16_2
end

math.Vec3Transform = function(l_17_0, l_17_1)
  local l_17_2 = l_17_0.x * l_17_1[1][1] + l_17_0.y * l_17_1[2][1] + l_17_0.z * l_17_1[3][1] + l_17_1[4][1]
  local l_17_3 = l_17_0.x * l_17_1[1][2] + l_17_0.y * l_17_1[2][2] + l_17_0.z * l_17_1[3][2] + l_17_1[4][2]
  l_17_0.z, l_17_0.y, l_17_0.x = l_17_0.x * l_17_1[1][3] + l_17_0.y * l_17_1[2][3] + l_17_0.z * l_17_1[3][3] + l_17_1[4][3], l_17_3, l_17_2
end

math.ClosestPointsOnSegmentsSquare = function(l_18_0, l_18_1, l_18_2, l_18_3)
  local l_18_4 = ObjectPool.Get("Vec3"):Set(l_18_1)
  local l_18_5 = ObjectPool.Get("Vec3"):Set(l_18_3)
  local l_18_6 = ObjectPool.Get("Vec3"):Set(l_18_0)
  l_18_6:Subtract(l_18_2)
  local l_18_7 = l_18_4:Dot(l_18_4)
  local l_18_8 = l_18_4:Dot(l_18_5)
  local l_18_9 = l_18_5:Dot(l_18_5)
  local l_18_10 = l_18_4:Dot(l_18_6)
  local l_18_11 = l_18_5:Dot(l_18_6)
  local l_18_12 = l_18_7 * l_18_9 - l_18_8 * l_18_8
  local l_18_13 = l_18_12
  local l_18_14 = l_18_12
  local l_18_15 = 0
  local l_18_16 = 0
  local l_18_17 = 0
  local l_18_18 = 0
  if l_18_12 < 9.9999997473788e-005 then
    l_18_13 = 1
    l_18_18 = l_18_11
    l_18_14 = l_18_9
  else
    l_18_17 = l_18_8 * l_18_11 - l_18_9 * l_18_10
    l_18_18 = l_18_7 * l_18_11 - l_18_8 * l_18_10
    if l_18_17 < 0 then
      l_18_17 = 0
      l_18_18 = l_18_11
      l_18_14 = l_18_9
    elseif l_18_13 < l_18_17 then
      l_18_17 = l_18_13
      l_18_18 = l_18_11 + l_18_8
      l_18_14 = l_18_9
    end
  end
  if l_18_18 < 0 then
    l_18_18 = 0
    if l_18_10 >= 0 then
      l_18_17 = 0
    elseif l_18_7 < l_18_8 - l_18_10 then
      l_18_17 = l_18_13
    else
      l_18_17 = l_18_8 - l_18_10
      l_18_13 = l_18_7
    end
    if abs(l_18_17) < 9.9999997473788e-005 then
      l_18_15 = 0
    else
      l_18_15 = (l_18_17) / l_18_13
    end
    if abs(l_18_18) < 9.9999997473788e-005 then
      l_18_16 = 0
    else
      l_18_16 = l_18_18 / l_18_14
    end
    local l_18_19 = ObjectPool.Get("Vec3"):Set(l_18_6)
    l_18_4:Scale(l_18_15)
    l_18_19:Add(l_18_4)
    l_18_5:Scale(l_18_16)
    l_18_19:Subtract(l_18_5)
    do
      local l_18_20 = LengthSqr(l_18_19)
      ObjectPool.Recycle(l_18_4)
      ObjectPool.Recycle(l_18_5)
      ObjectPool.Recycle(l_18_6)
      ObjectPool.Recycle(l_18_19)
      return l_18_20
    end
     -- Warning: missing end command somewhere! Added here
  end
end

math.Vec3TransformPQ = function(l_19_0, l_19_1)
  math.Vec3RotatePQ(l_19_0, l_19_1)
  l_19_0:Add(l_19_1.pos)
end

math.Vec3RotatePQ = function(l_20_0, l_20_1)
  qi = ObjectPool.Get("PosQuat")
  qi:Set(l_20_1)
  qi:Invert()
  result = ObjectPool.Get("PosQuat")
  result.quat.w = -l_20_0.x * qi.quat.x - l_20_0.y * qi.quat.y - l_20_0.z * qi.quat.z
  result.quat.x = l_20_0.x * qi.quat.w + l_20_0.y * qi.quat.z - l_20_0.z * qi.quat.y
  result.quat.y = -l_20_0.x * qi.quat.z + l_20_0.y * qi.quat.w + l_20_0.z * qi.quat.x
  result.quat.z = l_20_0.x * qi.quat.y - l_20_0.y * qi.quat.x + l_20_0.z * qi.quat.w
  result:QuatMultiply(l_20_1)
  l_20_0.x = result.quat.x
  l_20_0.y = result.quat.y
  l_20_0.z = result.quat.z
  ObjectPool.Recycle(qi)
  ObjectPool.Recycle(result)
end

math.Vec3TransformCoord = function(l_21_0, l_21_1)
  local l_21_2, l_21_3, l_21_4, l_21_5 = nil, nil, nil, nil
  l_21_2 = l_21_0.x * l_21_1[1][1] + l_21_0.y * l_21_1[2][1] + l_21_0.z * l_21_1[3][1] + l_21_1[4][1]
  l_21_3 = l_21_0.x * l_21_1[1][2] + l_21_0.y * l_21_1[2][2] + l_21_0.z * l_21_1[3][2] + l_21_1[4][2]
  l_21_4 = l_21_0.x * l_21_1[1][3] + l_21_0.y * l_21_1[2][3] + l_21_0.z * l_21_1[3][3] + l_21_1[4][3]
  l_21_5 = l_21_0.x * l_21_1[1][4] + l_21_0.y * l_21_1[2][4] + l_21_0.z * l_21_1[3][4] + l_21_1[4][4]
  if l_21_5 ~= 1 then
    l_21_0.x = (l_21_2) / (l_21_5)
    l_21_0.y = (l_21_3) / (l_21_5)
    l_21_0.z = (l_21_4) / (l_21_5)
  else
    l_21_0.x = l_21_2
    l_21_0.y = l_21_3
    l_21_0.z = l_21_4
  end
end

math.randfloat = function(l_22_0, l_22_1)
  if l_22_1 then
    return l_22_0 + math.random() * (l_22_1 - l_22_0)
  else
    return math.random() * l_22_0
  end
end

math.rolldice = function(l_23_0, l_23_1)
  local l_23_2 = 0
  for l_23_6 = 1, l_23_0 do
    l_23_2 = l_23_2 + math.random(l_23_1)
  end
  return l_23_2
end

math.GetDirPerpVectorsNormalized = function(l_24_0, l_24_1, l_24_2)
  if l_24_0:Equals(WorldAxes.posZ) then
    if l_24_1 then
      l_24_1:Set(WorldAxes.posX)
    end
    if l_24_2 then
      l_24_2:Set(WorldAxes.posY)
    elseif l_24_1 then
      l_24_1:Set(l_24_0)
      l_24_1:Cross(WorldAxes.posZ)
      l_24_1:Normalize()
      if l_24_2 then
        l_24_2:Set(l_24_0)
        l_24_2:Cross(l_24_1)
        l_24_2:Normalize()
      end
    end
  end
end


