---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Select_by_List --
-- Select_by_List.ms --
-- Selects all components in scene from a .txt list of names --
-- Outputs missing names from list in Listener --

-- V 2.0 --

---------------------------------------------------------------------

clearListener()

try (DestroyDialog myRol) catch()

rollout myRol "Select By List" 
(
	edittext lbl fieldWidth:450 height:550 text:"" offset:[-2,15] align:#center
	button clrList "Clear List" pos:[lbl.pos.x, lbl.height+50]
	button myBtnAll "List Selected" pos:[(lbl.width/3), lbl.height+50]
	button mySelector "Select by List" pos:[2*(lbl.width/3)-15, lbl.height+50]
	button myClose "Close" pos:[lbl.width-20, lbl.height+50]
	

	on myBtnAll pressed do 
	(
		myStream = ""
		for obj in selection do append myStream (obj.name + "\n")
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

	on myClose pressed do
	(
		DestroyDialog myRol
	)

	on myRol resized mySize do 
	(
 		lbl.width = (mySize.x  - 50)
 		lbl.height = (mySize.y  - 100)
 		clrList.pos = [lbl.pos.x, lbl.height+50]
 		myBtnAll.pos = [(lbl.width/3), lbl.height+50]
 		mySelector.pos = [2*(lbl.width/3)-15, lbl.height+50]
 		myClose.pos = [lbl.width-20, lbl.height+50]
	)

)

CreateDialog myRol 500 650 500 50 bgcolor:(color 50 70 70) style:#(#style_titlebar, #style_border, #style_sysmenu, #style_resizing)
setFocus myRol.lbl
-- CreateDialog myRol 500 650 500 50 bgcolor:(color 50 70 70) style:#(#style_resizing, #style_titlebar, #style_minimizebox, #style_maximizebox)

--  DestroyDialog myRol

