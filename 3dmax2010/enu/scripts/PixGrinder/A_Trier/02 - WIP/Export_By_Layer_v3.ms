-- Export by Layer



(

	global ary = #()
	global exp_path = getSavePath caption:"Export Files To : " initialDir:"c:"
	global exp_path = append exp_path "\\"
	
	
--------------------	

	fn l_off =
	(
		local i = 1
		local lxi = 1
		for i = 0 to layermanager.count-1 do (
			lxi  = layermanager.getLayer i
			lxi.on = false
		)
	)

--------------------

	fn l_on =
	(
		local i = 1
		local lxi = 1
		for i = 0 to layermanager.count-1 do (
			lxi  = layermanager.getLayer i
			lxi.on = true
		)
	)
	
	
	
--------------------
	
	fn l_sv =
	(
		
		local j = 1
		local lx = 1
		local d = 1
		local obj = 1
		
		for j = 1 to layermanager.count-1 do (
			l_off ()
			lx = layermanager.getLayer j
			d = #()
			lx.on = true
			lx.select on
			d = selection as array
			-- v3
			for obj in d do
			(				
				for w = 1 to obj.children.count do 
				(
					appendifunique d obj.children[w]
				)
			)
			------
			saveNodes d (exp_path + lx.name + ".max") quiet:true
		)
	)

--------------------

fn l_dt = 	
		(
		
		local j = 1
		local lx = 1
		local d = 1
		local obj = 1
		
		for j = 1 to layermanager.count-1 do (
			lx = layermanager.getLayer j
			deleteFile (exp_path + lx.name + ".max")
		)
	)
	
	
	
--------------------
fn layerNm = 
(
		
	for j = 1 to layermanager.count-1 do (
		lx = layermanager.getLayer j
		append ary lx.name
	)
	
	
)


-----------------------
	
	
fn l_exp = 
(
	local j = 1
	
	for j = 1 to ary.count do (
		loadMaxFile (exp_path + ary[j] + ".max") useFileUnits:false quiet:true
		l_on ()
		max unhide all
		exportFile (exp_path + ary[j] + ".fbx") #noprompt selectedOnly:false using:FBXEXP
	)
-------------------------------------	
-- print exporterPlugin.classes
-------------------------------------
	
)


-----------------
	
	print "-----"
	

	fname = MaxFilePath + MaxFileName

	fnm = replace MaxFileName (MaxFileName.count-3) 4 ""
	saveMaxFile ( MaxFilePath + fnm + "_backup.max" ) quiet:true

	-- v3
	delete cameras
	-------
	

	l_off ()
	
	max unhide all
	
	layerNm ()

	l_sv ()
	
	l_exp ()
	
	l_dt ()

	loadMaxFile fname useFileUnits:false quiet:true

)



