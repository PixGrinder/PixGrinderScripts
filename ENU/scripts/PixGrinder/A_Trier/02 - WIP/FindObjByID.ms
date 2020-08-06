-- Find obj by ID -- 
-- v0.4 --


fn searchForID v1 = 
(
	myAr = #()
	for obj in geometry where obj.isHidden == off do
	(
		convertToPoly obj
		for i = 1 to getnumfaces obj do
		(
			if (polyop.getFaceMatID obj i) == v1 then 
			(
				append myAr obj
				exit
			)
		)
	)

	if myAr.count == 0 then clearSelection() else select myAr
)

rollout mySearchID "Search ID"
(
	label lbl1 "Select objects with this ID #" offset:[0,10]
	spinner mySpinner "" range:[1,10000,1] type:#integer align:#center offset:[0,10]
	on mySpinner entered do searchForID mySpinner.value
)


try(DestroyDialog mySearchID) catch()
CreateDialog mySearchID height:75

