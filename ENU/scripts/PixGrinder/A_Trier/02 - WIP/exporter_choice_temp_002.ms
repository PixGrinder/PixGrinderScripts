-- Rollout avec choix de l'exporter

plgx = exporterPlugin.classes as array
plgy = exporterPlugin.classes as array
xi = 1
xj = 1 
xk = 1
for j = 1 to plgx.count do plgy[j] = plgx[j] as string

rollout youpi "youpla" (
	
	dropdownlist exporterx "Choose Exporter" items:plgy
	on exporterx selected i do
		-- format "You selected '%'!\n" exporterx.items[i]
		xi = exporterx.items[i]
	button btok "OK"
	on btok pressed do ( 
		xj = findItem plgy xi
		xk = plgx[xj]
	)
	
)
createDialog youpi

