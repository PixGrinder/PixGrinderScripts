/*##############################################################################
SugzTools Selection Struct
Version 1.06
Script By Clément "Sugz" Plantec
plantec.clement@gmail.com

#Required Components:
None

#Script infos:
Collection of functions to speed up the selection workflow

*Use / Modify this script at your own risk !*
###############################################################################*/



struct SelectionStruct
(

	/* Check if selection isn't empty *********************************************************************************************************************************/
	fn GetSelectionCountFn = 
	(
		if selection.count == 0 then 
		(
			messageBox  "Select at least one object"
			return false
		)
		
		true
	),
	
	
	
	/* Return only visible object in the array*********************************************************************************************************************************/
	fn UnselectHiddenObjectsFn objArray =
	(
		/*<Function>
		Arguments:
			<Array> objArray: objects that need to be check for visibility
		Return:
			<Array> return only the visible objects from the array passed in the argument
		</Function>*/
		
		return (for obj in objArray where not obj.isHiddeninVpt collect obj)
	),
		
	
	
	/* Return either all or only visible instances *********************************************************************************************************************************/
	fn GetInstancesFn objs getHidden: true limitToSel: false = 
	(
		/*<Function>
		Arguments:
			<Array> objs: the objects to get the instances
			<Optional> <Bool> getHidden: define if the function will return also the hidden instances <Default: true>
			<Optional> <Bool> limitToSel: define if the function will be limited only to the current selection <Default: false>
		Return:
			<Array> instancesArray: the instances
		</Function>*/
		
		-- Define empty array to store instances
		instancesArray = #()
		for obj in objs do 
		(
			-- get all instances
			InstanceMgr.GetInstances obj &instances
			
			-- append instances to the array depending on the visibility parameter
			if not getHidden then
				join instancesArray (UnselectHiddenObjectsFn instances)
			else join instancesArray instances
			
			-- limit the array depending on the limit to selection parameter
			if limitToSel then for _instance in instances do 
			(
				if (findItem (selection as array) _instance) == 0 then
					deleteItem instancesArray (findItem  instancesArray _instance)
					
			)
		)
		
		instancesArray
	),
	

	
	/* Return only the first instance from selection *********************************************************************************************************************************/
	fn DeleteInstanceFromSelectionFn limitToSel: false =
	(
		/*<Function>
		Arguments:
			<Optional> <Bool> limitToSel: define if the function will be limited only to the current selection <Default: false>
		Return:
			<Array> firstInstanceArray: the first instance for each object in selection
		</Function>*/
	
		firstInstanceArray = #()
		for obj in selection do 
		(
			instances = GetInstancesFn obj limitToSel:limitToSel
			appendIfUnique firstInstanceArray instances[1]
		)
		
		firstInstanceArray
	),
	
	
	
		
	 /* Get the parent hierarchy ********************************************************************************************************************************/
	fn GetParentFn node =
	(
		/*<Function>
		Arguments:
			<Node> node: the node to get parents hierarchy
		</Function>*/
		
		-- Get node parent as array then loop to get the hierarchy adding parent in the array (or return empty array to avoid undefined)
		parent = if node.parent != undefined then append #() node.parent else #()
		for p in parent where p.parent != undefined do append parent p.parent
		
		parent
	),
	
	
	
	/* Get children hierarchy *********************************************************************************************************************************/
	fn GetHierarchyFn selArray:(getCurrentSelection()) children:false parent:false getHidden:false =
	(
		/*<Function>
		Arguments:
			<Optional> <Array> selArray: the objects to work on (current selection by default) <Default: Current Selection>
			<Optional> <Bool> children: define if the function have to select children <Default: false>
			<Optional> <Bool> parent: define if the function have to select parent <Default: false>
			<Optional> <Bool> getHidden: define if the function will also return hidden objects <Default: false>
		Return:
			<Array> selArray: the hierachy of selected objects
		Further Infos:
			one liner to get all children by Rotem Shiffman aka lo on CGTalk
		</Function>*/
		
		-- get children and parent
		tempArray = #()
		if children then (for obj in selArray do join tempArray obj)									-- get children (no idea how this is working)
		if parent then (for obj in selArray do join tempArray (GetParentFn obj))				-- get parents
		
		-- get rid of hidden object if needed
		selArray = join selArray tempArray
		if not getHidden then selArray = UnselectHiddenObjectsFn selArray
		
		-- return the hierarchy
		selArray 
	)
	
)

