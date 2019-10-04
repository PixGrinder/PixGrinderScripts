-- FBX Anim Export --

clearListener()
myAnimList = #()

fn mySort v1 v2 =
(
	if v1.name > v2.name then 1 else -1
)

-- get animated objects -- 
myAnims = for obj in objects where obj.isAnimated and classof obj.controller == prs collect obj
myProblems = for obj in objects where obj.isAnimated and classof obj.controller != prs collect obj.name -- check for uncommon anim controllers
qsort myAnims mySort

-- Lists keys by animated objects -- 
i=1
for obj in myAnims do 
(
	
	print (i + obj.name)
	theKeys = #()
	if numKeys obj.position.controller > 0 do for p in obj.position.controller.keys do append theKeys p.time
	if numKeys obj.rotation.controller > 0 do for r in obj.rotation.controller.keys do append theKeys r.time
	if numKeys obj.scale.controller > 0 do for s in obj.scale.controller.keys do append theKeys s.time
	sort theKeys
	append myAnimList (obj.name + "; " + ((theKeys[1] as integer / 160) as string) + "; " + ((theKeys[theKeys.count] as integer / 160) as string)) 
	i = i+1
)

-- Print section --
for txt in myAnimList do format "%\r" txt
format "\r\r"
if myProblems.count > 0 then 
(
	Format "Problems : \r"
	for obj in myProblems do format "%\r" obj
	format "\r\r"
)
actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener