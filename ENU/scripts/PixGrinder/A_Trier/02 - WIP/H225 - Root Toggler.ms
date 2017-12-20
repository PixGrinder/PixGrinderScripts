-- H225 - Root Toggler
(
	if (getNodeByName "H225").pos.controller.weight[1] == 100.0 then (getNodeByName "H225").pos.controller.weight[1] = 0.0 else (getNodeByName "H225").pos.controller.weight[1] = 100.0
	if (getNodeByName "H225_ENGINE").pos.controller.weight[1] == 100.0 then (getNodeByName "H225_ENGINE").pos.controller.weight[1] = 0.0 else (getNodeByName "H225_ENGINE").pos.controller.weight[1] = 100.0
)
