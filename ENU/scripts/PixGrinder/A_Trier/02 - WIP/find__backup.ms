(
	pda=#()
	myPat = "_backup"
	for obj in geometry do if matchpattern obj.name pattern:myPat == true then appendifunique pda obj
	select pda
)