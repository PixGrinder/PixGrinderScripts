-- BackFaceCull Whole Scene --

(
	for obj in geometry where obj.backFaceCull == false do obj.backfaceCull = true
)