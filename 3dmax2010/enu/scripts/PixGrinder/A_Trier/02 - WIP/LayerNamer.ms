(
	Rollout myLayer "LayerName Display"
	(
		label nm "Object Name :"
		label objName selection[1].name style_sunkenedge:true
		label lynm "Object' layer Name :"
		label objLayer selection[1].layer.name style_sunkenedge:true

	)

	layRollout = newRolloutFloater "layRollout" 250 150
	addRollout myLayer layRollout
)