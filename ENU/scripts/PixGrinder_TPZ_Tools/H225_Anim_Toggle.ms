(

	if $H225.pos.controller.weight[1] == 100.0 then 
	(
		$H225.pos.controller.weight[1] = 0.0
	) else (
		$H225.pos.controller.weight[1] = 100.0
	)

	$H225_ENGINE.pos.controller.weight[1] = $H225.pos.controller.weight[1]

)