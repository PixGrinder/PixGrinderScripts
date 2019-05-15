macroScript LockUnlock category:"- Gueshni -" Icon:#("g9_lockunlock", 1) tooltip:"Lock / Unlock"
 (
	 on execute do
	(
		myBox = yesNoCancelBox " Verouiller Selection ? \n - Oui : Verouille Tout. \n - Non : Deverouille Tout."

if mybox == #yes then setTransformLockFlags selection #all

if mybox == #no then setTransformLockFlags selection #none
	)
)