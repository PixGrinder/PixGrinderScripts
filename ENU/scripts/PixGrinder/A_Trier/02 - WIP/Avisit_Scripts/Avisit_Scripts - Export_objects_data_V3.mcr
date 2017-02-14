-------------------------------------------------------------------------------
-- Avisit_Scripts - Export_objects_data_V3.mcr
-- MacroScripts File
-- V3.0
-- 2014/10/30
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------


macroScript Export_Objects_Datas
category:"Aicraft Visit Scripts"
toolTip:"Export Datas"
buttonText:"Export Datas"
icon:#("Avisit Scripts",1)
silentErrors:true
autoUndoEnabled:false


(
	try (destroyDialog test) catch ()
	
	myName = substring maxfilename 1 (maxfilename.count-4) +"_data.txt"
	global output_file = ((getSavePath  caption:"Choose the path to save hierarchy file" initialDir:MaxFilePath)+"\\"+myName)
	global output_name = output_file
	global theSep=";"
	global pdax=0

	rollout test "Objects data"
	(
	/*label txt0 "" style_sunkenedge:true width:175 height:55 pos:[15,10]*/
	label txt1 "Please, enter characters"  pos:[40,20]
	label txt2 "to be used as separator"
	edittext mySep "Separator :" text:";" fieldWidth:50 pos:[50,80]

	button btn "OK" width:100 pos:[50,115]
	
	fn round_to val =
	(
	(floor (val + 0.5))
	)
	on btn pressed do 	
	(
		
		clipboardstring="Object Name;Position X;Position Y;Position Z;Rotation X;Rotation Y;Rotation Z;Scale X;Scale Y;Scale Z;Bounding Box;Num verts;Material Type;Material Name;Animation Position;Animation Rotation;Animation Scale;Object Surface;Object Mapping\n"
		theSep = mySep.text
		output_file = createFile output_name	
		for obj in geometry do
			
		(
			clipboardstring += (obj.name+";"+obj.transform.position.x as string) 
			clipboardstring += (";"+obj.transform.position.y as string)
			clipboardstring += (";"+obj.transform.position.z as string)
			clipboardstring += (";"+(round_to (obj.rotation.x_rotation) as integer) as string)
			clipboardstring += (";" + (round_to ((obj.rotation.z_rotation * -1)) as integer) as string)
			clipboardstring += (";" + (round_to (obj.rotation.y_rotation) as integer) as string)
			clipboardstring += (";"+obj.transform.scale.x as string)
			clipboardstring += (";" + obj.transform.scale.y as string)
			clipboardstring += (";" + obj.transform.scale.z as string)
			clipboardstring += (";" + (distance obj.min obj.max) as string)
			clipboardstring += (";" + obj.mesh.numverts as string)
			if obj.material != undefined then
			(
				clipboardstring += (";" + (classof obj.material) as string)
				clipboardstring += (";" + obj.material.name)
			) else (
				clipboardstring += (";No Material")
				clipboardstring += (";No Material")
			)
			------------------------------
			for i = 1 to obj.position.controller.keys.count do
			(
				
			)
			
			----------------------------------
			clipboardstring += (";" + obj.position.controller.keys as string)			
			clipboardstring += (";" + obj.rotation.controller.keys as string)
			clipboardstring += (";" + obj.scale.controller.keys as string)
			pdax = -1			
			if classof obj == Editable_Poly  or classof obj == PolyMeshObject do
			(
				pdax = 0
				for i = 1 to obj.numfaces do
				(
					pdax += polyop.getFaceArea obj i
				)
			)
			if classof obj == Editable_mesh do
			(
				pdax = 0
				for i = 1 to obj.numfaces do
				(
					pdax += meshop.getFaceArea obj i
				)
			)
			--if classof obj != Editable_mesh and classof obj != PolyMeshObject do pdax = 0
			if pdax == -1 then clipboardstring += ("; not measurable") else clipboardstring += (";" + (pdax as string))
			
			clipboardstring += ("\n")
		)
		for obj in helpers do
			
		(
			clipboardstring += (obj.name+";"+obj.transform.position.x as string) 
			clipboardstring += (";"+((obj.transform.position.y) - (obj.transform.position.y) - (obj.transform.position.y)) as string)
			clipboardstring += (";"+obj.transform.position.z as string)
			clipboardstring += (";"+(round_to (obj.rotation.x_rotation) as integer) as string)
			clipboardstring += (";" + (round_to ((obj.rotation.z_rotation * -1)) as integer) as string)
			clipboardstring += (";" + (round_to (obj.rotation.y_rotation) as integer) as string)
			clipboardstring += (";"+obj.transform.scale.x as string)
			clipboardstring += (";" + obj.transform.scale.y as string)
			clipboardstring += (";" + obj.transform.scale.z as string)
			clipboardstring += (";" + (distance obj.min obj.max) as string)
			clipboardstring += ("\n")
		)
			format (clipboardstring as string) to:output_file
			close output_file
			shellLaunch output_name ""
			destroyDialog test
	)


)
createDialog test 200 160 fgcolor:Black
)
