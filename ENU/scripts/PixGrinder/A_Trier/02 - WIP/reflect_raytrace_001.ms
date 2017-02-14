pda_ar = #()


for obj in selection do (
		if classof obj.material == StandardMaterial do appendifunique pda_ar obj.material
	
)


for obj in selection do (
		if classof obj.material == Multimaterial do (
			
			for i=1 to obj.material.count do (
				
				if classof obj.material[i] == StandardMaterial do appendifunique pda_ar obj.material[i] 
				
			)
		)
)




for j = 1 to pda_ar.count do (
	pda_ar[j].reflectionMap = Raytrace ()
	pda_ar[j].reflectionMapAmount = 1
)


for j = 1 to pda_ar.count do (
	pda_ar[j].reflectionMap = undefined
	--pda_ar[j].reflectionMapAmount = 10
)

for j = 1 to pda_ar.count do (
	pda_ar[j].selfIllumAmount = 0
)