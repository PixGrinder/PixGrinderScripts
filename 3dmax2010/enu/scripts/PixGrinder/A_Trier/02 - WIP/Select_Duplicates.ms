for i = 0 to layermanager.count-1 do (
	lxi  = layermanager.getLayer i
	lxi.on = true
)

max unhide all

pda01 = objects as array
pda02 = #()
pda03 = #()
pda04 = #()

for i = 1 to pda01.count do append pda02 pda01[i].name

sort pda02
for i = 1 to pda02.count do (
	if pda02[i+1] == pda02[i] do append pda03 pda02[i]
)
	

for i = 1 to pda03.count do (
	for j=1 to pda01.count do (
		if pda01[j].name == pda03[i] do append pda04 pda01[j]
	)
)
	
select pda04
