-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: GuiManager.luac 

module("GuiManager", package.seeall)
local l_0_0 = 240
local l_0_1 = 240
local l_0_2 = function(l_1_0, l_1_1)
  local l_1_2 = getmetatable(l_1_0)
  local l_1_3 = assert
  l_1_3(type(l_1_2) ~= "table")
  l_1_3 = l_1_2.__gc
  l_1_2.__gc = function(l_1_0)
    l_1_1(l_1_0)
    l_1_3(l_1_0)
   end
end

canvas = DGGameView.CreateCanvasElement("Lua canvas", DERender.GetMainWidth(), DERender.GetMainHeight(), 100, 1000002)
objects = {}
l_0_2(canvas, DGGameView.DestroyCanvasElement)
AddQuickText = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4)
  if not l_2_0 then
    return 
  end
  local l_2_5 = new("TextBox", l_2_0)
  objects[l_2_5:GetName()] = l_2_5
  l_2_5.Background:SetOpacity(0)
  l_2_5:SetDimensions(1024, 768)
  if l_2_2 then
    l_2_5.Text:SetFont(l_2_2)
  end
  if l_2_3 and l_2_4 then
    l_2_5:SetPosition(l_2_3, l_2_4)
  end
  if l_2_1 then
    l_2_5.Text:SetText(l_2_1)
  end
  l_2_5.autorender = true
  return l_2_5
end

AddQuickTextFromToken = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4)
  if not l_3_0 then
    return 
  end
  local l_3_5 = new("TextBox", l_3_0)
  objects[l_3_5:GetName()] = l_3_5
  l_3_5.Background:SetOpacity(0)
  l_3_5:SetDimensions(1024, 768)
  if l_3_2 then
    l_3_5.Text:SetFont(l_3_2)
  end
  if l_3_3 and l_3_4 then
    l_3_5:SetPosition(l_3_3, l_3_4)
  end
  if l_3_1 then
    l_3_5.Text:SetTextFromToken(l_3_1)
  end
  l_3_5.autorender = true
  return l_3_5
end

MakeImageBox = function(l_4_0, l_4_1, l_4_2)
  return new("LuaImage", l_4_0, l_4_1, l_4_2)
end

MakeTextBox = function(l_5_0, l_5_1, l_5_2)
  do
    local l_5_3 = new("TextBox", l_5_0)
     -- DECOMPILER ERROR: Confused at declaration of local variable

    do
      if not l_5_1 then
        local l_5_5 = not l_5_1 and not l_5_2 or l_0_0
      if not l_5_1 then
        end
      end
      l_5_3:SetDimensions(l_5_5, l_0_1)
    end
     -- DECOMPILER ERROR: Confused about usage of registers!

    return l_5_3
  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ReleaseObject = function(l_6_0)
  if GuiManager.objects[l_6_0] then
    GuiManager.objects[l_6_0] = nil
  end
  return 
end

Update = function()
  for l_7_3,l_7_4 in pairs(objects) do
    if l_7_4.fading then
      l_7_4:DoFadeInOutRefresh()
    end
    if l_7_4.autorender then
      l_7_4:Render(GuiManager.canvas)
    end
  end
end

ScriptManager.RegisterUpdateFunction("GuiManagerUpdate", Update)
local l_0_3 = {}
l_0_3.Initialize = function(l_8_0)
  l_8_0.Background = DEGuiRectangle.Create("rect")
  l_8_0.Text = DEText.Create("text")
  l_8_0.Background:SetOpacity(0.5)
  l_8_0.Text:SetTextColor(1, 1, 1)
  l_8_0:ClearText()
  l_8_0:SetDimensions(l_0_0, l_0_1)
  l_8_0:SetPosition(0, 0)
  l_8_0.autorender = nil
end

l_0_3.ArgsConstructor = function(l_9_0, ...)
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

   -- Warning: undefined locals caused missing assignments!
end

l_0_3.Append = function(l_10_0, l_10_1)
  local l_10_2 = l_10_0.Text:GetText()
  if l_10_2 then
    l_10_0.Text:SetText(l_10_2 .. "" .. l_10_1)
  else
    l_10_0.Text:SetText(l_10_1)
  end
end

l_0_3.AddLine = function(l_11_0, l_11_1)
  l_11_0:Append("\n" .. l_11_1)
end

l_0_3.ClearText = function(l_12_0)
  l_12_0.Text:SetText("")
end

l_0_3.SetPosition = function(l_13_0, l_13_1, l_13_2)
  l_13_0.Background:SetPositionFloats(l_13_1, l_13_2)
  l_13_0.Text:SetPositionFloats(l_13_1, l_13_2)
end

l_0_3.SetDimensions = function(l_14_0, l_14_1, l_14_2)
  l_14_0.Background:SetWidth(l_14_1)
  l_14_0.Background:SetHeight(l_14_2)
  l_14_0.Text:SetWidth(l_14_1)
  l_14_0.Text:SetHeight(l_14_2)
end

l_0_3.Render = function(l_15_0, l_15_1)
  if not l_15_1 then
    local l_15_2, l_15_3, l_15_4, l_15_5, l_15_6 = GuiManager.canvas
  end
   -- DECOMPILER ERROR: Confused about usage of registers!

  DEGuiElement.Render(l_15_0.Background, l_15_2)
  DEGuiElement.Update(l_15_0.Text, gDT * 1000)
   -- DECOMPILER ERROR: Confused about usage of registers!

  DEGuiElement.Render(l_15_0.Text, l_15_2)
end

