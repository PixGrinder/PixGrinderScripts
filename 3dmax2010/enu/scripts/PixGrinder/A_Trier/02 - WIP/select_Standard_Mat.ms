(
	mySel = for obj in selection where classof obj.material == StandardMaterial collect obj
	select mySel
)