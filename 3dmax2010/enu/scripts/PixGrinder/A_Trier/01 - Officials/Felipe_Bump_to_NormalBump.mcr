
-------------------------------------------------------------------------------
-- Felipe_Bump_to_NormalBump.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2013/06/20
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Bump_to_NormalBump
category:"Felipe Scripts"
toolTip:"Bump To NormalBump"
buttonText:"Bump To N-Bump"
--icon:#("Felipe Scripts",11)
silentErrors:true
autoUndoEnabled:true

(

for pda_obj in selection do (
	if (classOf pda_obj.material == standard ) and (classOf pda_obj.material.bumpmap == Bitmaptexture)  then (
		pda_bmp= pda_obj.material.bumpmap
		pda_obj.material.bumpmap=Normal_Bump ()
		pda_obj.material.bumpmap.Normal_map = pda_bmp
		pda_obj.material.bumpmap.method = 3
		pda_obj.material.bumpMapAmount=100
	)
)

for pda_obj in selection do (
		if (classOf pda_obj.material== MultiMaterial ) do (
			for pda_j = 1 to pda_obj.material.numsubs do (
				if (classOf pda_obj.material[pda_j]== standard ) and (classOf pda_obj.material[pda_j].bumpmap == Bitmaptexture)  then (
				pda_bmp = pda_obj.material[pda_j].bumpmap
				pda_obj.material[pda_j].bumpmap=Normal_Bump ()
				pda_obj.material[pda_j].bumpmap.Normal_map = pda_bmp
				pda_obj.material[pda_j].bumpmap.method = 3
				pda_obj.material[pda_j].bumpMapAmount=100
			)
		)
	)
)


)
