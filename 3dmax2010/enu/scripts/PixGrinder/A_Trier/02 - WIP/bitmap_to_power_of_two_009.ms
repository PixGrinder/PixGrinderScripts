
-------------------------------------------------------------------------------
-- Felipe_Bitmap_to_power_of_two.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2014/10/27
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Bitmap_To_PowerOfTwo
category:"Felipe Scripts"
toolTip:"Resizes Bitmaps to neares power of two"
buttonText:"Power Of Two"
--icon:#("Felipe Scripts",18)
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
			radiobuttons rad1  labels:#("Save Bitmaps","Overwrite Bitmaps") ---columns:2
			button mybutton "OK" width:50
			
			
			on mybutton pressed do
			(
				if rad1.state == 1 do
				(
					-- create folder to backup bitmaps
					if maxfilepath == "" then messagebox "Please save current scene to disk" else
					(
						myDir = ( "@\""+maxfilepath +"bitmap_backup\"")
						makeDir (execute myDir) all:false
					)
					-- copy bitmaps to backup folder
					for i = 1 to pda.count do
					(
						pda_nm = filenamefrompath pda[i].bitmap.filename 
						copyFile pda[i].bitmap.filename (maxfilepath+"bitmap_backup\\"+pda_nm)
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

----------------------------


x1 = openbitmap "D:\\01_Projects\\CNES\\maps\\test_01.avi"
y1 = BitmapTexture()
y1.bitmap = x1
x1.frame = 15
renderMap y1 size:[1024,1024] filter:false display:true
x2 = bitmap 1024 1024 filename:"D:\\roger.avi" numframes:x1.numframes
x2 = renderMap y1 size:[1024,1024] filter:false display:false
save x2
display x2
x2.numframes



renderMap x1

x3 = renderMap x4 size:[512,512]


renderMap y1 display:true size:[1024,1024] filter:false


show y1



pda[1].bitmap.filename









----------------------------

global pda = getclassinstances bitmaptexture
 for i = 1 to pda.count do format "ID:%, frames:%\n" i pda[i].bitmap.numframes

pda[12].bitmap.width
pda[12].bitmap.height
pda[12].bitmap.numframes
pda[12].bitmap.frame
 
i = 12
x1 = openbitmap() (pda[i].bitmap as string)
x1.frame = 16

x1 = openbitmap "D:\\01_Projects\\CNES\\maps\\test_01.avi"
gotoFrame x1 52
-- x1.frame = 1
display x1 pos:[10,10]
 

 

 
x1.numframes
-- x1 = renderMap pda[i] size:[powoftwo(mySizeX),powoftwo(mySizeY)] filter:false fileName:(pda[i].bitmap.filename)
x1 = renderMap pda[i] size:[256,1000] filter:false fileName:(pda[i].bitmap.filename) time:1
x1.frame
gotoFrame x1 10
display x1

 x1.frame = 16
 
pda[12].bitmap.frame = 15
 
gotoFrame x1 16
 
 
 
 
 
 
 