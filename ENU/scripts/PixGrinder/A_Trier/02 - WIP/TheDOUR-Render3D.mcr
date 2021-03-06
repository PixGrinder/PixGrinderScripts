macroScript Render3D
	enabledIn:#("max")
	category:"TheDOUR"
	toolTip:"R e n d e r  3 D"
	buttonText:"R e n d e r  3 D"
	--rev. 2010-10-19
	--�Andrew Dour 2010 >>  www.thedour.net
	--Inspired in part by Louis Marcoux & 'Stereographer Max' by Ron K Lussier
(
	Global Render3D, r3D

	--fileIn ((GetDir #startupScripts) + "\\Render3D.ms")
	--encryptScript ((GetDir #startupScripts) + "\\Render3D.ms")
	fileIn ((GetDir #startupScripts) + "\\Render3D.mse")

	rcmenu Render3Dinfo
	(
		menuItem mi_i "Info"
		subMenu "Links"
		(
			menuItem mi_l1 "www.thedour.net"
		)
		on mi_i picked do (Render3D.ShowInfo())
		on mi_l1 picked do (Render3D.VisitLink())
	)

	on execute do with undo off
	(
		local cls = classof Render3D
		if (cls == RolloutClass) and Render3D.isDisplayed then setFocus Render3D
		else
		(
			CreateDialog Render3D width:480 height:136 \
			style:#(#style_titlebar, #style_minimizebox, #style_sysmenu) \
			menu:Render3Dinfo \
			lockHeight:true lockWidth:true
		)
	)	
	on isChecked return 
	(
		local cls = classof Render3D
		(cls == RolloutClass) and Render3D.isDisplayed and (not Render3D.isClosing)
	)
	on isEnabled return
	(
		local cls = classof Render3D
		(cls == RolloutClass)
	)
	on closeDialogs do with undo off
	(
		local cls = classof Render3D
		if (cls == RolloutClass) and Render3D.isDisplayed do 
		(
			destroyDialog Render3D
		)
	)
) 