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



