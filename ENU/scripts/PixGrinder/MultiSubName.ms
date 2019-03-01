-- MultiSubName -- 

matNames = #()

for obj in selection do 
( 
	if classof obj.material == multimaterial then
	(
		for i = 1 to obj.material.count do 
		(
			if obj.material[i].diffuseMap != undefined and classof obj.material[i].diffuseMap == Bitmaptexture then
			(

			)
		)
	)
)


if classof obj.material == multimaterial then

/*

classof $.material[1].diffuseMap == 

*/