-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: DeclareAbstractClassTemplate.luac 

module("AbstractClass", package.seeall)
require("ScriptingUtility")
local l_0_0 = {}
l_0_0.Abstract = {}
l_0_0.Name = "AbstractClass"
l_0_0.Extends = "Object"
local l_0_1 = {}
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1.IAmAbstract, l_0_1, l_0_0.Implements = "LotsOfInterfaces", l_0_0.Abstract, l_0_1
l_0_1 = l_0_0.Abstract
l_0_1.DescribeMe = function(l_2_0)
  print("I cannot be instantiated, only extended.")
end

l_0_1 = function(l_3_0)
  print("But my concrete functions will work!")
end

l_0_0.Concrete = l_0_1
l_0_1 = function(l_4_0)
  print("Don't forget to pass in self")
end

l_0_0.Concrete2 = l_0_1
l_0_1 = DeclareAbstractClass
l_0_1(l_0_0)

