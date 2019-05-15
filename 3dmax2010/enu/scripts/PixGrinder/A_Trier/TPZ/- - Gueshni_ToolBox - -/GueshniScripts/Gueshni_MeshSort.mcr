macroScript MeshSort category:"- Gueshni -" Icon:#("g9_meshsort", 1) tooltip:"Mesh Sort"
 ( fn DeleteFacedown  =
(
	Selected = #()
	if selection[1] != undefined do (for i in 1 to selection.count do (append  Selected selection[i] ))
	 if Objectalti != undefined then 
			( 
				for o in 1 to Selected.count do
						(
								altivertX Selected[o] Objectalti LSTVerts
								--selection[o].selectedVerts = LSTverts
								Selected[o].EditablePoly.ConvertSelection #Vertex #Element
							
								if Deletetype == 2  do (foretFacesSelect Selected[o])
								if inv == true do (invertSelFaces Selected[o])
								if del == true do (Selected[o].EditablePoly.delete #Face)
						)
			)
	else (Messagebox "No assigned alti Object !!!")
)


fn altivertX baseObject altiObject VertLST =
	(
		VertLST = #{}
		convertTo altiObject PolyMeshObject
		convertTo baseObject PolyMeshObject
		for v in 1 to baseObject.numverts do 
			(
				alti = intersectRay  altiObject  (ray (baseObject.verts[v].pos) [0,0,-1])
				if alti != undefined then(append VertLST v)
				else()
			)
		baseObject.selectedVerts = VertLST 
	)
	

fn foretFacesSelect OBj  =
	(
		oldeLST = #{}
		a = (polyop.getFaceSelection OBj) as array
		for l in 1 to a.count do
			(
				if  (mod a[l] 2) as integer ==  1 then 	 ( append oldeLST a[l]; append oldeLST ( a[l]+1) )
				else if  (mod  a[l] 2) as integer ==  0 then ( append oldeLST a[l]; append oldeLST ( a[l]-1)	)	
				else()
			)
		polyop.setFaceSelection OBj oldeLST
	)

fn invertSelFaces obj =
		(
		--	m = (polyop.getFaceSelection obj) as array
			select obj
		subobjectLevel = 4
		max select invert
		subobjectLevel = 0	
		)

		

try(destroydialog delmeshLow)catch()
--************************* VARS ***********************
global Objectalti = undefined
global Deletetype = 1
global LSTVerts  = #{}
global del, inv
global Selected = #()
global altiObj
del = true
inv = false

rollout delmeshLow "MeshSort"
(
group "Mesh Parameters"
	(
	radiobuttons opt1 labels:#("SimpleMesh","Cross (Forest)")
	checkbox delelMesh "Delete Mesh" checked:true  
	checkbox invMesh "Invert Mesh" checked:false 
	)
group "Ref object"
	(
		label altiname "..."
	pickbutton meshalti " Choisir"	 width:50 height:30	across:2
	button meshaltiList   width:38 height:30 align:#right images:#("Maintoolbar_24i.bmp","Maintoolbar_24a.bmp",102,19,19,19,19)
	)
	
	button exec "EVALUATE" width:100 height:30
	
	on opt1 changed value do 
		(
		case value of
			(
			1: (Deletetype = 1; print (Deletetype as string))
			2:	(Deletetype = 2; print (Deletetype as string))
			)
		)
		
	on invMesh changed value do (if value == true then (inv = true ) else (inv = false))
	on delelMesh changed value do (if value == true then (del = true ) else (del = false))	
		
	on meshalti picked ObjAlti do 
		(
		if Superclassof ObjAlti != GeometryClass  then (Messagebox " domage")
		else (altiname.text = ObjAlti.name; Objectalti = getnodebyname altiname.text)
		)
	on meshaltiList pressed do 
		(
			fn Poly_filt obj = isKindOf obj GeometryClass
			altiObj = "caca"
		)
		
	on exec pressed do 	(try( DeleteFacedown())catch() )
)

createdialog delmeshLow 115 220
)