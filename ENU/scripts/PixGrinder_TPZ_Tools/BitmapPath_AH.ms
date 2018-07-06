-- Helicopters Projects - redirect Bitmaps --
-- v2.1 --



(
	pda = getclassInstances bitmaptexture
	
	fn assignPath myPath =
	(
		for i = 1 to pda.count do
		(
			if pda[i].filename != undefined and (getFilenamePath pda[i].filename != myPath) do pda[i].filename = (myPath + "\\"+filenamefrompath pda[i].filename)
		)

	)

	rollout myCustPath "Choose Path"
	(
		label theLabel "Choose path to commit bitmaps to" offset:[0,5] align:#center
		edittext thePath text:("..\..\..\Textures_Common"+"\\") fieldWidth:250 align:#center offset:[0,5]
		button comitPath "OK" offset:[0,5] width:75
		on comitPath pressed do assignPath thePath.text
		on thePath entered txtTemp do assignPath thePath.text
	)

	createDialog myCustPath 350 100 1024 256
)

/*

---------------- MAX 2010 VERSION OK --------------------

(
	pda = getclassInstances bitmaptexture
	
	fn assignPath myPath =
	(
		for i = 1 to pda.count do
		(
			if pda[i].filename != undefined and (getFilenamePath pda[i].filename != myPath) do pda[i].filename = (myPath + "\\"+ (substring pda[i].filename ((getFilenamePath pda[i].filename).count + 1) (pda[i].filename.count - ((getFilenamePath pda[i].filename).count))) )
		)

	)

	rollout myCustPath "Choose Path"
	(
		label theLabel "Choose path to commit bitmaps to" offset:[0,5] align:#center
		edittext thePath text:("..\..\..\Textures_Common"+"\\") fieldWidth:250 align:#center offset:[0,5]
		button comitPath "OK" offset:[0,5] width:75
		on comitPath pressed do assignPath thePath.text
		on thePath entered txtTemp do assignPath thePath.text
	)

	createDialog myCustPath 350 100 1024 256
)





*/