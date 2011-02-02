-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: DebugWatcher.luac 

module("DebugWatcher", package.seeall)
local l_0_0 = _G
local l_0_1 = {}
l_0_1.watches = {}
l_0_1.DEFAULT_WATCH_WINDOW_WIDTH = 250
l_0_1.DEFAULT_WATCH_WINDOW_HEIGHT = 300
l_0_0.DebugWatcher = l_0_1
l_0_0 = _G
l_0_0 = l_0_0.DebugWatcher
l_0_1 = function(l_1_0, l_1_1)
  for l_1_5 = 1, #l_1_0.watches do
    if l_1_0.watches[l_1_5].item == l_1_1 then
      return l_1_5
    end
  end
end

l_0_0.FindWatchedItemIndex = l_0_1
l_0_0 = _G
l_0_0 = l_0_0.DebugWatcher
l_0_1 = function(l_2_0, l_2_1, l_2_2, l_2_3)
  if l_2_1 then
    if not l_2_0:FindWatchedItemIndex(l_2_1) then
      local l_2_4 = "DbgWatch"
      if l_2_2 then
        l_2_4 = l_2_4 .. "_" .. l_2_2
      end
      local l_2_5 = {}
      l_2_5.debugWin = GuiManager.MakeTextBox(l_2_4, l_2_0.DEFAULT_WATCH_WINDOW_WIDTH, l_2_0.DEFAULT_WATCH_WINDOW_HEIGHT)
      l_2_5.item = l_2_1
      l_2_5.title = l_2_2
      l_2_5.params = l_2_3
      l_2_5.debugWin:SetDimensions(not l_2_3 or 175, l_2_3.height or l_2_3.height or 200)
      l_2_5.debugWin:SetPosition(l_2_3.x or 0, l_2_3.y or 0)
      l_2_5.debugWin.Text:SetTextColor(l_2_3.color.r, l_2_3.color.g, l_2_3.color.b)
      table.insert(l_2_0.watches, l_2_5)
      if #l_2_0.watches == 1 then
        ScriptManager.RegisterUpdateFunction("debugwatcher", DebugWatcher.Update)
      end
      return l_2_5
    else
      print("Warning: DebugWatcher is already watching item")
    end
  else
    print("Error: DebugWatcher not given valid item")
  end
end

l_0_0.AddWatch = l_0_1
l_0_0 = _G
l_0_0 = l_0_0.DebugWatcher
l_0_1 = function(l_3_0, l_3_1)
  local l_3_2 = l_3_0:FindWatchedItemIndex(l_3_1)
  if l_3_2 then
    table.remove(l_3_0.watches, l_3_2)
    if #l_3_0.watches == 0 then
      ScriptManager.UnregisterUpdateFunction("debugwatcher")
    end
  end
end

l_0_0.RemoveWatch = l_0_1
l_0_0 = _G
l_0_1 = function(l_4_0, l_4_1, l_4_2)
  local l_4_3, l_4_4 = DebugWatcher:AddWatch, DebugWatcher
  local l_4_5 = l_4_0
  local l_4_6 = l_4_1
  local l_4_7 = l_4_2
  return l_4_3(l_4_4, l_4_5, l_4_6, l_4_7)
end

l_0_0.watch = l_0_1
l_0_0 = _G
l_0_1 = function(l_5_0)
  DebugWatcher:RemoveWatch(l_5_0)
end

l_0_0.unwatch = l_0_1
l_0_0 = _G
l_0_1 = function()
  DebugWatcher:Clear()
end

l_0_0.unwatchall = l_0_1
l_0_0 = _G
l_0_0 = l_0_0.DebugWatcher
l_0_1 = function(l_7_0)
  l_7_0.watches = {}
  ScriptManager.UnregisterUpdateFunction("debugwatcher")
end

l_0_0.Clear = l_0_1
l_0_0 = _G
l_0_0 = l_0_0.DebugWatcher
l_0_1 = function()
  local l_8_0 = 0
  local l_8_1 = 0
  do
    local l_8_2 = 0
    for l_8_6,l_8_7 in pairs(DebugWatcher.watches) do
      if not l_8_7.params then
        l_8_7.debugWin:SetPosition(l_8_0, l_8_1)
        l_8_0 = l_8_0 + DebugWatcher.DEFAULT_WATCH_WINDOW_WIDTH + 2
      end
      l_8_7.debugWin:ClearText()
      if l_8_7.title then
        l_8_7.debugWin:AddLine("Watching: " .. l_8_7.title .. " (" .. type(l_8_7.item) .. ")")
      end
      if type(l_8_7.item) == "table" then
        local l_8_8 = {}
        for l_8_12,l_8_13 in pairs(l_8_7.item) do
          if type(l_8_13) ~= "table" and type(l_8_13) ~= "function" then
            table.insert(l_8_8, l_8_12 .. ": " .. tostring(l_8_13))
            for l_8_12,l_8_13 in l_8_9 do
            end
            if type(l_8_13) == "table" then
              local l_8_14 = tostring(l_8_13)
              if not string.match(l_8_14, "table: ") then
                table.insert(l_8_8, l_8_12 .. ": " .. l_8_14)
              end
            end
          end
          table.sort(l_8_8)
          for l_8_18,l_8_19 in pairs(l_8_8) do
            l_8_7.debugWin:AddLine(tostring(l_8_19))
          end
        else
          if type(l_8_7.item) == "function" then
            local l_8_20, l_8_21, l_8_22 = l_8_7.item()
            if l_8_20 then
              l_8_7.debugWin:AddLine(tostring(l_8_20))
            end
            if l_8_21 then
              l_8_7.debugWin:AddLine(tostring(l_8_21))
            end
            if l_8_22 then
              l_8_7.debugWin:AddLine(tostring(l_8_22))
            else
              l_8_7.debugWin:AddLine(tostring(l_8_7.item))
            end
          end
        end
        l_8_7.debugWin:Render()
        l_8_2 = l_8_2 + 1
        if l_8_2 == 4 then
          l_8_2 = 0
          l_8_0 = 0
          l_8_1 = l_8_1 + DebugWatcher.DEFAULT_WATCH_WINDOW_HEIGHT + 2
        end
      end
    end
     -- Warning: missing end command somewhere! Added here
  end
end

l_0_0.Update = l_0_1

