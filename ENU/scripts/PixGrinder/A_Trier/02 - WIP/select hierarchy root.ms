-- select hierarchy root
(
	x = GetCurrentSelection()
	x = x[1]
	while x.parent != undefined do x=x.parent
	select x
)