l_0_3.DoFadeInOutRefresh = function(l_16_0)
  if l_16_0.fadeIn then
    do return end
  end
  do
    if l_16_0.Text:GetOpacity() + l_16_0.fadeRate * gDT - l_16_0.fadeRate * gDT > 1 then
      local l_16_1, l_16_2 = 1
      l_16_2(l_16_0)
      l_16_2 = l_16_0:FadeInOutComplete_PRIVATE
  end
   -- DECOMPILER ERROR: Confused about usage of registers!

  elseif l_16_1 < 0 then
    local l_16_3, l_16_4, l_16_5 = 0
    l_16_4, l_16_5 = l_16_0:FadeInOutComplete_PRIVATE, l_16_0
    l_16_4(l_16_5)
  end
   -- DECOMPILER ERROR: Confused about usage of registers!

  l_16_0.Text:SetOpacity(l_16_3)
end

l_0_3.FadeInOutComplete_PRIVATE = function(l_17_0)
  if l_17_0.loopingFade then
    l_17_0.fadeIn = not l_17_0.fadeIn
  else
    l_17_0.fading = nil
    l_17_0.fadeRate = nil
    l_17_0.fadeIn = nil
    l_17_0.loopingFade = nil
  end
end

l_0_3.FadeInOut = function(l_18_0, l_18_1, l_18_2, l_18_3)
  if not l_18_1 then
    return 
  end
  l_18_0.fadeRate = 1 / l_18_1
  if l_18_2 ~= nil then
    l_18_2 = true
  end
  l_18_0.fadeIn = l_18_2
  if l_18_3 ~= nil then
    l_18_3 = false
  end
  l_18_0.loopingFade = l_18_3
  l_18_0.fading = true
end

l_0_3.Name = "TextBox"
DeclareClass(l_0_3)
local l_0_4 = {}
l_0_4.ArgsConstructor = function(l_19_0, ...)
  do
    local l_19_2 = ...
     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

    l_19_2(l_19_2, l_19_0.ImageName)
     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

    l_19_2(l_19_2, 1)
     -- DECOMPILER ERROR: Overwrote pending register.

     -- DECOMPILER ERROR: Overwrote pending register.

  end
   -- DECOMPILER ERROR: Confused about usage of registers for local variables.

   -- Warning: undefined locals caused missing assignments!
end

l_0_4.Initialize = function(l_20_0)
end

l_0_4.SetImage = function(l_21_0, l_21_1)
  l_21_0.Image:SetImagePath("")
  l_21_0.Image:SetImagePath(l_21_1)
  l_21_0.ImageName = l_21_1
end

l_0_4.SetHeight = function(l_22_0, l_22_1)
  l_22_0.Image:SetHeight(l_22_1)
  l_22_0:SetImage(l_22_0.ImageName)
end

l_0_4.SetOpacity = function(l_23_0, l_23_1)
  l_23_0.Image:SetOpacity(l_23_1)
end

l_0_4.SetPosition = function(l_24_0, l_24_1, l_24_2)
  l_24_0.Image:SetPositionFloats(l_24_1, l_24_2)
end

l_0_4.SetScale = function(l_25_0, l_25_1, l_25_2)
  l_25_0.Image:SetScale(l_25_1, l_25_2)
end

l_0_4.SetWidth = function(l_26_0, l_26_1)
  l_26_0.Image:SetWidth(l_26_1)
  l_26_0:SetImage(l_26_0.ImageName)
end

l_0_4.DoFadeInOutRefresh = function(l_27_0)
  if l_27_0.fadeIn then
    do return end
  end
  do
    if l_27_0.Image:GetOpacity() + l_27_0.fadeRate * gDT - l_27_0.fadeRate * gDT > 1 then
      local l_27_1, l_27_2 = 1
      l_27_2(l_27_0)
      l_27_2 = l_27_0:FadeInOutComplete_PRIVATE
  end
   -- DECOMPILER ERROR: Confused about usage of registers!

  elseif l_27_1 < 0 then
    local l_27_3, l_27_4, l_27_5 = 0
    l_27_4, l_27_5 = l_27_0:FadeInOutComplete_PRIVATE, l_27_0
    l_27_4(l_27_5)
  end
   -- DECOMPILER ERROR: Confused about usage of registers!

  l_27_0.Image:SetOpacity(l_27_3)
end

l_0_4.FadeInOutComplete_PRIVATE = function(l_28_0)
  if l_28_0.loopingFade then
    l_28_0.fadeIn = not l_28_0.fadeIn
  else
    l_28_0.fading = nil
    l_28_0.fadeRate = nil
    l_28_0.fadeIn = nil
    l_28_0.loopingFade = nil
  end
end

l_0_4.FadeInOut = function(l_29_0, l_29_1, l_29_2, l_29_3)
  if not l_29_1 then
    return 
  end
  l_29_0.fadeRate = 1 / l_29_1
  if l_29_2 ~= nil then
    l_29_2 = true
  end
  l_29_0.fadeIn = l_29_2
  if l_29_3 ~= nil then
    l_29_3 = false
  end
  l_29_0.loopingFade = l_29_3
  l_29_0.fading = true
end

l_0_4.Render = function(l_30_0, l_30_1)
  if not l_30_1 then
    local l_30_2, l_30_3 = GuiManager.canvas
  end
   -- DECOMPILER ERROR: Confused about usage of registers!

  DEGuiElement.Render(l_30_0.Image, l_30_2)
end

l_0_4.ToggleAutoRender = function(l_31_0)
  if l_31_0.autorender then
    l_31_0.autorender = nil
  else
    l_31_0.autorender = true
  end
end

l_0_4.Name = "LuaImage"
DeclareClass(l_0_4)

