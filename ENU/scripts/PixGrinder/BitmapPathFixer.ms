/*
	rollout myCustPath "Choose Path"
	(
		label theLabel "Choose path to commit bitmaps to" offset:[0,5] align:#center
		edittext thePath text:("..\Textures_Common"+"\\") fieldWidth:250 align:#center offset:[0,5]
		button comitPath "OK" offset:[0,5] width:75
		on comitPath pressed do ATSOps.SetPathOnSelection thePath.text
		--on thePath entered txtTemp do assignPath thePath.text
	)


*/

ATSOps.Visible = true
ATSOps.Refresh()
ATSOps.GetFilesByFileSystemStatus #Missing &Youpla
-- Youpla = Array Of missing Files --

ATSOps.ClearSelection()

-- FileIn "$userScripts/PixGrinder/Reveal_Maxfile_In_Explorer.ms" -- Reveal MaxScene in Windows explorer

ATSOps.Refresh()

clearListener()
for obj in Youpla do format "%; " (filenamefrompath obj)

--createDialog myCustPath 350 100 1024 256

ATSOps.SelectFiles Youpla




/*

select (for obj in objects where matchpattern obj.name pattern:"* *" == true collect obj)


prest.agipi@gieps.fr

*/