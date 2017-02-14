MyAmt = 100

for i = 1 to $.material.count do $.material[i].selfIllumAmount = MyAmt
	


---------------------------------------------------------------

-- Assign unwrap Direct in UV 2

(
	MyChan = 2
	modPanel.addModToSelection (Unwrap_UVW())
	$.modifiers[1].unwrap.setMapChannel MyChan
	$.modifiers[1].unwrap.reset ()
	$.modifiers[1].unwrap.move ()
)