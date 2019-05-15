--   delete cameras


for i = 1 to $.material.count do
(
	--if $.material[i].bumpmap != undefined do $.material[i].bumpmap = undefined
	-- $.material[i].name = "temple_"+ (i as string)
)


-----------------------------------

meditmaterials[1][14].bumpmap

x1 = getclassinstances bitmaptexture

for i = 1 to x1.count do 
(
pdt = filenamefrompath x1[i].bitmap.filename
pdt = replace pdt (pdt.count-3) 4 ""
x1[i].name = pdt
)


--------------------------------------------

x1 = getclassinstances bitmaptexture
for i = 1 to x1.count do x1[i].coords.mapChannel = 1
	

--------------------------

for obj in geometry do obj.wirecolor = [(random 0 254), (random 0 254), (random 0 254)]

