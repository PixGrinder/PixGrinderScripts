/*##############################################################################
CompLoc Component
Version 0.01
Script By Cl�ment "Sugz" Plantec
plantec.clement@gmail.com

# Required Components:
SugzTools Manager
SugzTools Extend Maxscript Library
SugzTools Custom Attributes Library
SugzTools Spreadsheet Parser Library

# Script infos:

# Sources:

# To do list:
- set all rightclick on hotspot buttons
- send warning when selecting a component if it has a undefined relative

# History:

*Use / Modify this script at your own risk !*
###############################################################################*/



global _cplc, _ca, _csv
if doesFileExist "$userscripts\SugzTools\Libs\Custom_Attributes_Lib.ms" do include "$userscripts\SugzTools\Libs\Custom_Attributes_Lib.ms"
if doesFileExist "$userscripts\SugzTools\Libs\Spreadsheet_Parser_Lib.ms" do include "$userscripts\SugzTools\Libs\Spreadsheet_Parser_Lib.ms"
_ca = CustomAttributesLibraryStc()
_csv = SpreadsheetParserLibraryStc()	

try(destroyDialog _cplc.CplcView) catch()
-- try (destroyDialog _hotspot.HotspotListView) catch()


struct CompLocComponentStc
(
	-- the excel columns number
	atasCol = "3D ATA",
	usersCol = "Graphist",
	namesCol = "Element name in 3D",
	startupVisCol = "Visible at start-up",
	hotspotCol = "Hotspot location",
	transparentCol = "Transparent Container",
	hiddenCol = "Panel to hide",
	animatedCol = "Animation",
	
	
	compLocCA = undefined,				-- The comploc custom attribute
	hotspotCA = undefined,					-- The hotspot custom attribute
	
	CplcView = undefined,					-- The rollout
	atas = #(),										-- The ATAs for current user
	requiredComponents = #(),			-- The required compononts for a given ata
	sceneComponents = #(),				-- The scene objects whose have the comploc custom attribute
	
	heights = #(1.0, 10.0, 18.0, 35.0),
	insidePos = #([28.5, 3.89101, 19.5], [28.5, -3.92987, 19.5], [32.5, 0, 19], [46.5, 0, 18.25]),
	
	
	
	/* Set the items on the location dopdownlist ############################################################################################*/
	fn GetLocations locationType = 
	(
		/*<Function>
		Description:
			Set the locations on the location dopdownlist
		Arguments:
			<Integer> locationType: 1 for outside, 2 for inside the cabin
		Return:
			<Array <String>>  locations: the locations depending on the locationType
		</Function>*/
		
		locations = case locationType of 
		(
			1: (#("Lying (0,1 m)", "Crouched (1 m)", "Standing (1,8 m)", "Ladder (3,5 m)"))
			2: (#("Pilot", "Copilot", "Cabin FWD", "Cabin AFT"))
		)
		
		locations
	),
	
	
	
	/* Add or Update the comploc custom attribute on selection  ############################################################################################*/
	fn AddCA nodes custAttr =
	(
		/*<Function>
		Description:
			Add or Update the comploc custom attribute on selection
		Arguments:
			<Array <Node>> nodes: the nodes to apply the custom attribute
			<Var> custAttr: the custom attribute: compLocCA / hotspotCA
		</Function>*/
		
		if nodes.count != 0 then custAttributes.add nodes custAttr BaseObject:true
		
	),
	
	
	
	/* Remove the comploc custom attribute on a node ############################################################################################*/
	fn RemoveCA _node custAttr =
	(
		/*<Function>
		Description:
			Remove the comploc custom attribute on a node
		Arguments:
			<Node> _node: the node to remove the custom attribute
			<Name> custAttr: the name of the custom attribute: #compLoc / #hotspotAttr
		</Function>*/
		
		_ca.RemoveCA custAttr nodeList:(_sgz._extMxs.AsArray _node)
	
	),
	
	
	
	/* Check if an object is a component ############################################################################################*/
	fn IsComponent obj = 
	(
		/*<Function>
		Description:
			Check if an object is a component
		Arguments:
			<Node> obj: the object to check
		Return:
			<Bool> _isComponent: wheter the object is a component
		Further Infos:
		</Function>*/
		
		_isComponent = false
		hasCA = _ca.CheckForCustAttr obj #compLoc
		
		if hasCA[1] 
			then _isComponent = true
		else if queryBox "Do you want to set the selected object as component ?" beep:false then 
		(
			_isComponent = true
			AddCA #(obj) compLocCA
		)
		
		_isComponent
	
	),
	
	
	
	/* Check an hotspot position to determinate its locationType and location ############################################################################################*/
	fn GetHotspotLocation cam =
	(
		/*<Function>
		Description:
		Arguments:
		Return:
		Further Infos:
		</Function>*/
		
		returnVal = #(0, 0)
		
		find = false
		for i = 1 to insidePos.count while not find do 
		(
			absPos = cam.pos - insidePos[i]
			if (abs absPos[1]) < 0.1 and (abs absPos[2]) < 0.1 and (abs absPos[3]) < 0.1 then returnVal = #(2, i)
		)
		
		if not find then for i = 1 to heights.count while not find do 
		(
			absPos = cam.pos.z - heights[i]
			if (abs absPos) < 0.1 then returnVal = #(1, i)
		)
		
		returnVal
	
	),
	
	
	
	/* Create a hotspot ############################################################################################*/
	fn CreateHotspot refObj locationType location = 
	(
		/*<Function>
		Description:
			Create a hotspot
		Arguments:
			<Integer> locationType: the index of the location type dropdownlist 
			<Integer> location: the index of the location dropdownlist
		</Function>*/
		
		
		function CreateCam refObj = 
		(
			tm = Inverse(viewport.getTM())
				
			cam = Physical_Camera wirecolor:blue transform:tm name:(refObj.name + "_Hotspot")
			cam.targeted = true
			cam.target.pos = refObj.center
			cam.pos = tm.translationpart
			
			cam.parent = cam.target.parent = refObj
			
			setTransformLockFlags cam.target #{1..9}
				
			cam
		)
		
		
		function SetAsHotspot obj locationType location = 
		(
			AddCA #(obj) hotspotCA
			obj.locationType = locationType
			obj.location = location
			
			obj.parent.hotspot = obj
		
			viewport.setCamera obj
			select obj
		)
		
		
		if IsComponent refObj then 
		(
			cam = undefined
			
			for child in refObj.children while cam == undefined do 
				if superClassOf child == camera then cam = child
			
			if cam == undefined then cam = CreateCam refObj
			
			SetAsHotspot cam locationType location
		)
	),
	
	
	
	/* The Hotspot custom attribute  ############################################################################################*/
	fn SetHotspotCA = 
	(
		hotspotCA = attributes hotspotAttr attribID:#(0x6a52912, 0x6fe9699)
		(
			
			/* Get the node this custom attribute is attached to ***************************************************************************************************************************************************************/
			function GetNode = (refs.dependentnodes (custattributes.getowner this) firstonly:on)
			
			
			/* Open the comploc struct ***************************************************************************************************************************************************************/
			function OpenStruct =
			(
				/*<Function>
				Description:
					Open the comploc struct
				</Function>*/
				
				global _cplc
				if _cplc == undefined then 
					if doesFileExist "$userscripts\SugzTools\Scripts\CompLoc_Component.ms" then fileIn "$userscripts\SugzTools\Scripts\CompLoc_Component.ms"
			
			)
			
			parameters hotspotParams rollout:hotspotView
			(
				locationType type:#integer ui:locationTypeRdb
				location type:#integer ui:locationDdl
				
				on location set val do
				(
					if _cplc != undefined then case locationType of 
					(
						1: (GetNode()).pos.z = _cplc.heights[val]
						2: (GetNode()).pos = _cplc.insidePos[val]
					)
				)
				
			)
			
			rollout hotspotView "Hotspot"
			(
				radiobuttons locationTypeRdb labels:#("Outside", "Inside") align:#left offsets:#([-5,0], [15,0])
				dropdownlist locationDdl items:#() width:150 align:#center
				button selectComponent "Select Component" width:150 align:#center
				
				
				on hotspotView open do 
				(
					OpenStruct()
					locationDdl.items = _cplc.GetLocations this.locationType
				)
				
				
				on locationTypeRdb changed val do 
				(
					locationDdl.items = _cplc.GetLocations this.locationType
					this.location = 1
				)
				
				
				on selectComponent pressed do select (GetNode()).parent
				
			)
		)
	),
	
	
	
	/* The Comploc custom attribute ############################################################################################*/
	fn SetCompLocCA =
	(
		/*<Function>
		Description:
		Arguments:
		Return:
		Further Infos:
		</Function>*/
		
		compLocCA = attributes compLoc attribID: #(0x5887f429, 0x3990ace3)
		(
			/* Functions ############################################################################################*/
			/* Get the node this custom attribute is attached to ***************************************************************************************************************************************************************/
			function GetNode = (refs.dependentnodes (custattributes.getowner this) firstonly:on)
			
			
			/* Open the comploc struct ***************************************************************************************************************************************************************/
			function OpenStruct =
			(
				/*<Function>
				Description:
					Open the comploc struct
				</Function>*/
				
				global _cplc
				if _cplc == undefined then 
					if doesFileExist "$userscripts\SugzTools\Scripts\CompLoc_Component.ms" then fileIn "$userscripts\SugzTools\Scripts\CompLoc_Component.ms"
			
			)
				
				
			parameters compParams rollout:compView
			(
				hotspot type:#node
				transparent type:#nodeTab tabSize:0 tabSizeVariable:on
				hidden type:#nodeTab tabSize:0 tabSizeVariable:on
				animated type:#nodeTab tabSize:0 tabSizeVariable:on
			)
			 
			rollout compView "CompLoc Component"
			(
				groupbox hotspotGrp " Hotspot: " width:150 height:95 align:#right offset:[7,0]
				radiobuttons locationTypeRdb labels:#("Outside", "Inside") align:#left offset:[0,-80] offsets:#([0,0], [15,0])
				dropdownlist locationDdl width:140 align:#center
				button hotspotBtn "Set Hotspot" width:140 align:#center
				
				dropdownlist relativesObjectsDdl items:#("Transparent", "Hidden", "Animated") width:150 align:#center offset:[0,10]
				listbox relatedObjectsList width:150 height:7 align:#center offset:[0,-5]
				pickbutton addObjectsBtn "Add" width:70 align:#left offset:[-7,-3] across:2 
				button removeObjectsBtn "Remove" width:70 align:#right offset:[7,-3] 
				
				
				/* Functions ############################################################################################*/
				/* Set the related objects listbox ***************************************************************************************************************************************************************/
				function UpdateRelatedList = 
				(
					relatedObjectsList.items = 
					(
						case relativesObjectsDdl.selection of
						(
							1: for obj in this.transparent where obj != undefined collect obj.name
							2: for obj in this.hidden where obj != undefined collect obj.name
							3: for obj in this.animated where obj != undefined collect obj.name
						)
					)
					
				)
				
				
				/* Get hotspot infos ***************************************************************************************************************************************************************/
				function GetHotspotInfos = 
				(
					if this.hotspot != undefined then 
					(
						locationTypeRdb.state = this.hotspot.locationType
						locationDdl.selection = this.hotspot.location
						hotspotBtn.text = "Select Hotspot"
					)
				)
				
				
				
				/* Events ############################################################################################*/
				on compView open do 
				(
					OpenStruct()
					GetHotspotInfos()
					UpdateRelatedList()
					
					locationDdl.items = _cplc.GetLocations locationTypeRdb.state
					
				)
				
				
				
				/* Set the hotspot locationtype and change the UI accordingly ***************************************************************************************************************************************************************/
				on locationTypeRdb changed val do 
				(
					locationDdl.items = _cplc.GetLocations locationTypeRdb.state
					locationDdl.selection = 1
					
					if this.hotspot != undefined then 
					(
						this.hotspot.locationType = val
						this.hotspot.location = 1
					)
				)
				
				
				
				/* Set the hotspot location ***************************************************************************************************************************************************************/
				on locationDdl selected item do 
				(
					if this.hotspot != undefined then this.hotspot.location = item
				)
				
				
				/* Select or create the hotspot ***************************************************************************************************************************************************************/
				on hotspotBtn pressed do 
				(
					-- Select the camera if the hotspot is already defined, create it otherwise
					if this.hotspot != undefined
						then select this.hotspot
						else _cplc.CreateHotspot (GetNode()) locationTypeRdb.state locationDdl.selection
					
				)
				
				
				
				/* Remove the hotspot ***************************************************************************************************************************************************************/
				on hotspotBtn rightclick do
				(
					/*
					if this.hotspot != undefined then
					(
						delete this.hotspot
						this.hotspot = undefined 
						this.view.hotspotBtn.text = "Set Hotspot"
					)
					*/
				)
				
				
				
				/* Change the related objects listbox based on the dropdownlist selection ***************************************************************************************************************************************************************/
				on relativesObjectsDdl selected item do UpdateRelatedList()
				
				
				
				/* Add picked object to one of the related objects list ***************************************************************************************************************************************************************/
				on addObjectsBtn picked obj do
				(
					case relativesObjectsDdl.selection of
					(
						1: append this.transparent obj
						2: append this.hidden obj
						3: append this.animated obj
					)
					UpdateRelatedList()
				)
				
				
				
				/*  Remove selected object from the listbox of the related objects list***************************************************************************************************************************************************************/
				on removeObjectsBtn pressed do
				(
					case relativesObjectsDdl.selection of
					(
						1: deleteItem this.transparent (relatedObjectsList.selection)
						2: deleteItem this.hidden (relatedObjectsList.selection)
						3: deleteItem this.animated (relatedObjectsList.selection)
					)
					UpdateRelatedList()
				)
				
			) -- End rollout
			
			
		)
	
	),
	
	
	
	/* Get a formated position of an hotspot ############################################################################################*/
	fn GetHotspot cam = 
	(
		ss = StringStream ""
		
		if cam != undefined then 
		(
			hasTarget = false
			if cam.targeted then 
			(
				hasTarget = true 
				cam.targeted = false
			)
			
			format "%, %, %" (-cam.pos[1] / 10) (cam.pos[3] / 10) (-cam.pos[2] / 10) to:ss
			
			if hasTarget then cam.targeted = true
		)
			
		ss as string
	),
	
	
	
	/* Get a formated list of relatives objects of a component ############################################################################################*/
	fn GetRelatives relatives =
	(
		ss = StringStream ""
		for i = 1 to relatives.count do 
		(
			if relatives[i] != undefined then 
			(
				append ss (relatives[i].name)
				if i != relatives.count then append ss ", "
			)
			else format "relatives: %\n" relatives
		)
		
		ss as string
	),
	
	
	
	/* Export to a excel file the component and related objects list ############################################################################################*/
	fn ExcelExport =
	(
		/*<Function>
		Description:
		Arguments:
		Return:
		Further Infos:
		</Function>*/
		
		file = getOpenFileName title:"Select the synthesis file"
		if file != undefined then 
		(
			excel = CreateOLEObject "Excel.Application"
		
			-- Open the correct activesheet
			excel.application.Workbooks.Open(file)
			
			try ((excel.Worksheets "FromMax").Activate) 
			catch 
			(
				excel.ActiveWorkbook.Sheets.Add
				excel.ActiveSheet.Name = "FromMax"
			)
			
			-- Define Columns name
			col = #("A", "B", "C", "D", "E", "F")
			colName = #("Element name in 3D", "Visible at start-up", "Hotspot location", "Transparent Container", "Panel to hide", "Animation")
			for i = 1 to col.count do (excel.application.Range(col[i] + 1 as string)).value = colName[i]
			
			-- Write values
			i = 2
			for component in sceneComponents do 
			(
	-- 				format "component: %, hotspot: %\n\ttransparent: %\n\thidden: %\n\tanimated: %\n" component.name (GetHotspot component.hotspot) (GetRelatives component.transparent) (GetRelatives component.hidden) (GetRelatives component.animated)
				
				(excel.application.Range("A" + i as string)).value = component.name
				-- visible at startup ?
				(excel.application.Range("C" + i as string)).value = GetHotspot component.hotspot
				(excel.application.Range("D" + i as string)).value = GetRelatives component.transparent
				(excel.application.Range("E" + i as string)).value = GetRelatives component.hidden
				(excel.application.Range("F" + i as string)).value = GetRelatives component.animated
				
				i += 1
			)
			
			-- Save and close excel
			excel.DisplayAlerts = false
			excel.application.ActiveWorkbook.SaveAs(file)
			excel.application.ActiveWorkbook.Close
			excel.quit()
			releaseAllOLEObjects()
			
			messageBox "The writing on the excel file has gone well ;)"
		)
		
		
	),
	
	
	
	/* Check if scene components has no undefined relatives ############################################################################################*/
	fn ComponentChecker = 
	(
		/*<Function>
		Description:
			Check if scene components has no undefined relatives
		</Function>*/
		
		for component in sceneComponents do 
		(
			if component.hotspot == undefined do format "component: %\n\thotspot: %\n" component component.hotspot
			for obj in component.transparent where obj == undefined do format "component: %\n\ttransparent: %\n" component obj
			for obj in component.hidden where obj == undefined do format "component: %\n\thidden: %\n" component obj
			for obj in component.animated where obj == undefined do format "component: %\n\tanimated: %\n" component obj
		)
	),
	
	
	/* View ############################################################################################*/
	fn GetView = 
	(
		Rollout CplcView "CompLoc Components"
		(
			local dnColor = dotNetClass "System.Drawing.Color" -- dotNetClass to define colors
			local red = dnColor.FromArgb 255 150 40 40
			local green = dnColor.FromArgb 255 30 100 30
			
			label requiredComponentsLbl "Required Components :" align:#left offset:[-5,0]
			dropdownlist usersDdl width:60 align:#left offset:[114,-21]
			dropdownlist atasDdl width:60 align:#left offset:[174,-27]
			dotNetControl requiredComponentsList "listView" width:240 height:354 align:#left offset:[-7,-3]
			
			groupbox requiredSeparatorGrp width:230 height:7 align:#left offset:[-2,-3]
			
			label requiredHotspotBtn "Hotspot: " width:240 height:20 align:#left offset:[-7,4]
			dropdownlist requiredObjectsTypeDdl items:#("Transparent", "Hidden", "Animated") width:240 align:#left offset:[-7,-3]
			listbox requiredRelatedObjectsList width:240 height:8 align:#left offset:[-7,-5]
			
			edittext CSVFileTxt width:185 align:#left offset:[-10,-1] 
			button setCSVFilePathBtn "..." width:25 align:#center offset:[-45,-24] tooltip:"Set the spreadsheet path" 
			button loadCSVFileBtn "L" width:25 align:#center offset:[-17,-26] tooltip:"Load the spreadsheet" enabled:false
			
			label sceneComponentsLbl "Scene Components :" align:#left offset:[245,-574]
			listbox sceneComponentsList  width:240 height:25 align:#right offset:[7,0]
			button addComponentBtn "Add" width:76  align:#right offset:[-157,-3] 
			button removeComponentBtn "Remove" width:77  align:#right offset:[-75,-26] 
			button reloadComponentsBtn "Reload" width:77  align:#right offset:[7,-26] 

			groupbox hotspotGrp " Hotspot: " width:240 height:70 align:#right offset:[7,0]
			radiobuttons locationTypeRdb labels:#("Outside", "Inside") default:1 columns:2 align:#center offset:[70,-55]  --offsets:#([-5,0], [15,0])
			dropdownlist locationDdl width:110 align:#right offset:[2,-23] 
			button sceneHotspotBtn "Set Hotspot" width:230 height:20 align:#right offset:[2,1]

			dropdownlist sceneRelatedTypeDdl items:#("Transparent", "Hidden", "Animated") width:240 align:#right offset:[7,10]
			listbox sceneRelatedObjectsList width:240 height:8 align:#right offset:[7,-5]
			button sceneAddRelatedBtn "Add Objects" width:115 align:#center offset:[60,-3] 
			button sceneRemoveRelatedBtn "Remove Object" width:115 align:#right offset:[7,-26] 
			
			
			
			/* Functions ############################################################################################*/
			
			/* Initialize the look and feeel fo the listviews ***************************************************************************************************************************************************************/
			fn InitListViews = 
			(
				for lv in #(requiredComponentsList) do 
				(
					--Setup the forms view
					lv.view=(dotNetClass "system.windows.forms.view").details
					lv.FullRowSelect = true
					lv.MultiSelect = false		
					lv.HideSelection = false
					lv.AllowColumnReorder = false
					lv.BackColor = dnColor.FromArgb 255 86 86 86
					lv.ForeColor = dnColor.FromArgb 255 225 225 225
					lv.HeaderStyle = lv.HeaderStyle.None
					lv.columns.add "" 235
				)
			)
			
			
			/* Set the spreadsheet file path edittext ***************************************************************************************************************************************************************/
			fn SetCSVFilePathEdittext= 
			(
				if _csv.file != undefined then
				(
					CSVFileTxt.text = _csv.file as string
					loadCSVFileBtn.enabled = true
				)
				else CSVFileTxt.text = "Set the spreadsheet path"
			)
			
			
			
			/* Get objects from a name contain in a specific layer ***************************************************************************************************************************************************************/
			fn GetComponent name layer:"optim" = 
			(
				/*<Function>
				Description:
					Get objects from a name contain in a specific layer
				Arguments:
				Return:
				Further Infos:
				</Function>*/
				
				nodes = (getNodeByName name all:true)
				if atasDdl.items.count != 0 then 
				(
					layerName = layer + "_components_ata_" + _cplc.atas[atasDdl.selection] as string
					nodes = for n in nodes where toLower n.layer.name == layerName and IsValidNode n collect n
				)
				
				nodes
			)
			
			
			
			/* Set the scene component label ***************************************************************************************************************************************************************/
			fn UpdateSceneComponentLabel = 
			(
				-- Get the count of required and scene components that match required ones
				requiredCount = _cplc.requiredComponents.count
				if requiredCount != 0 then 
				(
					sceneCount = 0
					for requiredComponent in _cplc.requiredComponents do 
					(
						for sceneComponent in _cplc.sceneComponents do 
							if requiredComponent == sceneComponent then sceneCount += 1
					)
					
					-- Update the scene component label
					sceneComponentsLbl.text = "Scene Components : " + sceneCount as string  + " / " + requiredCount  as string
				)
				
				else sceneComponentsLbl.text = "Scene Components : "
			)
			
			
			
			/* Set the required components listbox ***************************************************************************************************************************************************************/
			fn FillRequiredComponentsList = 
			(
				-- Get the required components for a given ata
				_cplc.requiredComponents = _csv.GetColumn (_csv.GetColumnIndex _cplc.namesCol) columnFilter:(_csv.GetColumnIndex _cplc.atasCol) filter:(_cplc.atas[atasDdl.selection] as string)
				
				-- Clear the listview and add each component
				requiredComponentsList.items.Clear()
				for component in _cplc.requiredComponents do
				(
					listViewItem = dotNetObject "System.Windows.Forms.ListViewItem" component		
					listViewItem.BackColor = if (GetComponent component).count != 0 then (dnColor.FromArgb 255 30 100 30) 
					else 
					(
						if (GetComponent component layer:"cao").count != 0 
							then (dnColor.FromArgb 255 158 92 12) 
							else (dnColor.FromArgb 255 150 40 40)
					)
					
					requiredComponentsList.items.add listViewItem
				)
				
				UpdateSceneComponentLabel()
			)
			
			
			
			/* Set the ATAs dropdownlist ***************************************************************************************************************************************************************/
			fn FillAtasList = 
			(
				-- Fill the atas array and convert their value to integer and fill the dropdownlist
				_cplc.atas = _csv.GetColumn (_csv.GetColumnIndex _cplc.atasCol) columnFilter:(_csv.GetColumnIndex _cplc.usersCol) filter:usersDdl.selected
				_cplc.atas = for ata in _cplc.atas collect (ata as integer)
				atasDdl.items = for ata in _cplc.atas collect ("ATA " + ata as string)
				
				FillRequiredComponentsList()
			)
			
			
			
			/* Load the spreadsheet  ***************************************************************************************************************************************************************/
			fn LoadCSV =
			(
				/*<Function>
				Arguments:
				Return:
				Further Infos:
				</Function>*/
				
				-- Convert the file to CSV if it's a XLSX and fill the edittext with the csv path
				if getFilenameType _csv.file != ".csv" then _csv.ConvertXLSXToCSV "Complete-Unity"
				CSVFileTxt.text = _csv.file
				
				-- Get the user list
				users = _csv.GetColumn (_csv.GetColumnIndex _cplc.usersCol)
				usersDdl.items = for user in users collect user
					
				FillAtasList()
			
			)
			
			
			
			/* Get all scene components and set the scene component listbox ***************************************************************************************************************************************************************/
			fn FillSceneComponentsList = 
			(
				_cplc.sceneComponents = _ca.GetObjsWithCA #compLoc
				sceneComponentsList.items = _sgz._extMxs.SortStrings (for obj in _cplc.sceneComponents collect obj.name)
					
				UpdateSceneComponentLabel()
			)
			
			
			
			/* Get hotspot infos ***************************************************************************************************************************************************************/
			fn GetHotspotInfos obj = 
			(
				if obj.hotspot != undefined then 
				(
					locationTypeRdb.state = obj.hotspot.locationType
					locationDdl.selection = obj.hotspot.location
					sceneHotspotBtn.text = "Select Hotspot"
				)
				else 
				(
					locationTypeRdb.state = locationDdl.selection = 1
					sceneHotspotBtn.text = "Set Hotspot"
				)
			)
			
			
			
			/* Set scene related objects listbox and hotspot button ***************************************************************************************************************************************************************/
			fn SetSceneRelatedObjects =
			(
				if _cplc.sceneComponents.count != 0 then 
				(
					component = (GetComponent sceneComponentsList.selected)[1]
					sceneRelatedObjectsList.items = 
					(
						case sceneRelatedTypeDdl.selection of
						(
							1: for obj in component.transparent where obj != undefined collect obj.name
							2: for obj in component.hidden where obj != undefined collect obj.name
							3: for obj in component.animated where obj != undefined collect obj.name
						)
					)
					
					GetHotspotInfos component
				)
				
				else sceneRelatedObjectsList.items = #()
				
				locationDdl.items = _cplc.GetLocations locationTypeRdb.state
			)
			
			
			
			/* Events ############################################################################################*/
			/* Set the UI on opening ***************************************************************************************************************************************************************/
			on CplcView open do 
			(
				InitListViews()
				SetCSVFilePathEdittext()
				FillSceneComponentsList()
				SetSceneRelatedObjects()
			)
			
			
			
			/* Set the CSV file path ***************************************************************************************************************************************************************/
			on setCSVFilePathBtn pressed do 
			(
				filename = getOpenFileName caption:"Open the synthesis file" types:"Excel(*.csv)|*.csv|Excel(*.xlsx, *.xlsm)|*.xlsx;*.xlsm|All|*.*|"
				if filename != undefined then 
				(
					_csv.file = filename
					loadCSVFileBtn.enabled = true
					LoadCSV()
				)
			)
			
			
			/* Load the csv file ***************************************************************************************************************************************************************/
			on loadCSVFileBtn pressed do LoadCSV()
			
			on usersDdl selected item do FillAtasList()
			
			on atasDdl selected item do FillRequiredComponentsList()
			
			
			
			/* Select the required component from the listbox ***************************************************************************************************************************************************************/
			on requiredComponentsList MouseDoubleClick arg do
			(
				hit = requiredComponentsList.HitTest (dotNetObject "System.Drawing.Point" arg.x arg.y)
				obj = undefined
				try(obj = (GetComponent hit.item.text)) catch(obj = (GetComponent hit.item.text layer:"cao"))
				if obj != undefined then select obj
			)
			
			
			
			/* Change the related objects listbox based on the dropdownlist selection ***************************************************************************************************************************************************************/
			on sceneComponentsList selected item do SetSceneRelatedObjects()
			
			
			
			/* Select the scene component from the listbox ***************************************************************************************************************************************************************/
			on sceneComponentsList doubleClicked item do
			(
				component = (GetComponent sceneComponentsList.selected)[1]
				if component != undefined then select component
			)
			
			
			
			/* Add the comploc custom attribute  ***************************************************************************************************************************************************************/
			on addComponentBtn pressed do
			(
				-- get objects and cameras parent
				addArr = #()
				canAdd = true
				for obj in selection while canAdd do
				(
					if superClassOf obj != camera then 
						appendIfUnique addArr obj
					else
					(
						if obj.parent != undefined then appendIfUnique addArr obj.parent
						else 
						(
							canAdd = false
							messageBox "Please set all the hotspots (camera and target) as child of their component"
						)
					)
				)
				
				
				if canAdd then for obj in addArr do 
				(
					_cplc.AddCA #(obj) _cplc.compLocCA
						
					-- check if the object already have a camera  as children
					hasCam = false
					for child in obj.children while not hasCam do 
					(
						if superClassOf child == camera then
						(
							pos = _cplc.GetHotspotLocation child
							_cplc.CreateHotspot obj pos[1] pos[2]
							hasCam = true
						)
					)
						
					FillSceneComponentsList()
					GetHotspotInfos obj
					locationDdl.items = _cplc.GetLocations locationTypeRdb.state
				)

			)
			
			
			
			/* Remove the comploc custom attribute  ***************************************************************************************************************************************************************/
			on removeComponentBtn pressed do
			(
				if _cplc.sceneComponents.count != 0 then 
				(
					component = (GetComponent sceneComponentsList.selected)[1]
					if component != undefined then
					(
						index = sceneComponentsList.selection
						_cplc.RemoveCA component #compLoc
						FillSceneComponentsList()
						
						-- select previous item if its the last from the list whose been removed
						if index > _cplc.sceneComponents.count then 
							sceneComponentsList.selection = _cplc.sceneComponents.count
						
						SetSceneRelatedObjects()
					)
				)
			)
			
			
			
			/* Reload the scene components and related listbox ***************************************************************************************************************************************************************/
			on reloadComponentsBtn pressed do 
			(
				FillSceneComponentsList()
				SetSceneRelatedObjects()
			)
			
			
			/* Set the location dropdownlist ***************************************************************************************************************************************************************/
			on locationTypeRdb changed val do 
			(
				locationDdl.items = _cplc.GetLocations val
				
				-- check if component have hotspot to be able to change its location here
				if _cplc.sceneComponents.count != 0 then 
				(
					component = (GetComponent sceneComponentsList.selected)[1]
					if component.hotspot != undefined then 
					(
						component.hotspot.locationType = val
						component.hotspot.location = 1
					)
				)
			)
				
				
				
			/* Set the hotspot location ***************************************************************************************************************************************************************/
			on locationDdl selected item do 
			(
				if _cplc.sceneComponents.count != 0 then 
				(
					component = (GetComponent sceneComponentsList.selected)[1]
					if component.hotspot != undefined then component.hotspot.location = item
				)
			)
			
			
			
			/* Set or select the camera used for the hotspot ***************************************************************************************************************************************************************/
			on sceneHotspotBtn pressed do
			(
				if _cplc.sceneComponents.count != 0 then 
				(
					-- Select the camera if the hotspot is already defined, create it otherwise
					component = (GetComponent sceneComponentsList.selected)[1]
					if component.hotspot != undefined 
						then select component.hotspot
						else _cplc.CreateHotspot component locationTypeRdb.state locationDdl.selection
				)
			)
			
			
			
			/* Remove the component hotspot ***************************************************************************************************************************************************************/
			on sceneHotspotBtn rightclick do
			(
				/*
				component = (GetComponent sceneComponentsList.selected)[1]
				if component.hotspot != undefined then
				(
					delete component.hotspot
					component.hotspot = undefined 
					SetSceneRelatedObjects()
				)
				*/
			)
			
			
			
			/* Change the related objects listbox based on the dropdownlist selection ***************************************************************************************************************************************************************/
			on sceneRelatedTypeDdl selected item do SetSceneRelatedObjects()
			
			
			
			/* Add selection as related objects to the scene composant listbox selected item ***************************************************************************************************************************************************************/
			on sceneAddRelatedBtn pressed do
			(
				component = (GetComponent sceneComponentsList.selected)[1]
				
				-- Be sure there isn't the component in the selection
				selArr = for obj in selection where obj != component collect obj
				case sceneRelatedTypeDdl.selection of
				(
					1: for obj in selArr do appendIfUnique component.transparent obj
					2: for obj in selArr do appendIfUnique component.hidden obj
					3: for obj in selArr do appendIfUnique component.animated obj
				)
				
				SetSceneRelatedObjects()
			)
			
			
			
			/* Remove the scene related objects listbox selected item as a related objects of the scene composant listbox selected item ***************************************************************************************************************************************************************/
			on sceneRemoveRelatedBtn pressed do
			(
				component = (GetComponent sceneComponentsList.selected)[1]
				case sceneRelatedTypeDdl.selection of
				(
					1: deleteItem component.transparent (sceneRelatedObjectsList.selection)
					2: deleteItem component.hidden (sceneRelatedObjectsList.selection)
					3: deleteItem component.animated (sceneRelatedObjectsList.selection)
				)
				
				SetSceneRelatedObjects()
			)

			
		)
	),
	
	
	
	/* Create a dialog and add the view inside ############################################################################################*/
	fn CreateView = 
	(
		try(destroyDialog _cplc.CplcView) catch()
		GetView()
		createDialog _cplc.CplcView 500 625 style:#(#style_titlebar, #style_sysmenu, #style_toolwindow)
	),
	
	
	
	/* Execute  ############################################################################################*/
	fn Run = 
	(
		SetHotspotCA()
		SetCompLocCA()
		
		sceneComponents = _ca.GetObjsWithCA #compLoc
	),
	
	
	/* Open CplcView Macroscript ############################################################################################*/
	macroUI =
	(
		macroScript CompLocComponents
			category:"SugzTools"
			toolTip:"CompLoc Components"
			Icon:#("Comploc",1)
		
		(
			global _cplc
			on execute do 
			(
				if doesFileExist "$userscripts\SugzTools\Scripts\CompLoc_Component.ms" then 
				(
					fileIn "$userscripts\SugzTools\Scripts\CompLoc_Component.ms"
					_cplc.CreateView()
				)
			)
		)
		
	),
	
	
	
	/* Check if scene components has no undefined relatives ############################################################################################*/
	macroChecker =
	(
		macroScript CompLocChecker
			category:"SugzTools"
			toolTip:"CompLoc Checker"
			Icon:#("Comploc",2)
		
		(
			global _cplc
			on execute do 
			(
				if doesFileExist "$userscripts\SugzTools\Scripts\CompLoc_Component.ms" then 
				(
					fileIn "$userscripts\SugzTools\Scripts\CompLoc_Component.ms"
					_cplc.ComponentChecker()
				)
			)
		)
	),
	
	
	
	/* Export components informations to excel ############################################################################################*/
	macroExport =
	(
		macroScript CompLocExcelExporter
			category:"SugzTools"
			toolTip:"CompLoc Excel Exporter"
			Icon:#("Comploc",3)
		
		(
			global _cplc
			on execute do 
			(
				if doesFileExist "$userscripts\SugzTools\Scripts\CompLoc_Component.ms" then 
				(
					fileIn "$userscripts\SugzTools\Scripts\CompLoc_Component.ms"
					_cplc.ExcelExport()
				)
			)
		)
	)
	
	
)

if heapSize < 100000000 then heapSize += 85000000
_cplc = CompLocComponentStc()
_cplc.Run()