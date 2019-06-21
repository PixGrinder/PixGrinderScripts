-- Isolate_Toggle --


-- global pdaVisible

global pdaVisible
global pdaMyToggle
global pdaExist
if pdaMyToggle == undefined then global pdaMyToggle = false
global pdaMySelec = selection as array

if pdaMyToggle == false then
(
	pdaVisible = for obj in objects where obj.isHidden == false collect obj
	for obj in pdaVisible where (isValidNode obj) do obj.isHidden = true
	for obj in pdaMySelec where (isValidNode obj) do obj.isHidden = false
	pdaExist = for obj in pdaMySelec where (isValidNode obj) collect obj
	select pdaExist
	pdaMyToggle = true
) else (
	for obj in pdaVisible where (isValidNode obj) do obj.isHidden = false
	pdaExist = for obj in pdaMySelec where (isValidNode obj) collect obj
	select pdaExist
	pdaMyToggle = false
)

--print pdaMyToggle

/*

pdaMyToggle = false
for obj in pdaVisible do print obj
isValidNode $

*/

