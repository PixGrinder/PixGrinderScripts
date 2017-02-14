macroScript DisplayObjectColor category:"- Gueshni -" Icon:#("g9_displayobjectcolor", 1) tooltip:"Display Object Color"
 (
		displayColor.shaded = if displayColor.shaded ==#object then #material else #object
		freescenebitmaps()
	)