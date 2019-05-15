-- SelectByModifier --


	(
		modifierName = "Unwrap UVW"
		mySelec = for obj in geometry where obj.modifiers[1] != undefined and obj.modifiers[1].name == modifierName collect obj
		clearSelection()
		select mySelec
	)