-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: MasterTags.luac 

module("MasterTags", package.seeall)
require("InGameGraphEditor")
_G.ReloadTags = function()
  rerequire("MasterTags")
end

InGameGraphEditor.RegisterTag("PrefabEntryway")
InGameGraphEditor.RegisterTag("LeftPeekDesignBlock")
InGameGraphEditor.RegisterTag("RightPeekDesignBlock")
InGameGraphEditor.RegisterTag("MinCrouchCoverByDesign")
InGameGraphEditor.RegisterTag("graphname", "scenario")
InGameGraphEditor.RegisterTag("ftrail")

