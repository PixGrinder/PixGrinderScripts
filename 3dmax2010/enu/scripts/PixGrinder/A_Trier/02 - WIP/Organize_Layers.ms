-------------------------------------------------------------------------------
-- Felipe_Organize_Layers.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2013/09/11
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Organize Layers
category:"Felipe Scripts"
toolTip:"Organize_Layers"

(


	-- Trier les objets dans des calques par type (camera, etc )
	------------------------------------------------------------------

	l0 = layermanager.getLayer 0  -- lo est le layer par défaut

	-----------------------------------------------------------------




	-- Tous les objets hors calque "zz" sont mis en calque défaut
	--------------------------------------------------------------------
	for obj in objects do (
			glurf = obj.layer.name
			if findstring glurf "zz" != 1 do l0.addnode obj
			-- print glurf 
	)
	-----------------------------------------------------------------------




	-- Rangement des bons objets dans les bons layers en fonction du préfixe deleur nom
	---------------------------------------------------------------------------------------------



	(


		cm = layermanager.newLayerFromName "cameras"
		lt = layermanager.newLayerFromName "lights"
		cl = layermanager.newLayerFromName "zz_collisions_zz"
		it = layermanager.newLayerFromName "items"
		dr = layermanager.newLayerFromName "doors"
		tp = layermanager.newLayerFromName "traps"
		st = layermanager.newLayerFromName "structure"
			
		global cm = layermanager.getLayerFromName "cameras"
		global lt = layermanager.getLayerFromName "lights"
		global cl = layermanager.getLayerFromName "zz_collisions_zz"
		global it = layermanager.getLayerFromName "items"
		global dr = layermanager.getLayerFromName "doors"
		global tp = layermanager.getLayerFromName "traps"
		global st = layermanager.getLayerFromName "structure"
			

		global ar_col=#()
		global ar_ite=#()
		global ar_tra=#()
		global ar_doo=#()
		global i = 1
		global ar_cam=#()
		global ar_lit=#()	
			
		for c in cameras do append ar_cam c
		for i =1 to ar_cam.count do cm.addnode ar_cam[i]
		for l in lights do append ar_lit l
		for i=1 to ar_lit.count do lt.addnode ar_lit[i]

		(
		
			for g in objects do (
				if findString g.name "col_" == 1 do (
					append ar_col g
				)	
				if findString g.name "ite_" == 1 do (
					append ar_ite g
				)	
				if findString g.name "tra_" == 1 do (
					append ar_tra g
				)	
				if findString g.name "doo_" == 1 do (
					append ar_doo g
				)	
				
			)
			
			for i = 1 to ar_col.count do cl.addnode ar_col[i]
			for i = 1 to ar_ite.count do it.addnode ar_ite[i]
			for i = 1 to ar_tra.count do tp.addnode ar_tra[i]
			for i = 1 to ar_doo.count do dr.addnode ar_doo[i]
			
			cm.on = false
			cl.on = false
			lt.on = false
			
			for obj in objects do (
				if obj.layer == layermanager.getlayer 0 do st.addnode obj
			)
			
			l0.current = true
		)

	)


	-- supression des calques inutiles
	----------------------------------------


	(

	l_ar = #()

	l0 = layermanager.getLayer 0
	l0.current = true

	for i = 1 to (layermanager.count-1) do (
		x = layermanager.getLayer i
		append l_ar x.name
	)
	for j = 1 to l_ar.count do layermanager.deleteLayerByName l_ar[j]


	)

	-----------------------------------------------------------------------





	-- cacher les calques "zz_"
	---------------------------------

	for i = 1 to (LayerManager.count-1) do (
		pda_tmp = layermanager.getLayer i
		if findstring pda_tmp.name "zz" ==1 do pda_tmp.on = false
	)
		
	-----------------------------------------------------------------------	



)


