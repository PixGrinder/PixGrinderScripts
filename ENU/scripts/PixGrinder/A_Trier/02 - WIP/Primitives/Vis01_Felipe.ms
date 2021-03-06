plugin simpleObject Vis01
name:"Vis01"
classID:#(0x4e6c9103, 0xaede42b7)
category:"Felipe"
(
	local theTriMesh = triMesh()
	local originalSize = 0.115812
	function buildTriMesh =
	(
		v_arr =  #([0,-0.0175404,-0.0912521], [0.0151904,-0.0087702,-0.0912521], [0.0151904,0.00877021,-0.0912521], [0,0.0175404,-0.0912521], [-0.0151904,0.00877022,-0.0912521], [-0.0151905,-0.00877019,-0.0912521], [0,-0.0175404,0.00456035], [0.0151904,-0.0087702,0.00456035], [0.0151904,0.00877021,0.00456035], [0,0.0175404,0.00456035], [-0.0151905,0.00877022,0.00456035], [-0.0151905,-0.00877019,0.00456035], [0,-0.032542,0.00456035], [0.0281822,-0.016271,0.00456036], [0.0281822,0.016271,0.00456036], [0,0.032542,0.00456035], [-0.0281822,0.016271,0.00456034], [-0.0281822,-0.016271,0.00456034], [0,-0.032542,0.0245603], [0.0281822,-0.016271,0.0245604], [0.0281822,0.016271,0.0245604], [0,0.032542,0.0245603], [-0.0281822,0.016271,0.0245603], [-0.0281822,-0.016271,0.0245603], [0,-0.0175404,0.0245603], [0.0151904,-0.0087702,0.0245603], [0.0151904,0.00877021,0.0245603], [0,0.0175404,0.0245603], [-0.0151905,0.00877022,0.0245603], [-0.0151905,-0.00877019,0.0245603], [0,-0.0175404,0.0178042], [0.0151904,-0.0087702,0.0178042], [0.0151904,0.00877021,0.0178042], [0,0.0175404,0.0178042], [-0.0151905,0.00877022,0.0178042], [-0.0151905,-0.00877019,0.0178042], [-0.0092985,0.0161055,0.000484575], [0,0.0185971,0.000484575], [0,0.0185971,0.00486861], [-0.00929851,0.0161055,0.00486861], [0.00929853,0.0161055,0.000484575], [0.00929853,0.0161055,0.00486861], [0.0161055,0.00929852,0.000484575], [0.0161055,0.00929853,0.00486861], [0.0185971,0,0.000484575], [0.0185971,0,0.00486861], [0.0161055,-0.00929852,0.000484571], [0.0161055,-0.00929852,0.00486861], [0.00929853,-0.0161055,0.000484571], [0.00929853,-0.0161055,0.00486861], [0,-0.018597,0.000484571], [0,-0.018597,0.00486861], [-0.00929852,-0.0161055,0.000484571], [-0.00929852,-0.0161055,0.00486861], [-0.0161055,-0.00929852,0.000484571], [-0.0161055,-0.00929852,0.00486861], [-0.018597,0,0.000484575], [-0.018597,0,0.00486861], [-0.0161055,0.00929852,0.000484575], [-0.0161055,0.00929852,0.00486861], [-0.0212623,0.0368275,0.000484571], [0,0.0425247,0.000484575], [0,0.0425247,0.00486862], [-0.0212623,0.0368275,0.00486861], [0.0212624,0.0368275,0.000484571], [0.0212624,0.0368275,0.00486861], [0.0368275,0.0212624,0.000484575], [0.0368275,0.0212624,0.00486861], [0.0425247,0,0.000484575], [0.0425247,0,0.00486861], [0.0368275,-0.0212624,0.000484571], [0.0368275,-0.0212624,0.00486861], [0.0212624,-0.0368275,0.000484575], [0.0212624,-0.0368275,0.00486861], [0,-0.0425247,0.000484575], [0,-0.0425247,0.00486861], [-0.0212624,-0.0368275,0.000484575], [-0.0212624,-0.0368275,0.00486861], [-0.0368275,-0.0212624,0.000484571], [-0.0368275,-0.0212624,0.00486861], [-0.0425247,0,0.000484575], [-0.0425247,0,0.00486861], [-0.0368275,0.0212624,0.000484575], [-0.0368275,0.0212624,0.00486861])
		f_arr =  #([1,2,8], [8,7,1], [2,3,9], [9,8,2], [3,4,10], [10,9,3], [4,5,11], [11,10,4], [5,6,12], [12,11,5], [6,1,7], [7,12,6], [5,4,3], [3,2,1], [5,3,1], [6,5,1], [32,33,34], [34,35,36], [32,34,36], [31,32,36], [7,8,14], [14,13,7], [8,9,15], [15,14,8], [9,10,16], [16,15,9], [10,11,17], [17,16,10], [11,12,18], [18,17,11], [12,7,13], [13,18,12], [13,14,20], [20,19,13], [14,15,21], [21,20,14], [15,16,22], [22,21,15], [16,17,23], [23,22,16], [17,18,24], [24,23,17], [18,13,19], [19,24,18], [19,20,26], [26,25,19], [20,21,27], [27,26,20], [21,22,28], [28,27,21], [22,23,29], [29,28,22], [23,24,30], [30,29,23], [24,19,25], [25,30,24], [25,26,32], [32,31,25], [26,27,33], [33,32,26], [27,28,34], [34,33,27], [28,29,35], [35,34,28], [29,30,36], [36,35,29], [30,25,31], [31,36,30], [37,38,39], [39,40,37], [38,41,42], [42,39,38], [41,43,44], [44,42,41], [43,45,46], [46,44,43], [45,47,48], [48,46,45], [47,49,50], [50,48,47], [49,51,52], [52,50,49], [51,53,54], [54,52,51], [53,55,56], [56,54,53], [55,57,58], [58,56,55], [57,59,60], [60,58,57], [59,37,40], [40,60,59], [38,37,61], [61,62,38], [40,39,63], [63,64,40], [41,38,62], [62,65,41], [39,42,66], [66,63,39], [43,41,65], [65,67,43], [42,44,68], [68,66,42], [45,43,67], [67,69,45], [44,46,70], [70,68,44], [47,45,69], [69,71,47], [46,48,72], [72,70,46], [49,47,71], [71,73,49], [48,50,74], [74,72,48], [51,49,73], [73,75,51], [50,52,76], [76,74,50], [53,51,75], [75,77,53], [52,54,78], [78,76,52], [55,53,77], [77,79,55], [54,56,80], [80,78,54], [57,55,79], [79,81,57], [56,58,82], [82,80,56], [59,57,81], [81,83,59], [58,60,84], [84,82,58], [37,59,83], [83,61,37], [60,40,64], [64,84,60], [62,61,64], [64,63,62], [61,83,84], [84,64,61], [83,81,82], [82,84,83], [81,79,80], [80,82,81], [79,77,78], [78,80,79], [77,75,76], [76,78,77], [75,73,74], [74,76,75], [73,71,72], [72,74,73], [71,69,70], [70,72,71], [69,67,68], [68,70,69], [67,65,66], [66,68,67], [65,62,63], [63,66,65])
		setMesh theTriMesh verts:v_arr faces:f_arr
		theEdgeVis = #(#(1, #{3}), #(2, #{3}), #(3, #{3}), #(4, #{3}), #(5, #{3}), #(6, #{3}), #(7, #{3}), #(8, #{3}), #(9, #{3}), #(10, #{3}), #(11, #{3}), #(12, #{3}), #(13, #{3}), #(14, #{3}), #(15, #{1..3}), #(16, #{2}), #(17, #{3}), #(18, #{3}), #(19, #{1..3}), #(20, #{2}), #(21, #{3}), #(22, #{3}), #(23, #{3}), #(24, #{3}), #(25, #{3}), #(26, #{3}), #(27, #{3}), #(28, #{3}), #(29, #{3}), #(30, #{3}), #(31, #{3}), #(32, #{3}), #(33, #{3}), #(34, #{3}), #(35, #{3}), #(36, #{3}), #(37, #{3}), #(38, #{3}), #(39, #{3}), #(40, #{3}), #(41, #{3}), #(42, #{3}), #(43, #{3}), #(44, #{3}), #(45, #{3}), #(46, #{3}), #(47, #{3}), #(48, #{3}), #(49, #{3}), #(50, #{3}), #(51, #{3}), #(52, #{3}), #(53, #{3}), #(54, #{3}), #(55, #{3}), #(56, #{3}), #(57, #{3}), #(58, #{3}), #(59, #{3}), #(60, #{3}), #(61, #{3}), #(62, #{3}), #(63, #{3}), #(64, #{3}), #(65, #{3}), #(66, #{3}), #(67, #{3}), #(68, #{3}), #(69, #{3}), #(70, #{3}), #(71, #{3}), #(72, #{3}), #(73, #{3}), #(74, #{3}), #(75, #{3}), #(76, #{3}), #(77, #{3}), #(78, #{3}), #(79, #{3}), #(80, #{3}), #(81, #{3}), #(82, #{3}), #(83, #{3}), #(84, #{3}), #(85, #{3}), #(86, #{3}), #(87, #{3}), #(88, #{3}), #(89, #{3}), #(90, #{3}), #(91, #{3}), #(92, #{3}), #(93, #{3}), #(94, #{3}), #(95, #{3}), #(96, #{3}), #(97, #{3}), #(98, #{3}), #(99, #{3}), #(100, #{3}), #(101, #{3}), #(102, #{3}), #(103, #{3}), #(104, #{3}), #(105, #{3}), #(106, #{3}), #(107, #{3}), #(108, #{3}), #(109, #{3}), #(110, #{3}), #(111, #{3}), #(112, #{3}), #(113, #{3}), #(114, #{3}), #(115, #{3}), #(116, #{3}), #(117, #{3}), #(118, #{3}), #(119, #{3}), #(120, #{3}), #(121, #{3}), #(122, #{3}), #(123, #{3}), #(124, #{3}), #(125, #{3}), #(126, #{3}), #(127, #{3}), #(128, #{3}), #(129, #{3}), #(130, #{3}), #(131, #{3}), #(132, #{3}), #(133, #{3}), #(134, #{3}), #(135, #{3}), #(136, #{3}), #(137, #{3}), #(138, #{3}), #(139, #{3}), #(140, #{3}), #(141, #{3}), #(142, #{3}), #(143, #{3}), #(144, #{3}), #(145, #{3}), #(146, #{3}), #(147, #{3}), #(148, #{3}), #(149, #{3}), #(150, #{3}), #(151, #{3}), #(152, #{3}), #(153, #{3}), #(154, #{3}), #(155, #{3}), #(156, #{3}), #(157, #{3}), #(158, #{3}), #(159, #{3}), #(160, #{3}), #(161, #{3}), #(162, #{3}), #(163, #{3}), #(164, #{3}))
		theSmoothGroups = #(8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
		theMatIDs = #(7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5)
		theNumMaps = 2
		theMapSupport = #(false, true)
		theNumMapVerts = #(undefined, 166)
		theNumMapFaces = #(undefined, 164)
		theMapVerts = #()
		theMapFaces = #()
		theMapVerts[1] = undefined
		theMapFaces[1] = undefined
		theMapVerts[2] = #([0.543226,0.303894,1], [0.668131,0.303894,1], [0.0507779,0.303894,1], [0.168512,0.303894,1], [0.293417,0.303894,1], [0.418322,0.303894,1], [0.543226,0.533924,1], [0.668131,0.533924,1], [0.523221,0.861802,0], [0.168512,0.533924,1], [0.293417,0.533924,1], [0.418322,0.533924,1], [0.78728,0.303894,1], [0.399839,0.969236,0], [0.896475,0.857341,-0.25], [0.896475,0.76367,-0.25], [0.735111,0.716835,-0.25], [0.573747,0.76367,-0.25], [0.573747,0.857341,-0.25], [0.735111,0.904177,-0.25], [0.342961,0.91971,0], [0.409465,0.861802,0], [0.0507779,0.533924,1], [0.153075,0.969236,0], [0.209953,0.91971,0], [0.029693,0.861802,0], [0.543178,0.560001,0], [0.668089,0.560001,0], [0.143449,0.861802,0], [0.168464,0.560001,0], [0.293369,0.560001,0], [0.418273,0.560001,0], [0.153075,0.754368,0], [0.209953,0.803895,0], [0.399839,0.754368,0], [0.342961,0.803895,0], [0.855698,0.809656,0.25], [0.79215,0.86499,0.25], [0.291278,0.585691,0], [0.784859,0.585691,0], [0.66578,0.585691,0], [0.540946,0.585691,0], [0.416112,0.585691,0], [0.166444,0.585691,0], [0.166444,0.561022,0], [0.291278,0.561022,0], [0.78728,0.533924,1], [0.665053,0.86499,0.25], [0.601505,0.809656,0.25], [0.668089,0.585919,0], [0.543178,0.585919,0], [0.665053,0.754322,0.25], [0.0507779,0.560001,0], [0.0507779,0.585919,0], [0.79215,0.754322,0.25], [0.787244,0.560001,0], [0.168464,0.585919,0], [0.787244,0.585919,0], [0.0488053,0.585691,0], [0.0488053,0.561022,0], [0.293369,0.585919,0], [0.66578,0.561022,0], [0.784859,0.561022,0], [0.418273,0.585919,0], [0.540946,0.561022,0], [0.416112,0.561022,0], [-0.950689,1.56326,0], [-0.888925,1.56326,0], [-0.888925,1.58504,0], [-0.950689,1.58504,0], [-0.827161,1.56326,0], [-0.827161,1.58504,0], [-0.765397,1.56326,0], [-0.765397,1.58504,0], [-0.703633,1.56326,0], [-0.703633,1.58504,0], [-0.641869,1.56326,0], [-0.641869,1.58504,0], [-0.580104,1.56326,0], [-0.580104,1.58504,0], [-0.51834,1.56326,0], [-0.51834,1.58504,0], [-0.456576,1.56326,0], [-0.456576,1.58504,0], [-0.394812,1.56326,0], [-0.394812,1.58504,0], [-0.333048,1.56326,0], [-0.333048,1.58504,0], [-0.271284,1.56326,0], [-0.271284,1.58504,0], [-0.209519,1.56326,0], [-0.209519,1.58504,0], [-0.827148,1.87563,0], [-0.799066,1.90167,0], [-0.899734,1.95394,0], [-0.963948,1.89438,0], [-0.693149,1.91683,0], [-0.643695,1.90204,0], [-0.544457,1.95506,0], [-0.65754,1.98888,0], [-0.826742,1.84567,0], [-0.963018,1.82589,0], [-0.614908,1.8762,0], [-0.478631,1.89599,0], [-0.797954,1.81984,0], [-0.897192,1.76682,0], [-0.614501,1.84625,0], [-0.477701,1.8275,0], [-0.748501,1.80505,0], [-0.784109,1.73299,0], [-0.642584,1.8202,0], [-0.541916,1.76793,0], [-0.691631,1.80526,0], [-0.654069,1.73348,0], [-0.691631,1.80504,0], [-0.654069,1.73326,0], [-0.642584,1.82042,0], [-0.541916,1.76815,0], [-0.748501,1.80483,0], [-0.784109,1.73277,0], [-0.614501,1.84647,0], [-0.477701,1.82772,0], [-0.797954,1.81962,0], [-0.897193,1.76659,0], [-0.614908,1.87643,0], [-0.478631,1.89621,0], [-0.826742,1.84545,0], [-0.963018,1.82567,0], [-0.643695,1.90226,0], [-0.544457,1.95528,0], [-0.827148,1.87541,0], [-0.963948,1.89416,0], [-0.693149,1.91705,0], [-0.65754,1.98911,0], [-0.799066,1.90145,0], [-0.899733,1.95372,0], [-0.750018,1.91684,0], [-0.78758,1.98862,0], [-0.750019,1.91662,0], [-0.78758,1.98839,0], [-0.826489,1.56482,0], [-0.765435,1.56482,0], [-0.765435,1.58227,0], [-0.826489,1.58227,0], [-0.70438,1.56482,0], [-0.70438,1.58227,0], [-0.643325,1.56482,0], [-0.643325,1.58227,0], [-0.582271,1.56482,0], [-0.582271,1.58227,0], [-0.521216,1.56482,0], [-0.521216,1.58227,0], [-0.460161,1.56482,0], [-0.460161,1.58227,0], [-0.399107,1.56482,0], [-0.399107,1.58227,0], [-0.338052,1.56482,0], [-0.338052,1.58227,0], [-0.276997,1.56482,0], [-0.276997,1.58227,0], [-0.215943,1.56482,0], [-0.215943,1.58227,0], [-0.948599,1.56482,0], [-0.887544,1.56482,0], [-0.887544,1.58227,0], [-0.948599,1.58227,0])
		theMapFaces[2] = #([1,2,8], [8,7,1], [2,13,47], [47,8,2], [3,4,10], [10,23,3], [4,5,11], [11,10,4], [5,6,12], [12,11,5], [6,1,7], [7,12,6], [16,17,18], [18,19,20], [16,18,20], [15,16,20], [38,48,49], [49,52,55], [38,49,55], [37,38,55], [7,8,28], [28,27,7], [8,47,56], [56,28,8], [23,10,30], [30,53,23], [10,11,31], [31,30,10], [11,12,32], [32,31,11], [12,7,27], [27,32,12], [27,28,50], [50,51,27], [28,56,58], [58,50,28], [53,30,57], [57,54,53], [30,31,61], [61,57,30], [31,32,64], [64,61,31], [32,27,51], [51,64,32], [9,14,21], [21,22,9], [14,24,25], [25,21,14], [24,26,29], [29,25,24], [26,33,34], [34,29,26], [33,35,36], [36,34,33], [35,9,22], [22,36,35], [44,59,60], [60,45,44], [40,41,62], [62,63,40], [41,42,65], [65,62,41], [42,43,66], [66,65,42], [43,39,46], [46,66,43], [39,44,45], [45,46,39], [67,68,69], [69,70,67], [68,71,72], [72,69,68], [71,73,74], [74,72,71], [73,75,76], [76,74,73], [75,77,78], [78,76,75], [77,79,80], [80,78,77], [79,81,82], [82,80,79], [81,83,84], [84,82,81], [83,85,86], [86,84,83], [85,87,88], [88,86,85], [87,89,90], [90,88,87], [89,91,92], [92,90,89], [93,94,95], [95,96,93], [97,98,99], [99,100,97], [101,93,96], [96,102,101], [98,103,104], [104,99,98], [105,101,102], [102,106,105], [103,107,108], [108,104,103], [109,105,106], [106,110,109], [107,111,112], [112,108,107], [113,109,110], [110,114,113], [111,115,116], [116,112,111], [117,113,114], [114,118,117], [115,119,120], [120,116,115], [121,117,118], [118,122,121], [119,123,124], [124,120,119], [125,121,122], [122,126,125], [123,127,128], [128,124,123], [129,125,126], [126,130,129], [127,131,132], [132,128,127], [133,129,130], [130,134,133], [131,135,136], [136,132,131], [137,133,134], [134,138,137], [135,139,140], [140,136,135], [94,137,138], [138,95,94], [139,97,100], [100,140,139], [141,142,143], [143,144,141], [142,145,146], [146,143,142], [145,147,148], [148,146,145], [147,149,150], [150,148,147], [149,151,152], [152,150,149], [151,153,154], [154,152,151], [153,155,156], [156,154,153], [155,157,158], [158,156,155], [157,159,160], [160,158,157], [159,161,162], [162,160,159], [163,164,165], [165,166,163], [164,141,144], [144,165,164])
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
		size type:#worldUnits ui:size default:0.115812
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
