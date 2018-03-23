---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Name Transfert --
-- NamesTransfer.ms --
-- Copy 1st selected object's name to the second one --
-- V 1.0 --

---------------------------------------------------------------------

(
	if selection.count != 2 then messagebox("Please select only 2 objects") else 
	(
		selection[2].name = selection[1].name 
		--if querybox ("Delete 1st object ?") == true then delete selection[1] else print "Name Copied"
		select selection[2]
		)
)