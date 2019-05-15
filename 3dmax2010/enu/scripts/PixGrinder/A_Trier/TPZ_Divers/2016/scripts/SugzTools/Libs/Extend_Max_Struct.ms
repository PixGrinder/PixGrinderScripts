/*##############################################################################
SugzTools Extend 3ds Max Struct
Version 0.06
Script By Clément "Sugz" Plantec
plantec.clement@gmail.com

#Required Components:
None

#Script infos:
General functions to extend 3ds max scripting

*Use / Modify this script at your own risk !*
###############################################################################*/



struct ExtendMaxStruct
(

	/* Delete User Property (Thanks to DenisT)  ############################################################################################*/
	fn DeleteUserProp node prop = 
	(
		/*<Function>
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
	
	
	/* Delete folder ############################################################################################*/
	fn DeleteFolder _path =
	(
		local sioDir = dotNetClass "System.IO.Directory"
		if (SIODir.Exists _path) then SIODir.Delete (_path) true
	)


	
	
)
