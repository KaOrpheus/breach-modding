-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: DebugDisplayObject.luac 

module("DebugDisplayObject", package.seeall)
require("ObjectOrientedParadigm")
local l_0_0 = {}
l_0_0.Name = "DebugDisplayObject"
l_0_0.ArgsConstructor = function(l_1_0, l_1_1, l_1_2, l_1_3)
  l_1_0:Define(l_1_1, l_1_2, l_1_3)
end

l_0_0.AddRenderFunction = function(l_2_0, l_2_1, l_2_2)
  local l_2_3 = assert
  l_2_3(type(l_2_2) == "function")
  l_2_3 = l_2_0.debugRenderFunctions
  l_2_3[l_2_1] = l_2_2
end

l_0_0.Debug = function(l_3_0, l_3_1, l_3_2)
  l_3_0.debugWindow = togset(l_3_0.debugWindow, l_3_1)
  l_3_0.debugRender = togset(l_3_0.debugRender, l_3_2)
end

l_0_0.DebugDisplay = function(l_4_0, l_4_1)
  if l_4_0.debugWindow then
    local l_4_2 = nil
    if not l_4_1 then
      if not l_4_0.debugWin then
        print("MakeTextBox with", l_4_0.object:GetName(), l_4_0.debugWinX, l_4_0.debugWinY)
        l_4_0.debugWin = GuiManager.MakeTextBox(l_4_0:GetName(), l_4_0.debugWinX, l_4_0.debugWinY)
      end
      l_4_2 = l_4_0.debugWin
    else
      l_4_2 = l_4_1
    end
    l_4_2:ClearText()
    l_4_2:SetPosition(0, 0)
    l_4_0.object:UpdateDebugWindow(l_4_2)
    l_4_2:Render()
  end
  if l_4_0.debugRender then
    l_4_0.object:DebugRender()
    for l_4_6,l_4_7 in pairs(l_4_0.debugRenderFunctions) do
      l_4_7()
    end
  end
end

l_0_0.Define = function(l_5_0, l_5_1, l_5_2, l_5_3)
  local l_5_4 = assert
  l_5_4(type(l_5_1.DebugRender) == "function", "DebugRender must be a function")
  l_5_4 = assert
  l_5_4(type(l_5_1.UpdateDebugWindow) == "function", "UpdateDebugWindow must be a function")
  l_5_0.object = l_5_1
  if not l_5_3 then
    l_5_4 = l_5_0.debugWinY
  end
  l_5_0.debugWinY = l_5_4
  if not l_5_2 then
    l_5_4 = l_5_0.debugWinX
  end
  l_5_0.debugWinX = l_5_4
end

l_0_0.Initialize = function(l_6_0)
  l_6_0.debugWinX = 300
  l_6_0.debugWinY = 300
  l_6_0.debugWindow = false
  l_6_0.debugRender = false
  l_6_0.debugRenderFunctions = {}
end

l_0_0.RemoveRenderFunction = function(l_7_0, l_7_1)
  l_7_0.debugRenderFunctions[l_7_1] = nil
end

l_0_0.SetWindowSize = function(l_8_0, l_8_1, l_8_2)
  do
     -- DECOMPILER ERROR: Confused at declaration of local variable

    if not l_8_2 then
      l_8_0.debugWinY = l_8_0.debugWinY
    end
    if not l_8_1 then
      l_8_0.debugWinX = l_8_0.debugWinX
    end
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

DeclareClass(l_0_0)

