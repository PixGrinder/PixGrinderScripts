global pda_ar = #()





for obj in geometry do
(
	if classof obj.material == Standardmaterial do
	(
		if obj.material.opacity != 100 do appendifunique pda_ar obj
		
	)

)

delete pda_ar

pda_ar = #()


for obj in geometry do
(
	if classof obj.material == multimaterial do
	(
		for i = 1 to obj.material.count do 
		(
			if classof obj.material[i] == standardmaterial do
			(
				if obj.material[i].opacity != 100 do appendifunique pda_ar obj
			)
				
		)
	)

)
select pda_ar
