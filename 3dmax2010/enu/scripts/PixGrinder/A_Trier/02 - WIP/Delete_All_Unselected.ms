-- c = selection as array
-- d = #()

-- for obj in objects do (
	-- if findItem c obj == 0 do append d obj
-- )

-- delete d



c = selection as array

max unhide all

max select invert

d = selection as array

for obj in objects do (

	if obj.layer.on == false do append d obj

)


delete d
