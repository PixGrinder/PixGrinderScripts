-- Philippe DASSONVILLE
-- PixGrinder
-- AssignCurrentMaterial.ms
-- 19/04/2016


(
	myMat = medit.GetCurMtl()  -- myMat = materiau actif du Material Editor

	mySel = getcurrentselection() -- mySel = selection actuelle

	for obj in mySel do obj.material = myMat -- pour tous les objets de mySel, assigner le materiau myMat
	
)
