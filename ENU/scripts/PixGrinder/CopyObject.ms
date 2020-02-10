(
	if $ != undefined then
	( 
		deleteFile (((GetDir #scene) as string ) + "\copy_paste_buffer_backup.max")
		
		renameFile (((GetDir #scene) as string ) + "\copy_paste_buffer.max") (((GetDir #scene) as string ) + "\copy_paste_buffer_backup.max")
			
		saveNodes $ (((GetDir #scene) as string ) + "\copy_paste_buffer.max")
	)
)