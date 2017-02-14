-- Hide object with camera
(
	pda=#()
	myCond = 0
	for obj in objects do if matchpattern obj.name pattern:(selection[1].name + "*") == true do append pda obj
	for obj in pda do if classof obj == Physical do myCond = 1
	if myCond == 1 do hide pda
)