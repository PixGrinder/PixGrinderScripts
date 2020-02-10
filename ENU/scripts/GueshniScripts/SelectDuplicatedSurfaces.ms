-- select duplicated surface

(
	t1 = timestamp()
	selarray = $selection as array
	objpos = #()
	theindexarray=#()
	for i=1 to selarray.count do (
	objpos[i] = selarray[i].pos
	)

	objpos2 =objpos
	objpos2 = makeUniqueArray objpos2

	if objpos2.count != objpos.count then (

	thenewsel =#()
	theposarray =#()

	for i=1 to selarray.count do (
	for k=i+1 to selarray.count do (
	if objpos[i] == objpos[k] do (

	if (finditem theposarray objpos[i]) == 0 and (finditem thenewsel selarray[i]) == 0 do (

	append thenewsel selarray[i]
	append theposarray objpos[i]

	)

	if (finditem theposarray objpos[i]) != 0 and (finditem thenewsel selarray[i]) == 0 do (

	append thenewsel selarray[i]

	)
	)
	)
	)

	t2 = timestamp()
	print ("sorting duplicates took " + ((t2-t1)/1000.0) as string + " milisecs")

	clearselection()
	select thenewsel

	) else (
	messagebox "there are no duplicates or nthlicates xD"
	)

)