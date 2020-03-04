-- Multimat_On_One_Mesh.ms --

if selection.count < 1 then messageBox ("Please select 1 object with the multimaterial") else
(
	meditmaterials[1] = selection[1].material
	meditmaterials[1].materialIDList
	myCount = meditmaterials[1].materialIDList.count

	myPlane = plane pos:[0,0,-1] width:0.1 length:0.1 lengthsegs:1 widthsegs:1 name:"Nuancier"
	select myPlane

	convertToMesh myPlane

	meshop.extrudeEdges myPlane #{4} 0.1 dir:[1,0,0]
	update myPlane

	for i = 1 to (myCount-2) do
	(
		meshop.extrudeEdges myPlane #{myPlane.selectedEdges[1].index} 0.1 dir:[1,0,0]
		update myPlane
	)

	convertToPoly myPlane
	myPlane.material = meditmaterials[1]

	polyop.setFaceSelection myPlane #{43}
	update myPlane

	for i = 1 to myCount do polyop.setFaceMatID myPlane #{i} meditmaterials[1].materialIDList[i]
	update myPlane
)