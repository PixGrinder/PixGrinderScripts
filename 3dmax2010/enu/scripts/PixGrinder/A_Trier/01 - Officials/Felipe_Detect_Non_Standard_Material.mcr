
-------------------------------------------------------------------------------
-- Felipe_Detect_Non_Standard_Material.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2013/06/21
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Felipe_Detect_Non_Standard_Material
category:"Felipe Scripts"
toolTip:"Detect Non Standard Material"
buttonText:"Select Inv Std Mat"
--icon:#("Felipe Scripts",11)
silentErrors:true
autoUndoEnabled:true

(


-- Ouvrir tous les groupes de la scène
-------------------------------------------
i=1
for i = 1 to 100 do (
	select helpers
	max group open
)
max select none

-------

pda_temp = #()
i=1

for obj in geometry do (
	if classOf obj.material == multimaterial do (
		for i = 1 to obj.material.numsubs do (
			if classOf obj.material[i] != standardmaterial do (append pda_temp obj)
		)
	)
	if classOf obj.material != standardmaterial and classOf obj.material != multimaterial do appendifunique pda_temp obj

)

select pda_temp

)