
-------------------------------------------------------------------------------
-- Felipe_Detect_Non_Standard_Material.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2013/06/21
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Felipe_Detect_Non_Standard_Material
category:"Felipe Scripts"
toolTip:"Detect Non Standard Material"

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