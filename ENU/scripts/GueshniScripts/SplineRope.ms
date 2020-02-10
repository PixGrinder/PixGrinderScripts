
	try(destroyDialog SplineRope)catch()
rollout SplineRope "Spline Rope" width:136 height:188
(
	global sp=undefined
	global n=0
	global np=0
	global mvscr=""
	global dist_p
	label lbl1 "=== Spline Rope ===" pos:[13,8] width:116 height:16
	pickButton btn1 "Pick Spline" pos:[8,32] width:120 height:32
	button btn2 "Set Control" pos:[8,72] width:120 height:32
	button btn3 "Hide pt." pos:[8,112] width:58 height:24
	button btn4 "Unhide pt." pos:[70,112] width:58 height:24
	button btn5 "Apply" pos:[8,142] width:120 height:24
-- 	label lbl2 "Bodyul Vladislav"
	
	on btn1 picked obj do (
	sp=obj
	btn1.caption=obj.name
		)
		
	on btn2 pressed do (
		if (isvalidnode sp)==true then (
		for kp=1 to (numknots sp) do (
		np+=1
		p=point pos:(getknotpoint sp 1 kp) name:("sp_pnt"+(np as string)) wirecolor:green
		if kp>=2 then hide p
			)
		n=0
		-----------------------------------------------
		$sp_pnt*[1].wirecolor=red
		-----------------------------------------------
		for i=1 to $sp_pnt*.count do (
			if i==1 then (
				$sp_pnt*[1].position.controller=Position_List()
				$sp_pnt*[1].position.controller[2].controller=Position_Script()
				$sp_pnt*[1].position.controller[2].script="try(
setknotpoint sp 1 1 $"+($sp_pnt*[1].name as string)+".position.controller[1].pos
updateshape sp
[0,0,0])catch([0,0,0])")
			
			if i>=2 then (
			n+=1
			$sp_pnt*[i].position.controller=Position_List()
			$sp_pnt*[i].position.controller[2].controller=Position_Script()
			dist_p=(Distance $sp_pnt*[i] $sp_pnt*[i-1])
			mvscr=("try(
DependsOn $sp_pnt*[1]
this"+(n as string)+"=$"+($sp_pnt*[i].name as string)+".position.controller[1].pos
dis"+(n as string)+"=distance this"+(n as string)+" $"+($sp_pnt*[i-1].name as string)+".pos
vec"+(n as string)+"=($"+($sp_pnt*[i-1].name as string)+".pos-this"+(n as string)+")
a"+(n as string)+"=(dis"+(n as string)+"-("+(dist_p as string)+"))
p"+(n as string)+"=(vec"+(n as string)+"/(dis"+(n as string)+"/a"+(n as string)+"))
kp=($"+($sp_pnt*[i].name as string)+".position.controller[1].pos+=p"+(n as string)+")
setknotpoint sp 1 "+(i as string)+" kp
updateshape sp
p"+(n as string)+")catch([0,0,0])")
			$sp_pnt*[i].position.controller[2].script=mvscr
				)
			)
		)
	max views redraw
	)
	
	on btn3 pressed do (
		try(for p=1 to $sp_pnt*.count do (if p>=2 then (hide $sp_pnt*[p])))catch()
	max views redraw
	)
	on btn4 pressed do (
		try(for p=1 to $sp_pnt*.count do (unhide $sp_pnt*[p]))catch()
	max views redraw
	)
	on btn5 pressed do (
		try(delete $sp_pnt*)catch()
	max views redraw
	)
)
createDialog SplineRope width:136 height:188 pos:[140,210] bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)
