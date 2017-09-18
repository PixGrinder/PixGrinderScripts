(

	global myHide =#()
	global myTransp =#()
	global myAnim = #()


	fn fixComponents myVar= 
	(
		


		pda = #()

		for tst in myVar.compLoc.hidden do
		(
			if tst.node == undefined then appendIfUnique myHide myVar.name else appendIfUnique pda tst
		)
		myVar.compLoc.hidden = pda


		pda = #()

		for tst in myVar.compLoc.transparent do
		(
			if tst.node == undefined then appendIfUnique myTransp myVar.name else appendIfUnique pda tst
		)
		myVar.compLoc.transparent = pda


		pda = #()

		for tst in myVar.compLoc.animated do
		(
			if tst.node == undefined then appendIfUnique myAnim myVar.name else appendIfUnique pda tst
		)
		myVar.compLoc.animated = pda

	)

	(
		setCommandPanelTaskMode mode:#create
		SetQuietMode true
		for obj in objects where custAttributes.count obj == 1 do fixComponents obj
		clearListener()
		sort myHide
		sort myTransp
		sort myAnim


		format "\rHidden problems :\r------------------\r" 
		for obj in myHide do format "%\r" obj

		format "\rTransparent problems :\r---------------------\r" 
		for obj in myTransp do format "%\r" obj

		format "\rAnimation problems :\r---------------------\r" 
		for obj in myAnim do format "%\r" obj
		format "\r"

		actionMan.executeAction 0 "40472"
		SetQuietMode false




	)

)