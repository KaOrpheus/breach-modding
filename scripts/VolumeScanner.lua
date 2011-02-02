-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: VolumeScanner.luac 

module("VolumeScanner", package.seeall)
require("Vector")
dzBottom = 12
dzMiddle = 36
zTop = 48
halfWidth = 12
_v1 = new("Vec3")
local l_0_0 = {}
l_0_0.CapsuleIsClear = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
  local l_1_5 = DEPhysics.CapsuleIsClear
  local l_1_6 = l_1_1
  local l_1_7 = l_1_2
  local l_1_8 = l_1_3
  do
     -- DECOMPILER ERROR: Confused at declaration of local variable

    if not l_1_4 then
      l_1_5 = l_1_5(l_1_6, l_1_7, l_1_8, l_1_0.flags)
    end
    l_1_6 = l_1_0.debug
    if l_1_6 then
      l_1_6 = DEBugRendering
      l_1_6 = l_1_6.DrawBall
      l_1_7 = l_1_1
      l_1_8 = l_1_3
      l_1_6(l_1_7, l_1_8, l_1_5 and "green" or "red")
      l_1_6 = DEBugRendering
      l_1_6 = l_1_6.DrawBall
      l_1_7 = l_1_2
      l_1_8 = l_1_3
      l_1_6(l_1_7, l_1_8, l_1_5 and "green" or "red")
    end
    return l_1_5
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.Cast = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5)
  if not l_2_4 then
    l_2_4 = l_2_0.flags
  end
  if not l_2_5 then
    l_2_5 = 0
  end
  DEPhysics.CastRay(l_2_1, l_2_2, l_2_0.BottomCenter, l_2_4, l_2_3)
  return l_2_0.dist - l_2_5 <= l_2_0.bottomCenterDist
end

l_0_0.CastToPos = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
  l_3_0.dir:Set(l_3_2):Subtract(l_3_1)
  local l_3_5, l_3_6 = l_3_0:Cast, l_3_0
  local l_3_7 = l_3_1
  local l_3_8 = l_3_0.dir
  local l_3_9 = l_3_0.dir:Normalize()
  local l_3_10 = l_3_3
  local l_3_11 = l_3_4
  return l_3_5(l_3_6, l_3_7, l_3_8, l_3_9, l_3_10, l_3_11)
end

l_0_0.DebugDraw = function(l_4_0)
  l_4_0:DebugRayCasts()
  l_4_0:DebugCapsuleCasts()
end

l_0_0.DebugRayCasts = function(l_5_0)
  _v1:Set(l_5_0.dir):Scale(l_5_0.bottomLeftDist):Add(l_5_0.bottomLeft)
  if l_5_0.dist <= l_5_0.bottomLeftDist then
    DEBugRendering.DrawLine(l_5_0.bottomLeft, _v1, "green")
    DEBugRendering.DrawBox(_v1, 5, "green")
  else
    DEBugRendering.DrawLine(l_5_0.bottomLeft, _v1, "orange")
    DEBugRendering.DrawBox(_v1, 5, "red")
  end
  _v1:Set(l_5_0.dir):Scale(l_5_0.bottomCenterDist):Add(l_5_0.bottomCenter)
  if l_5_0.dist <= l_5_0.bottomCenterDist then
    DEBugRendering.DrawLine(l_5_0.bottomCenter, _v1, "green")
    DEBugRendering.DrawBox(_v1, 5, "green")
  else
    DEBugRendering.DrawLine(l_5_0.bottomCenter, _v1, "orange")
    DEBugRendering.DrawBox(_v1, 5, "red")
  end
  _v1:Set(l_5_0.dir):Scale(l_5_0.bottomRightDist):Add(l_5_0.bottomRight)
  if l_5_0.dist <= l_5_0.bottomRightDist then
    DEBugRendering.DrawLine(l_5_0.bottomRight, _v1, "green")
    DEBugRendering.DrawBox(_v1, 5, "green")
  else
    DEBugRendering.DrawLine(l_5_0.bottomRight, _v1, "orange")
    DEBugRendering.DrawBox(_v1, 5, "red")
  end
end

l_0_0.DebugCapsuleCasts = function(l_6_0)
  local l_6_1, l_6_2, l_6_3 = nil, nil, nil
  if l_6_0.capsuleCastingClear then
    l_6_1 = "green"
    l_6_2 = "green"
    l_6_3 = DEBugRendering.DrawBox
  else
    l_6_1 = "yellow"
    l_6_2 = "orange"
    l_6_3 = DEBugRendering.DrawJack
  end
  _v1:Set(l_6_0.motion):Scale(l_6_0.percentage):Add(l_6_0.endpoint1)
  DEBugRendering.DrawLine(l_6_0.endpoint1, _v1, l_6_1)
  l_6_3(_v1, 5, l_6_2)
  _v1:Set(l_6_0.motion):Scale(l_6_0.percentage):Add(l_6_0.endpoint2)
  DEBugRendering.DrawLine(l_6_0.endpoint2, _v1, l_6_1)
  l_6_3(_v1, 5, l_6_2)
  if not l_6_0.capsuleCastingClear then
    _v1:Set(l_6_0.motion):Scale(-l_6_0.percentage):Add(l_6_0.impact)
    DEBugRendering.DrawLine(_v1, l_6_0.impact, "orange")
    DEBugRendering.DrawJack(l_6_0.impact, 20, "red")
  end
