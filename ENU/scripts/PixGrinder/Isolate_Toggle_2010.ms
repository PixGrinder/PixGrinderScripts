-- Isolate_Toggle --


-- global pdaVisible
if pdaMyToggle == undefined then global pdaMyToggle = false

pdaMySelec = selection as array

if pdaMyToggle == false then
(
	pdaVisible = for obj in objects where obj.isHidden == false collect obj
	for obj in pdaVisible do obj.isHidden = true
	for obj in pdaMySelec do obj.isHidden = false
	select pdaMySelec
	pdaMyToggle = true
) else (
	for obj in pdaVisible do obj.isHidden = false
	select pdaMySelec
	pdaMyToggle = false
)

print pdaMyToggle
