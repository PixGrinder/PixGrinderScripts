-- Comploc -  get Camera view from component --
-- Comploc_CamFromComponent.ms --


(
	mySelTemp = selection[1]
	theCam = for cam in cameras where matchpattern cam.name pattern:(selection[1].name +"*") and classof cam!= Targetobject collect cam
-- 	select theCam[1]
	viewport.setCamera theCam[1]
	select mySelTemp
)
