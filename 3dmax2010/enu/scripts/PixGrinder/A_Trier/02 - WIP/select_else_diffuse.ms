-- obj = $

(

	pda=#()

		for obj in objects do 
		(
			if classof obj.material.diffusemap != Bitmaptexture do appendifunique pda obj
			if obj.material.bumpmap != undefined do appendifunique pda obj

		)
	select pda
)