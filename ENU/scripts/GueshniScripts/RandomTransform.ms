rollout rantrans "Random Transform" width:230 height:400
(
	button rand_but  "go random" pos:[35,235] width:146 height:32
	button anim_but  "go animate" pos:[35,350] width:146 height:32
	groupBox grp1 "Move" pos:[20,16] width:171 height:47
	groupBox grp2 "Rotate" pos:[20,67] width:171 height:47
	groupBox grp3 "Scale" pos:[20,114] width:171 height:47
	groupBox grpanim "animation rage" pos:[20,280] width:180 height:60
	
	checkbox chk1 "X" pos:[35,29] width:36 height:30 checked:true
	checkbox chk2 "Y" pos:[86,29] width:36 height:30 checked:true
	checkbox chk3 "Z" pos:[140,29] width:36 height:30 checked:true
	
	checkbox chk4 "X" pos:[35,81] width:36 height:30
	checkbox chk5 "Y" pos:[86,81] width:36 height:30
	checkbox chk6 "Z" pos:[140,81] width:36 height:30
	
	checkbox chk7 "X" pos:[35,125] width:36 height:30
	checkbox chk8 "Y" pos:[86,125] width:36 height:30
	checkbox chk9 "Z" pos:[140,125] width:36 height:30
	
	checkbox chk10 "Relative_Scale" pos:[110,180] width:100 height:50
	
	spinner spn1 "From" pos:[31,179] width:72 height:16  range:[-10000,10000,0]
	spinner spn2 "To    " pos:[31,204] width:72 height:16 range:[-10000,10000,0]
	
	spinner spn3 "From" pos:[40,300] width:72 height:16  range:[-10000,10000,0] type:#integer
	spinner spn4 "To    " pos:[125,300] width:72 height:16 range:[0,10000,0] type:#integer
	spinner spn5 "by    " pos:[80,330] width:72 height:16 range:[0,1000,5] type:#integer


	on rand_but pressed do (
	if (selection.count == 0)then 
		messageBox "plz select an one or more object to randomize"
		else 

		undo on
		(
for i in selection do 
(
	--- check foooooooooor relative
			if (chk10.checked == true and chk7.checked == false )do 
	(
				messageBox "plz chek the x scale for relative scale or uncheck RelativeScale  "
		exit
		)
-- random the postion
	

	if (chk1.checked == false)then
	ranx  = 0
	else 
	ranx = random spn1.value spn2.value

		if (chk2.checked == false)then
	rany  = 0
	else 
	rany = random spn1.value spn2.value

		if (chk3.checked == false)then
	ranz  = 0
	else 
	ranz= random spn1.value spn2.value

	move i [ranx,rany,ranz]
-- random the Rotation
		if (chk4.checked == false)then
	ranx  = 0
	else 
	ranx = random spn1.value spn2.value

		if (chk5.checked == false)then
	rany  = 0
	else 
	rany = random spn1.value spn2.value

		if (chk6.checked == false)then
	ranz  = 0
	else 
	ranz= random spn1.value spn2.value

	roteu = eulerangles ranx rany ranz
rotate i roteu


-- random the Scale

	if (chk7.checked == false)then
	ranx  =1
	else 
	ranx = random spn1.value spn2.value

		if (chk8.checked == false)then
	rany  = 1
	else 
	rany = random spn1.value spn2.value

		if (chk9.checked == false)then
	ranz  = 1
	else 
	ranz= random spn1.value spn2.value
if (ranx!=1) do
ranx=ranx/100

if (rany!=1) do
rany=rany/100

if (ranz!=1) do
ranz=ranz/100
		if (chk10.checked == false)then
	scale i [ranx,rany,ranz]
	else (
	if (chk7.checked == false)then(
		messageBox "plz chek the x scale for relative scale "
	
		)else 
		scale i [ranx,ranx,ranx]
	)



)
)
)

	on anim_but pressed do 

	(

if (selection.count == 0)then 
	messageBox "plz select an one or more object to randomize"
		else 
(

	
	
	
	
      stepy = spn5.value

	spnin  = spn3.value
	spnout = spn4.value
				undo on 
				animate on
				(
for tframe =  (spnin+stepy)  to spnout by stepy do 
(
			if (chk10.checked == true and chk7.checked == false )do 
	(
				messageBox "plz chek the x scale for relative scale or uncheck RelativeScale  "
		exit
		)

for i in selection do 
(
-- random the postion

	if (chk1.checked == false)then
	ranx  = 0
	else 
	ranx = random spn1.value spn2.value

		if (chk2.checked == false)then
	rany  = 0
	else 
	rany = random spn1.value spn2.value

		if (chk3.checked == false)then
	ranz  = 0
	else 
	ranz= random spn1.value spn2.value

	at time tframe (move i [ranx,rany,ranz])
-- random the Rotation
		if (chk4.checked == false)then
	ranx  = 0
	else 
	ranx = random spn1.value spn2.value

		if (chk5.checked == false)then
	rany  = 0
	else 
	rany = random spn1.value spn2.value

		if (chk6.checked == false)then
	ranz  = 0
	else 
	ranz= random spn1.value spn2.value

	roteu = eulerangles ranx rany ranz
at time tframe (rotate i roteu)


-- random the Scale

	if (chk7.checked == false)then
	ranx  =1
	else 
	ranx = random spn1.value spn2.value

		if (chk8.checked == false)then
	rany  = 1
	else 
	rany = random spn1.value spn2.value

		if (chk9.checked == false)then
	ranz  = 1
	else 
	ranz= random spn1.value spn2.value
if (ranx!=1) do
ranx=ranx/100

if (rany!=1) do
rany=rany/100

if (ranz!=1) do
ranz=ranz/100
		if (chk10.checked == false)then
at time tframe (scale i [ranx,rany,ranz])
	else (
		if (chk7.checked == false)then(
		messageBox "plz chek the x scale for relative scale "
		)else 
		at time tframe (scale i [ranx,ranx,ranx])




)
)
)
)


))
	)

	
createdialog rantrans pos:[140,210] -- bgcolor:(color 84 101 120) fgcolor:(color 248 113 45) 