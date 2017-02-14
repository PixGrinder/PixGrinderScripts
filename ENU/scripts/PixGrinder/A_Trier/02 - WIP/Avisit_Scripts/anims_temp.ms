$.transform.rotation as eulerAngles at time 50f
	
$.rotation.controller.keys
$.transform[2]


		(
			obj = getCurrentSelection()
			obj = obj[1]
			i=2
			for i = 1 to obj.controller[2].keys.count do
			(
				x1 = obj.controller[2].keys[i].time as string
				x2 = obj.controller[2].value at time (obj.controller[2].keys[i].time) --as eulerAngles -- at time (obj.controller[2].keys[i].time)
				x2 = x2 as eulerAngles
				x2 = x2 as string
				
				(print (x1 + " - " + x2))
			)
		)
