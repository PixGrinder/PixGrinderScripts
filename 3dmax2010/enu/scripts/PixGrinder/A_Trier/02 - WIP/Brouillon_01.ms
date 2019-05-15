



getAppData rootNode -55555

pda_maincam






--------------------------


(
	
	max modify mode
	
	persistent global pda_maincam = $
	
	persistent global pdamod = EmptyModifier () 
	
	global svData = StringStream ""
	
	pdamod.name = "StereoCam"
	addmodifier pda_maincam pdamod
	
	fn pda_save =
	(
		svData = StringStream ""
		print (pda_maincam.modifiers["StereoCam"].stereoCamRol.dummy_w.value) to:svData
		setAppData rootNode -55555 svData
	)
	
	
	if getAppData rootNode -55555 == undefined do 
	(
		
		global stereoCamCA = attributes stereoCam
		(		
			rollout stereoCamRol "Custom Attribs"
			(
				label txt1 "      ----------------------\r       Camera Offset :\r      ----------------------\r\r       50 = No 3D effect\r\r    100 = Full 3D effect" pos:[15,10] width:130 height:105 style_sunkenedge:true  offset:[10,0]
				spinner dummy_w "Test Attribute : " type:#float pos:[35,215] width:100 height:20 range:[1,1000000,10]
				
				
				on dummy_w changed state do
				(
					pda_save()
				)
				
			)
		)
		custAttributes.add pda_maincam.modifiers["StereoCam"] stereoCamCA baseobject:false
		
		pda_save()
		
	)

)


-- Brouillon 

pda_maincam.modifiers["StereoCam"].stereoCamRol.dummy_w.value


ss = StringStream ""

for v in data_values do print v to:ss

setAppData $foo 1 ss
