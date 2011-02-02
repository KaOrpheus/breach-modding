-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: FallujahClient.luac 

module("FallujahClient", package.seeall)
require("ClientAgent")
local l_0_0 = {}
l_0_0.Name = "FallujahClient"
l_0_0.Extends = "ClientAgent"
l_0_0.ScreenMessage = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
  local l_1_5 = DEEventManager.CreateEvent("DGEventHudMessage")
  l_1_5.Message = l_1_1
  do
     -- DECOMPILER ERROR: Confused at declaration of local variable

    l_1_5.LocIndex = l_1_2 or 0
    l_1_5.FadeTime = l_1_3 or 2000
    l_1_5.NoQueue = l_1_4 or false
    DEEventManager.AddEvent(l_1_5)
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.ScreenLocMessage = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4)
  local l_2_5 = DEString.GetLocalizedString(l_2_1, l_2_2)
  if l_2_5 then
    l_2_0:ScreenMessage(l_2_5, l_2_3, l_2_4)
  end
end

l_0_0.SetCameraFocus = function(l_3_0, l_3_1, l_3_2)
  if localPlayer and l_3_1 == localPlayer:GetPlayerID() then
    sprint("ID: " .. l_3_1 .. " trying to focus on " .. l_3_2)
    local l_3_3 = DGGamerManager.GetActiveGamer():GetCamera()
    local l_3_4 = DGDataNodeManager.GetNodeOfTypeByName("DGDataNodeScriptedCamera", l_3_2)
    if l_3_4 then
      local l_3_5 = ObjectPool.Get("PosQuat"):Set(l_3_4:GetWorldTransformPQ())
      l_3_3:SetWorldTransformPQ(l_3_5)
      ObjectPool.Recycle(l_3_5)
    end
  end
end

l_0_0.AddXP = function(l_4_0, l_4_1, l_4_2, l_4_3)
  if localPlayer and l_4_1 == localPlayer:GetPlayerID() then
    local l_4_4 = DEEventManager.CreateEvent("ShurikenEventAwardXP")
    l_4_4.XP = l_4_2
    l_4_4.Reason = l_4_3
    l_4_4.PlayerID = localPlayer:GetPlayerID()
    DEEventManager.AddEvent(l_4_4)
  end
end

