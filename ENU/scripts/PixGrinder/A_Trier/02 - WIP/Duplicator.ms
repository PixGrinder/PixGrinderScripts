
pda_newnode = #()
pda_sel = getCurrentSelection()
global c1 = $.center
-- if pda_sel.count == undefined or pda_sel.count > 1 do messageBox "You must have a single object selected" title:"Warning of the Dead" beep:true

maxOps.cloneNodes pda_sel cloneType:#copy newNodes:&pda_newnode

global d1 = distance c1 $.center


		fn drawLineBetweenTwoPoints pointA pointB =
		(
			ss = SplineShape pos:[0,0,0]
			addNewSpline ss
			addKnot ss 1 #corner #line PointA
			addKnot ss 1 #corner #line PointB
			updateShape ss
			ss
		)
		
		myLine = drawLineBetweenTwoPoints t1.center t2.center


		cam_right.position.controller = path follow:true
		cam_right.position.controller.path = myLine
		cam_right.position.controller.percent = 65
		deleteKeys cam_right.position.controller.percent.controller #allKeys
		
		
		


rollout 
(
	spinner nb "Number of in between objects : " type:#float pos:[35,215] width:100 height:20 range:[1,100,1]
	
	on nb changed state do
	(
		for i = 1 to nb do
			maxOps.cloneNodes pda_sel cloneType:#copy newNodes:&pda_newnode
			move pda_newnode 
		
		
	)
	
)


track

tool pdatool
(
	
	on start do $.pos = worldPoint
	
	on mousePoint arg do #stop
	
	
)

startTool pdatool



tool foo

(

local b

on mousePoint clickno do

if clickno == 1 then b = box pos:worldPoint else #stop

on mouseMove clickno do b.pos = worldPoint

)

startTool foo





