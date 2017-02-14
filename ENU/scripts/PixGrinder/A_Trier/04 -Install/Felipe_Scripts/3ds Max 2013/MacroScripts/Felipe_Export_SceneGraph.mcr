-------------------------------------------------------------------------------
-- Felipe_Export_SceneGraph.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2014/08/28
-- Version 1.0
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Export_SceneGraph
category:"Felipe Scripts"
toolTip:"Export Scenegraph as text file"
buttonText:"Export Scenegraph"
icon:#("Felipe Scripts",6)
silentErrors:true
autoUndoEnabled:false

(
	try (destroyDialog mychoice) catch ()
	
	myName = substring maxfilename 1 (maxfilename.count-3) +"txt"
	global output_file = ((getSavePath  caption:"Choose the path to save hierarchy file" initialDir:MaxFilePath)+"\\"+myName)
	global output_name = output_file
	global theSep=""

	rollout mychoice "Separator choice"
	(
		
		fn find_kids obj indent =
		(
			format (indent + obj.name + "\n") to:output_file
			for k in obj.children do find_kids k (indent + theSep)
		)
		
		label txt0 "" style_sunkenedge:true width:175 height:55 pos:[15,10]
		label txt1 "Please, enter characters"  pos:[40,20]
		label txt2 "to be used as separator"
		edittext mySep "Separator :" text:";" fieldWidth:50 pos:[50,80]
		button btn "OK" width:100 pos:[50,115]
		
		on btn pressed do 
		(
			theSep = mySep.text
			output_file = createFile output_name
			for obj in objects where obj.parent == undefined do find_kids obj ""
			close output_file
			shellLaunch output_name ""
			destroyDialog mychoice
		)
	)
	createDialog mychoice width:200 height:150
)

----------------------------