l_0_0.SetRespawnCountdown = function(l_5_0, l_5_1, l_5_2)
  if localPlayer and l_5_1 == localPlayer:GetPlayerID() and l_5_2 > 1 then
    ScriptManager.RegisterTimerFunction("Respawn Countdown", function()
    if l_5_2 < 1 then
      ScriptManager.UnregisterTimerFunction("Respawn Countdown")
      if not l_5_0.gameEnded then
        localPlayer:SetState("eWaitingToRespawn")
        DGGamerManager.GetActiveGamer():DeactivateInputSetByName("FreeCamera")
      end
      l_5_0.DeathTipDisplayed = false
    else
      local l_6_0 = DEString.GetLocalizedString("ui_messages_reinforcements", l_5_2)
      if l_6_0 then
        l_5_0:ScreenMessage(l_6_0, 0, 900, true)
      end
    end
    l_5_2 = l_5_2 - 1
    if not localPlayer:GetFaction() or not localPlayer:GetFaction():GetFactionID() then
      local l_6_1, l_6_2 = l_5_2 ~= l_5_0.reinforcementsVOTime or -1
    end
     -- DECOMPILER ERROR: Confused about usage of registers!

    l_5_0:HQRadioChatter("HQ_Radio_Message_General", "HQ_Reinforcements", l_6_1)
   end, 1)
    do
       -- DECOMPILER ERROR: Confused at declaration of local variable

      if not l_5_0.DeathTipDisplayed and l_5_0.NumDeaths == l_5_0.DeathsPerTip then
        if DEString.GetLocalizedString(l_5_0.TipStrings[math.random(#l_5_0.TipStrings)], 0) then
          l_5_0:ScreenMessage(DEString.GetLocalizedString(l_5_0.TipStrings[math.random(#l_5_0.TipStrings)], 0), 2, 7000, true)
        end
        l_5_0.DeathTipDisplayed = true
      end
       -- DECOMPILER ERROR: Confused about usage of registers for local variables.

    end
  end
end

l_0_0.EndGame = function(l_6_0)
  l_6_0.gameEnded = true
end

l_0_0.Initialize = function(l_7_0)
  _G.missionInfo = DGApp.GetSession():GetActiveMissionInfo()
  l_7_0.indicatorIDs = {}
  l_7_0.music = {}
  l_7_0.bConvoyArmor = false
  l_7_0.DeathTipDisplayed = false
  l_7_0.NumDeaths = 0
  l_7_0.DeathsPerTip = 3
  do
    local l_7_1 = {}
     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

    if l_7_1 then
      l_7_1("ui_message_activecover_king", "ui_message_activecover_two")
    end
  end
   -- Warning: undefined locals caused missing assignments!
end

l_0_0.HandleKill = function(l_8_0, l_8_1)
  if l_8_0.NumDeaths == l_8_0.DeathsPerTip then
    l_8_0.NumDeaths = 0
  end
  if l_8_1.PlayerID == localPlayer:GetPlayerID() then
    l_8_0.NumDeaths = l_8_0.NumDeaths + 1
  end
end

l_0_0.HQRadioChatter = function(l_9_0, l_9_1, l_9_2, l_9_3)
  local l_9_4 = math.CRC32(l_9_2)
  DGChatter.Post_BroadCastRadioRequestCRC(l_9_1, l_9_4, l_9_3)
end

l_0_0.HandleCap = function(l_10_0, l_10_1)
  if localPlayer and l_10_1 == localPlayer:GetPlayerID() then
    local l_10_2 = DEEventManager.CreateEvent("ShurikenEventAwardXP")
    l_10_2.XP = 10
    l_10_2.PlayerID = l_10_1
    DEEventManager.AddEvent(l_10_2)
  end
end

l_0_0.HandleEndMission = function(l_11_0)
  if DGApp.IsDedicatedServer() then
    return 
  end
  local l_11_1 = localPlayer:GetFaction()
  if l_11_1 ~= nil then
    if l_11_1:GetFactionID() == l_11_0.WinningFactionID then
      local l_11_2 = DESoundSystem.GetSoundCue(l_11_1:GetVictoryMusicCue(), true)
      if l_11_2 ~= nil then
        DESoundSystem.PlayMusicCue(l_11_2, 0.20000000298023, 4, 1, 0)
      else
        local l_11_3 = DESoundSystem.GetSoundCue(l_11_1:GetDefeatMusicCue(), true)
        if l_11_3 ~= nil then
          DESoundSystem.PlayMusicCue(l_11_3, 0.20000000298023, 4, 1, 0)
        end
      end
    end
  end
end

l_0_0.HandleSwitchControl = function(l_12_0)
  if not localPlayer or localPlayer:GetPlayerID() == l_12_0.PlayerID then
     -- Warning: missing end command somewhere! Added here
  end
end

l_0_0.HandleScenarioLoaded = function(l_13_0)
  if DGApp.IsDedicatedServer then
    return 
  end
  local l_13_1 = localPlayer:GetFaction()
  if l_13_1 ~= nil then
    local l_13_2 = DESoundSystem.GetSoundCue(l_13_1:GetLevelStartMusicCue(), true)
    if l_13_2 ~= nil then
      DESoundSystem.PlayMusicCue(l_13_2, 0.20000000298023, 4, 1, 0)
    end
  end
  DGGamerManager.GetActiveGamer():DeactivateInputSetByName("FreeCamera")
end

l_0_0.NearConvoy = function(l_14_0, l_14_1, l_14_2)
  if localPlayer and l_14_1 == localPlayer:GetPlayerID() and l_14_0.bConvoyArmor ~= l_14_2 then
    l_14_0.bConvoyArmor = l_14_2
    local l_14_3 = localPlayer:GetControlEntity()
    if l_14_2 then
      l_14_3:AddArmorBonus(25)
    else
      l_14_3:RemoveArmorBonus(25)
    end
  end
end

l_0_0.ReverseExtractionPoints = function(l_15_0)
  if not l_15_0 or localPlayer and l_15_0 == localPlayer:GetPlayerID() then
    for l_15_4,l_15_5 in pairs(DGDataNodeManager.EnumAllNodesOfType("DGDataNodeExtraction")) do
      if l_15_5.Faction == 0 then
        l_15_5:SetFaction(1)
        for l_15_4,l_15_5 in l_15_1 do
        end
        l_15_5:SetFaction(0)
      end
    end
     -- Warning: missing end command somewhere! Added here
  end
end

l_0_0.SetMusic = function(l_16_0, l_16_1)
  if l_16_0.music[l_16_1] then
    DESoundSystem.PlayMusicCue(l_16_0.music[l_16_1], 2, 4, 1, 0)
  end
end

DeclareClass(l_0_0)

