(
-- 	try 
-- 	(
	myPb = for obj in objects where custAttributes.count obj != 0 and obj.compLoc.hotspot == undefined collect obj
-- 	) catch ()
	select myPb
)


for obj in selection do print obj.name
