(
	
-- alljpg = #()
-- alltif = #()
-- allgif = #()
-- allbmp = #()
-- alltga = #()
-- allpng = #()
-- alldds = #()

-- b		= undefined
-- alli 	= #()
-- count 	= 0
-- index 	= 1
-- logoposition = 6
-- logofile = undefined
-- vfblogo = undefined

-- cylsides = 8
-- gcolor = [88,88,88]
-- rallscale = 50
-- maxt = 12
-- assignalpha = off
-- assignsubmat = off
-- progpath = undefined
-- mshelppath = undefined

quadspsz = 10.0
quadspseg = 6
qs = undefined
qshemi = off
qswire = random (color 64 64 64) (color 200 200 200) 

-- quadcylinderrollout = undefined
-- qc = undefined
-- qcht=10.0
-- qcsz=5.0
-- qcseg=6
-- qcbias=1.5
-- qchtseg = 4
-- qctaper = 0.0
-- qccham = 1.0
-- qcchamseg = 4
-- qcwire = random (color 64 64 64) (color 200 200 200) 

-- rw1 = 64
-- rw2 = 200
-- rpselfillum = 100
-- rpcross = on
-- rprender = off

-- quadspsz = 10.0
-- quadspseg = 6
-- qs = undefined
-- qswire = random (color 64 64 64) (color 200 200 200) 
	
	
	fn autosmoothall obj =
(
	psel = polyOp.getFaceSelection obj
	np = polyOp.getNumFaces obj
	polyop.setFaceSelection obj #{1..np} 
	obj.autosmooth()
	polyOp.setFaceSelection obj psel
)	

	fn createquadsphere = 
( 
	with undo "QuadSphere" on 
	(
		try (delete qs)
		catch()
		qs=box height:quadspsz width:quadspsz length:quadspsz lengthsegs:quadspseg  widthsegs:quadspseg heightsegs:quadspseg
		qs.wirecolor = qswire
		addmodifier qs (Spherify PERCENT:100)
		converttopoly qs
		CenterPivot qs
		qs.pos = [0,0,0]
		if qshemi then
		(
			nv = polyop.getNumVerts qs
			for v=1 to nv do
			(
				pos = polyop.getVert qs v
				if pos.z < 0 then polyop.setVert qs #{v} [pos.x,pos.y,0] 
			)
		)
		autosmoothall qs
		qs.name = uniquename "QuadSphere"
		select qs
		max zoomext sel all
	)
)

	try(destroyDialog quadspheresettings)catch()
rollout quadspheresettings "QuadSphere"
(
	label 	lbl1 "Iterations" 	pos:[10,10] 
	label 	lbl2 "Diameter"		pos:[10,40] 
	spinner spn1 ""				pos:[60,10] 	width:50 height:25 range:[1,256,6] type:#integer
	spinner spn2 ""				pos:[60,40] 	width:50 height:25 range:[1,1000000,10] type:#float scale:0.1
	
	checkbox chkhemi "Hemisphere" 
	button btnnew "Create New" pos:[10,100] width:100 height:30

	on quadspheresettings open do 
	(
		spn1.value = quadspseg
		spn2.value = quadspsz
		qs = undefined
		qswire = random (color 64 64 64) (color 200 200 200) 
		createquadsphere()
	)
	
	on spn1 entered do
	(
		quadspseg = spn1.value
		createquadsphere()
	)
	on spn2 entered do
	(
		quadspsz = spn2.value
		createquadsphere()
	)
	on btnnew pressed do
	(
		qs = undefined
		qswire = random (color 64 64 64) (color 200 200 200) 
		createquadsphere()
	)
	on chkhemi changed state do 
	(
		qshemi = chkhemi.checked
		createquadsphere()
	)

)

createdialog quadspheresettings  width:120 height:140 pos:[140,210] bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)

)