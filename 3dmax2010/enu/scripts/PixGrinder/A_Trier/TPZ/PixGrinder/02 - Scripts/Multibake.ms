

---MultiBake 
clearListener()
mySel = getCurrentSelection()
myNames = #()
myFaces =  #()

-- Startup conditions

for i = 1 to mySel.count do
(
	if superclassof mySel[i] != GeometryClass do return messagebox ("Please select only Geometry objects")
)

if mySel.count < 2 do return messagebox ("Please, select multiple objects")
	
-- End Startup conditions


for i = 1 to mySel.count do
(
	convertToPoly(mySel[i])
	append myNames mySel[i].name
	if i == 1 then
	(
		myMin = 1
		myMax = polyop.getNumFaces mySel[1]
		-- myBit = #{1..myMax}
		append myFaces #{1..myMax}
	) else (
		for j = 1 to i do myMin = myMax + 1
		myMax = myMin + polyop.getNumFaces mySel[i]
		append myFaces #{myMin..myMax}
	)
)

for i = 1 to mySel.count do print ( myNames[i] + " : " + (myFaces[i] as string))

for i = 2 to mySel.count do polyop.attach mySel[1] mySel[i]
	

--------------------------------

i = 2
polyop.setFaceSelection $ myFaces[i]
redrawViews()


--------------------------------

-- Brouillon
clearListener()
pda_faces=#()
myObj = $
convertToPoly(myObj)
polyop.getNumFaces myObj
max modify mode
subobjectLevel = 4
max select all
x = polyop.getFaceSelection $
append pda_faces x
-- subobjectLevel = 0
polyop.attach myObj $Teapot002

polyop.setFaceSelection myObj pda
max select invert
x = polyop.getFaceSelection $
append pda_faces x
polyop.setFaceSelection $ pda_faces[2]
redrawViews()

