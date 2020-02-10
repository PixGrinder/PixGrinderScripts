-- Created by Travis Williams 2014 @ all3dmax.com

macroScript MS01 category:"_custom" toolTip:"Selection 01: All" 				(SetSelectFilter 1)
macroScript MS02 category:"_custom" toolTip:"Selection 02: Geometry" 		(SetSelectFilter 2)
macroScript MS03 category:"_custom" toolTip:"Selection 03: Shapes"			(SetSelectFilter 3)
macroScript MS04 category:"_custom" toolTip:"Selection 04: Lights"	 		(SetSelectFilter 4)
macroScript MS05 category:"_custom" toolTip:"Selection 05: Cameras" 		(SetSelectFilter 5)
macroScript MS06 category:"_custom" toolTip:"Selection 06: Helpers" 			(SetSelectFilter 6)
macroScript MS07 category:"_custom" toolTip:"Selection 07: Warps" 			(SetSelectFilter 7)
macroScript MS08 category:"_custom" toolTip:"Selection 08: Bone"	 			(SetSelectFilter 8)
macroScript MS09 category:"_custom" toolTip:"Selection 09: IK Chain"		(SetSelectFilter 9)
macroScript MS10 category:"_custom" toolTip:"Selection 10: Point"	 			(SetSelectFilter 10)
macroScript MS11 category:"_custom" toolTip:"Selection 11: CAT Bone"		(SetSelectFilter 11)

macroScript MS12 category:"_custom" toolTip:"Selection 12: Next"
(
	local A1 = GetSelectFilter()
	
	A1 += 1
	If A1 == 12 then A1 = 1
	SetSelectFilter A1
)

macroScript MS13 category:"_custom" toolTip:"Selection 13: Back"
(
	local A1 = GetSelectFilter()
	
	A1 -= 1
	If A1 == 0 then A1 = 11
	SetSelectFilter A1
)