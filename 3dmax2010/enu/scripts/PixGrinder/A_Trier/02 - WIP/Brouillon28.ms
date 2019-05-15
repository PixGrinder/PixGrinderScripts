pda_ar = #()

for obj in geometry do if obj.primaryVisibility == off do append pda_ar obj
	
select pda_ar

x1 = $.pos
x2 = $.pos



		fn drawLineBetweenTwoPoints pointA pointB =
		(
			ss = SplineShape pos:[0,0,0]
			addNewSpline ss
			addKnot ss 1 #corner #line PointA
			addKnot ss 1 #corner #line PointB
			updateShape ss
			ss
		)
		
		drawLineBetweenTwoPoints x1 x2