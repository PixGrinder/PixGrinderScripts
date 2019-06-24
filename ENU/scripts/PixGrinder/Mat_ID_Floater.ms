
-- Mat_ID_Floater --
-- pixgrinder@gmail.com --

-- v1.0 --
--------------------------



clearListener()

theMatList = #()

myIds = #()
for i = 1 to getNumFaces selection[1] do appendifUnique myIds (polyop.getFaceMatID selection[1] i)
myIds = for obj in myIds where obj != undefined collect obj
sort myIds

if classof selection[1].material == Multimaterial then
(
	for i = 1 to myIds.count do
	(
		if selection[1].material[myIds[i]].diffuseMap == undefined then 
		(
			append theMatList (myIds[i] as string + " - ")
		) else (
			append theMatList (myIds[i] as string + " - " + (filenameFromPath selection[1].material[myIds[i]].diffuseMap.filename)) 
		)
	)
)



fn selID var1= 
(
	subObjectLevel = 4
	myAr = #{}
	for i = 1 to getNumFaces selection[1] do 
	(
		if polyop.getFaceMatID selection[1] i == var1 then append myAr i

	)
	polyop.setFaceSelection selection[1] myAr
	update selection[1]
)






rollout PDE_Ids "Material IDs" 
(
	Label lbl1 "Set ID :" across:2
	spinner mySet "" range:[1,150,1] type:#integer fieldWidth:50
	button myGetBtn "Select ID" across:2
	spinner myGet "" range:[1,150,1] type:#integer fieldWidth:50 offset:[0,3]
	dropdownlist myDropList "" items:theMatList offset:[3,0] --[selection:<number>] [height:<number>] [tooltip:<string>] 


	on myGetBtn pressed do selID myGet.value

	on mySet changed val do 
	(
		theAr = polyop.getFaceSelection selection[1]
		--theAr
		for fc in theAr do polyop.setFaceMatID selection[1] fc mySet.value
		update selection[1]
	)

	on myDropList selected val do
	(
		selID (myDropList.selected[1] as integer)
	)

)

createDialog PDE_Ids --width:300




/*






myIds = #()
for i = 1 to getNumFaces selection[1] do appendifUnique myIds (polyop.getFaceMatID selection[1] i)
myIds = for obj in myIds where obj != undefined collect obj


polyop.getFaceMatID selection[1] 2


*/



/*


-- for i = 1 to getNumFaces selection[1] do appendIfUnique myIds (polyop.getFaceMatID selection[1] i)
-- for obj in myIds do print obj

for i = 1 to myIds.count do format "% - %\r" i myIds[i]


polyop.setFaceSelection $ #{249..260}

polyop.getFaceSelection $



getFaceMatID <mesh> <face_index_integer>
Returns the indexed face's material ID as an integer.

   

setFaceMatID <mesh> <face_index_integer> <integer>
Sets the indexed face's material ID.


polyop.getFaceMatID $ 2











<index><EditablePoly>.getMaterialIndex <*bool>determined

determined is In and Out parameterReturns the material ID. 

    

<void><EditablePoly>.setMaterialIndex <index>index <DWORD>faceFlagsSet the material ID of the faces specified by the supplied flags. 

    













polyop.setFaceSmoothGroup <Poly poly> <facelist> <int smoothing_group> add:<boolean=false>Sets the smoothing groups for the specified faces. 

The state of each bit in <smoothing_group> specifies whether the face belongs to the corresponding smoothing group. 

If <add> is true , <smoothing_group> is added to the existing smoothing group data specified for each face. 

If <add> is false , the existing smoothing group data is overwritten. 

    

polyop.getFaceSmoothGroup <Poly poly> <int face>Returns the smoothing group data for the specified face as an integer. 

The state of each bit in the result specifies whether the face belongs to the corresponding smoothing group. 

*/
