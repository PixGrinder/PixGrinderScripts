-- Felipe Save and Copy Script
-----------------------------------



(
	max saveplus

	fname = MaxFilePath + (MaxFileName)

	-- pda_mydir="\\\Bla-nas-01\shares\REALFUSIO\E13COA0050\Production\3D\Batch10\cbn\\"+ (MaxFileName)
	
	pda_mydir="\\\Bla-nas-01\shares\REALFUSIO\E13C0A0049 ( Airbus eADD )\Production\3D\01_General Information\\"--+ (MaxFileName)

	-- copyFile fname pda_mydir

	pda_command = "copy "+ fname +" "+ pda_mydir

	HiddenDOSCommand pda_command donotwait:true exitCode:&pda_code
	
	pda_code

)

