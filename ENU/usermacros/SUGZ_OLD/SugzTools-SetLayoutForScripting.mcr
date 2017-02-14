macroScript SetLayoutForScripting
	category:"SugzTools"
	toolTip:"Set 3ds max for scripting"
	Icon:#("Maxscript",2)
(
	viewport.ResetAllViews()
	if viewport.numViews == 1 then ( max tool maximize )
	viewport.setLayout #layout_2v
	viewport.activeViewport = 2
	viewport.setType #view_persp_user
	actionMan.executeAction 0 "550"  -- Views: Viewport Visual Style Shaded
	max zoomext sel all 
	viewport.activeViewport = 1
	actionMan.executeAction 0 "40409" -- add maxscript listener as extended viewport
	actionMan.executeAction 0 "40839" -- open maxscript editor
)
