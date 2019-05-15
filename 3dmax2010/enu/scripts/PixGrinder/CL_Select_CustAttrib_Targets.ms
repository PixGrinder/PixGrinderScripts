-- CL - Select Custom Attributes Targets --
-- Selects all Components hidden + transp objects --

(
	select (for obj in objects where CustAttributes.count obj == 1 collect obj)

	clResult = #()

	for obj in selection do
	(
		for hid in obj.compLoc.hidden do appendIfUnique clResult hid.node
		for tra in obj.compLoc.transparent do appendIfUnique clResult tra.node
	)

	clearSelection()

	select clResult
)

--------------------------
/*


Structure_ATA_H255_Text190
Structure_ATA_H255_Text191


*/