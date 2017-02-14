macroScript MapChannelCopier
category:"Felipe Scripts"
toolTip:"Copies a map chanel to another on all scene objects"
buttonText:"MapChannelCopier"
--icon:#("Felipe Scripts",11)
silentErrors:true
autoUndoEnabled:true

(
rollout pda_chanelcopier "Map Channel Copier" 
(
	button pda_MapChanelCopyBtn "Copy Map Channels" pos:[45,10] width:120 height:20 
	spinner pda_ChanelNb "Map Channel Source" pos:[75,50] width:100 height:20 range:[1,10,3] type:#integer fieldWidth:30
	spinner  pda_ChanelDestination "Map Channel Destination" pos:[75,90] width:100 height:20 range:[1,10,1] type:#integer fieldWidth:30
	button pda_CollapseModifiers "Collapse Modifiers" pos:[45,130] width:120 height:20 
		
	on pda_MapChanelCopyBtn pressed do
		(
					ChannelInfo.dialog()
			
			for obj in geometry do (
				
				if classOf obj == PolyMeshObject or classOf obj == Editable_Poly do (
				pda_x = polyop.getNumMaps obj
				if pda_x >= (1+pda_ChanelNb.value) do (
					channelInfo.CopyChannel obj 3 (pda_ChanelNb.value)
					channelInfo.PasteChannel obj 3 (pda_ChanelDestination.value)
					--maxOps.CollapseNode obj off
				)
			)
			
			if classOf obj == Editable_mesh do (
				pda_y=meshop.getNumMaps obj
				if pda_y >= (1+pda_ChanelNb.value) do (
					channelInfo.CopyChannel obj 3 (pda_ChanelNb.value)
					channelInfo.PasteChannel obj 3 (pda_ChanelDestination.value)
					--maxOps.CollapseNode obj off
				)
			)
			)
			ChannelInfo.closeDialog()
		)

		
	on pda_CollapseModifiers pressed do 
		(
		for obj in geometry do maxOps.CollapseNode obj on
		)
		
		
)
createDialog pda_chanelcopier 200 170



)