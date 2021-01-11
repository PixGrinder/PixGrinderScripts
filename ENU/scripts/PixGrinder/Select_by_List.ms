---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Select_by_List --
-- Select_by_List.ms --
-- Outputs missing names from list in Listener --
-- dassonphil@gmail.com -- 
-- V 3.0 --

---------------------------------
-- Ideas to implement :  
--     Sort List alphabetically
---------------------------------




---------------------------------------------------------------------

clearListener()

try (DestroyDialog myRol) catch()

fn pda_selectList thePath = 
(
	theDialog = dotNetObject "System.Windows.Forms.OpenFileDialog" --create a OpenFileDialog 
	theDialog.title = "PLEASE Select One Or More Files" --set the title
	theDialog.Multiselect = false --allow multiple files to be selected
	theDialog.Filter = "TextFile(*.txt)|" --specify the filter
	theDialog.FilterIndex = 1 --set the filter drop-down list to All Files
	theDialog.InitialDirectory = thePath
	theDialog.FileName="*.txt"
	result = theDialog.showDialog() --display the dialog, get result into variable
	result.ToString() --when closed, convert the result to string
	result.Equals result.OK --returns TRUE if OK was pressed, FALSE otherwise
	result.Equals result.Cancel --returns TRUE if Cancel was pressed, FALSE otherwise
	theFilenames = theDialog.fileNames --the selected filenames will be returned as an array
	if result.Equals result.OK then return theFilenames else return false
)


rollout myRol "Select By List" 
(
	edittext lbl fieldWidth:450 height:550 text:"" offset:[-2,15] align:#center
	button clrList "Clear List" pos:[lbl.pos.x, lbl.height+50]
	button myBtnAll "List Selected" pos:[(lbl.width/4)+10, lbl.height+50]
	button mySelector "Select by List" pos:[2*(lbl.width/4)+8, lbl.height+50]
	button myFileLoad "Load File" pos:[3*(lbl.width/4)+5, lbl.height+50]
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
		theBad = for obj in mySelec where (getNodeByName obj == undefined) collect obj
-- 		theRes
		clearSelection()
		select theRes
		clearListener()
		if theBad.count != 0 then
		(
			actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
			format "Missing objects : \r-----------------\n\n"
			for obj in theBad do format "%\r" obj
		)
	)

	on clrList pressed do
	(
		lbl.text = ""
	)

	on myFileLoad pressed do
	(
		pda_theFile = pda_selectList (getDir #scene)
		if pda_theFile != false then 
		(		
			pda_theFile = openFile pda_theFile[1]
			pda_fStream = stringStream ""
			seek pda_theFile 0
			while not eof pda_theFile do format ((readline pda_theFile) as string + "\n") to:pda_fStream
			lbl.text = pda_fStream
			close pda_theFile
			close pda_fStream
		)
	)


	on myClose pressed do
	(
		DestroyDialog myRol
	)

	on myRol resized mySize do 
	(
 		if mySize.x <= 420 then mySize.x = 420
 		lbl.width = (mySize.x  - 50)
 		lbl.height = (mySize.y  - 100)
 		clrList.pos = [lbl.pos.x, lbl.height+50]
 		myBtnAll.pos = [(lbl.width/4)+10, lbl.height+50]
 		mySelector.pos = [2*(lbl.width/4)+8, lbl.height+50]
 		myFileLoad.pos = [3*(lbl.width/4)+5, lbl.height+50]
 		myClose.pos = [lbl.width-20, lbl.height+50]
	)

)

CreateDialog myRol 500 650 500 50 bgcolor:(color 50 70 70) style:#(#style_titlebar, #style_border, #style_sysmenu, #style_resizing)
setFocus myRol.lbl
-- CreateDialog myRol 500 650 500 50 bgcolor:(color 50 70 70) style:#(#style_resizing, #style_titlebar, #style_minimizebox, #style_maximizebox)

--  DestroyDialog myRol





	--pda_theFile = pda_selectList (getDir #scene)
	-- print pda_theFile

