addnewkey  $.pos.controller 10
addnewkey  $.pos.controller 50
addnewkey  $.pos.controller 75
getKeyIndex  $.pos.controller 


selectkeys  $.pos.controller 0f 100f


deselectkeys  $.pos.controller 0f 60f


$.position.controller.keys[3].time - $.position.controller.keys[1].time

movekey $.position.controller 1 ($.position.controller.keys[3].time+1f)

numkeyss $.position.controller

getKeyIndex $.position.controller 50f

getKeyTime  $.position.controller 3

addnewkey $.pos.controller 

$.position.controller.y_position.keys[1].time = 80f
$.position.controller.keys[1].time = 80f



$.position.controller.keys[1].time = 80f --($.position.controller.keys[3].time+1f)
$.position.controller

----------------------------------------

(
	pda_obj = getcurrentselection()
	pda_obj = pda_obj[1]
	
	local pda_ctl=pda_obj.controller as string
	local pda_pos = pda_obj.position.controller as string
	local pda_rot = pda_obj.rotation.controller as string
	local pda_scl = pda_obj.scale.controller as string

	clearListener()

	if pda_ctl == "Controller:Position_Rotation_Scale" then print "Controller:Position_Rotation_Scale" else print "bad"
	if pda_pos == "Controller:Linear_Position" then print "linear pos" else print ("bad : "+pda_pos)
	if pda_rot == "Controller:Linear_Rotation" then print "linear rot" else print ("bad : "+pda_rot)
	if pda_scl == "Controller:Linear_Scale" then print "linear scale" else print ("bad : "+pda_scl)

)

---
--- Brouillon ---
---

$.position.controller.keys.count
$.rotation.controller.keys.count
$.scale.controller.keys.count
$.visibility.controller




