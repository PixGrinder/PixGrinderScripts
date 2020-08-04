-- select Isolated Materials --
(
	clearSelection()
	select (for obj in geometry where obj.material != meditmaterials[1] collect obj)
	max hide inv
)