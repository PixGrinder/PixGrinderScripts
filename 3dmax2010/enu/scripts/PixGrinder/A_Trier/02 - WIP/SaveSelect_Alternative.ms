
-- Alternative to 3dsmax save selected command

(
	mySel = selection as array
	x1 = for sel in mySel where sel.parent == undefined or sel.parent.isHidden == true collect sel
	for obj in x1 do x1[1].parent = undefined
	
	thePath = getSaveFileName  filename:((GetDir #scene)+"\\" + "a.max") types:"MaxFile|*.max"
	select x1
	gc()
	sleep 1
	savenodes x1 thePath
)