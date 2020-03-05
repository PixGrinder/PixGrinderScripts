-- Object history search --

fn myDateSort v1 v2 = 
(
	if v1[1] > v2[1] then 1 else -1
)


fn pda_ItemSelect v =
(
	case of
	(
		v = 1: return "Topology Changed"
		v = 2: return "Link Changed"
		v = 3: return "Material Changed"
		v = 4: return "Name Changed"
		v = 5: return "Object Created"
	)
)


rollout pda_HistorySearch "History Search"
(
	--edittext <name> [<caption>] [text:<string>] [fieldWidth:<integer>] [height:<integer>] [bold:<boolean>] [labelOnTop:<boolean>] [readOnly:<boolean>] [toolTip:<string>]
	label lbl "Search Objects by date" offset:[0,10]
	radiobuttons mySwitch labels:#("Before","After") columns:2 offset:[0,10] -- [offsets:<array_of_point2s>]
	
	dropdownlist Crit "" items:#("Topology", "Link", "Material", "Name", "Creation") selection:1 across:3 offset:[0,12] width:100 --[height:<number>] [tooltip:<string>] 
	edittext Date "" text:localTime fieldWidth:120 bold:off readOnly:off offset:[0,12] height:20 -- offset:[0,15]
	button myButton"OK" width:75 offset:[15,12]


	on myButton pressed do
	(

		
		x1 = for obj in objects where getUserProp obj (pda_ItemSelect Crit.items) != undefined collect #(getUserProp obj (pda_ItemSelect Crit.items), obj)
		if mySwitch.state == 1 then
		(
			x2 = for obj in x1 where obj[1] <= DateCreation.text collect obj[2]
			clearSelection()
			select x2
		) else (
			x2 = for obj in x1 where obj[1] >= DateCreation.text collect obj[2]
			clearSelection()
			select x2
		)
	)


	--radiobuttons <name> [<caption>]	labels:<array_of_strings> \ [tooltip:{<string>|<array_of_strings>}] \[default:<number>] [columns:<number>] [offsets:<array_of_point2s>] 	
)


CreateDialog pda_HistorySearch 360 125 1024 512 --bgcolor:(color 50 95 95)


-- select (for obj in geometry where (getUserProp obj "Object Created" != undefined) and (matchpattern (getUserProp obj "Object Created") pattern:"*:52*" == true) collect obj)
/*
x1 = for obj in objects where getUserProp obj "Object Created" != undefined collect #(getUserProp obj "Object Created", obj)


qsort x1 myDateSort

for obj in x1 do print obj


x2 = for obj in x1 where obj[1] < Date.text collect obj[2]


x2 = for obj in x1 where obj[1] < "04/03/2020" collect obj[2]

select x2
*/
/*


trimright localTime
substring localTime 1 10


*/


