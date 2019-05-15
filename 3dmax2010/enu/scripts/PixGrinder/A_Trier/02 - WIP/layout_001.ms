		fn pda_vport =	
		(
			hideByCategory.cameras = true
			hideByCategory.lights = true
			hideByCategory.helpers = true
			
			--viewport.setLayout #layout_3vl
			viewport.setGridVisibility #all false
			viewport.activeViewport = 1
			viewport.SetRenderLevel #smoothhighlights
			viewport.setCamera cam_left
			max views redraw
			x1 = gw.getViewportDib()
			viewport.setCamera cam_right
			max views redraw
			x2 = gw.getViewportDib()
			
			hideByCategory.cameras = cam_status
			hideByCategory.lights = light_status
			hideByCategory.helpers = helpers_status
			
		)
		
		-- pda_vport