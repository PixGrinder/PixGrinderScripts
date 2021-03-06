plugin simpleObject Collier_01
name:"Collier_01"
classID:#(0xe9b28b4, 0x95845484)
category:"TPZ_Assets"
(
	local theTriMesh = triMesh()
	local originalSize = 0.468337
	function buildTriMesh =
	(
		v_arr =  #([-0.0485137,0.0499851,0.0749943], [-0.0485139,-0.0522555,0.0749942], [0.0623784,-0.0526711,0.0749652], [0.0623791,0.0495636,0.0749652], [-0.0850694,0.0498048,-0.0306251], [-0.0850694,-0.052442,-0.0306252], [0.00454354,0.0492624,-0.0960081], [0.00454354,-0.0529622,-0.0960081], [0.0948846,0.0491134,-0.0329849], [0.0948849,-0.0531045,-0.0329849], [0.0978379,0.0666417,0.110433], [0.0976183,0.0566798,0.184178], [0.102874,-0.0463363,0.190156], [0.104764,-0.0687897,0.11655], [0.0987115,0.029586,0.214814], [0.101316,-0.0219671,0.220361], [-0.0873647,0.0458394,0.18289], [0.0472636,0.0640155,0.109641], [-0.0376763,0.0596043,0.108299], [-0.0871925,0.0570334,0.107518], [-0.0821095,-0.0571679,0.188867], [-0.0802665,-0.0783964,0.113673], [-0.030659,-0.0758213,0.114445], [0.0538645,-0.0714324,0.115765], [-0.0862744,0.0187724,0.213668], [-0.0836678,-0.0328015,0.219105], [0.0277905,0.0264534,0.073585], [-0.0135522,0.0243062,0.0729316], [-0.0101366,-0.0416077,0.0759228], [0.0310023,-0.0394717,0.0765656], [-0.0852482,0.0179361,0.114855], [-0.116872,0.0167397,0.113659], [-0.11902,0.0390317,0.145163], [-0.0867133,0.0402634,0.146365], [-0.119289,0.0324874,0.183296], [-0.086756,0.0337311,0.1845], [-0.11752,0.000940442,0.20572], [-0.0853505,0.00216544,0.20692], [-0.114749,-0.037129,0.199298], [-0.0833206,-0.0359424,0.200493], [-0.1126,-0.0594211,0.167794], [-0.0818558,-0.0582694,0.168982], [-0.112331,-0.0528766,0.129662], [-0.0818126,-0.0517374,0.130846], [-0.1141,-0.0213304,0.107239], [-0.0832181,-0.020172,0.108427], [-0.151867,-0.0385079,0.161241], [-0.153041,-0.0263379,0.178442], [-0.154554,-0.00555229,0.181947], [-0.15552,0.0116717,0.169705], [-0.155372,0.0152446,0.148885], [-0.154199,0.00307357,0.131684], [-0.152686,-0.0177118,0.128179], [-0.15172,-0.0349356,0.140422])
		f_arr =  #([3,4,1], [1,2,3], [2,1,5], [5,6,2], [6,5,7], [7,8,6], [8,7,9], [9,10,8], [10,9,4], [4,3,10], [5,1,4], [7,5,4], [7,4,9], [10,3,2], [8,10,2], [8,2,6], [13,14,11], [11,12,13], [16,13,12], [12,15,16], [17,12,11], [17,11,18], [17,18,19], [17,19,20], [13,21,22], [13,22,23], [13,23,24], [13,24,14], [26,16,15], [15,25,26], [25,15,12], [12,17,25], [21,13,16], [16,26,21], [25,17,20], [25,20,22], [25,22,21], [25,21,26], [23,22,20], [20,19,23], [18,11,14], [14,24,18], [28,19,18], [18,27,28], [29,23,19], [19,28,29], [30,24,23], [23,29,30], [27,18,24], [24,30,27], [33,34,31], [31,32,33], [35,36,34], [34,33,35], [37,38,36], [36,35,37], [39,40,38], [38,37,39], [41,42,40], [40,39,41], [43,44,42], [42,41,43], [45,46,44], [44,43,45], [32,31,46], [46,45,32], [47,48,49], [49,50,51], [51,52,53], [49,51,53], [47,49,53], [47,53,54], [51,33,32], [32,52,51], [50,35,33], [33,51,50], [49,37,35], [35,50,49], [48,39,37], [37,49,48], [47,41,39], [39,48,47], [54,43,41], [41,47,54], [53,45,43], [43,54,53], [52,32,45], [45,53,52])
		setMesh theTriMesh verts:v_arr faces:f_arr
		theEdgeVis = #(#(1, #{3}), #(2, #{3}), #(3, #{3}), #(4, #{3}), #(5, #{3}), #(6, #{3}), #(7, #{3}), #(8, #{3}), #(9, #{3}), #(10, #{3}), #(11, #{3}), #(12, #{2..3}), #(13, #{1}), #(14, #{3}), #(15, #{2..3}), #(16, #{1}), #(17, #{3}), #(18, #{3}), #(19, #{3}), #(20, #{3}), #(21, #{3}), #(22, #{1, 3}), #(23, #{1, 3}), #(24, #{1}), #(25, #{3}), #(26, #{1, 3}), #(27, #{1, 3}), #(28, #{1}), #(29, #{3}), #(30, #{3}), #(31, #{3}), #(32, #{3}), #(33, #{3}), #(34, #{3}), #(35, #{3}), #(36, #{1, 3}), #(37, #{1, 3}), #(38, #{1}), #(39, #{3}), #(40, #{3}), #(41, #{3}), #(42, #{3}), #(43, #{3}), #(44, #{3}), #(45, #{3}), #(46, #{3}), #(47, #{3}), #(48, #{3}), #(49, #{3}), #(50, #{3}), #(51, #{3}), #(52, #{3}), #(53, #{3}), #(54, #{3}), #(55, #{3}), #(56, #{3}), #(57, #{3}), #(58, #{3}), #(59, #{3}), #(60, #{3}), #(61, #{3}), #(62, #{3}), #(63, #{3}), #(64, #{3}), #(65, #{3}), #(66, #{3}), #(67, #{3}), #(68, #{3}), #(69, #{3}), #(70, #{1..3}), #(71, #{1..3}), #(72, #{1}), #(73, #{3}), #(74, #{3}), #(75, #{3}), #(76, #{3}), #(77, #{3}), #(78, #{3}), #(79, #{3}), #(80, #{3}), #(81, #{3}), #(82, #{3}), #(83, #{3}), #(84, #{3}), #(85, #{3}), #(86, #{3}), #(87, #{3}), #(88, #{3}))
		theSmoothGroups = #(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		theMatIDs = #(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		theNumMaps = 2
		theMapSupport = #(false, true)
		theNumMapVerts = #(undefined, 98)
		theNumMapFaces = #(undefined, 88)
		theMapVerts = #()
		theMapFaces = #()
		theMapVerts[1] = undefined
		theMapFaces[1] = undefined
		theMapVerts[2] = #([0.40659,0.650247,-0.0490215], [0.002,0.650309,-0.120663], [0.00615021,0.743429,-0.144791], [0.410918,0.742591,-0.0879694], [0.407174,0.563982,0.1432], [0.00255931,0.563309,0.0734365], [0.411861,0.92134,0.144791], [0.00705633,0.920798,0.0912987], [0.00255931,0.997328,0.0734365], [0.407174,0.998,0.1432], [0.414175,0.835155,-0.0509127], [0.00927509,0.835469,-0.0922667], [0.795866,0.260195,0], [0.608463,0.320494,0], [0.493059,0.160932,0], [0.609141,0.002,0], [0.796275,0.0633474,0], [0.790792,0.583628,0], [0.791192,0.390086,0], [0.607193,0.329766,0], [0.493059,0.486028,0], [0.606531,0.642917,0], [0.805699,0.255146,0], [0.915809,0.227987,0], [0.938966,0.0402517,0], [0.805546,0.002,0], [0.979717,0.176255,0], [0.985478,0.0819708,0], [0.479935,0.002,-0.0123176], [0.00294532,0.00464951,-0.0043163], [0.00258541,0.0701817,0.0594658], [0.128509,0.0722366,0.057157], [0.345595,0.0758182,0.0540629], [0.471519,0.0779121,0.0527886], [0.0025984,0.349218,-0.0594658], [0.479385,0.348435,-0.0421329], [0.468724,0.243793,-0.00547522], [0.343393,0.245965,-0.00737515], [0.127331,0.249744,-0.00978514], [0.002,0.251954,-0.0106749], [0.00306841,0.439483,0.0417211], [0.483788,0.436808,0.0448282], [0.483085,0.384549,0.0364849], [0.00287261,0.386409,0.0235478], [0.00294532,0.48645,-0.0043163], [0.479935,0.4838,-0.0123176], [0.984866,0.490601,0], [0.922472,0.541046,0], [0.80057,0.564634,0], [0.800464,0.329766,0], [0.945205,0.357962,0], [0.990314,0.398619,0], [0.345595,0.0758182,0.0540629], [0.128509,0.554037,0.057157], [0.00258541,0.551982,0.0594658], [0.744803,0.90394,0], [0.682655,0.837366,0], [0.562027,0.836903,0], [0.496965,0.902989,0], [0.560128,0.717164,0], [0.493059,0.656977,0], [0.680113,0.714833,0], [0.739582,0.652189,0], [0.754074,0.684278,0.0648489], [0.868502,0.684713,0.0639154], [0.868502,0.652415,0.0625393], [0.756424,0.652189,0.0653496], [0.756424,0.910582,0.0653496], [0.868502,0.910808,0.0625393], [0.868502,0.878509,0.0618063], [0.756088,0.878252,0.0648524], [0.868502,0.84621,0.0630283], [0.755752,0.845924,0.0645172], [0.868502,0.813911,0.0648569], [0.755417,0.813594,0.0639233], [0.868502,0.781611,0.0653528], [0.755081,0.781266,0.0625425], [0.868502,0.749311,0.0648489], [0.754745,0.748936,0.0618028], [0.868502,0.717013,0.064509], [0.75441,0.716606,0.0630202], [0.603917,0.818967,0], [0.64105,0.819292,0], [0.66755,0.793202,0], [0.667889,0.75598,0], [0.641874,0.729429,0], [0.604739,0.729105,0], [0.578241,0.755196,0], [0.5779,0.792417,0], [0.996752,0.685319,-0.0611517], [0.996752,0.653019,-0.0646091], [0.996752,0.911412,-0.0646091], [0.996752,0.879113,-0.0653528], [0.996752,0.846814,-0.0624258], [0.996752,0.814515,-0.0580072], [0.996752,0.782215,-0.05516], [0.996752,0.749917,-0.0551167], [0.996752,0.717617,-0.0574315])
		theMapFaces[2] = #([3,4,1], [1,2,3], [2,1,5], [5,6,2], [9,10,7], [7,8,9], [8,7,11], [11,12,8], [12,11,4], [4,3,12], [14,15,16], [13,14,16], [13,16,17], [19,20,21], [18,19,21], [18,21,22], [25,26,23], [23,24,25], [28,25,24], [24,27,28], [29,30,31], [29,31,32], [29,32,33], [29,33,34], [35,36,37], [35,37,38], [35,38,39], [35,39,40], [43,44,41], [41,42,43], [42,41,45], [45,46,42], [36,35,44], [44,43,36], [47,48,49], [47,49,50], [47,50,51], [47,51,52], [38,37,34], [34,53,38], [54,55,40], [40,39,54], [58,59,56], [56,57,58], [60,61,59], [59,58,60], [62,63,61], [61,60,62], [57,56,63], [63,62,57], [66,67,64], [64,65,66], [70,71,68], [68,69,70], [72,73,71], [71,70,72], [74,75,73], [73,72,74], [76,77,75], [75,74,76], [78,79,77], [77,76,78], [80,81,79], [79,78,80], [65,64,81], [81,80,65], [82,83,84], [84,85,86], [86,87,88], [84,86,88], [82,84,88], [82,88,89], [91,66,65], [65,90,91], [93,70,69], [69,92,93], [94,72,70], [70,93,94], [95,74,72], [72,94,95], [96,76,74], [74,95,96], [97,78,76], [76,96,97], [98,80,78], [78,97,98], [90,65,80], [80,98,90])
		for f in theEdgeVis do for i in f[2] do
			setEdgeVis theTriMesh f[1] i false
		for f = 1 to getNumFaces theTriMesh do
		(
			setFaceSmoothGroup theTriMesh f theSmoothGroups[f]
			setFaceMatID theTriMesh f theMatIDs[f]
		)
		meshOp.setNumMaps theTriMesh theNumMaps keep:false
		for n = 1 to theNumMaps do
		(
			local supp = theMapSupport[n]
			meshOp.setMapSupport theTriMesh (n - 1) supp
			if supp do
			(
				local numMV = theNumMapVerts[n]
				local numMF = theNumMapFaces[n]
				meshOp.setNumMapVerts theTriMesh (n - 1) numMV
				meshOp.setNumMapFaces theTriMesh (n - 1) numMF
				for v = 1 to numMV do
					meshOp.setMapVert theTriMesh (n - 1) v theMapVerts[n][v]
				for f = 1 to numMF do
					meshOp.setMapFace theTriMesh (n - 1) f theMapFaces[n][f]
			)
		)
	)
	parameters main rollout:params
	(
		size type:#worldUnits ui:size default:0.468337
	)
	rollout params "Parameters"
	(
		fn showLocation =
		(
			rollout rltLoc ""
			(
				local theLoc = getSourceFileName()
				local w = (getTextExtent theLoc).x + 26
				button done "" align:#left offset:[-8,0]
				on rltLoc open do
				(
					rltLoc.width = w
					done.caption = theLoc
				)
				on done pressed do destroyDialog rltLoc
			)
			createDialog rltLoc modal:true style:#(#style_border)
		)
		spinner size "Size:" type:#worldUnits range:[0,10000,0] align:#center
		button orSz "Original Size" width:94
		button shLoc "Show Location" toolTip:"plugin's file"width:94
		on orSz pressed do size.value = originalSize
		on shLoc pressed do showLocation()
	)
	on create do buildTriMesh()
	on load do buildTriMesh()
	on clone orig do buildTriMesh()
	on buildMesh do
	(
		theMesh = copy theTriMesh
		local theScale = size / originalSize
		scale theMesh [theScale, theScale, theScale]
		setMesh mesh theMesh
	)
	tool create
	(
		on mousePoint click do
		case click of
		(
			1: (size = 0; coordSys grid (nodeTM.translation = gridPoint))
			2: #stop
		)
		on mouseMove click do
		case click of
		(
			2: size = 2 * length gridDist
		)
	)
)
