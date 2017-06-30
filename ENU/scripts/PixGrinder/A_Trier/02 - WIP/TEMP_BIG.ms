

x1 = for obj in objects where obj.isHidden == false and matchpattern obj.name pattern:"ATA_??-??_*" == true collect obj
clearListener()
for obj in x1 do format "%\r" obj.name

----------------------------------------------



-- Copier le nom de l'objet dans le presse papiers de windows
setclipboardText $.name



----------------------------------------------

(

	theItems = for obj in objects where matchpattern obj.name pattern:"ATA_??-??_*"== true collect obj
	clearSelection()
	select theItems

)

----------------------------------------------

x1 = "D:\\10 - Helicopters\\H225VMT\\CAO\\2017-05-24_3D\\H225-Package 8 -24_05_2017\\"
x2 = getfiles (x1+"*.max")
for obj in x2 do format (filenamefromPath obj + "\r")

----------------------------------------------


(
	--for obj in geometry do convertToPoly obj
	myStart = 1
	j = 1
	thePolys = for obj in geometry where classof obj == Editable_Poly collect obj
-- 	while (polyop.getNumFaces thePolys[j]) < 60000 do
-- 	(
-- 		myStart = j
-- 		j=j+1
-- 	)
	if (polyop.getNumFaces thePolys[j]) < 10000 then myStart = j  else myStart = j+1
	pda = for i = myStart to (myStart+100) collect thePolys[i]
	-- select pda[1]
	for i = 2 to pda.count do polyop.attach pda[1] pda[i]

)


----------------------------------------------

(
	thePolys = for obj in geometry where classof obj == Editable_Poly collect obj
	a = thePolys.count
	while polyop.getNumFaces thePolys[a] > 10000 do a = a-1
	for i =1 to 100 do
	(
		
		polyop.attach thePolys[a] thePolys[i]
	)

	messagebox ("Name : "+thePolys[a].name+"\rFaces : "+polyop.getNumFaces thePolys[a] as string)

)

----------------------------------------------

_pixGrinderLib.NmDisplay



for obj in objects where matchpattern obj.layer.name pattern:"CAO_ATA_H225_21_COCKPIT_with_ACS_secured" == true do delete obj


----------------------------------------------

(
	x1 = for obj in geometry where obj.material == undefined collect obj
	clearSelection()
	select x1
)

----------------------------------------------

(
clearListener()
for obj in selection do format (obj.name + "\r")
)


----------------------------------------------

x1 = getFiles "D:\10 - Helicopters\H225VMT\MAX\CAO\*.max"
for obj in x1 do format (fileNameFromPath obj + "\r")


----------------------------------------------

clearListener()
for obj in objects where obj.parent != undefined do print obj.name


----------------------------------------------

	rollout SplineTools "SplineTools"
	(
		button btn1 "" width:27 height:27 pos:[5,5] images:#("Splines_24i.bmp", "Splines_24a.bmp", 11, 11, 1,1,1) tooltip:"CableRetopology"
		
		on btn1 pressed do macros.run "-- PixGrinder --" "CableRetopology"
	)


-- 	global pixGrindWindow = newRolloutFloater "PixGrinder Tools" 50 50 100 100 
-- 	addRollout systm pixGrindWindow 

createDialog SplineTools 120 34 760 250 style:#(#style_titlebar, #style_border, #style_toolwindow, #style_resizing, #style_sysmenu)
-- 	destroyDialog systm
-- global pixGrindWindow = undefined


cui.RegisterDialogBar SplineTools






x1 = cui.getConfigFile()
format x1

cui.setAppTitle maxfilename

--------------------------------------------

move selection [0.0,0.0,9.75]

--------------------------------------------

getDir #scene

--------------------------------------------

for obj in $.compLoc.hidden do print obj.node

$.compLoc.hidden[5].node
deleteItem $.compLoc.hidden 5

clearListener()
for obj in $.compLoc.transparent do print obj.node

$.compLoc.transparent[2].node
deleteItem $.compLoc.transparent 2

--------------------------------------------

custAttributes.get selection[1] 1 != undefined



