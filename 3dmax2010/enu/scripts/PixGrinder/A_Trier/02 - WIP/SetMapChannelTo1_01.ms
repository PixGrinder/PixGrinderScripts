
-- Ouvrir tous les groupes de la scène
-------------------------------------------
i=1
for i = 1 to 100 do (
	select helpers
	max group open
)
max select none

-------

i=1

for obj in geometry do (
	if classOf obj.material == multimaterial do (
		for i = 1 to obj.material.numsubs do (
			if classOf obj.material[i] != standardmaterial do (obj.material[i].diffusemap.coords.mapChannel=1)
		)
	)
	if classOf obj.material != standardmaterial and classOf obj.material != multimaterial do obj.material.diffusemap.coords.mapChannel=1

)



--------------
for obj in selection do obj.material.diffusemap.coords.mapChannel=1


x1 = getclassInstances StandardMaterial 

x1[2].diffusemap

x1 = for obj in selection collect obj.material

for obj in x1 where obj.diffusemap != undefined do obj.diffusemap.coords.mapChannel = 1

show x1[1].diffusemap.coords.mapChannel