-------------------------------------------------------------------------------
-- Felipe_Uncheck_Self_Illum.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2013/02/12
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Uncheck_Self_Illum
category:"Felipe Scripts"
toolTip:"Unchecks Self illum on all standard materials"

(
i=1
pda_std = #()
for i=1 to sceneMaterials.count do (
	if classOf sceneMaterials[i] == standard do appendifUnique pda_std sceneMaterials[i]
)

pda_mult = #()

i=1
for i=1 to sceneMaterials.count do (
	if classOf sceneMaterials[i] == Multimaterial do appendifUnique pda_mult sceneMaterials[i]
)

for i=1 to pda_std.count do pda_std[i].useSelfIllumColor = off
	
i=1
j=1
for i=1 to pda_mult.count do (
	for j=1 to pda_mult[i].numsubs do(
		if classOf pda_mult[i][j] == Standardmaterial do (
		pda_mult[i][j].useSelfIllumColor = off
		)
		
	)
)

	


)