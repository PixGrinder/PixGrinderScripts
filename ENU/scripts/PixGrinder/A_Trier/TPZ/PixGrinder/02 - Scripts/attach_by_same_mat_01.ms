(
	clearlistener()
	global pda = getcurrentSelection()
	global test = #()
	pda = pda[1]
	convertToPoly(pda)
	for i = 1 to geometry.count do 
	(
		if classof geometry[i].material == standardmaterial do
		(
			if geometry[i].material == pda.material do
			(
				--polyop.attach pda geometry[i]
				append test geometry[i]
			)
		)
	)
	print test.count
	--select test
	convertToPoly(test[1])
	select test[1]
	for k = 2 to test.count do polyop.attach $ test[k]
	--hide $
)







