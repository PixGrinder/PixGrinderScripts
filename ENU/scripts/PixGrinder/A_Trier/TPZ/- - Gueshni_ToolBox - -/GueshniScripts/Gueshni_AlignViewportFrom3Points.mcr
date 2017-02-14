macroScript AlignViewportFrom3points category:"- Gueshni -" Icon:#("g9_alignviewportfrom3pts", 1) tooltip:"Align Viewport from 3 Points"
(
local savesnap=snapMode.active
snapMode.active=true

fn getMatrix p1 p2 p3 = (
  		v1 = normalize (p2 - p1)
		v3 = normalize (cross v1 (normalize (p3 - p1)))
		v2 = normalize (cross v3 v1)
		return matrix3 v1 v2 v3 p1
) 

redrawViews()
a = pickpoint snap:#3d		
if classof a == point3 do (
	redrawViews()
	b = pickpoint snap:#3d rubberband:a
	if classof b == point3 do (
		redrawViews()
		c = pickpoint snap:#3d rubberband:b
		if classof c == point3 do (
			m=getMatrix a b c
			pmin=pmax=a
			for i = 1 to 3 do pmin[i]= amin #(a[i], b[i])
			for i = 1 to 3 do pmin[i]= amin #(b[i], c[i])
			for i = 1 to 3 do pmax[i]= amax #(a[i], b[i])
			for i = 1 to 3 do pmax[i]= amax #(b[i], c[i])
			local gri=$coordgrig_tmp
			if gri==undefined do gri=grid name:"coordgrig_tmp"
			gri.transform=m
			activeGrid=gri
			viewport.settype #view_grid 
			viewport.ZoomToBounds true pmax pmin
		)
	)
)
snapMode.active=savesnap
)