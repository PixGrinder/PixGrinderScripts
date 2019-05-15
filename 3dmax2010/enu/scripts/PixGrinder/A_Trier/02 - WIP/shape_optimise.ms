


shp1= $Circle01
stp=2
ar1=#()
for i =1 to (numKnots shp1) by stp do (
	append ar1 i
)

for j=1 to shp1.numSplines do selec1 = setKnotSelection shp1 j ar1
	
select stp
subObjectLevel = 1
splineOps.delete shp1


shp1.numSplines