--------------------------------------------
$.compLoc.Hidden.count
-- Comploc auto add nodes
(
	clearListener()
	mySort = for obj in selection where custAttributes.get obj 1 != undefined collect obj
	mySelec = #()
	theNode1 = getNodeByName "ATA_53-50_TransmissionDeckCowlings_RH_sub28"
	theNode2 = getNodeByName "ATA_53-50_TransmissionDeckCowlings_LH_sub28"
-- 	theNode3 = getNodeByName "ATA_53-50_TransmissionDeckCowlings_07"
-- 	theNode4 = getNodeByName "ATA_53-50_TransmissionDeckCowlings_06"


	for obj in mySort do
	(

		for attrib in obj.compLoc.hidden do
		(
			if matchpattern attrib.node.name pattern:"*TransmissionDeckCowling*" == true do append mySelec obj
		)

	)

	for obj in mySelec do appendifunique obj.CompLoc.hidden (nodeTransformMonitor node:theNode1 forwardTransformChangeMsgs:false)
	for obj in mySelec do appendifunique obj.CompLoc.hidden (nodeTransformMonitor node:theNode2 forwardTransformChangeMsgs:false)
-- 	for obj in mySelec do append obj.hidden (nodeTransformMonitor node:theNode3 forwardTransformChangeMsgs:false)
-- 	for obj in mySelec do append obj.hidden (nodeTransformMonitor node:theNode4 forwardTransformChangeMsgs:false)
-- 	max hide inv
-- 	select mySelec
)

$.compLoc.Hidden.count




for obj in selection[1].compLoc.hidden do print obj.node

$.compLoc.Hidden.count

select mySelec


-----------------------------------------------------------------------------

-- ForceUpdate Bitamp 2v --

obj = selection[1]
if classof obj.material == standardmaterial and obj.material.diffusemap != undefined and classof obj.material.diffusemap == BitmapTexture

-----------------------------------------------------------------------------

(
x1 = for obj in selection[1].compLoc.hidden collect obj.node
select x1
)

-----------------------------------------------------------------------------

sysInfo.username

$userScripts

symbolicPaths.getPathValue "$userScripts"



-----------------------------------------------------------------------------

(

	mySearch = "_chromeBrillantDore"

	mySearch = "*" + mySearch + "*"

	x1 = getClassInstances StandardMaterial

	x2 = for obj in x1 where (matchPattern obj.name pattern:mySearch == true )collect obj

	meditmaterials[1] = x2[1]

	MatEditor.Open()

)

-----------------------------------------------------------------------------

for i = 1 to $.compLoc.hidden.count do print $.compLoc.hidden[i].node.name 


for i = 1 to $.compLoc.transparent.count do print $.compLoc.transparent[i].node.name


x28 = for bla in $.compLoc.transparent collect (bla.node.name)
print x28 as string


for i = 1 to $.compLoc.transparent.count do print $.compLoc.transparent[i].node
deleteItem $.compLoc.transparent 1

for i = 1 to $.animated.hidden.count do print $.compLoc.animated[i].node.name 

-----------------------------------------------------------------------------

--- select objects with Unwrap modifier

	(
		mySelec = for obj in geometry where obj.modifiers[1] != undefined and obj.modifiers[1].name == "Unwrap UVW" collect obj
		clearSelection()
		select mySelec
	)



-----------------------------------------------------------------------------

-- ROLLOUT TEST

rollout csom_rollout "CollapseSubObjectMaterial"
	(
	group "Object"
	(
	label what_obj "None" align:#center
	pickbutton PickObj "Pick Object" width:210 align:#center toolTip:"Pick Object" -- filter:geometry_filter
	
	label submats_text_label "Sub-Object Materials:" across:2 align:#left
	label submats_label "" align:#right

	label usedmatid_text_label "Used MatIDs:" across:2 align:#left
	label usedmatid_label "" align:#right
	)
	
-- 	on PickObj picked obj do prepare_mesh obj
	
	group "Options"
	(
	checkbox active_slot "Put Collapsed Material in Active Slot" checked:true enabled:true
	checkbox sort_alpha "Sort Sub-Materials Alphabetically" checked:true enabled:true
	checkbox reduce_instanced "Reduce Instanced Sub-Materials" checked:true enabled:true
	checkbox reduce_nested "Reduce Nested Sub-Materials" checked:true enabled:true
	)
	
-- 	on active_slot changed state do active_slot_value = active_slot.checked
-- 	on sort_alpha changed state do sort_alpha_value = sort_alpha.checked
-- 	on reduce_instanced changed state do reduce_instanced_value = reduce_instanced.checked
-- 	on reduce_nested changed state do reduce_nested_value = reduce_nested.checked

	group "Collapse"
	(
	Button cm_do "Collapse Material" enabled:false width:210
	label label1 "Warning: Operation will collapse" align:#center
	label label2 "object's modifier stack" align:#center
	)
-- 	on cm_do pressed do collapse_material()
	)

