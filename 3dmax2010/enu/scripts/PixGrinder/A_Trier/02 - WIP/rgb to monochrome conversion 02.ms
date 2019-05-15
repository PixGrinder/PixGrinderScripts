-- Variables and arrays : 
-----------------------------

global pda_ar = #()
global pda_std = #()
global pda_mentalray= #()
global pda_vray = #()
global pda_other = #()

global pda_error = #()

global pda_name = ""


-- function to generate bump map from diffuse map :
-----------------------------------------------------------
fn compfn c1 p1 c2 p2 = 
(
	--res = (c1*0.5 + c2*0.5)
	res = c2
	res.r = (c1.r+c1.g+c1.b)/3
	res.g = res.r
	res.b = res.r
	res
)



-- select none !
-------------------------------
max select none


-- Display all Layers !
-------------------------------
(
	local i = 1
	local lxi = 1
	for i = 0 to layermanager.count-1 do (
		lxi  = layermanager.getLayer i
		lxi.on = true
	)
)


-- collect all single materials
-----------------------------------
for obj in geometry do 
(
	if classof obj.material == multimaterial then
	(
		for i = 1 to obj.material.count do 
		(
			if classof obj.material[i] != multimaterial then appendifunique pda_ar obj.material[i] else appendifunique pda_error obj
		)
	)
	else
	(
		appendifunique pda_ar obj.material
	)
)
--for i = 1 to pda_ar.count do print (classof pda_ar[i])



-- collect materials by class
---------------------------------
for i = 1 to pda_ar.count do
(
	if classof pda_ar[i] == standardmaterial do appendifunique pda_std pda_ar[i]
	if classof pda_ar[i] == Arch___Design__mi do appendifunique pda_mentalray pda_ar[i]
	if classof pda_ar[i] == VRayMtl do appendifunique pda_vray pda_ar[i]
)


-- Generate bump for standard materials 
----------------------------------------------
for i = 1 to pda_std.count do 
(
	if pda_std[i].diffusemap != undefined and pda_std[i].diffusemap.bitmap != undefined do
	(
		pda_map = pda_std[i].diffusemap.bitmap
		b1 = bitmap pda_map.width pda_map.height color:white
		b2 = bitmap pda_map.width pda_map.height color:white
		b1 = pda_map
		pastebitmap b1 b2 [0,0] [0,0] type:#function function:compfn
		pda_name= pda_map.filename
		pda_name = replace pda_name (pda_name.count-3) 4 "_bump.jpg"
		b2.filename = pda_name
		save b2
	)
)




(
	x= geometry[1]
	y = x.material.diffusemap.bitmap

	b1 = bitmap y.width y.height color:white
	b2 = bitmap y.width y.height color:white

	b1 = y

	display b1
	-- display b2

	fn compfn c1 p1 c2 p2 = 
	(
		--res = (c1*0.5 + c2*0.5)
		res = c2
		res.r = (c1.r+c1.g+c1.b)/3
		res.g = res.r
		res.b = res.r
		res
	)

	pastebitmap b1 b2 [0,0] [0,0] type:#function function:compfn

	display b2

)







-- select object with multimaterial containing multimaterial !! (WTF !! )
--------------------------------------------------------------------------------
if pda_error.count !=0 do
(
	messagebox "Objects containing recursive multimaterials are now selected"
	select pda_error
)






---------------------------------------------


y.r

y1 =rendermap y display:true







