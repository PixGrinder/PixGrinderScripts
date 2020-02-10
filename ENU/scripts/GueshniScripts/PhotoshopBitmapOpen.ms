-- Title     :  Photoshop Bitmap Open
--
--              Opens all bitmaps that are assigned to a selected objects 
--
-- Author    : Colin Bamber
-- Version   : 1.1
-- Changes   :	Added function to select location of Photoshop 
-- Homepage  : www.colinbamber.com

-- Details	: 	When first run the script will ask you for the location of Photoshop;  which it then stores in 3dmax.ini.
--				if Photoshop is moved the script will ask you to reconfirm the location.
--				When pressed Photoshop is launched and bitmaps on selected object are opened.
---------------------------------------------------------------------------------------------
(
	
 local theMats = #() 
 local ps = getIniSetting (getMAXIniFile()) "photoshop" "path"
 

 fn getSubAnims theParent = (
 	for i = 1 to theParent.numsubs do ( 
 		append theMats theParent[i]
 		try(getSubAnims theParent[i].object)catch(getSubAnims theParent[i])
 	)
 )
 

 theMats = for o in selection where o.material != undefined collect o.material
 for m in theMats do getSubAnims m 
 local theTextures = #() 
 for o in theMats where 
 	hasProperty o "filename" and findItem theTextures o.filename == 0 do 
 		append theTextures o.filename 
 
 if ps == "" do
	(
	local ps = getOpenFileName caption:"Please locate Photoshop.exe" filename:"C:\Program Files\Adobe\Adobe Photoshop CC 2018/Photoshop.exe" types:"Executable Files(*.exe)|*.exe"
	if ps != undefined do setINISetting (getMAXIniFile()) "photoshop" "path" ps
	)

	
for t in theTextures do (

if ps != undefined AND doesFileExist ps then
(
	shelllaunch ps ("/open " + t)
	print ps
	print t
)
else
	(
	delINISetting (getMAXIniFile()) "photoshop" "path"
	messagebox "Photoshop could not be found"
	)
 )
 )
