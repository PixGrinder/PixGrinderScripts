 (
	objToIntersect = undefined

rollout ConformVertRollout "Conform vertices" width:160 height:80
(
	groupBox grp1 "Parameters" pos:[5,5] width:150 height:70
	pickButton PickBtn "Pick mesh to conform" pos:[10,25] width:140 height:20 enabled:true message:"Pick mesh to intersect" toolTip:"Pick mesh to intersect"
	button GenBtn "Conform Vertices" pos:[10,50] width:140 height:20 toolTip:"Conform vertices on picked mesh"
	
	on PickBtn picked pickedObj do
	(
		if superclassof pickedObj != GeometryClass then
		(
			pickedObj = undefined
			PickBtn.text = "Invalid Node"
		)
		elseq
		(
			objToIntersect = pickedObj
			PickBtn.text = objToIntersect.name
		)
	)
	
	on GenBtn pressed do
	(
		objSel = selection[1]
		if superclassof objSel == GeometryClass and objToIntersect != undefined do
		(
			convertToPoly objSel
			VerticesSel = polyop.getVertSelection objSel as array
			for vertex in VerticesSel do
			(
				l_ray = ray objSel.verts[vertex].pos [0,0,-1]
				l_ir = intersectRay objToIntersect l_ray
				if l_ir != undefined then
					objSel.verts[vertex].pos.z = l_ir.pos.z
				else
					objSel.verts[vertex].pos.z = objSel.verts[vertex].pos.z +10
			)
		)
	)
)

createdialog ConformVertRollout pos:[140,210] bgcolor:(color 84 101 120)
)