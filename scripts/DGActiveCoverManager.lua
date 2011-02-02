-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: DGActiveCoverManager.luac 

module("DGActiveCoverManager", package.seeall)
require("ObjectOrientedParadigm")
require("Observation")
_G.ACMgr = DGActiveCoverManager
ACMgr.railsReady = false
HandleRailsReadyEvent = function()
  print("ActiveCover and Navigation is ready.")
  railsReady = true
  resultOfSave = false
end

railsReadyTicket = DEEventManager.SubscribeEvent("DGACRailsReadyEvent", HandleRailsReadyEvent)
_G.CurrentAC = {}
_G.AllACPrefs = {}
local l_0_0 = _G.AllACPrefs
local l_0_1 = {}
l_0_1.DefaultPreferences = "FileName"
l_0_1.CanMoveIntoLostCover = false
l_0_1.PushExitCover = true
l_0_1.PushExitCoverTime = 400
l_0_1.PushExitMaxAngle = 30
l_0_1.PushPeek = false
l_0_1.PushPeekWaitTime = 300
l_0_1.PushPeekWithAim = true
l_0_1.MinimumCrouchCoverHeight = 36
l_0_1.MinimumStandCoverHeight = 48
l_0_1.DistanceFromCover = 9
l_0_1.DistanceFromEdge = 20
l_0_1.MinimumHeightForLostCover = 18
l_0_1.MinimumWidthForLostCover = 24
l_0_1.MaxCrouchSidePeekHeight = 18
l_0_1.MaxCrouchSideStandHeight = 36
l_0_1.ForcePose = true
l_0_1.ForceStand = true
l_0_1.MinSearchLength = 30
l_0_1.MaxSearchLength = 200
l_0_1.StandardSearchLength = 30
l_0_1.StandardSearchSpeed = 90
l_0_1.MaxAttachAngle = 150
l_0_0.ACDefaults = l_0_1
l_0_0 = _G
l_0_1 = function(l_2_0, l_2_1)
   -- DECOMPILER ERROR: unhandled construct in 'if'

  if l_2_0.DefaultPreferences and l_2_0.DefaultPreferences ~= "FileName" and l_2_0.DefaultPreferences ~= "ACDefaults" then
    LoadScript("ActiveCoverSettings/" .. l_2_0.DefaultPreferences .. ".lua")
    do return end
    l_2_0.DefaultPreferences = "ACDefaults"
  end
end

l_0_0.LoadParentPreferences = l_0_1
l_0_0 = _G
l_0_1 = function(l_3_0, l_3_1)
  local l_3_2 = assert
  l_3_2(l_3_1 ~= "ACDefaults", "The entry at the bottom of the file should be changed from \"ACDefaults\"")
  l_3_2 = _G
  l_3_2 = l_3_2.LoadParentPreferences
  l_3_2(l_3_0)
  l_3_2 = _G
  l_3_2 = l_3_2.AllACPrefs
  l_3_2[l_3_1] = l_3_0
  l_3_2 = _G
  l_3_2 = l_3_2.SetTableEntriesAsCurrent
  l_3_2(l_3_1)
  l_3_2 = _G
  l_3_2 = l_3_2.SetPlayerActiveCoverPreferences
  l_3_2()
end

l_0_0.LoadACPrefs = l_0_1
l_0_0 = _G
l_0_1 = function(l_4_0)
  local l_4_1 = AllACPrefs[l_4_0]
  for l_4_5,l_4_6 in pairs(AllACPrefs.ACDefaults) do
    print("Key: ", l_4_5, ", Value: ", GetACValue(l_4_5, l_4_1))
    CurrentAC[l_4_5] = GetACValue(l_4_5, l_4_1)
  end
end

l_0_0.SetTableEntriesAsCurrent = l_0_1
l_0_0 = _G
l_0_1 = function(l_5_0, l_5_1)
  if l_5_1[l_5_0] ~= nil then
    return l_5_1[l_5_0]
  else
    local l_5_2 = GetACValue
    local l_5_3 = l_5_0
    do
      local l_5_5 = AllACPrefs
      l_5_5 = l_5_5[l_5_1.DefaultPreferences]
       -- DECOMPILER ERROR: Confused at declaration of local variable

      return l_5_2(l_5_3, l_5_5)
    end
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

l_0_0.GetACValue = l_0_1
l_0_0 = _G
l_0_1 = function()
  DGActiveCoverManager.ReconnectRails()
end

l_0_0.ReconnectRails = l_0_1
l_0_0 = _G
l_0_1 = function()
  if DGEntityManager.GetPlayerEntity() and DGEntityManager.GetPlayerEntity():GetActiveCover() then
    local l_7_0 = DGEntityManager.GetPlayerEntity():GetActiveCover()
    l_7_0:SetPushDetach(CurrentAC.PushExitCover)
    l_7_0:SetDistanceFromEdge(CurrentAC.DistanceFromEdge)
    l_7_0:SetDistanceFromCover(CurrentAC.DistanceFromCover)
    l_7_0:SetDetachAngle(CurrentAC.PushExtMaxAngle)
    l_7_0:SetDetachTime(CurrentAC.PushExitCoverTime)
    l_7_0:SetForcePose(CurrentAC.ForcePose)
    l_7_0:SetForceStand(CurrentAC.ForceStand)
    l_7_0:SetMaxAttachAngle(CurrentAC.MaxAttachAngle)
    l_7_0:SetMaxCrouchPeekSideHeight(CurrentAC.MaxCrouchSidePeekHeight)
    l_7_0:SetMaxStandPeekSideHeight(CurrentAC.MaxSideStandStandHeight)
    l_7_0:SetMinCrouchHeight(CurrentAC.MinimumCrouchCoverHeight)
    l_7_0:SetMinStandHeight(CurrentAC.MinimumStandCoverHeight)
    l_7_0:SetMovementIntoNoCover(CurrentAC.CanMoveIntoLostCover)
    l_7_0:SetStandardSearchLength(CurrentAC.StandardSearchLength)
    l_7_0:SetStandardSearchSpeed(CurrentAC.StandardSearchSpeed)
    l_7_0:SetMinSearchLength(CurrentAC.MinSearchLength)
    l_7_0:SetMaxSearchLength(CurrentAC.MaxSearchLength)
    l_7_0:SetPushPeek(CurrentAC.PushPeek)
    l_7_0:SetPushPeekTime(CurrentAC.PushPeekWaitTime)
    l_7_0:SetPushPeekWithAim(CurrentAC.PushPeekWithAim)
  end
end

l_0_0.SetPlayerActiveCoverPreferences = l_0_1
l_0_0 = _G
l_0_1 = function(l_8_0)
  if l_8_0 ~= "ACDefaults" then
    LoadScript("ActiveCoverSettings/" .. l_8_0 .. ".lua")
  end
  SetTableEntriesAsCurrent(l_8_0)
  SetPlayerActiveCoverPreferences()
end

l_0_0.ACPref = l_0_1

