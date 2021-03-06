(

	rollout myFelipe "HotSpot Helpers"
	(
		button SelComp "Select Component"
		button nxt "Next"
		button hdComp "Hide"
		
		on nxt pressed do 
		(
			pda=#()
			myCond = 0
			if selection[1] != undefined then 
			(
				for obj in objects do if matchpattern obj.name pattern:(selection[1].name + "*") == true do append pda obj
				for obj in pda do if superclassof obj == camera do myCond = 1
				if myCond == 1 do hide pda
				all = #()
				c = selection[1]-- current selection
				for obj in objects do
				(
					if (obj.ishidden == false) and (matchpattern obj.name pattern:"ATA_??-??_*" == true) and superclassof obj != camera  and classof obj != Targetobject do append all obj
				)
				v = findItem all c
				if v+1 >all.count then select all[1]  else ( 
				v=v+1
				select all[v]
				viewport.setType #view_persp_user
				max zoomext sel
				) 
			) else (
				messagebox "Please selection one object"
			)
		)
		
		on hdComp pressed do 
		(
			for obj in cameras do 
			(
				hide obj
				try hide obj.parent catch (print obj.name)
			)
		)
		
		on SelComp pressed do
		(
			curcam = try(getActiveCamera()) catch()
			if curcam != undefined do select curcam.parent
		)
		
	)
	
	createDialog myFelipe
	--clearListener()
)
