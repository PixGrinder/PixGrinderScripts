
-- assign materials with random diffuse color and selfillum à 100
------------------------------------------------------------------------

pda_sph = selection as array

for i = 1 to pda_sph.count do (
	
	macros.run "Medit Tools" "clear_medit_slots"

	--meditMaterials[1].name = pda_sph[i].name
	meditMaterials[1].Diffuse = [random 1 250,random 1 250,random 1 250]
	meditMaterials[1].selfIllumAmount =100
	
	pda_sph[i].material = meditMaterials[1]
	
	
)




