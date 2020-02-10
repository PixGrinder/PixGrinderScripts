 (
	global lstface =#{} 
f = 1
while f < $.faces.count do
(
--	$.EditablePoly.SetSelection #Face #{f,(f+1)}
append	lstface f
 f += 2
)
$.EditablePoly.SetSelection #Face lstface
)