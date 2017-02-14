
-------------------------------------------------------------------------------
-- Felipe_Bitmap_to_power_of_two.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2014/12/01
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Bitmap_To_PowerOfTwo
category:"Felipe Scripts"
toolTip:"Resize bimaps to nearest power of two"
buttonText:"Power Of Two"
icon:#("Felipe Scripts",18)
silentErrors:true
autoUndoEnabled:true


(
	
	if (querybox "Please check bitmap paths in the assets tracking before continuing.") == true do
	(
		global pda = getclassinstances bitmaptexture
		
		fn powoftwo n1=
		(
			x=n1
			pda_origin = n1
			y=0
			while x > 1 do
			(
				x = x/2
				--print ("x = "+(x as string))
				y+=1
			)

			--print ("y = "+(y as string))

			x1 = pow 2 y
			x2 = pow 2 (y+1)
				
			pda_moy = (x1+x2)/2
				
			if pda_origin > pda_moy then return (x2 as integer) else return (x1 as integer)
		)
		
		rollout resizor "Resizor !! "
		(
			label txt1 "Choose an option : " pos:[35,20]
			label txt2 "-----------------------" pos:[35,40]
			radiobuttons rad1  labels:#("Backup Bitmaps","Overwrite Bitmaps") ---columns:2
			button mybutton "OK" width:50
			
			
			on mybutton pressed do
			(
				if rad1.state == 1 do
				(
					-- create folder to backup bitmaps
					if maxfilepath == "" then messagebox "Please save current scene to disk" else
					(
						myDir = ( maxfilepath +"bitmap_backup")
						makeDir myDir all:false
					)
					-- copy bitmaps to backup folder
					for i = 1 to pda.count do
					(
						if pda[i].bitmap.filename != undefined do
						(
							pda_nm = filenamefrompath pda[i].bitmap.filename 
							copyFile pda[i].bitmap.filename (maxfilepath+"bitmap_backup\\"+pda_nm)
						)
					)
				)
				
				for i = 1 to pda.count do
				(
					mySizeX = pda[i].bitmap.width
					mySizeY = pda[i].bitmap.height
					myMap = renderMap pda[i] size:[powoftwo(mySizeX),powoftwo(mySizeY)] filter:false fileName:(pda[i].bitmap.filename)
					save MyMap
				)
				
				destroyDialog resizor
			)
			
		)
		
		createDialog resizor height:150 --width:300 
		
	)
)

