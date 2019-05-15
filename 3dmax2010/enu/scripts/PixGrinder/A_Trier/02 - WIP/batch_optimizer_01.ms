-- batch_optimizer.ms

setCommandPanelTaskMode #modify
clearListener()



actionMan.executeAction 0 "40472" -- launch Listener
myAr = selection as array

myMod = ProOptimizer vertexPercent:35.0


fn myOp v1 = 
(
	--modPanel.addModToSelection(v1)
	addModifier v1 (ProOptimizer vertexPercent:35.0 calculate:on)
	v1.modifiers[1].calculate = on
	--select v1
	--modpanel.addModToSelection myMod
	--myMod.calculate = on
	--collapseStack v1
)





--with redraw off
(
	myProg = 0
	progressStart "Processing..."
	for i = 1 to myAr.count do 
	(
		if superClassOf myAr[i] == GeometryClass do
		(	
			if (100*(i as float)/(myAr.count as float) > (myProg as float)) do  --then print "youpi" else print ((obj as float)/gem.count) as string
			(
				myProg = myProg+1
				progressUpdate myProg
			)

			myOp myAr[i]
		)
	)
	progressEnd()
)

clearSelection()
select myAr



-- addModifier $ myMod

for obj in selection do 
(
	obj.modifiers[1].calculate = on
	collapseStack obj

)