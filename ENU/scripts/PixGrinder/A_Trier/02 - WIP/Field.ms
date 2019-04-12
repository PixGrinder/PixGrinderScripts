-- Field.ms --




rollout myRol "MyRol" 
(
	edittext lbl fieldWidth:450 height:550 text:"Youpi\nYoupla\nBlast"
	button myBtnAll "List All"
	button mySelector "Select by List"
	button clrList "Clear List"

	on myBtnAll pressed do 
	(
		myStream = ""
		for obj in objects do append myStream (obj.name + "\n")
		lbl.text=myStream
	)

	on mySelector pressed do
	(
		mySelec = #()
		myStream = (lbl.text) as StringStream
		--print myStream
		seek myStream 0
		while not eof myStream do append mySelec (readline myStream) -- recently added
		theRes = for obj in mySelec where (getNodeByName obj != undefined) collect (getNodeByName obj)
		clearListener()
		theRes
		clearSelection()
		select theRes --------------
	)

	on clrList pressed do
	(
		lbl.text = ""
	)

)

CreateDialog myRol 500 700 500 50


