-- CL_Select_CL_Comps.ms --
(
		clearSelection()
-- 		pda_myPreset = (for obj in objects where CustAttributes.count obj == 1 collect obj)
-- 		pda_myRes = for obj in pda_myPreset where (CustAttributes.get obj 1).name == "compLoc" collect obj
-- 		select pda_myRes
		select (for obj in objects where CustAttributes.count obj == 1 and (CustAttributes.get obj 1).name == "compLoc" collect obj)
)