if csom_floater != undefined then CloseRolloutFloater csom_floater
csom_floater = newRolloutFloater "CollapseSubObjectMaterial v1.21" 270 366
addRollout csom_rollout csom_floater
)



-----------------------------------------------------------------------------






-- classof meditmaterials[1]
-- meditmaterials[1].count
(
	MultiMat = for obj in objects where classof obj.material == MultiMaterial collect obj
	SingleMat = for obj in MultiMat where obj.material.count == 1 collect obj

-- 	select SingleMat

	for obj in SingleMat do 
	(
		myTemp = obj.material[1]
		obj.material = myTemp
	)
)



------------------------------------------------------

callbacks.show #filePreOpen
callbacks.show #filePreOpenProcess
callbacks.removeScripts #filePreOpenProcess id:#UpdateFileOnOpenCb
callbacks.addScript #filePreOpenProcess fileName:"$userScripts/PixGrinder/SVN_FileUpdate_Callback.ms" id:#UpdateFileOnOpenCb

------------------------------------------------------




-- myMod = $.modifiers[1]
myMod = Poly_Select()

-- for obj in selection do addModifier obj Poly_Select()
for obj in selection do addModifier obj (Poly_Select())



------------------------------------------------------


(
	x1 = getClassInstances StandardMaterial
	x2 = for obj in x1 where matchpattern obj.name pattern:"*hole*" == true collect obj
	meditmaterials[1] = x2[1]
)


------------------------------------------------------


(
	clearListener()
	i = 1
	for obj in objects where custAttributes.count obj == 1 do 
	(
-- 		print (i as string+";"+obj.name +";" + substring obj.compLoc.hotspot.name (obj.name.count+2) obj.compLoc.hotspot.name.count)
		format (i as string+";"+obj.name +";" + substring obj.compLoc.hotspot.name (obj.name.count+2) obj.compLoc.hotspot.name.count+"\n")
		i = i+1
	)
)



-- substring obj.compLoc.hotspot.name (obj.name.count+2) obj.compLoc.hotspot.name.count



------------------------------------------------------

(
	pda = #(2.0,10.0,18.0)
	pda_res = #()
	for obj in cameras do
	(
		if findItem pda obj.pos.z == 0 do append pda_res obj
	)


	ClearSelection()
	select pda_res
)



------------------------------------------------------



(
	x1 = for obj in objects where custAttributes.count obj == 1 collect obj
	x2 = for obj in x1 where obj.compLoc.fov > 80.0 collect obj
	clearSelection()
	select x2
)


for obj in selection do 
(
	obj.compLoc.fov = 80.0
	obj.compLoc.hotspot.fov = 80.0
)



------------------------------------------------------

(
	x1 = for obj in objects where custAttributes.count obj == 1 collect obj
	x2 = for obj in x1 where obj.compLoc.fov > 80.0 collect obj
	clearSelection()
	select x2
)


for obj in selection do 
(
	obj.compLoc.fov = 80.0
	obj.compLoc.hotspot.fov = 80.0
)


------------------------------------------------------

(
	x1 = getClassInstances StandardMaterial
	x2 = meditmaterials [1]

	x3 = for obj in x1 where obj.diffuseMap != undefined and obj.diffuseMap.name == x2.name collect obj

	meditmaterials[2] = x3[1]
)




------------------------------------------------------


x1 = for obj in selection where obj.parent == undefined and obj.children.count == 0 collect obj
clearSelection()
select x1


------------------------------------------------------

show $.compLoc
  .hotspot : node
  .fov : integer
  .hidden : maxObject array
  .transparent : maxObject array
  .animated : maxObject array

$.compLoc.hidden[1].node

