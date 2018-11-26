-- FBX Anim Export --

clearListener()
myAnimList = #()
myErrors = #()

fn mySort v1 v2 =
(
	if v1.name > v2.name then 1 else -1
)


-- get animated objects -- 
myAnims = for obj in objects where obj.isAnimated and classof obj.controller == prs collect obj
myProblems = for obj in objects where obj.isAnimated and classof obj.controller != prs collect obj.name
qsort myAnims mySort

-- list of animated objects (name, start, end) --

for obj in myAnims do 
(
	theKeys = #()
	--print obj.name
	--select obj
	if numKeys obj.position.controller > 0 do for p in obj.position.controller.keys do append theKeys p.time
	if numKeys obj.rotation.controller > 0 do for r in obj.rotation.controller.keys do append theKeys r.time
	if numKeys obj.scale.controller > 0 do for s in obj.scale.controller.keys do append theKeys s.time

	if numKeys obj.position.controller == -1 then appendifunique myErrors obj.name
	if numKeys obj.rotation.controller == -1 then appendifunique myErrors obj.name
	if numKeys obj.scale.controller == -1 then appendifunique myErrors obj.name
	
	if theKeys.count > 1 then 
	(
		sort theKeys
		append myAnimList (obj.name + "; " + ((theKeys[1] as integer / 160) as string) + "; " + ((theKeys[theKeys.count] as integer / 160) as string)) 
		--format "%; %; %\r" obj.name ((theKeys[1] as integer / 160) as string) ((theKeys[theKeys.count] as integer / 160) as string)
		--format "$\r" obj.name
		--format "%; %\r" ((theKeys[1] as integer / 160) as string) ((theKeys[theKeys.count] as integer / 160) as string)
	)
)
for txt in myAnimList do format "%\r" txt
format "\r\r"

if myProblems.count > 0 then 
(
	Format "Problems : \r"
	Format "----------\r"
	for obj in myProblems do format "%\r" obj
	format "\r\r"
)

if myErrors.count > 0 then 
(
	Format "Wrong controller type : \r"
	Format "-----------------------\r"
	for obj in myErrors do format "%\r" obj
	format "\r\r"
)



actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener

--myAnims
/*  

-- TESTS 
myAnimList.count
	theKeys = #()
	for p in $.pos.controller.keys do append theKeys p.time
	for r in $.rotation.controller.keys do append theKeys r.time
	for s in $.scale.controller.keys do append theKeys s.time
	sort theKeys


theKeys[1] as integer / 160


$.pos.controller.keys[1]
$.pos.controller.keys[1] as integer
for k in $.pos.controller.keys do print k.time


*/