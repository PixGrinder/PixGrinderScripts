(

	myComps = for obj in objects where custAttributes.count obj > 0 collect obj

	myFault = for obj in myComps where obj.compLoc.hotspot == undefined collect obj

	clearSelection()

	select myFault
)




-------------------------------------------------------------------------------------------------


-- Select by hotspot name


(
	clearListener()

	myComploc = for obj in objects where custAttributes.count obj > 0 collect obj

-- 	select myComploc

	myMainHotspot = for obj in myComploc where matchpattern obj.comploc.hotspot.name pattern:"*_HMainPanel_fixe" == true collect obj

	for obj in myMainHotspot do print (obj.compLoc.hotspot.fov as string +"  :  " + substring obj.comploc.hotspot.name (obj.comploc.hotspot.name.count-15) 16 + "  :  " + obj.name )

	clearSelection()

	select myMainHotspot


-- 	myInterest = for obj in myMainHotspot where obj.comploc.hotspot.fov != 50.0 collect obj

-- 	select myInterest

-- 	for obj in myInterest do obj.comploc.hotspot.fov = 50.0

)


-------------------------------------------------------------------------------------------------



for obj in selection do print obj.compLoc.hotspot.name
getnodebyname "ATA_29-20_PushBtnInflatingBrakeAcc"


clearListener()
myString = "ATA_34-60_TAWSindicatorLights_HMainPanel_fixe"
substring myString (myString.count-15) 16




select $.comploc.hotspot


show custAttributes obj