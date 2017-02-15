/*##############################################################################
SugzTools Extend Maxscript Library
Version 1.02
Script By Clément "Sugz" Plantec
plantec.clement@gmail.com

# Script infos:
General functions to extend maxscript

# Required Components:
SugzTools Manager
SugzTools INI Manager

# Sources:

# To do list:
rename library variable from _extMax to _mxs

# History:
1.02:
 - Change script name from SugzTools Extend 3ds Max Library" to "SugzTools Extend Maxscript Library"
 - Add CutString

*Use / Modify this script at your own risk !*
###############################################################################*/






struct ExtendMxsLibraryStc
(

	/* Delete a User Property ############################################################################################*/
	fn DeleteUserProp node prop = 
	(
		/*<Function>
		Description:
			Delete a User Property
		Arguments:
			<Node> node: the node to work on 
			<String> prop: the property to get rid
		Further Infos:
			DenisT post : http://forums.cgsociety.org/showthread.php?f=98&t=797430&
		</Function>*/
		
		if getUserProp node prop != undefined do
		(
			
			buff = (getUserPropBuffer node) as stringStream 
			newb = stringStream ""
			while not eof buff do
			(
				str = readLine buff
				if str != "" and not matchpattern str pattern:("*" + prop + "*=*") do format "%\n" str to:newb
			)
			
			setUserPropBuffer node (replace_LF_with_CRLF (newb as string))
		)
	),
	
	
	
	/* Print all actionMan ############################################################################################*/
	fn PrintActionMan = 
	(
		/*<Function>
		Description:
			Print all actionMan
		</Function>*/

		for i = 1 to actionMan.numActionTables-1 do 
		(
			atbl = actionMan.getActionTable i
			format "% ID:% Name:'%' ContextID:% ContextName:'%' NumActionItems:%\n" i atbl.id atbl.name atbl.contextID atbl.contextName atbl.numActionItems
			for j = 1 to atbl.numActionItems do
			(
				aitm = atbl.getActionItem j
				aitm.getDescription &desc 
				aitm.getCategory &cat
				aitm.getButtonText &btn
				aitm.getMenuText &mnu
				hasicon = aitm.hasIcon()
				if hasicon then
				(
					aitm.getIconFileName &iconfile 
					iconfile = filenamefrompath iconfile 
					iconindex = aitm.getIconIndex()
					format "\t% ID:% Desc:'%' Cat:'%' BtnTxt:'%' MnuTxt:'%' Icon:[%,%] \n" j aitm.id desc cat btn mnu iconfile iconindex
				)
				else
					format "\t% ID:% Desc:'%' Cat:'%' BtnTxt:'%' MnuTxt:'%'\n" j aitm.id desc cat btn mnu 
			)
		)
	),
	
	
	
	/* Return the current check state of the specified ActionMan ############################################################################################*/
	fn GetActionManState table id =
	(
		/*<Function>
		Description:
			Return the current check state of the specified ActionMan
		Arguments:
			<String> table: the name of the action table to search for 
			<String> id: the id of the action item to search for in the given action table
		Return:
			<Bool> The current state of the selection outline action item
		</Function>*/
		
		for i = 1 to actionMan.numActionTables - 1 do
		(
			aTable = actionMan.getActionTable i
			if aTable.name == table then 
			(
				for j = 1 to aTable.numActionItems do
				(
					aItem = aTable.getActionItem j
					if aItem.id == id  then return aItem.isChecked
				)
			)
		)
	
	),
	
	
	
	/* Delete a folder ############################################################################################*/
	fn DeleteFolder _path =
	(
		/*<Function>
		Description:
			Delete a folder
		Arguments:
			<String> _path: the folder to delete
		</Function>*/

		local sioDir = dotNetClass "System.IO.Directory"
		if (SIODir.Exists _path) then SIODir.Delete (_path) true
	),


	
	/* Display a temp prompt ############################################################################################*/
	fn Prompt str =
	(
		/*<Function>
		Description:
			Display a temp prompt
		Arguments:
			<String> str: the string to prompt
		</Function>*/
		
		displayTempPrompt ("SugzTools: " + str) (execute (getIniSetting _sgz._ini "Common" "promptTime") * 1000)
	
	),
	
	
	
	/* Convert a value to an array ############################################################################################*/
	fn AsArray input =
	(
		/*<Function>
		Description:
			Convert a value to an array
		Arguments:
		 <Var>  input: a variable that need to be an array
		Return:
			<Array <Var>> the input as array
		</Function>*/
		
		if not isKindOf input array then #(input) else input
	
	),
	
	
	
	/* Sort a list of integer ############################################################################################*/
	fn SortIntegers intList = 
	(
		/*<Function>
		Description:
			Sort a list of integer
		Arguments:
			<Array <Integer>> intList : the list of integer that need to be sorted
		Return:
			<Array <Integer>> intList : the list of integer after it has been sorted
		</Function>*/
		
		function CompareValues val1 val2 =
		(
			return (val1 as integer) - (val2 as integer)
		)
		qsort intList CompareValues
		
		intList
	),
	
	
	
	/* Cut a string that its displayed width isn't superior to a given value ############################################################################################*/
	fn CutString str width location:#left =
	(
		/*<Function>
		Description:
			Cut a string that its displayed width isn't superior to a given value
		Arguments:
			<String> str: the string to cut
			<Integer>width: the maximum widh of the cut string
			<Name> location: decide if the string have to be cut from the begining or the end
		Return:
			<String> cutString: the cut string
		</Function>*/
		
		_cutString = str
		
		if (GetTextExtent str)[1] > width then 
		(
			case location of
			(
				#left: 
				(
					i = 2
					_cutString = str[1]
					while (GetTextExtent _cutString)[1] < width do 
					(
						_cutString += str[i]
						i += 1
					)
					
					_cutString += "..."
				)
				
				#center:
				(
					i = 1
					_cutString = str[str.count / 2]
					left = true
					while (GetTextExtent _cutString)[1] < width - 12 do 
					(
						if left then
						(
							_cutString = str[(str.count / 2) - i] + _cutString
							left = false
						)
						else 
						(
							_cutString += str[(str.count / 2) + i]
							i += 1
							left = true
						)
					)
					
					_cutString = "..." + _cutString + "..."
					
				)
				
				#right: 
				(
					i = str.count - 1
					_cutString = str[str.count]
					while (GetTextExtent _cutString)[1] < width do 
					(
						_cutString = str[i] + _cutString
						i -= 1
					)
					
					_cutString = "..." + _cutString
				)
			)
		)
	
		_cutString
	)
	
	
	
)
