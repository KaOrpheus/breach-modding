-- Decompiled using luadec 2.0 UNICODE by sztupy (http://winmo.sztupy.hu)
-- Command line was: EntityManager.luac 

module("EntityManager", package.seeall)
require("MountEntity")
entities = {}
mountedGuns = {}
AddEntity = function(l_1_0)
  table.insert(EntityManager.entities, l_1_0)
end

HandleDeleteEntity = function(l_2_0)
  local l_2_1 = DGEntityManager.GetEntityByID(l_2_0.Bucket, l_2_0.EntityID)
  EntityManager.RemoveEntity(l_2_1)
end

RecycleEntity = function(l_3_0)
  local l_3_1 = DEEventManager.CreateEvent("DGEventDeleteEntity")
  l_3_1.Bucket = l_3_0:GetBucketID()
  l_3_1.EntityID = l_3_0:GetID()
  DEEventManager.AddEvent(l_3_1, "edel")
  entityNode = l_3_0:GetNode()
  if entityNode then
    if entityNode:GetParent() then
      entityNode:GetParent():RemoveChild(entityNode)
    else
      DGGameView.GetScene():RemoveNode(entityNode)
    end
  end
end

AddMountedGun = function(l_4_0, l_4_1)
  for l_4_5,l_4_6 in pairs(EntityManager.mountedGuns) do
    if l_4_0 == l_4_6.BucketID and l_4_1 == l_4_6.EntityID then
      print("failure adding mounted weapon " .. tostring(l_4_0) .. ":" .. tostring(l_4_1) .. " to entity manager: already exists")
      return 
    end
  end
  local l_4_7, l_4_9 = DGEntityManager.GetEntityByIndex(l_4_0, l_4_1)
  if l_4_7 then
    l_4_9 = type
    l_4_9 = l_4_9(l_4_7)
    if l_4_9 == "<DGMountEntity>" then
      l_4_9 = new
      l_4_9 = l_4_9("MountEntity")
       -- DECOMPILER ERROR: Confused at declaration of local variable

      l_4_9:AttachMG(l_4_7)
      l_4_9:SetIDs(l_4_0, l_4_1)
      table.insert(EntityManager.mountedGuns, l_4_9)
      print("mounted weapon " .. tostring(l_4_0) .. ":" .. tostring(l_4_1) .. " added to entity manager")
    else
      print("failure adding mounted weapon " .. tostring(l_4_0) .. ":" .. tostring(l_4_1) .. " to entity manager: not DGMountEntity")
    end
  else
    print("failure adding mounted weapon " .. tostring(l_4_0) .. ":" .. tostring(l_4_1) .. " to entity manager: nil entity")
     -- DECOMPILER ERROR: Confused about usage of registers for local variables.

  end
end

RemoveEntity = function(l_5_0)
  for l_5_4,l_5_5 in pairs(EntityManager.entities) do
    if l_5_0 == l_5_5.entity then
      EntityManager.entities[l_5_4] = nil
    end
  end
end

RemoveMountedGun = function(l_6_0)
  for l_6_4,l_6_5 in pairs(EntityManager.mountedGuns) do
    if l_6_0 == l_6_5 then
      EntityManager.mountedGuns[l_6_4] = nil
      print("mounted weapon " .. l_6_4 .. " removed from the entity manager")
    end
  end
end

Update = function()
  for l_7_3,l_7_4 in pairs(EntityManager.entities) do
    l_7_4:Update(gDT)
  end
  for l_7_8,l_7_9 in pairs(EntityManager.mountedGuns) do
    l_7_9:Update()
  end
end

Reset = function()
  ScriptManager.UnregisterUpdateFunction("entman", EntityManager.Update)
  EntityManager.entities = {}
  EntityManager.mountedGuns = {}
  ScriptManager.RegisterUpdateFunction("entman", EntityManager.Update)
end

ScriptManager.RegisterUpdateFunction("entman", Update)
ScriptManager.RegisterEventHandler("Unloading", "ScriptManager", Reset)
DEEventManager.SubscribeEvent("DGEventDeleteEntity", HandleDeleteEntity, "edel")

