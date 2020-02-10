 (
	 (
-- Globals

global make_unique

-- Functions

fn make_unique = 
	(
	undo "Make Unique" on
		(
		objs = #()
		new_objs = #()
		group_error = false
		
		disableSceneRedraw()
		
		try
			(
			for i in selection do 
				(
				if isgroupmember i == false and isgrouphead i == false then
					(
					append objs i
					)
				else group_error = true
				)

			progressStart "Make Unique"
			escapeEnable = false
			itemnum = objs.count
			
			curiter = 0
			for i in objs do
				(
				curiter += 1
				m = ((curiter as float)/(itemnum as float))*100
				
				mo = copy i
				mo.name = i.name
				mo.wirecolor = i.wirecolor
				
				append new_objs mo
				progressUpdate m
				)
			progressEnd()
		
			for i in objs do delete i
			if new_objs.count != 0 then select new_objs
			)
		
		catch
			(
			MessageBox "An error has occured, you may want to undo." title:"MakeUnique"
			)
		
		enableSceneRedraw()
		completeRedraw()
		
		if group_error == true then
			(
			MessageBox "At least one object in your selection is a group, and this script cannot operate on groups. Use Blur's Object Utilities instead (http://www.blur.com/blurbeta/). All other objects should now be unique." title:"MakeUnique"
			)
		)
	)

-- The Script

if selection.count == 0 then (MessageBox "Please select at least one object" title:"MakeUnique")
else
	(
	if (queryBox "Do you wish to make these objects Unique?" title:"MakeUnique") == true then make_unique()
	)
)
)