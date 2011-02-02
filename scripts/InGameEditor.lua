-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: InGameEditor.luac 

module("InGameEditor", package.seeall)
require("GuiManager")
tools = {}
currentTool = nil
currentToolName = nil
active = false
debugWin = GuiManager.MakeTextBox("InGameEdit_MainDbgWin", 150, 100)
update = true
_G.EditMode = function()
  active = not active
  if active then
    DGApp.ConsoleCommand("fx(0)")
    DGApp.SetShowCursor(true)
    DGApp.SetCenterCursor(false)
    Activate()
    debugWin:SetPosition(100, 1)
    if currentTool then
      currentTool.draw = not DGInGameConsole.IsOpen()
    end
    print("In-game edit mode ACTIVE")
  else
    Deactivate()
    print("In-game edit mode deactivated")
  end
  AINavigation.HandleEditMode(active)
end

_G.edit = _G.EditMode
Activate = function()
  SelectTool("GraphTool")
  if currentTool and currentTool.Activate then
    currentTool.Activate()
  end
  local l_2_0 = DEEventManager.CreateEvent("DGEventActivateMode")
  DEEventManager.AddEvent(l_2_0, "Edit")
  active = true
  ScriptManager.RegisterEventHandler("Lua_F3", "F3_Pressed", ToggleTools)
  ScriptManager.RegisterUpdateFunction("InGameEditor", Update)
end

Deactivate = function()
  if currentTool and currentTool.Deactivate then
    currentTool.Deactivate()
  end
  local l_3_0 = DEEventManager.CreateEvent("DGEventDeactivateMode")
  DEEventManager.AddEvent(l_3_0, "Edit")
  active = false
  ScriptManager.UnregisterUpdateFunction("InGameEditor")
end

Update = function()
  if currentTool and currentTool.Update then
    currentTool.draw = not DGInGameConsole.IsOpen()
    currentTool.Update()
    debugWin:ClearText()
    debugWin:Append("InGame Editor\n" .. currentToolName)
    if currentTool and currentTool.DebugDisplay then
      currentTool.DebugDisplay(debugWin)
    end
    debugWin:Render()
  end
end

SelectTool = function(l_5_0)
  if tools[l_5_0] then
    if currentTool and currentTool.Deactivate then
      currentTool.Deactivate()
    end
    currentTool = tools[l_5_0]
    currentToolName = l_5_0
    if currentTool.Activate then
      currentTool.Activate()
    else
      print(l_5_0 .. " is not an installed tool")
      currentToolName = nil
    end
  end
end

ToggleTools = function()
  local l_6_0 = next(tools, currentToolName)
  if l_6_0 == nil then
    l_6_0 = next(tools, l_6_0)
  end
  SelectTool(l_6_0)
end

InstallTool = function(l_7_0, l_7_1)
  tools[l_7_0] = l_7_1
end

UninstallTool = function(l_8_0)
  tools[l_8_0] = nil
end


