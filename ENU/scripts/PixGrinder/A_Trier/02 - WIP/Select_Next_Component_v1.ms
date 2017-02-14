(

	rollout myFelipe "HotSpot Helpers"
	(
		button prv "Prev"
		button nxt "Next"
		button hdComp "Hide"
		
		on prv pressed do 
		(
			pda=#()
			myCond = 0
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
			if v-1 < 0 then select all[all.count]  else ( 
			v=v-1
			select all[v]
			viewport.setType #view_persp_user
			max zoomext sel
			)
		)
		
		on nxt pressed do 
		(
			pda=#()
			myCond = 0
			if selection[1] != undefined do 
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
			pda=#()
			myCond = 0
			for obj in objects do if matchpattern obj.name pattern:(selection[1].name + "*") == true do append pda obj
			for obj in pda do if superclassof obj == camera do myCond = 1
			if myCond == 1 do hide pda
		)
	)


	createDialog myFelipe
	--clearListener()
)
