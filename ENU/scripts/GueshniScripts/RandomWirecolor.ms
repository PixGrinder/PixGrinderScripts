 /*
Simple script to make random color of object wires.
*/

(
	
on isEnabled return
(selection.count >=1)

on execute do
(
try
	for i =1 to $.count do $[i].wirecolor = random black white
catch
	try $.wirecolor = random black white catch messagebox "Please select something before"
)

)