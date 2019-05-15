(
	for component in _cplc.sceneComponents do 
	(
		if component.hotspot == undefined do format "component: %\n\thotspot: %\n" component component.hotspot
		for obj in component.transparent where obj == undefined do format "component: %\n\transparent: %\n" component obj
		for obj in component.hidden where obj == undefined do format "component: %\n\hidden: %\n" component obj
		for obj in component.animated where obj == undefined do format "component: %\n\animated: %\n" component obj
	)
	
)