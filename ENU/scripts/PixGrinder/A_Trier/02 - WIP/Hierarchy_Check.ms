-- Hierarchy Check

myObjects = (for obj in objects where obj.isHidden == off collect obj)

myErrors = (for obj in myObjects where (obj.parent != undefined) and (obj.parent.layer.name != obj.layer.name) collect obj)

clearListener()

actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener

for obj in myErrors do format "%\r" obj.name

