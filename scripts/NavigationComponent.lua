-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: NavigationComponent.luac 

module("NavigationComponent", package.seeall)
require("AIComponent")
require("AIManager")
require("Math")
require("Observation")
require("ObjectPool")
require("ScriptingUtility")
require("Vector")
require("VolumeScanner")
_G.debugNav = function(l_1_0, l_1_1, l_1_2, l_1_3)
  if l_1_0 and l_1_0.MovementComponent and l_1_0.MovementComponent.navigation then
    if l_1_1 == nil then
      l_1_1 = true
    end
    if l_1_2 == nil then
      l_1_2 = true
    end
    if l_1_3 == nil then
      l_1_3 = true
    end
    l_1_0.MovementComponent.navigation:Debug(l_1_1, false, l_1_3)
  end
end

MAX_NUM_BREADCRUMBS = 30
maxSearchDist = 1000
local l_0_0 = GetCollisionFlags
local l_0_1 = {}
 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1, NavStaticFlags, l_0_0 = {"Static", "Dynamic", "Transparent", "AllCollide", "Vehicles"}, l_0_0, l_0_0(l_0_1)
l_0_0 = l_0_0(l_0_1)
NavCharacterFlags = l_0_0
l_0_0 = false
callbackClearLOS = l_0_0
l_0_0 = 18
STEP_OFFSET = l_0_0
l_0_0 = function()
  return NavigationComponent.STEP_OFFSET
end

step_offset = l_0_0
l_0_0 = 35
CONTROLLER_HEIGHT = l_0_0
l_0_0 = function()
  return NavigationComponent.CONTROLLER_HEIGHT
end

contoller_height = l_0_0
l_0_0 = 13
CONTROLLER_RADIUS = l_0_0
l_0_0 = function()
  return NavigationComponent.CONTROLLER_RADIUS
end

controller_radius = l_0_0
l_0_0 = CONTROLLER_RADIUS
l_0_1 = STEP_OFFSET
l_0_0 = l_0_0 + l_0_1
NAVIGABLE_POSITION_HEIGHT = l_0_0
l_0_0 = function()
  return NavigationComponent.NAVIGABLE_POSITION_HEIGHT
end

nav_pos_height = l_0_0
l_0_0 = CONTROLLER_HEIGHT
l_0_1 = STEP_OFFSET
l_0_0 = l_0_0 - l_0_1
NAVIGABLE_CAPSULE_HEIGHT = l_0_0
l_0_0 = function()
  return NavigationComponent.NAVIGABLE_CAPSULE_HEIGHT
end

nav_capsule_height = l_0_0
l_0_0 = CONTROLLER_RADIUS
l_0_0 = l_0_0 * 2
l_0_1 = CONTROLLER_HEIGHT
l_0_0 = l_0_0 + l_0_1
NAVIGATION_COLLISION_HEIGHT = l_0_0
l_0_0 = function()
  return NavigationComponent.NAVIGATION_COLLISION_HEIGHT
end

nav_collision_height = l_0_0
l_0_0 = 1
MAX_GROUND_CHECK_DELTA = l_0_0
l_0_0 = 24
GROUND_EXTRA = l_0_0
l_0_0 = STEP_OFFSET
l_0_1 = GROUND_EXTRA
l_0_0 = l_0_0 + l_0_1
l_0_1 = CONTROLLER_RADIUS
l_0_0 = l_0_0 + l_0_1
GROUND_CHECK = l_0_0
l_0_0 = function()
  return GROUND_CHECK
end

ground_check = l_0_0
l_0_0 = math
l_0_0 = l_0_0.huge
l_0_0 = -l_0_0
screwUpTime = l_0_0
l_0_0 = vs
l_0_1 = controller_radius
l_0_1 = l_0_1()
l_0_0.radius = l_0_1
l_0_0 = vs
l_0_1 = nav_capsule_height
l_0_1 = l_0_1()
l_0_0.z = l_0_1
l_0_0 = _G
l_0_0.debugNavPositions = false
l_0_0 = function(l_9_0, l_9_1)
  local l_9_2, l_9_3, l_9_4 = nil, nil, nil
  l_9_2, l_9_3, l_9_4 = AINavigation.GetNavigablePos(l_9_0)
  if l_9_2 and l_9_3 and l_9_4 then
    l_9_1:Set(l_9_2, l_9_3, l_9_4)
    return true
  end
end

GetNavigablePosition = l_0_0