fn fixComponents myVar= 
(
	pda = #()
	print myVar.compLoc.hidden.count
	for i = 1 to myVar.compLoc.hidden.count do
	(
		if myVar.compLoc.hidden[i].node == undefined do 
		(
			print ("hidden pb : " + myVar.name)
			append pda i
		)

	) 

	for obj in pda do deleteItem myVar.compLoc.hidden obj

	print myVar.compLoc.hidden.count


	pda = #()
	print myVar.compLoc.transparent.count
	for i = 1 to myVar.compLoc.transparent.count do
	(
		if myVar.compLoc.transparent[i].node == undefined do 
		(
			append pda i
			print ("transp pb : " + myVar.name)
		)

	) 

	for obj in pda do deleteItem myVar.compLoc.transparent obj

	print myVar.compLoc.transparent.count
)

clearListener()
for obj in objects where custAttributes.count == 1 do fixComponents obj

----------------------------------------------------




(
	myTemp = getClassInstances StandardMaterial
	myTemp2 = for obj in myTemp where obj.opacity != 100.0 collect obj
	print myTemp2.count
	for i = 1 to myTemp2.count do meditmaterials[i] = myTemp2[i]
)


-----------------------------------------------------

(
	-- $.compLoc.hotspot.name

	myComploc = for obj in objects where custAttributes.count obj > 0 collect obj

	myResult = for obj in myComploc where matchpattern obj.compLoc.hotspot.name pattern:"*overhead*" == true collect obj

	clearListener()

	for obj in myResult do print obj.name

	--selec myResult


)




(
-- 	ss = StringStream ""

	oldEuler = $.rotation as eulerAngles
	quat = eulerToQuat (eulerAngles (oldEuler.x + 90.0) oldEuler.y oldEuler.z)
	


)



(
-- 	ss = StringStream ""

	oldEuler = $.rotation as eulerAngles
	oldEuler.x = oldEuler.x + 90.0
	oldEuler.y = oldEuler.y
	oldEuler.z = oldEuler.z
	oldEuler


	quat = eulerToQuat oldEuler
	


)


(
	clearListener()
	ss = StringStream ""

	oldEuler = $.rotation as eulerAngles
	oldEuler.x = oldEuler.x + 90.0
	oldEuler.y = oldEuler.y
	oldEuler.z = oldEuler.z
	oldEuler
	quat = eulerToQuat oldEuler
	
	format "%, %, %, %" quat.x -quat.y quat.z -quat.w to:ss
	
-- 	if hasTarget then cam.targeted = true
		
	ss as string
)



---------------------------------------------------


x1 = for obj in selection collect obj.name

myTest = ""
for obj in x1 do append myTest (obj+", ")
myTest






-------------------------------------------------------
-- Layers rename


		for i = 1 to (layermanager.count-1) do 
		(
			x = layermanager.getLayer i
			print x.name
			if matchpattern x.name pattern:"anim_" == true do x.name
		)


		x = "anim_youpla"
x.name = "test"


-------------------------------------------------------

-- remove Custom Attribs


try (for obj in objects do custAttributes.delete obj 1) catch ()
delete cameras


-------------------------------------------------------


-- transfer names

if selection.count != 2 then messagebox("Please select only 2 objects") else 
(
selection[2].name = selection[1].name 
delete selection[1]
)

-------------------------------------------------------


-- Transfer Comploc Custom Attributes

clearListener()
if selection.count != 2 then messagebox("Please select only 2 objects") else 
(
	if custAttributes.count selection[2] > 0 do custAttributes.delete selection[2] 1 baseObject:true
	custAttributes.add selection[2] _cl.compLocCA BaseObject:true
	selection[2].compLoc.hotspot = selection[1].compLoc.hotspot
	selection[2].compLoc.fov = selection[1].compLoc.fov
	selection[2].compLoc.hidden = selection[1].compLoc.hidden
	selection[2].compLoc.transparent = selection[1].compLoc.transparent
	selection[2].compLoc.animated = selection[1].compLoc.animated
	custAttributes.delete selection[1] 1 baseObject:true
	selection[2].name = selection[1].name 
	delete selection[1]
)











-------------------------------------------------------


-- AutoSave Startup Script --

clearListener()
fn mytestfn=
(
-- 	sleep 5
	messagebox ("AutoSave is launched !")
	fileIn "$userScripts/PixGrinder/AutoSave_PDA_V7.ms"
)
callbacks.addScript #filePostOpen "mytestfn()" id:#FelipeCallback persistent:false




-- callbacks.removeScripts id:#FelipeCallback


-------------------------------------------------------


-- rename all materials

(
	stdMats = getClassInstances StandardMaterial
	for obj in stdMats do obj.name = ("Demo_"+obj.name)
)