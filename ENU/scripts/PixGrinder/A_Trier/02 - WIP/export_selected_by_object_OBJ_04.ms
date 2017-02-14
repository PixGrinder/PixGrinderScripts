-- Exporteur par objet -- FBX sa mère !!!
-- Exporter FBX

(
	if (querybox "Please save your scene before exporting. Continue ?") == true do
	(
		global myScene = maxfilepath+maxfilename
		global pda = getCurrentSelection()
		global pda_names = #()
		global x1
		global y1
		for i = 1 to pda.count do append pda_names pda[i].name
		i=1
		for i = 1 to pda.count do
		(
				print pda[i].name
				x1 = pda[i].position ------- UE4
				y1 = pda[i].rotation ------- UE4
				pda[i].position = [0,0,0] ------- UE4
				pda[i].rotation = (quat 0 0 0 0)
				saveNodes pda[i] ("D:\TEMP\H135\\" + pda[i].name + ".max")
				pda[i].position = x1 ------- UE4
				pda[i].rotation = y1 ------- UE4
		)

		for j = 1 to pda.count do
		(
			loadMaxFile ("D:\01 - Work\Recherche Emploi\ArrowHead\Livraison\05_Models_Textures\\" + pda_names[j] + ".max")
			--exportFile ( "D:\01 - Work\Recherche Emploi\ArrowHead\Arrowhead_Unity\Assets\Props\\" + pda_names[j] + ".fbx") #noprompt selectedOnly:false using:FBXEXP
			exportFile ( "D:\01 - Work\Recherche Emploi\ArrowHead\Livraison\05_Models_Textures\\" + pda_names[j] + ".obj") #noprompt selectedOnly:false using:ObjExp
		)


		loadMaxFile myScene
	)
)

-- exporterPlugin.classes 


