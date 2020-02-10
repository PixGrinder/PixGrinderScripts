
rollout a "Color Palette"
(
	
	colorpicker cl01 ""  pos:[10,5] width:30 height:25  color:[84,101,120] 
	button btn01 "•" pos:[14,35] width:25 height:25 

	colorpicker cl02 ""  pos:[45,5] width:30 height:25  color:[121,24,107] 
	button btn02 "•" pos:[49,35] width:25 height:25 

	colorpicker cl03 ""  pos:[80,5] width:30 height:25  color:[248,89,58] 
	button btn03 "•" pos:[84,35] width:25 height:25 

	colorpicker cl04 ""  pos:[115,5] width:30 height:25  color:[143,225,87] 
	button btn04 "•" pos:[119,35] width:25 height:25 

	colorpicker cl05 ""  pos:[150,5] width:30 height:25  color:[0,218,195] 
	button btn05 "•" pos:[154,35] width:25 height:25 

	colorpicker cl06 ""  pos:[185,5] width:30 height:25  color:[252,255,0] 
	button btn06 "•" pos:[189,35] width:25 height:25 

	colorpicker cl07 ""  pos:[220,5] width:30 height:25  color:[255,0,252] 
	button btn07 "•" pos:[224,35] width:25 height:25 

	colorpicker cl08 ""  pos:[255,5] width:30 height:25  color:[45,80,200] 
	button btn08 "•" pos:[259,35] width:25 height:25 

	colorpicker cl09 ""  pos:[290,5] width:30 height:25  color:[255,138,0] 
	button btn09 "•" pos:[294,35] width:25 height:25
	
	
	on btn01 pressed do ( selection.wirecolor = cl01.color )
	on btn02 pressed do ( selection.wirecolor = cl02.color )
	on btn03 pressed do ( selection.wirecolor = cl03.color )
	on btn04 pressed do ( selection.wirecolor = cl04.color )
	on btn05 pressed do ( selection.wirecolor = cl05.color )
	on btn06 pressed do ( selection.wirecolor = cl06.color )
	on btn07 pressed do ( selection.wirecolor = cl07.color )
	on btn08 pressed do ( selection.wirecolor = cl08.color )
	on btn09 pressed do ( selection.wirecolor = cl09.color )
	
)
createDialog a width:330 height:65 pos:[3630,950] bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)