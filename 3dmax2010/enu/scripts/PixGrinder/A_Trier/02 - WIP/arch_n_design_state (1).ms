pda_state = on


for obj in objects do (
	if classOf obj.material == Arch___Design__mi do (
		obj.material.refl_interp = pda_state
		obj.material.refl_hlonly = pda_state
	)
)

for obj in objects do (
	if classOf obj.material == Multimaterial do (
		for i = 1 to obj.material.numsubs do (
			obj.material[i].refl_interp = pda_state
			obj.material[i].refl_hlonly = pda_state
		)
		
	)
)
