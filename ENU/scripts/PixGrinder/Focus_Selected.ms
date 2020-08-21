-- Focus Selected -- 
(
	mySel = selection as Array
	clearSelection()
	max hide inv
	mySel.isHidden = off
	select mySel
	max zoomext sel
	ForceCompleteRedraw()
)