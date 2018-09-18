-- Box Slice - v2 -- 


mySelec = getCurrentSelection()

fn sBound v1 = 
(
	myX = abs(v1.min.x - v1.max.x)
	myY = abs(v1.min.y - v1.max.y)
	myZ = abs(v1.min.z - v1.max.z)
	return [myX,myY,myZ]
)

mySlicer = dummy name:"mySlice" pos:selection.center boxsize:(sBound selection) selected:false

myPtTop = Point pos:[mySlicer.center.x,mySlicer.center.y,mySlicer.max.z] parent:mySlicer
myPtBtm = Point pos:[mySlicer.center.x,mySlicer.center.y,mySlicer.min.z] parent:mySlicer
myPtLft = Point pos:[mySlicer.min.x,mySlicer.center.y,mySlicer.center.z] parent:mySlicer
myPtRgt = Point pos:[mySlicer.max.x,mySlicer.center.y,mySlicer.center.z] parent:mySlicer
myPtFrt = Point pos:[mySlicer.center.x,mySlicer.min.y,mySlicer.center.z] parent:mySlicer
myPtBck = Point pos:[mySlicer.center.x,mySlicer.max.y,mySlicer.center.z] parent:mySlicer

mySliceMod =  (SliceModifier name:"theSlicer" Slice_Type:3)

modPanel.addModToSelection mySliceMod --ui:on
mySliceMod.slice_plane.position = myPtTop.position - mySlicer.center


/*

				pda_ar[1].modifiers[#slice].name = "bottom"
				pda_ar[1].modifiers["bottom"].enabled = false
				pda_ar[1].modifiers["bottom"].slice_plane.rotation = pda_tmp.rotation
				pda_ar[1].modifiers["bottom"].slice_plane.position = pda_tmp.position-$.center
				pda_ar[1].modifiers["bottom"].Slice_Type = 3
				select $

				$.modifiers[1].enabled = false


*/