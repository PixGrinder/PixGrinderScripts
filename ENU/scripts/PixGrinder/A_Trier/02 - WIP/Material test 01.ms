pda = #()
for i = 1 to geometry.count do
(
	x1 = classof geometry[i].material as string
	appendifunique pda x1
)
pda




pda = #()
for i = 1 to geometry.count do
(
	if (classof geometry[i].material) == Multimaterial do append pda geometry[i]
)
max select none
select pda

for i = 1 to SceneMaterials.count do print (classof scenematerials[i])


pda = #()
for i = 1 to geometry.count do
(
	--if (classof geometry[i].material) == standard do appendifunique pda geometry[i].material
	if (classof geometry[i].material) == Multimaterial do for j = 1 to geometry[i].material.count do print (classof geometry[i].material[j])
)
pda.count