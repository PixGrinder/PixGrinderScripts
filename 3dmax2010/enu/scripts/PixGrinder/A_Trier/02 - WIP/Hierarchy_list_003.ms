(
	local output_file, output_name = "c:\\hierarchy.txt"
	
	fn find_kids obj indent =
	(
		format (indent + obj.name + "\n") to:output_file
		for k in obj.children do find_kids k (indent + "	")
	)

	output_file = createFile output_name
	for obj in objects where obj.parent == undefined do find_kids obj ""
	close output_file
	shellLaunch output_name ""
)

----------------------------

(
try (destroyDialog mychoice) catch ()

rollout mychoice "Separator choice"
(
	label txt0 "" style_sunkenedge:true width:175 height:55 pos:[15,10]
	label txt1 "Please, enter characters"  pos:[40,20]
	label txt2 "to be used as separator"
	edittext mySep "Separator :" fieldWidth:50 pos:[50,80]
	button btn "OK" width:100 pos:[50,115]
	
	on btn pressed do 
	(
		destroyDialog mychoice
	)
	
)
createDialog mychoice width:200 height:150
)
