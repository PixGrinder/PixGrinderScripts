timer clock interval:100
button btnInstances "Viewport Instances"  width:175 tooltip:"Add visible instances to the selection\n+Ctrl: Add all instances to the selection\n+Alt: Keep only one instance from selection"
button btnHierarchy "Viewport Children"  width:175 tooltip:"Add visible children hierarchy to the selection\n+Ctrl: Add all children hierarchy to the selection"

/*FUNCTIONS ####################################################################################################################*/
-- Get the current coord sys and set the buttons accordingly
fn SetBtnCoordSysFn = 
(
	case (getRefCoordSys()) of 
	(
		#hybrid: (btnView.state = true; btnLocal.state = btnParent.state = false)
		#local: (btnLocal.state = true; btnView.state = btnParent.state = false)
		#parent: (btnParent.state = true; btnView.state = btnLocal.state = false)
		default: btnView.state = btnLocal.state = btnParent.state = false
	)
)

-- Set the controls captions depending on the keyboard input 
fn SetControlsCaptionsFn input = 
(
	case input of 
	(
		#ctrl: (btnInstances.caption = "All Instances"; btnHierarchy.caption = "All Children")
		#alt: btnInstances.caption = "Keep One Instance"
		#none: (btnInstances.caption = "Viewport Instances"; btnHierarchy.caption = "Viewport Children")
	)
)

/*UI EVENTS ####################################################################################################################*/
on clock tick do 
(
	case of 
	(
		(keyboard.controlPressed): SetControlsCaptionsFn #ctrl
		(keyboard.altPressed): SetControlsCaptionsFn #alt
		default: SetControlsCaptionsFn #none
	)
)
	
	
-- Get instances 
on btnInstances pressed do
(
	if _sgz._sel.GetSelectionCountFn() then
	(
		case of 
		(
			(keyboard.controlPressed): select (_sgz._sel.GetInstancesFn selection getHidden:true)
			(keyboard.altPressed): select (_sgz._sel.DeleteInstanceFromSelectionFn limitToSel: true)
			default: select (_sgz._sel.GetInstancesFn selection getHidden:false)
		)
	)
)


-- Add childnodes to selection
on btnHierarchy pressed do 
(
	if _sgz._sel.GetSelectionCountFn() then
	(
		case of 
		(
			(keyboard.controlPressed): select (_sgz._sel.GetHierarchyFn children:true getHidden:true)
			default: select (_sgz._sel.GetHierarchyFn children:true)
		)
	)
)