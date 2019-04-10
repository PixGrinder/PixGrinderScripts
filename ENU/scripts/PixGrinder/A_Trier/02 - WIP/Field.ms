-- Field.ms --


rollout myRol "MyRol" 
(
	edittext lbl fieldWidth:450 height:600 text:"Youpi\nYoupla\nBlast"
	button myBtn "OK"
	button myBtnAll "List All"
	button mySelector "List All"

	on myBtn pressed do
	(
		print lbl.text
	)

	on myBtnAll pressed do 
	(
		myStream = ""
		for obj in objects do append myStream (obj.name + "\n")
		lbl.text=myStream
	)

	on mySelector pressed do
	(
		myStream = lbl.text
		seek myStream 0
		append mySelec 
	)

)

CreateDialog myRol 500 700 500 50
