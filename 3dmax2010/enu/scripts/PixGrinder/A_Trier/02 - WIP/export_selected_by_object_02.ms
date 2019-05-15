(
	if (querybox "Please save your scene before exporting. Continue ?") == true do
	(
		global myScene = maxfilepath+maxfilename
		global pda = getCurrentSelection()
		global pda_names = #()
		for i = 1 to pda.count do append pda_names pda[i].name
		i=1
		for i = 1 to pda.count do
		(
				print pda[i].name
				saveNodes pda[i] ("d:\\" + pda[i].name + ".max")
				
		)

		for j = 1 to pda.count do
		(
			loadMaxFile ("d:\\" + pda_names[j] + ".max")
			exportFile ( "d:\\" + pda_names[j] + ".fbx") #noprompt selectedOnly:false using:FBXEXP
		)


		loadMaxFile myScene
	)
)

