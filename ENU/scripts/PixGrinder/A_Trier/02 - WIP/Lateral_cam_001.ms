
	Freecamera name:"cam_SharpZone" orthoProjection:true fov:70 transform:$SharpZone.transform isSelected:off targetdistance:($SharpZone.boxsize.x) wirecolor:black
	freeze $cam_SharpZone
	in coordsys local rotate $cam_SharpZone (eulerAngles 0 90 0)
	in coordsys local move $cam_SharpZone [0,0,($SharpZone.boxsize.x*2)]
	$cam_SharpZone.parent = $SharpZone
		
		
		
		
		
-- Brouillon
---------------
		
		
		
		
	$SharpZone.boxsize.x
nearclip:0 farclip:50 nearrange:0 farrange:50 mpassEnabled:off mpassRenderPerPass:off transform:pda_campos isSelected:on 