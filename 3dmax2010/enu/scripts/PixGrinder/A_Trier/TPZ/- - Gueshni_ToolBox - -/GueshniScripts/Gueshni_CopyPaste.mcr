/****************************************************************************************************************************/
/*   FUNCTIONS
/****************************************************************************************************************************/
macroScript CopyObject
	category:"- Gueshni -" 
	tooltip:"CopyObject"
	ButtonText:"CopyObject"
	icon:#("g9_copypaste",1)
	
(
	if $ != undefined then
	( 
		deleteFile (((GetDir #scene) as string ) + "\copy_paste_buffer_backup.max")
		
		renameFile (((GetDir #scene) as string ) + "\copy_paste_buffer.max") (((GetDir #scene) as string ) + "\copy_paste_buffer_backup.max")
			
		saveNodes $ (((GetDir #scene) as string ) + "\copy_paste_buffer.max")
	)
)
-------------------------------------
macroScript PasteObject
	category:"- Gueshni -" 
	tooltip:"PasteObject"
	ButtonText:"PasteObject"
	icon:#("g9_copypaste",2)

(
	mergeMAXFile (((GetDir #scene) as string ) + "\copy_paste_buffer.max") #mergeDups #select
) 