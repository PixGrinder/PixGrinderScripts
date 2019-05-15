

fn pda_RotatePivotOnly obj rotation= 
( 
	local rotValInv=inverse (rotation as quat)
	animate off in coordsys local obj.rotation*=RotValInv
	obj.objectoffsetrot*=RotValInv
	obj.objectoffsetpos*=RotValInv
)


myObject = $
myPivot = $
RotatePivotOnly myObject myPivot.transform.rotation
