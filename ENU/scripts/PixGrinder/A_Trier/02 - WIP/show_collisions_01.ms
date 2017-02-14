pda = #()

for obj in objects do obj.ishidden = true
for obj in objects do if findstring obj.name "col_" != undefined do append pda obj
for obj in pda do obj.ishidden = false
	