end

l_0_0.GetSweepDistance = function(l_7_0)
  if not l_7_0.distance then
    l_7_0.distance = l_7_0.percentage * l_7_0.motion:Length()
  end
  return l_7_0.distance
end

l_0_0.GetSweepMotion = function(l_8_0)
  return l_8_0.motion
end

l_0_0.GetSweepPercentage = function(l_9_0)
  return l_9_0.percentage
end

l_0_0.Initialize = function(l_10_0)
  local l_10_1 = GetCollisionFlags
  do
    local l_10_2 = {}
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

     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

  end
   -- Warning: undefined locals caused missing assignments!
end

l_0_0.RayCastingIsClear = function(l_11_0)
  return l_11_0.rayCastingIsClear
end

l_0_0.Scan = function(l_12_0, l_12_1, l_12_2, l_12_3, l_12_4)
  l_12_0.dir:Set(l_12_2)
  do
     -- DECOMPILER ERROR: Confused at declaration of local variable

    l_12_0.dist = l_12_3 or maxraycastdist
    l_12_0.right:Set(l_12_2)
    l_12_0.right:Cross(WorldAxes.posZ)
    l_12_0.right:Normalize()
    l_12_0.right:Scale(halfWidth)
    if not l_12_4 then
      l_12_4 = l_12_0.flags
    end
    l_12_0.bottomCenter:Set(l_12_1)
    l_12_0.bottomCenter.z = l_12_0.bottomCenter.z + dzBottom
    l_12_0.bottomLeft:Set(l_12_0.bottomCenter)
    l_12_0.bottomLeft:Subtract(l_12_0.right)
    l_12_0.bottomRight:Set(l_12_0.bottomCenter)
    l_12_0.bottomRight:Add(l_12_0.right)
    l_12_0.rayCastingIsClear = false
    l_12_0.bottomLeftDist = 0
    l_12_0.bottomCenterDist = 0
    l_12_0.bottomRightDist = 0
    DEPhysics.CastRay(l_12_0.bottomCenter, l_12_2, l_12_0.BottomCenter, l_12_4, l_12_3)
    if l_12_0.dist <= l_12_0.bottomCenterDist then
      DEPhysics.CastRay(l_12_0.bottomLeft, l_12_2, l_12_0.BottomLeft, l_12_4, l_12_3)
      if l_12_0.dist <= l_12_0.bottomLeftDist then
        DEPhysics.CastRay(l_12_0.bottomRight, l_12_2, l_12_0.BottomRight, l_12_4, l_12_3)
        l_12_0.rayCastingIsClear = l_12_0.dist <= l_12_0.bottomRightDist
      end
    end
    return l_12_0.rayCastingIsClear
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.ScanToPos = function(l_13_0, l_13_1, l_13_2, l_13_3)
  l_13_0.dir:Set(l_13_2)
  l_13_0.dir:Subtract(l_13_1)
  local l_13_4, l_13_5 = l_13_0:Scan, l_13_0
  local l_13_6 = l_13_1
  local l_13_7 = l_13_0.dir
  local l_13_8 = l_13_0.dir:Normalize()
  local l_13_9 = l_13_3
  return l_13_4(l_13_5, l_13_6, l_13_7, l_13_8, l_13_9)
end

l_0_0.SetRaycastFlags = function(l_14_0, l_14_1)
  l_14_0.flags = l_14_1
end

l_0_0.Sweep = function(l_15_0, l_15_1, l_15_2, l_15_3, l_15_4, l_15_5)
  l_15_0.distance = nil
  if not l_15_3 then
    l_15_3 = l_15_0.radius
  end
  if not l_15_4 then
    l_15_4 = l_15_0.z
  end
  if not l_15_5 then
    l_15_5 = l_15_0.flags
  end
  l_15_0.endpoint1:Set(l_15_1.x, l_15_1.y, l_15_1.z)
  l_15_0.endpoint2:Set(l_15_1.x, l_15_1.y, l_15_1.z + l_15_4)
  l_15_0.motion:Set(l_15_2)
  DEPhysics.CapsuleSweep(l_15_0.CapsuleSweepFunc, l_15_2, l_15_0.endpoint1, l_15_0.endpoint2, l_15_3, l_15_5)
  l_15_0.capsuleCastingClear = l_15_0.percentage >= 1
  return l_15_0.capsuleCastingClear
end

l_0_0.SweepIsClear = function(l_16_0)
  return l_16_0.capsuleCastingClear
end

l_0_0.SweepToPos = function(l_17_0, l_17_1, l_17_2, l_17_3, l_17_4, l_17_5)
  l_17_0.motion:Set(l_17_2)
  l_17_0.motion:Subtract(l_17_1)
  local l_17_6, l_17_7 = l_17_0:Sweep, l_17_0
  local l_17_8 = l_17_1
  local l_17_9 = l_17_0.motion
  local l_17_10 = l_17_3
  local l_17_11 = l_17_4
  local l_17_12 = l_17_5
  return l_17_6(l_17_7, l_17_8, l_17_9, l_17_10, l_17_11, l_17_12)
end

l_0_0.Name = "VolumeScanner"
DeclareClass(l_0_0)
_G.vs = new("VolumeScanner")

