(

	pda_frame = #(0,450,900,1150,1341,1540,1730,1900)

	for i = 1 to pda_frame.count do
	(
	
		render camera:$Camera001_left frame:pda_frame[i] outputfile:(("D:\01_Projects\CNES\Renders\1920\\")+(pda_frame[i] as string)+("_left.jpg")) vfb:false progressbar:true
		
		render camera:$Camera001_right frame:pda_frame[i] outputfile:(("D:\01_Projects\CNES\Renders\1920\\")+(pda_frame[i] as string)+("_right.jpg")) vfb:false progressbar:true
	)
	
)

