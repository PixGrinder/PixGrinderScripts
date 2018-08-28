myObj = selection[1]
resetXForm myObj
collapseStack myObj

-- define the sphere radius using shape section --


select myObj


max hide inv 

theSection = section length:10.0 width:10.0 pos:myObj.center isSelected:on

max views redraw

theSpline = convertToSplineShape theSection

select theSpline

max zoomext sel 

max modify mode


subObjectLevel = 1

max select all

weldSpline theSpline 0.001

subObjectLevel = 3

setSplineSelection theSpline #(1)

max select invert 

splineOps.delete theSpline


myradius = (distance theSpline.min theSpline.max)*2


-- /define the sphere radius using shape section --


nbSpline = numSplines theSpline
for i = 1 to nbSpline do 
(
	tempAr = for j = 1 to numKnots theSpline i collect j
	setKnotSelection theSpline i tempAr keep:true 
)
max views redraw
updateshape theSpline


