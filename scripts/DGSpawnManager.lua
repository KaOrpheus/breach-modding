-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: DGSpawnManager.luac 

module("DGSpawnManager", package.seeall)
local l_0_0 = DGSpawnManager.Spawn
Spawn = function(l_1_0, l_1_1, l_1_2, l_1_3)
  if assetWhiteList then
    warn(assetWhiteList[string.lower(l_1_0) .. ".whu"], "Spawning non-whitelisted asset: " .. l_1_0)
  end
  local l_1_4 = l_0_0
  local l_1_5 = l_1_0
  local l_1_6 = l_1_1
  local l_1_7 = l_1_2
  local l_1_8 = l_1_3
  return l_1_4(l_1_5, l_1_6, l_1_7, l_1_8)
end


