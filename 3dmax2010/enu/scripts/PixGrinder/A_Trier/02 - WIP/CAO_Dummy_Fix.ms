-- CAO Dummy Fix -- 

(
	clearListener()

	theCondition = true
	myIniTest = for obj in objects where obj.children.count == 0 collect obj

	if matchpattern geometry[1].name pattern:"VIFS*" == false then theCondition = false
	


	if theCondition == true then 
	(
		a1 = geometry.count
		b1 = helpers.count

		fn mySort v1 v2 = 
		(
			if v1.name > v2.name then 1 else -1
		)

		myNoChild = for obj in objects where obj.children.count == 0 collect obj

		for obj in myNoChild where obj.parent != undefined do obj.name = (replace obj.parent.name (obj.parent.name.count - 2) 3 "")

		qsort myNoChild mySort

		fn HierFix v1 = 
		(
			if v1.parent != undefined and matchpattern v1.parent.name pattern:(v1.name+"*") == true then 
			(
				v2 = v1.parent
				v1.parent = v2.parent
				--delete v2
				HierFix v1
			)
		)

		for obj in myNoChild do HierFix obj

		myTest = true
		while myTest == true do
		(
			myRemove = for hlp in helpers where hlp.children.count == 0 collect hlp
			delete myRemove
			if myremove.count == 0 then myTest = false
		)

		clearListener()

		format "% : %\r" "Geometry before" (a1 as string)
		format "% : %\r" "Geometry after" (geometry.count as string)
		format "\r"
		format "% : %\r" "Helpers before" (b1 as string)
		format "% : %\r" "Helpers after" (helpers.count as string)
	) else (messagebox("Ta Mere !"))
)

