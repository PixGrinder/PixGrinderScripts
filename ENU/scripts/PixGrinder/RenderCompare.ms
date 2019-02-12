-- Render Compare -- 

bm =  GetLastRenderedImage copy:false --share the bitmap

HiddenDOSCommand ("mkdir " + maxfilepath + "tmp")
bm.filename = maxfilepath + "tmp\\render1.tga"

save bm

rollout myRoll "Youpla"
(
	--bm =  GetLastRenderedImage copy:false --share the bitmap
	bitmap theMap bitmap:bm
	button btnLeft "<-" across:4
	button btnUpdate "Update"
	button btnStore "Store"
	button btnRight "->"

	on btnUpdate pressed do 
	(
		bm =  GetLastRenderedImage copy:false
		HiddenDOSCommand ("mkdir " + maxfilepath + "tmp")
		bm.filename = maxfilepath + "tmp\\render1.tga"
		theMap.bitmap = bm
	)

)

createDialog myRoll bm.width (bm.height+50) 10 10
è_çàuiop7890UIOP