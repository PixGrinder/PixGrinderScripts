macroScript AlignPivotToMin category:"- Gueshni -" Icon:#("g9_alignpivottomin", 1) tooltip:"Align Pivot to Min"
(
	for i in selection do i.pivot.z = i.min.z
)
