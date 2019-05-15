pda = #()
pda_alone = #()
pda_root = #()


for obj in objects do 
(
	if obj.parent == undefined do append pda obj
	
)

for obj in pda do 
(
	if obj.children.count == 0 do append pda_alone obj
	if obj.children.count > 0 do append pda_root obj
)

for obj in pda_root do 
(
)

	
("pda = " + pda.count as string)
("pda_alone = " + pda_alone.count as string)
("pda_root = " + pda_root.count as string)



