(
	clearlistener()
	global pda = #()
	global pda_miss = #()


	myString = "JA-A-33-41-21-00A-340A-A_PositionLightLeft_1.6
JA-A-33-41-21-00A-340A-A_PositionLightRight_1.1
JA-A-33-41-21-00A-340A-A_PositionLightRear_1.2
JA-A-33-44-00-00A-340A-A_FormationLights_1.1_0
JA-A-33-44-00-00A-340A-A_FormationLights_1.1_1
JA-A-33-44-00-00A-340A-A_FormationLights_1.1_3
JA-A-33-44-00-00A-340A-A_FormationLights_1.1_2
JA-A-33-42-00-00A-311A-A_LowerAnticollisionLight_off_1.4
JA-A-33-42-00-00A-311A-A_RearAnticollisionLight_off_1.2
JA-A-33-52-00-00A-340A-A_ DinghyLight_1.4
JA-A-33-52-00-00A-340A-A_ DinghyLight_1.1"

	myList = filterString myString ";\n	"

	for i = 1 to myList.count do
	(
		for obj in geometry do 
		(
			if findstring myList[i] obj.name != undefined do appendifunique pda obj
		)
	)

	for i = 1 to pda.count do append pda_miss pda[i].name
	
	Print "Objects missing : "

	
	for i = 1 to myList.count do
	(
		if finditem pda_miss myList[i] == 0 do print myList[i]
	)
	print pda.count
	select pda
)

