
	
pda = getClassInstances Standardmaterial
	
for i = 1 to pda.count do pda[i].reflectionMapEnable = off
	

------------



show Standardmaterial
show scenematerials[1]




pda = getClassInstances Standardmaterial
for i = 1 to pda.count do 
(
	if pda[i].diffusemap != undefined do (
		showTextureMap pda[i] pda[i].diffusemap on
		)
)