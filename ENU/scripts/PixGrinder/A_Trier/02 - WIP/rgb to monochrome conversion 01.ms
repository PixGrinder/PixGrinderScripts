global pda_ar = #()
global pda_std = #()
global pda_mentalray= #()
global pda_vray = #()
global pda_other = #()

global pda_error = #()


max select none

(
	local i = 1
	local lxi = 1
	for i = 0 to layermanager.count-1 do (
		lxi  = layermanager.getLayer i
		lxi.on = true
	)
)

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

if pda_error.count !=0 do
(
	messagebox "Objects containing recursive multimaterials are now selected"
	select pda_error
)





for i = 1 to pda_ar.count do 
(
	if classof pda_ar[i]
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



---------------------------------------------


y.r

y1 =rendermap y display:true







