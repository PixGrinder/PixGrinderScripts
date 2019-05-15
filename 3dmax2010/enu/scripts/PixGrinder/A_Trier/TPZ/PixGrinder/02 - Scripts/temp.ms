-- Diffuse color to white


pda = getClassInstances StandardMaterial
for i = 1 to pda.count do pda[i].diffuseColor = color 255 255 255
	

-------------------------

-- find material by name

myString = "chrome"
pda = getClassInstances StandardMaterial
pda2 = #()
for i = 1 to pda.count do (
	if findstring pda[i].name myString != undefined do append pda2 pda[i]
)


for i = 1 to pda2.count do meditmaterials[i] = pda2[i]


pda[1].name
-------------------------

-- Error message

Some materials in this scene may not be supported by certain applications and will import as standard gray materials instead. The following materials are affected: 
    -black_brossé
    -black_metal
    -chrome




----------------------------

-- change wirecolor

geometry[1].wirecolor

for obj in selection do 
(
	obj.wirecolor = color  (random 50 200) (random 50 200) (random 50 200)
)


-----------------------------------

pda=#()
for obj in geometry do if (findstring obj.name "hsm") != undefined do appendifunique pda obj
if pda.count != 0 do select pda
pda.count

--------------------------------------------

-- select objects without material

glurf = #()
for obj in geometry do 
(
	if obj.material == undefined do
	(
		append glurf obj
	)
)

select glurf


