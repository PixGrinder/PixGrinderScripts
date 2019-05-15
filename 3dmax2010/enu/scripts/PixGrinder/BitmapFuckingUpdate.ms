-- Update fucking bitmaps in Fucking 3DS MAx !! --

(
	FreeSceneBitmaps()
	tempFile =  getDir(#scene) + "\\" + "zz_tempSceneMaterialsHack.max"
	saveNodes geometry[1] tempFile
	deleteFile tempFile
)

