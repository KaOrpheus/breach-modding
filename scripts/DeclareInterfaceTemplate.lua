-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: DeclareInterfaceTemplate.luac 

module("Interface", package.seeall)
require("ScriptingUtility")
local l_0_0 = {}
l_0_0.ImplementMe = function(l_1_0, l_1_1, l_1_2)
end

l_0_0.ImplmentMeToo = function(l_2_0)
  print("Don't forget me!")
end

l_0_0.Name = "Interface"
DeclareInterface(l_0_0)

