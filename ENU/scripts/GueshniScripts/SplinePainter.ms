	(
-------------------------------------------------------------------------------
-- Required Files:
-- g9_Lib2.ms
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Description:
-- Ce script permet de peindre des spline sur la surface d'une autre géométrie.
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
(
	try(destroyDialog SplinePainter)catch()
	rollout SplinePainter "Spline Painter"
-- Globals

global splinePainterDefaults
global splinePainterUI

global sPACloseOpenUI

global sPAstartStroke
global sPApaintStroke
global sPAendStroke
global sPAcancelStroke
global sPAsystemEnd

global sPAHelp
global sPALoadDef
global sPASaveDef

global sPADefineUI
global sPADefineEMUI
global sPARollout
global sPAEMRollout
global sPAFloater

-- Includes

-------------------------------------------------------------------------------
-- g9_Lib2.ms
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Initialization Start
-------------------------------------------------------------------------------
global sLibInit
if sLibInit != true then
(
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Globals
-------------------------------------------------------------------------------

-- Arrays
global sLibArrayAsArrayString
global sLibArrayStringAsArray
global sLibAverageMinMaxOfArray 
global sLibChooseUniqueValuesByNumber
global sLibChooseUniqueValuesByPercentage
global sLibChooseUniqueValuesByWeight
global sLibCompareArrays
global sLibCopyArray
global sLibCreateBlankArray
global sLibGetRangeFromArray
global sLibMoveIndexDownInArray
global sLibMoveIndexUpInArray
global sLibRandomizeArray
global sLibRemoveIndexFromArray
global sLibRemoveIndexesFromArray
global sLibRemoveItemFromArray
global sLibRemoveItemsFromArray
global sLibSortAscending	
global sLibSortDecending
global sLibTrimDups

-- Bounding Boxes
global sLibGetCollectionBBox
global sLibGetCollectionBBoxCenter

-- Coincident
global sLibCoincidentPoints

-- Collecting
global sLibAllSameParent
global sLibFindObjTopLevelParent
global sLibGetAllAtm
global sLibGetAllControllersOnObj
global sLibGetAllEffects
global sLibGetHiddenObjects
global sLibGetUnhiddenObjects
global sLibSelectionAllGeometry
global sLibSelectionAllShapes

-- Files
global sLibFileExist
global sLibFilenameFromPath
global sLibGetAllFilesInDir
global sLibGetLengthOfFile
global sLibStripFileExtension

-- Filters
global sLibBipedFilter
global sLibCameraFilter
global sLibEditablePolyFilter
global sLibGeometryFilter
global sLibHelperFilter
global sLibParticlesFilter
global sLibPowerNurbsFilter
global sLibPowerSolidsFilter
global sLibShapeFilter
global sLibStandardLightFilter
global sLibStandardParticleFilter

-- Groups
global sLibGetGroupHead

-- Instances
global sLibDoesArrayContainInstancesOfObj
global sLibGetInstancesOfObject
global sLibIsInstanceOf
global sLibRemoveInstancesOfObjFromArray
global sLibRemoveUniqueObjectsFromArray
global sLibRemoveUnneededInstancesFromArray
global sLibSelectionOfInstances

-- Layers
global sLibCopyAndPasteLayerFromNodeToNode

-- Maps Specific
global sLibGetAllBlurEffectMaps
global sLibGetAllBrazilSkylightMaps
global sLibGetAllDisplaceModMaps
global sLibGetAllDisplaceSWMaps
global sLibGetAllEnvironmentMaps
global sLibGetAllFogMaps
global sLibGetAllMapsFromSelectedObjects
global sLibGetAllMeditMaps
global sLibGetAllProjectorLightMaps
global sLibGetAllSceneMaps
global sLibGetAllUnwrapUVWMaps

-- Maps Utility
global sLibFindBitmapInMapPaths
global sLibGetBitmapsFromMaps
global sLibGetMapsFromMaxWrapperObject

-- Materials Specific
global sLibGetAllSceneMaterials
global sLibGetAllMaterialsOnSelectedObjects
global sLibGetAllMatLibMaterials
global sLibGetAllMeditMaterials
global sLibGetSceneMaterials
global sLibGetMaterialsOnSelectedObjects
global sLibGetMatLibMaterials
global sLibGetMeditMaterials

-- Materials Utility
global sLibGetAllMaterials
global sLibGetSubMaterials

-- Modifiers
global sLibRemoveModifiersByName
global sLibRemoveModifiersByNameFragment

-- Selection Sets
global sLibAddToSelectionSet
global sLibCopyAndPasteSelectionSetsFromNodeToNode
global sLibGetSceneSelectionSetsNames
global sLibGetSelectionSetsByNode

-- Software Tests
global sLibBrazil1Test
global sLibBrazil2Test
global sLibMaxVer
global sLibSplineMesherTest

-- g9
global sLibSSPrintHelp
global sLibSSFindTextFragment
global sLibSSGetTextFragment

-- Strings
global sLibCompareCaseInsensitive
global sLibCompareCaseSensitive
global sLibFindAndReplaceInString
global sLibMakeStringLowercase
global sLibMakeStringUppercase
global sLibNameCompareCaseInsensitive
global sLibNameCompareCaseSensitive
global sLibPadValue
global sLibRemoveTailNumbers
global sLibReverseString

-- Transforms
global sLibResetXForm
global sLibRotateObjByAxis

-- Values
global sLibRandomWithBias

-------------------------------------------------------------------------------
-- Arrays
-------------------------------------------------------------------------------

fn sLibArrayAsArrayString a spacer = 
	(
	s = ""
	if a.count != 0 then
		(
		for i = 1 to a.count do
			(
			s += (a[i] as string)
			if i != a.count then s += (spacer as string)
			)
		)
	return s
	)
	
fn sLibArrayStringAsArray s spacer = 
	(
	a = filterString s spacer
	return a
	)
	
fn sLibAverageMinMaxOfArray a = 
	(
	a1 = amax a
	a2 = amin a
	return ((abs (((a1 as float) - (a2 as float)) / (2 as float))) + a2)
	)

fn sLibChooseUniqueValuesByNumber a number =
	(
	if number < 1 then return #() 
	else
		(
		local b = sLibCopyArray a
		if number < b.count then
			(
			for i = 1 to ((b.count) - number) do
				(
				deleteItem b (random 1 b.count)
				)
			)
		return b
		)
	)

fn sLibChooseUniqueValuesByPercentage a percentage =
	(
	number = a.count * percentage * 0.01
	sLibChooseUniqueValuesByNumber a number
	)
	
fn sLibChooseUniqueValuesByWeight a weight =
	(
	local b = #()
	if a.count >= 1 then 
		(
		for i = 1 to a.count do
			(
			if ((random 1 99) + (weight - 50)) > 50 then append b a[i]
			)
		)
	return b
	)

fn sLibCompareArrays a b = 
	(
	if a.count != b.count then return false
	else
		(
		for i = 1 to a.count do
			(
			if a[i] != b[i] then return false
			)
		true
		)
	)

fn sLibCopyArray a = 
	(
	local b = #()
	if a.count != 0 then 
		(
		for i = 1 to a.count do
			(
			append b a[i]
			)
		)
	return b
	)

fn sLibCreateBlankArray size = 
	(
	b = #()
	for a = 1 to size do
		(
		append b undefined
		)
	return b
	)

fn sLibGetRangeFromArray a start end =
	(
	local b = #()
	for i = start to end do
		(
		append b a[i]
		)
	return b
	)

fn sLibMoveIndexDownInArray a index = 
	(
	local b = sLibCopyArray a
	if index < (a.count +1) then
		(
		if index != a.count then
			(
			b[index] = a[index + 1]
			b[index + 1] = a[index]
			)
		)
	return b
	)
	
fn sLibMoveIndexUpInArray a index = 
	(
	local b = sLibCopyArray a
	if index < (a.count +1) then
		(
		if index != 1 then
			(
			b[index] = a[index - 1]
			b[index - 1] = a[index]
			)
		)
	return b
	)

fn sLibRandomizeArray a = 
	(
	local b = #()
	for i = 1 to a.count do
		(
		toAdd = a[(random 1 a.count)]
		append b toAdd
		)
	return b
	)

fn sLibRemoveIndexFromArray a index =
	(
	local a = sLibCopyArray a
	deleteitem a index
	return a
	)

fn sLibRemoveIndexesFromArray a indexes =
	(
	local a = sLibCopyArray a
	local b = sLibCopyArray indexes
	if b.count != 0 then
		(
		sort b
		for i = 1 to b.count do
			(
			deleteitem a b[i]
			for w = 1 to b.count do
				(
				b[w] -= 1
				)
			)
		)
	return a
	)
	
fn sLibRemoveItemFromArray a item =
	(
	b = sLibCopyArray a
	if b.count != 0 then
		(
		delete_array = #()
		for i = 1 to b.count do
			(
			if b[i] == item then append delete_array i
			)
		b = sLibRemoveIndexesFromArray b delete_array
		)
	return b
	)
	
fn sLibRemoveItemsFromArray a items =
	(
	local a = sLibCopyArray a
	local b = sLibCopyArray items
	if b.count != 0 then
		(
		for i in b do 
			(
			a = sLibRemoveItemFromArray a i
			)
		)
	return a
	)
	
fn sLibCopyArray a = 
	(
	local b = #()
	if a.count != 0 then 
		(
		for i = 1 to a.count do
			(
			append b a[i]
			)
		)
	return b
	)
	
fn sLibSortAscending a = 
	(
	sort a
	)
	
fn sLibSortDecending a =
	(
	b = #()
	sort a
	for w = 1 to a.count do
		(
		append b a[a.count]
		deleteitem a a.count
		)
	return b
	)

fn sLibTrimDups a = 
	(
	for i in a.count to 1 by -1 do 
		(
		idx = findItem a a[i]
		if (idx != 0) AND (idx != i) do deleteItem a i
		)
	a
	)
	
-------------------------------------------------------------------------------
-- Bounding Boxes
-------------------------------------------------------------------------------
	
fn sLibGetCollectionBBox collection = 
	(
	if collection.count == 0 then return #([0,0,0],[0,0,0])
	else
		(
		max = [collection[1].max.x,collection[1].max.y,collection[1].max.z]
		min = [collection[1].min.x,collection[1].min.y,collection[1].min.z]
		for i in collection do 
			(
			if i.max.x > max.x then max.x = i.max.x
			if i.max.y > max.y then max.y = i.max.y
			if i.max.z > max.z then max.z = i.max.z
			if i.min.x < min.x then min.x = i.min.x
			if i.min.y < min.y then min.y = i.min.y
			if i.min.z < min.z then min.z = i.min.z
			)
		return #([max.x,max.y,max.z],[min.x,min.y,min.z])
		)
	)
	
fn sLibGetCollectionBBoxCenter collection = 
	(
	a = sLibGetCollectionBBox collection
	return [(a[1][1]+a[2][1])/2, (a[1][2]+a[2][2])/2, (a[1][3]+a[2][3])/2]
	)

-------------------------------------------------------------------------------
-- Coincident
-------------------------------------------------------------------------------

fn sLibCoincidentPoints a b tolerance = 
(
	answer = true
	if a.x > (b.x + tolerance) then answer = false
	else if a.x < (b.x - tolerance) then answer = false
	else if a.y > (b.y + tolerance) then answer = false
	else if a.y < (b.y - tolerance) then answer = false
	else if a.z > (b.z + tolerance) then answer = false
	else if a.z < (b.z - tolerance) then answer = false
	return answer
)

-------------------------------------------------------------------------------
-- Collecting
-------------------------------------------------------------------------------

fn sLibAllSameParent a = 
	(
	result = true
	if a.count > 1 then
		(
		testParent = a[1].parent
		for i in a do
			(
			if i.parent != testParent then result = false
			)
		)
	return result
	)

fn sLibFindObjTopLevelParent inputObj =
	(
	objsToProcess = #(inputObj)
	for obj in objsToProcess do
		(
		if obj.parent == undefined then return obj
		else append objsToProcess obj.parent
		)
	)

fn sLibGetAllAtm =
	(
	a = #()
	if numAtmospherics != 0 then
		(
		for i = 1 to numAtmospherics do
			(
			append a (getAtmospheric i)
			)
		)
	return a
	)

fn sLibGetAllControllersOnObj input a = 
	(
	contToProcess = #(input)
	for cont in contToProcess do
		(
		if cont.numsubs != 0 then
			(
			for i = 1 to cont.numsubs do
				(
				if cont[i] != undefined then
					(
					if cont[i].numsubs != 0 then
						(
						for j = 1 to cont[i].numsubs do
							(
							if cont[i][j] != undefined then
								(
								append a cont[i][j]
								)
							)
						)
					)
				append contToProcess cont[i]
				)
			)
		)
	)
	
fn sLibGetAllEffects =
	(
	a = #()
	if numEffects != 0 then
		(
		for i = 1 to numEffects do
			(
			append a (getEffect i)
			)
		)
	return a
	)

fn sLibGetHiddenObjects = 
	(
	a = #()
	for i in $* do
		(
		if i.ishidden == true then append a i
		)
	return a
	)

fn sLibGetUnhiddenObjects = 
	(
	a = #()
	for i in $* do
		(
		if i.ishidden == false then append a i
		)
	return a
	)

fn sLibSelectionAllGeometry a = 
	(
	result = true
	if a.count == 0 then return false
	else
		(
		result = true
		for i in a do
			(
			if (sLibGeometryFilter i) == false then 
				(
				result = false
				exit
				)
			)
		return result
		)
	)
	
fn sLibSelectionAllShapes a = 
	(
	result = true
	if a.count == 0 then return false
	else
		(
		result = true
		for i in a do
			(
			if (sLibShapeFilter i) == false then 
				(
				result = false
				exit
				)
			)
		return result
		)
	)
	
-------------------------------------------------------------------------------
-- Files
-------------------------------------------------------------------------------

fn sLibFileExist f = 
	(
	(getfiles f).count != 0 
	)

fn sLibFilenameFromPath f = 
	(
	filteredString = filterString f "\\"
	if filteredString.count != 0 then return filteredString[filteredString.count]
	else return undefined
	)
	
fn sLibGetAllFilesInDir inputDir rec type = 
	(
	a = #()
	dirsToProcess = #(inputDir)
	for dir in dirsToProcess do
		(		
		currentFiles = getFiles (dir + "*." + (type as string))
		for i in currentFiles do append a i
		if rec == true then
			(
			subDirs = getDirectories (dir + "*.*")
			for i in subDirs do append dirsToProcess i
			)
		)
	return a
	)

fn sLibGetLengthOfFile thefile = 
	(
	result = 0
	thefileOpen = openFile thefile
	if thefileOpen != undefined and (classof thefileOpen == FileStream) then 
		(
		while ((eof thefileOpen) == false) do
			(
			readLine thefileOpen
			result += 1
			)
		)
	close thefileOpen
	return result
	)
	
fn sLibStripFileExtension f = 
	(
	fileName = sLibReverseString f
	locationOfCut = findString fileName "."
	fileNameReversed = substring fileName (locationOfCut + 1) fileName.count
	return sLibReverseString fileNameReversed
	)
	
-------------------------------------------------------------------------------
-- Filters
-------------------------------------------------------------------------------

fn sLibBipedFilter o = 
	(
	classof o == Biped_Object
	)

fn sLibCameraFilter o = 
	(
	superclassof o == camera 
	)
	
fn sLibEditablePolyFilter o = 
	(
	classof o.baseobject == Editable_Poly
	)
	
fn sLibGeometryFilter o = 
	(
	superclassof o == GeometryClass
	)

fn sLibHelperFilter o = 
	(
	superclassof o == helper
	)

fn sLibParticlesFilter o =
	(
	if \
	classof o.baseobject == SuperSpray or \
	classof o.baseobject == PArray or \
	classof o.baseobject == PCloud or \
	classof o.baseobject == Blizzard or \
	classof o.baseobject == Snow or \
	classof o.baseobject == Spray or \
	classof o.baseobject == ParticleStudio or \
	classof o.baseobject == Sand_Blaster or \
	classof o.baseobject == PF_Source or \
	classof o.baseobject == Particles \
	then true
	else false
	)

fn sLibPowerNurbsFilter o =
	(
	if \
	classof o == Pwr_EditNRB or \
	classof o == Pwr_Join or \
    	classof o == Pwr_Extrude or \
	classof o == Pwr_Assembly or \
	classof o == Pwr_Boolean or \
	classof o == Pwr_Fillet or \
	classof o == Pwr_Shell or \
	classof o == Pwr_Planar or \
	classof o == Pwr_Revolve or \
	classof o == Pwr_Skin or \
	classof o == Pwr_Pipe or \
	classof o == Pwr_Sweep or \
	classof o == Pwr_Swung \
	then true
	else false
	)

fn sLibPowerSolidsFilter o =
	(
	if \
	classof o == EditableBrep or \
	classof o == BrepJoin or \
    	classof o == BrepExtrude or \
	classof o == BrepAssembly or \
	classof o == BrepBoolean or \
	classof o == BrepFillet or \
	classof o == BrepShell or \
	classof o == BrepPlanar or \
	classof o == BrepRevolve or \
	classof o == BrepSkin or \
	classof o == BrepPipe or \
	classof o == BrepSweep or \
	classof o == BrepSwung \
	then true
	else false
	)

fn sLibShapeFilter o = 
	(
	superclassof o.baseobject == shape
	)

fn sLibStandardLightFilter o = 
	(
	if \
	classof o == targetSpot or \
	classof o == Omnilight or \
	classof o == TargetDirectionallight or \
	classof o == Directionallight or \
	classof o == freeSpot \
	then true
	else false
	)
	
fn sLibStandardParticleFilter o =
	(
	if \
	classof o.baseobject == SuperSpray or \
	classof o.baseobject == PArray or \
	classof o.baseobject == PCloud or \
	classof o.baseobject == Blizzard \
	then true
	else false
	)

-------------------------------------------------------------------------------
-- Groups
-------------------------------------------------------------------------------

fn sLibGetGroupHead obj = 
	(
	groupHeads = for o in objects where (isGroupHead o) collect o
	for o in groupHeads do 
		(
		if (findItem o.children obj != 0) do ( return o )
		)
	return undefined
	)

-------------------------------------------------------------------------------
-- Instances
-------------------------------------------------------------------------------

fn sLibDoesArrayContainInstancesOfObj a Obj = 
	(
	if Obj != undefined then
		(
		if a != 0 then
			(
			if (refs.dependents Obj.baseobject).count != 0 then
				(
				r = #()
				for w = 1 to (refs.dependents Obj.baseobject).count do
					(
					if (refs.dependents Obj.baseobject)[w] != Obj then
						(
						if iskindof (refs.dependents Obj.baseobject)[w] (classof Obj) then
							(
							append r (refs.dependents Obj.baseobject)[w]
							)
						)
					)
				for i in a do
					(
					if (finditem r i) != 0 then 
						(
						return true
						exit
						)
					)
				)
			)
		)
	return false
	)

fn sLibGetInstancesOfObject Obj = 
	(
	a = #()
	if (refs.dependents Obj.baseobject).count != 0 then
		(
		for i = 1 to (refs.dependents Obj.baseobject).count do
			(
			if (refs.dependents Obj.baseobject)[i] != Obj then
				(
				if iskindof (refs.dependents Obj.baseobject)[i] (classof Obj) then
					(
					append a (refs.dependents Obj.baseobject)[i]
					)
				)
			)
		)
	return a
	)

fn sLibIsInstanceOf Obj1 Obj2 = 
	(
	a = sLibGetInstancesOfObject Obj1
	if (findItem a Obj2) != 0 then return true
	else return false
	)
	
fn sLibRemoveInstancesOfObjFromArray a Obj = 
	(
	local b = sLibCopyArray a
	if Obj != undefined then
		(
		toRemove = sLibGetInstancesOfObject Obj
		b = sLibRemoveItemsFromArray a toRemove 
		)
	return b
	)
	
fn sLibRemoveUniqueObjectsFromArray a = 
	(
	local b = sLibCopyArray a
	for i in b do
		(
		if ((sLibDoesArrayContainInstancesOfObj b i) == false) then
			(
			b = sLibRemoveItemFromArray b i
			)
		)
	return b
	)	
	
fn sLibRemoveUnneededInstancesFromArray objsToProcess = 
	(
	a = #()
	while objsToProcess.count != 0 do
		(
		append a objsToProcess[1]
		objsWithoutFirst = sLibRemoveItemFromArray objsToProcess objsToProcess[1]
		trimmedArray = sLibRemoveInstancesOfObjFromArray objsWithoutFirst objsToProcess[1]
		objsToProcess = sLibCopyArray trimmedArray
		)
	return a
	)

fn sLibSelectionOfInstances a =
	(
	if a.count < 2 then return true
	else	
		(
		result = true
		for i = 2 to a.count do
			(
			if (sLibIsInstanceOf a[1] a[i]) == false then 
				(
				result = false
				exit
				)
			)
		return result
		)
	)

-------------------------------------------------------------------------------
-- Layers
-------------------------------------------------------------------------------

fn sLibCopyAndPasteLayerFromNodeToNode copyObj pasteObj = 
	(
	myLayerName = copyObj.layer.name
	myLayer = layermanager.getLayerFromName myLayerName
	myLayer.addnode pasteObj
	)

-------------------------------------------------------------------------------
-- Maps Specific
-------------------------------------------------------------------------------

fn sLibGetAllBlurEffectMaps = 
	(
	b = #()
	for e in (sLibGetAllEffects()) do
		(
		if classof e == blur then
			(
			if e.selMaskMap != undefined then
				(			
				a = #()
				append a e.selMaskMap
				sLibGetMapsFromMaxWrapperObject e.selMaskMap a
				join b a
				)
			)
		)
	sLibTrimDups b
	return b
	)

fn sLibGetAllBrazilSkylightMaps = 
	(
	b = #()
	if sLibCompareArrays renderers.current.classid #(1387076610, 288174012) then
		(
		if renderers.current.flux_skylt_map != undefined then
			(
			a = #()
			append a renderers.current.flux_skylt_map
			sLibGetMapsFromMaxWrapperObject renderers.current.flux_skylt_map a
			join b a
			)
		)
	else if sLibCompareArrays renderers.current.classid #(95494396, 474502030) then
		(
		Brz = trackviewnodes.Brazil_r_s[renderers.current.renderer_no + 1]
		if Brz.Luma_Server_Parameter_Block_Holder.skylight_map != undefined then
			(
			a = #()
			append a Brz.Luma_Server_Parameter_Block_Holder.skylight_map
			sLibGetMapsFromMaxWrapperObject Brz.Luma_Server_Parameter_Block_Holder.skylight_map a
			join b a		
			)
		)
	sLibTrimDups b
	return b
	)

fn sLibGetAllDisplaceModMaps = 
	(
	b = #()
	for obj in geometry do 
		(
		for m in obj.modifiers do
			(
			if classof m == Displace then 
				(
				if m.map != undefined then 
					(
					a = #()
					append a m.map
					sLibGetMapsFromMaxWrapperObject m.map a
					join b a
					)
				)
			)
		)
	sLibTrimDups b
	return b
	)
	
fn sLibGetAllDisplaceSWMaps = 
	(
	b = #()
	for s in spacewarps do 
		(
		if classof s == Spacedisplace then if s.map != undefined then 
			(
			a = #()
			append a s.map
			sLibGetMapsFromMaxWrapperObject s.map a
			join b a
			)
		)
	sLibTrimDups b
	return b
	)

fn sLibGetAllEnvironmentMaps = 
	(
	b = #()
	if EnvironmentMap != undefined then 
		(
		a = #()
		append a EnvironmentMap
		sLibGetMapsFromMaxWrapperObject EnvironmentMap a
		join b a
		)
	return b
	)
	
fn sLibGetAllFogMaps = 
	(
	b = #()
	for f in (sLibGetAllAtm()) do
		(
		if classof f == fog then
			(
			a = #()
			sLibGetMapsFromMaxWrapperObject f a
			join b a
			)
		)
	sLibTrimDups b
	return b
	)
	
fn sLibGetAllMapsFromSelectedObjects = 
	(
	b = #()
	mats = sLibGetAllMaterialsOnSelectedObjects()
	for m in mats do
		(
		a = #()
		sLibGetMapsFromMaxWrapperObject m a
		join b a
		)
	sLibTrimDups b
	return b
	)

fn sLibGetAllMeditMaps = 
	(
	b = #()
	mats = sLibGetAllMeditMaterials()
	for m in mats do
		(
		a = #()
		sLibGetMapsFromMaxWrapperObject m a
		join b a
		)
	sLibTrimDups b
	return b
	)

fn sLibGetAllProjectorLightMaps = 
	(
	b = #()
	for l in lights do 
		(
		if superclassof l == light then 
			(
			if classof l == Brazil_Light then
				(
				if l.projector_map != undefined then 
					(
					a = #()
					append a l.projector_map
					sLibGetMapsFromMaxWrapperObject l.projector_map a
					join b a
					)
				)
			else if classof l == B2_Main_Light then
				(
				if l.base_parameters.feat_projector_on == true then
					(
					if l.projector_pb_holder.projector_map != undefined then
						(
						a = #()
						append a l.projector_pb_holder.projector_map
						sLibGetMapsFromMaxWrapperObject l.projector_pb_holder.projector_map a
						join b a
						)
					)
				)
			else if sLibStandardLightFilter l == true then
				(
				if l.projectorMap != undefined then 
					(
					a = #()
					append a l.projectorMap
					sLibGetMapsFromMaxWrapperObject l.projectorMap a
					join b a
					)
				)
			)
		)
	sLibTrimDups b
	return b
	)
	
fn sLibGetAllSceneMaps = 
	(
	b = #()
	mats = sLibGetAllSceneMaterials()
	for m in mats do
		(
		a = #()
		sLibGetMapsFromMaxWrapperObject m a
		join b a
		)
	sLibTrimDups b
	return b
	)
	
fn sLibGetAllUnwrapUVWMaps = 
	(
	b = #()
	for obj in geometry do 
		(
		for m in obj.modifiers do
			(
			if classof m == Unwrap_UVW then 
				(
				if m.texMapList != undefined then 
					(
					a = m.texMapList
					join b a
					)
				)
			)
		)
	sLibTrimDups b
	return b
	)

-------------------------------------------------------------------------------
-- Maps Utility
-------------------------------------------------------------------------------

fn sLibFindBitmapInMapPaths mymap =
	(
	pathcount = mapPaths.count()
	if pathcount != 0 then
		(
		for i = 1 to pathcount do
			(
			currentpath = mapPaths.get i
			testbitmap = (currentpath + "\\" + mymap)
			if (sLibFileExist testbitmap) == true then 
				(
				return testbitmap
				exit
				)
			)
		)
	return false
	)

fn sLibGetBitmapsFromMaps a = 
	(
	b = #()
	for i in a do
		(
		if classof i == Bitmaptexture then append b i
		)
	return b
	)

fn sLibGetMapsFromMaxWrapperObject inputMat a =
	(
	matsToProcess = #(inputMat)
	for mat in matsToProcess do
		(
		if mat.numsubs != 0 then
			(
			for i = 1 to mat.numsubs do
				(
				if mat[i] != undefined then
					(
					if classof mat[i] == SubAnim then
						(
						if superclassof mat[i].object == textureMap then
							(
							if mat[i].object != undefined then append a mat[i].object
							)
						)
					append matsToProcess mat[i]
					)
				)
			)
		)
	)

-------------------------------------------------------------------------------
-- Materials Specific
-------------------------------------------------------------------------------
	
fn sLibGetAllSceneMaterials = 
	(
	a = #()
	for i in $* do
		(
		if i.material != undefined then
			(
			for i in (sLibGetAllMaterials i.material) do
				(
				if (finditem a i) == 0 then append a i
				)
			)
		)
	return a
	)
	
fn sLibGetAllMaterialsOnSelectedObjects = 
	(
	a = #()
	for i in selection do
		(
		if i.material != undefined then
			(
			for i in (sLibGetAllMaterials i.material) do
				(
				if (finditem a i) == 0 then append a i
				)
			)
		)
	return a
	)

fn sLibGetAllMatLibMaterials = 
	(
	a = #()
	for i in currentMaterialLibrary do
		(
		if superclassof i == Material then 
			(
			for i in (sLibGetAllMaterials i) do
				(
				if (finditem a i) == 0 then append a i
				)
			)
		)
	return a
	)
	
fn sLibGetAllMeditMaterials = 
	(
	a = #()
	for i = 1 to 24 do
		(
		for i in (sLibGetAllMaterials meditmaterials[i]) do
			(
			if (finditem a i) == 0 then append a i
			)
		)
	return a
	)
	
fn sLibGetSceneMaterials = 
	(
	a = #()
	for i in $* do
		(
		if i.material != undefined then
			(
			if (finditem a i.material) == 0 then append a i.material
			)
		)
	return a
	)
	
fn sLibGetMaterialsOnSelectedObjects = 
	(
	a = #()
	for i in selection do
		(
		if i.material != undefined then
			(
			if (finditem a i.material) == 0 then append a i.material
			)
		)
	return a
	)
	
fn sLibGetMatLibMaterials = 
	(
	a = #()
	for i in currentMaterialLibrary do
		(
		if superclassof i == Material then 
			(
			if (finditem a i) == 0 then append a i
			)
		)
	return a
	)
	
fn sLibGetMeditMaterials = 
	(
	a = #()
	for i = 1 to 24 do
		(
		if (finditem a meditmaterials[i]) == 0 then append a meditmaterials[i]
		)
	return a
	)
	
-------------------------------------------------------------------------------
-- Materials Utility
-------------------------------------------------------------------------------

fn sLibGetAllMaterials mat = 
	(
	a = #()
	x = #()
	append a mat
	sLibGetSubMaterials mat x
	for i in x do
		(
		if finditem a i == 0 then append a i
		)
	return a
	)	

fn sLibGetSubMaterials inputMat a = 
	(
	matsToProcess = #(inputMat)
	for mat in matsToProcess do	
		(
		if mat.numsubs != 0 then
			(
			for i = 1 to mat.numsubs do
				(
				if mat[i] != undefined then
					(
					if iskindof mat[i] material == true then 
						(
						if classof mat[i] == SubAnim then
							(
							if superclassof mat[i].object == material then 
								(
								if finditem a (mat[i].object) == 0 then append a (mat[i].object)
								)
							)
						if superclassof mat[i] == material then 
							(
							if finditem a (mat[i]) == 0 then append a (mat[i])
							)
						)
					append matsToProcess mat[i]
					)
				)
			)
		)
	)

-------------------------------------------------------------------------------
-- Modifiers
-------------------------------------------------------------------------------

fn sLibRemoveModifiersByName objs name = 
	(
	modNumberKilled = 0
	for i in objs do
		(
		modsToKill = #()
		if i.modifiers.count != 0 then
			(
			for j = 1 to i.modifiers.count do
				(
				if i.modifiers[j].name == name then append modsToKill j 
				)
			)
		if modsToKill.count != 0 then
			(
			modsToKill = (sLibSortDecending modsToKill)
			for k = 1 to modsToKill.count do
				(
				deleteModifier i i.modifiers[modsToKill[k]]
				)
			modNumberKilled += modsToKill.count
			)
		)
	return modNumberKilled
	)
	
fn sLibRemoveModifiersByNameFragment objs name = 
	(
	modNumberKilled = 0
	for i in objs do
		(
		modsToKill = #()
		if i.modifiers.count != 0 then
			(
			for j = 1 to i.modifiers.count do
				(
				modname = i.modifiers[j].name
				if (findString modname name) != undefined then append modsToKill j 
				)
			)
		if modsToKill.count != 0 then
			(
			modsToKill = (sLibSortDecending modsToKill)
			for k = 1 to modsToKill.count do
				(
				deleteModifier i i.modifiers[modsToKill[k]]
				)
			modNumberKilled += modsToKill.count
			)
		)
	return modNumberKilled
	)

-------------------------------------------------------------------------------
-- Selection Sets
-------------------------------------------------------------------------------

fn sLibAddToSelectionSet mySetName obj = 
	(
	a = #()
	mySet = SelectionSets[mySetName]
	for i in mySet do append a i
	append a obj
	selectionSets[mySetName] = a	
	)

fn sLibCopyAndPasteSelectionSetsFromNodeToNode copyObj pasteObj = 
	(
	sets = sLibGetSelectionSetsByNode copyObj
	for s in sets do
		(
		sLibAddToSelectionSet s pasteObj
		)
	)

fn sLibGetSceneSelectionSetsNames = 
	(
	a = #()
	sSNum = getNumNamedSelSets()
	if sSNum != 0 then
		(
		for i = 1 to sSNum do
			(
			append a (getNamedSelSetName i)
			)
		)
	return a
	)

fn sLibGetSelectionSetsByNode obj = 
	(
	sSets = #()
	sSNum = getNumNamedSelSets()
	if sSNum != 0 then
		(
		for i = 1 to sSNum do
			(
			ItemNum = getNamedSelSetItemCount i
			if ItemNum != 0 then
				(
				for j = 1 to ItemNum do
					(
					if obj == (getNamedSelSetItem i j) then append sSets (getNamedSelSetName i)
					)
				)
			)
		)
	return sSets
	)

-------------------------------------------------------------------------------
-- Software Tests
-------------------------------------------------------------------------------

fn sLibBrazil1Test = 
	(
	try ((BzVersion())[1] == 1)
	catch (return false)
	)
	
fn sLibBrazil2Test = 
	(
	Brazil_Main_Renderer != undefined
	)

fn sLibMaxVer = 
	(
	return (maxVersion())[1] / 1000.0
	)

fn sLibSplineMesherTest = 
	(
	disableSceneRedraw()
	answer = true
	s = for obj in selection collect obj
	try
		(
		testLine = Circle radius:10 pos:[0,0,0] isSelected:on
		addmodifier $ (SplineMesher ())
		)
	catch	
		(
		answer = false
		)
	delete testLine
	if s != #() then select s
	
	enableSceneRedraw()
	completeRedraw()

	return answer
	)
	
-------------------------------------------------------------------------------
-- g9
-------------------------------------------------------------------------------

fn sLibSSPrintHelp myscript = 
	(
	myfile = ((getdir #scripts) + "\\g9\\scripts\\" + myscript + ".ms")
	aDesc = sLibSSFindTextFragment "-- Description:" myfile
	aTut = sLibSSFindTextFragment "-- Tutorial:" myfile
	aIssues = sLibSSFindTextFragment "-- Known Issues:" myfile
	mainText = ""
	if aDesc.count != 0 then
		(
		for i in aDesc do
			(
			newi = substring i 4 (i.count - 3)
			mainText += newi
			mainText += "\n"
			)
		)
	if aTut.count != 0 then
		(
		mainText += "\n"
		for i in aTut do
			(
			newi = substring i 4 (i.count - 3)
			mainText += newi
			mainText += "\n"
			)
		)		
	if aIssues.count != 0 then
		(
		mainText += "\n"
		for i in aIssues do
			(
			newi = substring i 4 (i.count - 3)
			mainText += newi
			mainText += "\n"
			)
		)
	mainTitle = "Help For " + (getFilenameFile myfile)
	MessageBox mainText title:mainTitle
	)

fn sLibSSFindTextFragment whichFrag myfile = 
	(
	aBuild = #()
	aFinal = #()
	if openFile myfile != undefined then
		(
		myfileOpen = openFile myfile
		numlines = sLibGetLengthOfFile myfile
		if numlines != 0 then
			(
			for i = 1 to numlines do
				(
				inputdata = readLine myfileOpen
				if inputdata == whichFrag then
					(
					aFinal = #(inputdata)
					join aFinal (sLibSSGetTextFragment myfileOpen aBuild)
					exit
					)
				)
			)
		close myfileOpen
		)
	return aFinal
	)
	
fn sLibSSGetTextFragment myfileOpen a = 
	(
	inputdata = undefined
	while inputdata != "-------------------------------------------------------------------------------" do
		(
		if inputdata != undefined then append a inputdata
		inputdata = readLine myfileOpen
		)
	return a
	)

-------------------------------------------------------------------------------
-- Strings
-------------------------------------------------------------------------------

fn sLibCompareCaseInsensitive s1 s2 = 
	(
	if (sLibMakeStringLowercase s1) < (sLibMakeStringLowercase s2) then return -1
	else if (sLibMakeStringLowercase s1) > (sLibMakeStringLowercase s2) then return 1
	else return 0
	)

fn sLibCompareCaseSensitive s1 s2 = 
	(
	if s1 < s2 then return -1
	else if s1 > s2 then return 1
	else return 0
	)

fn sLibFindAndReplaceInString s1 f r = 
	(
	InsertPoint = findString s1 f
	if InsertPoint != undefined then return (replace s1 InsertPoint f.count r)
	else return s1
	)

fn sLibMakeStringLowercase s1 =
	(
	upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	lower = "abcdefghijklmnopqrstuvwxyz" 
	s2 = copy s1
	for i = 1 to s2.count do 
		(
		j = findString upper s2[i]
		if (j != undefined) do s2[i] = lower[j]
		)
	return s2
	)
	
fn sLibMakeStringUppercase s1 =
	(
	upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	lower = "abcdefghijklmnopqrstuvwxyz" 
	s2 = copy s1
	for i = 1 to s2.count do 
		(
		j = findString lower s2[i]
		if (j != undefined) do s2[i] = upper[j]
		)
	return s2
	)
	
fn sLibNameCompareCaseInsensitive s1 s2 = 
	(
	if (sLibMakeStringLowercase s1.name) < (sLibMakeStringLowercase s2.name) then return -1
	else if (sLibMakeStringLowercase s1.name) > (sLibMakeStringLowercase s2.name) then return 1
	else return 0
	)

fn sLibNameCompareCaseSensitive s1 s2 = 
	(
	if s1.name < s2.name then return -1
	else if s1.name > s2.name then return 1
	else return 0
	)
	
fn sLibPadValue n pad =
	(
	local a = (n as string)
	for w = 1 to 99999 do
		(
		if a.count < pad then a = "0" + a
		else exit
		)
	return a
	)

fn sLibRemoveTailNumbers s =
	(
	s2 = (sLibReverseString s)
	if s2.count != 0 then
		(
		nums = "01234567890" 
		for i = 1 to s2.count do
			(
			j = findString nums s2[i]
			if (j == undefined) do 
				(
				newS = sLibReverseString (substring s2 i s2.count)
				return newS
				)
			)
		)
	)
	
fn sLibReverseString s =
	(
	newS = ""
	if s.count != 0 then
		(
		for i = s.count to 1 by -1 do newS += s[i]
		)
	return newS
	)
	
-------------------------------------------------------------------------------
-- Transforms
-------------------------------------------------------------------------------

fn sLibResetXForm obj = 
	(
	-- Code thanks To Larry Minton
	local ntm = obj.transform
	obj.transform=transMatrix obj.pos
	local piv=obj.objecttransform * inverse obj.transform
	obj.objectoffsetPos  = [0,0,0]
	obj.objectoffsetRot = (quat 0 0 0 1)
	obj.objectoffsetScale = [1,1,1]
	ntm.translation=[0,0,0]
	ntm = piv * ntm
	local xformMod=xform()
	addmodifier obj xformMod
	xformMod.gizmo.transform=ntm
	xformMod.name = "Reset Xform"
	)

fn sLibRotateObjByAxis obj rot =  
	(
	-- borrowed from the maxscript help file
	local axis
	local objA = if classof obj == objectSet or classof obj == array then obj else #(obj)
	if getCoordCenter() != #local then
		(
		axis = getTransformAxis objA[1] 0
		for obj1 in objA do in coordsys axis about axis rotate obj1 rot
		)
	else
		(
		for obj1 in objA do
			(
			axis = getTransformAxis obj1 0
			in coordsys axis about axis rotate obj1 rot
			)
		)
	)
	
-------------------------------------------------------------------------------
-- Values
-------------------------------------------------------------------------------

fn sLibRandomWithBias a b bias = 
	(
	a1 = a as float
	b1 = b as float
	randomNum = random 0.0 1.0
	--value = pow randomNum ((log bias)/(log 0.5))
	value = randomNum/((1/bias-2)*(1-randomNum)+1)
	remap = ((value)*(b1-a1)) + a1
	return remap
	)
	
-------------------------------------------------------------------------------
-- Initialization End
-------------------------------------------------------------------------------
Print "sLib v 1.31 has been loaded"
sLibInit = true
)
-------------------------------------------------------------------------------

-- Variables

global sPASpline
global sPANewS
global sPAThick

global sPABrushSizeValue = 10
global sPASplineDetailValue = 100
global sPANormalizeValue = false
global sPANormalizeFactorValue = 20.0
global sPAStepsValue = 2
global sPASurfaceOffsetValue = 0.0
global sPAPrefixValue = "sPA_Line"
global sPACloseValue = false
global sPARenderableValue = false
global sPAMappingValue = false
global sPAThicknessValue = 1 
global sPAMinThicknessValue = 1.0
global sPAMaxThicknessValue = 2.0
global sPASidesValue = 6
global sPAPlaceValue = 1

global sPAPaintOnList = #()
global sPALastSplines = #()

sPAPosValue = [85,90]

-- Functions

fn splinePainterDefaults = 
	(
	sPALoadDef()
	)

fn splinePainterUI = 
	(
	sPALoadDef()
	sPACloseOpenUI sPAPosValue
	)
	
fn sPACloseOpenUI pos = 
	(
-- 	if sPAFloater != undefined then CloseRolloutFloater sPAFloater
-- 	sPADefineUI()
-- 	sPAFloater = newRolloutFloater "Spline Painter" 210 629 pos.x pos.y
-- 	addRollout sPARollout sPAFloater
createdialog SplinePainter  width:210 height:629 pos:[140,210] bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)
	)

fn sPAstartStroke = 
	(
	thePainterInterface.undoStart()
	thePainterInterface.minSize = sPABrushSizeValue
	thePainterInterface.maxSize = sPABrushSizeValue
	
	sPASpline = line pos:[0,0,0]
	
	sPASpline.name = uniquename sPAPrefixValue
	sPASpline.baseobject.renderable = sPARenderableValue
	sPASpline.baseobject.DisplayRenderMesh = sPARenderableValue
	sPASpline.baseobject.mapCoords = sPAMappingValue
	if sPAThicknessValue == 1 then
		(
		sPAThick = random sPAMinThicknessValue sPAMaxThicknessValue
		sPASpline.baseobject.render_thickness = sPAThick
		)
	else sPASpline.baseobject.render_thickness = sPABrushSizeValue
	sPASpline.baseobject.render_sides = sPASidesValue
	sPASpline.baseobject.steps = sPAStepsValue
	
	sPANewS = addnewspline sPASpline
	)

fn sPApaintStroke = 
	(
	-- Variables
	localHit = Point3 0 0 0
	localNormal = Point3 0 0 0
	worldHit = Point3 0 0 0
	worldNormal = Point3 0 0 0
	str = 0.0f
	radius = 0.0f
	
	-- Get Hit Point
    	thePainterInterface.getHitPointData &localHit &localNormal &worldHit &worldNormal &radius &str 0
    	if sPAPlaceValue == 1 then dist = sPASurfaceOffsetValue
    	else if sPAPlaceValue == 2 then 
    		(
    		if sPAThicknessValue == 1 then dist = (sPAThick/2) + sPASurfaceOffsetValue
    		else dist = (sPABrushSizeValue/2) + sPASurfaceOffsetValue
     		)
	finalHit = worldHit + (dist*normalize(worldNormal))  

	-- Density
	if ((random 1 99) + (sPASplineDetailValue - 50)) > 50 then 
		(
		addknot sPASpline sPANewS #smooth #curve finalHit
		)
	)

fn sPAendStroke = 
	(
	if sPACloseValue == true then close sPASpline 1
	updateshape sPASpline
	if sPANormalizeValue == true then
		(
		pathLength = curveLength sPASpline 1
		nMod = Normalize_Spl()
		addmodifier sPASpline nMod
		nMod.length = pathLength / sPANormalizeFactorValue
		)
	append sPALastSplines sPASpline
	thePainterInterface.undoAccept()
	)

fn sPAcancelStroke = 
	(
	thePainterInterface.undoCancel()
	)

fn sPAsystemEnd = 
	(
	)
	
fn sPAHelp = 
	(
	sLibSSPrintHelp "splinePainter"
	)
	
fn sPALoadDef = 
	(
	presetDir = ((getdir #plugcfg) + "\\g9\\presets\\")
	sPAInputFilename = presetDir + "splinePainter.ini"
	if (sLibFileExist sPAInputFilename == true) then
		(
		sPABrushSizeValue = execute (getINISetting sPAInputFilename "splinePainter" "sPABrushSizeValue")
		sPASplineDetailValue = execute (getINISetting sPAInputFilename "splinePainter" "sPASplineDetailValue")
		sPANormalizeValue = execute (getINISetting sPAInputFilename "splinePainter" "sPANormalizeValue")
		sPANormalizeFactorValue = execute (getINISetting sPAInputFilename "splinePainter" "sPANormalizeFactorValue")
		sPAStepsValue = execute (getINISetting sPAInputFilename "splinePainter" "sPAStepsValue")
		sPASurfaceOffsetValue = execute (getINISetting sPAInputFilename "splinePainter" "sPASurfaceOffsetValue")
		sPAPrefixValue = getINISetting sPAInputFilename "splinePainter" "sPAPrefixValue"
		sPACloseValue = getINISetting sPAInputFilename "splinePainter" "sPACloseValue"
		sPARenderableValue = execute (getINISetting sPAInputFilename "splinePainter" "sPARenderableValue")
		sPAMappingValue = execute (getINISetting sPAInputFilename "splinePainter" "sPAMappingValue")
		sPAThicknessValue = execute (getINISetting sPAInputFilename "splinePainter" "sPAThicknessValue")
		sPAMinThicknessValue = execute (getINISetting sPAInputFilename "splinePainter" "sPAMinThicknessValue")
		sPAMaxThicknessValue = execute (getINISetting sPAInputFilename "splinePainter" "sPAMaxThicknessValue")
		sPASidesValue = execute (getINISetting sPAInputFilename "splinePainter" "sPASidesValue")
		sPAPlaceValue = execute (getINISetting sPAInputFilename "splinePainter" "sPAPlaceValue")
		sPAPosValue = execute (getINISetting sPAInputFilename "splinePainter" "sPAPosValue")
		
		if sPABrushSizeValue == OK then sPABrushSizeValue = 10
		if sPASplineDetailValue == OK then sPASplineDetailValue = 100
		if sPANormalizeValue == OK then sPANormalizeValue = false
		if sPANormalizeFactorValue == OK then sPANormalizeFactorValue = 20.0
		if sPAStepsValue == OK then sPAStepsValue = 2
		if sPASurfaceOffsetValue == OK then sPASurfaceOffsetValue = 0.0
		if sPAPrefixValue == OK then sPAPrefixValue = "sPA_Line"
		if sPACloseValue == OK then sPACloseValue = false
		if sPARenderableValue == OK then sPARenderableValue = false
		if sPAMappingValue == OK then sPAMappingValue = false
		if sPAThicknessValue == OK then sPAThicknessValue = 1
		if sPAMinThicknessValue == OK then sPAMinThicknessValue = 1.0
		if sPAMaxThicknessValue == OK then sPAMaxThicknessValue = 2.0
		if sPASidesValue == OK then sPASidesValue = 6
		if sPAPlaceValue == OK then sPAPlaceValue = 1
		if sPAPosValue == OK then sPAPosValue = [85,90]
		)
	else
		(
		sPABrushSizeValue = 10
		sPASplineDetailValue = 100
		sPANormalizeValue = false
		sPANormalizeFactorValue = 20.0
		sPAStepsValue = 2
		sPASurfaceOffsetValue = 0.0
		sPAPrefixValue = "sPA_Line"
		sPACloseValue = false
		sPARenderableValue = false
		sPAMappingValue = false
		sPAThicknessValue = 1 
		sPAMinThicknessValue = 1.0
		sPAMaxThicknessValue = 2.0
		sPASidesValue = 6
		sPAPlaceValue = 1
		sPAPosValue = [85,90]
		)
	)
	
fn sPASaveDef = 
	(
	presetDir = ((getdir #plugcfg) + "\\g9\\presets\\")
	if (getDirectories presetDir).count == 0 then makeDir presetDir
	sPAOutputFilename = presetDir + "splinePainter.ini"
	if (sLibFileExist sPAOutputFilename == true) then deleteFile sPAOutputFilename
	setINISetting sPAOutputFilename "splinePainter" "sPABrushSizeValue" (sPABrushSizeValue as string)
	setINISetting sPAOutputFilename "splinePainter" "sPASplineDetailValue" (sPASplineDetailValue as string)
	setINISetting sPAOutputFilename "splinePainter" "sPANormalizeValue" (sPANormalizeValue as string)
	setINISetting sPAOutputFilename "splinePainter" "sPANormalizeFactorValue" (sPANormalizeFactorValue as string)
	setINISetting sPAOutputFilename "splinePainter" "sPAStepsValue" (sPAStepsValue as string)
	setINISetting sPAOutputFilename "splinePainter" "sPASurfaceOffsetValue" (sPASurfaceOffsetValue as string)
	setINISetting sPAOutputFilename "splinePainter" "sPAPrefixValue" (sPAPrefixValue as string)
	setINISetting sPAOutputFilename "splinePainter" "sPACloseValue" (sPACloseValue as string)
	setINISetting sPAOutputFilename "splinePainter" "sPARenderableValue" (sPARenderableValue as string)
	setINISetting sPAOutputFilename "splinePainter" "sPAMappingValue" (sPAMappingValue as string)
	setINISetting sPAOutputFilename "splinePainter" "sPAThicknessValue" (sPAThicknessValue as string)
	setINISetting sPAOutputFilename "splinePainter" "sPAMinThicknessValue" (sPAMinThicknessValue as string)
	setINISetting sPAOutputFilename "splinePainter" "sPAMaxThicknessValue" (sPAMaxThicknessValue as string)
	setINISetting sPAOutputFilename "splinePainter" "sPASidesValue" (sPASidesValue as string)
	setINISetting sPAOutputFilename "splinePainter" "sPAPlaceValue" (sPAPlaceValue as string)
	setINISetting sPAOutputFilename "splinePainter" "sPAPosValue" (sPAFloater.pos as string)
	)

-- UI

fn sPADefineUI = 
	(
	try(destroyDialog sPARollout)catch()
	rollout sPARollout "splinePainter"
		(
		group "Paint On"
		(
		button sPAPaintOnButton "Add Sel To Paint On List" toolTip:"Add Selection To Paint On List" width:153 align:#left across:2
		button sPAPaintOnDelButton "-" toolTip:"Delete Choosen Object From Paint On List" width:15 align:#right
		listbox sPAPaintOnListbox "Paint On List:" items:sPAPaintOnList height:6
		)

		group "Options"
		(
		spinner sPABrushSizeSpinner "Brush Size: " range:[0,9999999,sPABrushSizeValue] fieldWidth:40 type:#float align:#right
		spinner sPASplineDetailSpinner "Spline Detail: " range:[0,100,sPASplineDetailValue] fieldWidth:40 type:#float align:#right
		checkbox sPANormalizeCheckbox "Normalize?" checked:sPANormalizeValue across:2
		spinner sPANormalizeFactorSpinner "Factor: " range:[1,999999,sPANormalizeFactorValue] type:#float fieldWidth:35 offset:[0,1]
		spinner sPAStepsSpinner "Spline Steps: " range:[0,100,sPAStepsValue] fieldWidth:40 type:#integer align:#right
		spinner sPASurfaceOffsetSpinner "Surface Offset: " range:[-9999999,9999999,sPASurfaceOffsetValue] fieldWidth:40 type:#float align:#right
		edittext sPAPrefixEditText "Prefix:" fieldWidth:110 text:sPAPrefixValue align:#right
		button sPASelectObjsButton "Select" width:80 align:#center toolTip:"Select Previous Painted Objects" across:2
		button sPADeleteObjsButton "Delete" width:80 align:#center toolTip:"Delete Previous Painted Objects"
		checkbox sPACloseCheckbox "Close?" checked:sPACloseValue align:#right
		)
		
		group "Renderable"
		(
		checkbox sPARenderableCheckbox "Renderable?" checked:sPARenderableValue align:#right
		checkbox sPAMappingCheckbox "Generate Mapping Coords?" checked:sPAMappingValue align:#right
		dropdownlist sPAThicknessDropdown "" items:#("Random Thickness", "Thickness Based On Brush Size") width:170 selection:sPAThicknessValue align:#right
		spinner sPAMinThicknessSpinner "Min Thickness: " range:[0,9999999,sPAMinThicknessValue] fieldWidth:40 type:#float align:#right
		spinner sPAMaxThicknessSpinner "Max Thickness: " range:[0,9999999,sPAMaxThicknessValue] fieldWidth:40 type:#float align:#right
		spinner sPASidesSpinner "Sides: " range:[3,100,sPASidesValue] fieldWidth:40 type:#integer align:#right
		dropdownlist sPAPlaceDropdown "" items:#("Place Spline On Surface", "Place Surface On Surface") width:170 selection:sPAPlaceValue align:#right
		)
		
		checkbutton sPAOnOrOffButton "Paint" checked:false align:#center width:170

		on sPAPaintOnButton pressed do 
			(
			sPAPaintOnList = #()
			error = false
			for i in selection do
				(
				if (sLibGeometryFilter i) == false then error = true
				else append sPAPaintOnList i.name
				)
			if error == true then (MessageBox "One of your objects to be painted on is not a piece of geometry and was removed from your list." title:"splinePainter")
			curPos = sPAFloater.pos
			curOn = sPAOnOrOffButton.checked
			sPACloseOpenUI curPos
			if curOn == true then (sPAOnOrOffButton.text = "Stop Paint";sPAOnOrOffButton.checked = true)
			)
		on sPAPaintOnDelButton pressed do 
			(
			if sPAPaintOnList.count != 0 then 
				(
				deleteItem sPAPaintOnList sPAPaintOnListbox.selection
				curPos = sPAFloater.pos
				curOn = sPAOnOrOffButton.checked
				sPACloseOpenUI curPos
				if curOn == true then (sPAOnOrOffButton.text = "Stop Paint";sPAOnOrOffButton.checked = true)
				)
			)

		on sPABrushSizeSpinner changed val do sPABrushSizeValue = val
		on sPASplineDetailSpinner changed val do sPASplineDetailValue = val
		on sPANormalizeCheckbox changed state do 
			(
			sPANormalizeValue = state
			sPANormalizeFactorSpinner.enabled = state
			)
		on sPANormalizeFactorSpinner changed val do sPANormalizeFactorValue = val
		on sPAStepsSpinner changed val do sPAStepsValue = val
		on sPASurfaceOffsetSpinner changed val do sPASurfaceOffsetValue = val
		on sPAPrefixEditText changed text do sPAPrefixValue = sPAPrefixEditText.text
		on sPACloseCheckbox changed state do sPACloseValue = state
		
		on sPASelectObjsButton pressed do 
			(
			undo "splinePainter" on
				(
				sPALastSplinesWhoExist = #()
				myerror = false
				for o in sPALastSplines do
					(
					if (IsValidNode o) == true then append sPALastSplinesWhoExist o
					else myerror = true 
					)
				if myerror == true then (MessageBox "At least one spline no longer exists. Selecting any splines that still exist." title:"splinePainter")
				if sPALastSplinesWhoExist.count != 0 then (select sPALastSplinesWhoExist)
				)
			)
		on sPADeleteObjsButton pressed do 
			(
			undo "splinePainter" on
				(
				sPALastSplinesWhoExist = #()
				myerror = false
				for o in sPALastSplines do
					(
					if (IsValidNode o) == true then append sPALastSplinesWhoExist o
					else myerror = true 
					)
				if myerror == true then (MessageBox "At least one spline no longer exists. Selecting any splines that still exist." title:"splinePainter")
				for o in sPALastSplinesWhoExist do delete o
				sPALastSplines = #()
				sPALastSplinesWhoExist = #()
				)
			)

		on sPARenderableCheckbox changed state do 
			(
			sPARenderableValue = state		
			curPos = sPAFloater.pos
			curOn = sPAOnOrOffButton.checked
			sPACloseOpenUI curPos
			if curOn == true then (sPAOnOrOffButton.text = "Stop Paint";sPAOnOrOffButton.checked = true)
			)
		on sPAMappingCheckbox changed state do sPAMappingValue = state	
		on sPAThicknessDropdown selected i do
			(
			sPAThicknessValue = i
			curPos = sPAFloater.pos
			curOn = sPAOnOrOffButton.checked
			sPACloseOpenUI curPos
			if curOn == true then (sPAOnOrOffButton.text = "Stop Paint";sPAOnOrOffButton.checked = true)
			)
		on sPAMinThicknessSpinner changed val do sPAMinThicknessValue = val
		on sPAMaxThicknessSpinner changed val do sPAMaxThicknessValue = val
		on sPASidesSpinner changed val do sPASidesValue = val
		on sPAPlaceDropdown selected i do
			(
			sPAPlaceValue = i
			curPos = sPAFloater.pos
			curOn = sPAOnOrOffButton.checked
			sPACloseOpenUI curPos
			if curOn == true then (sPAOnOrOffButton.text = "Stop Paint";sPAOnOrOffButton.checked = true)
			)
	
		on sPAOnOrOffButton changed state do 
			(
			if state == false then 
				(
				sPAOnOrOffButton.text = "Paint"
				thePainterInterface.endPaintSession()
				)
			else 
				(
				if sPAPaintOnList.count == 0 then
					(
					MessageBox "Please add objects to the 'Paint On' List" title:"splinePainter"
					sPAOnOrOffButton.checked = false
					)
				else
					(
					sPAOnOrOffButton.text = "Stop Paint"
					thePainterInterface.endPaintSession()
					thePainterInterface.ScriptFunctions sPAstartStroke sPApaintStroke sPAendStroke sPAcancelStroke sPAsystemEnd
					sPAPaintOnObjList = for i in sPAPaintOnList collect (getNodeByName i)
					thePainterInterface.initializeNodes 0 sPAPaintOnObjList
					thePainterInterface.startPaintSession()
					)
				)
			)
			
		button sPAHelpButton "Help" width:50 toolTip:"Help" pos:[45,570]
		on sPAHelpButton pressed do sPAHelp()
		button sPASaveDefButton "SaveDef" width:50 toolTip:"Save Current Settings as Default" pos:[100,570]
		on sPASaveDefButton pressed do sPASaveDef()
		
		on sPARollout open do
			(
			if sPARenderableValue == false then
				(
				sPAPlaceValue = 1
				sPAPlaceDropdown.selection = 1
				sPAPlaceDropdown.enabled = false
				sPAMappingCheckbox.enabled = false
				sPAThicknessDropdown.enabled = false
				sPAMaxThicknessSpinner.enabled = false
				sPAMinThicknessSpinner.enabled = false
				sPASidesSpinner.enabled = false
				)
			if sPAThicknessValue == 2 then (sPAMinThicknessSpinner.enabled = false;sPAMaxThicknessSpinner.enabled = false)
			if sPANormalizeValue == true then sPANormalizeFactorSpinner.enabled = true else sPANormalizeFactorSpinner.enabled = false
			)
		)
	)
)
-------------------------------------------------------------------------------
	splinePainterUI()
	)
