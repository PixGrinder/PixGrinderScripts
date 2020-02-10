
clearListener()
LayArray = #()

for i = 1 to (LayerManager.count-1) do 
(
	x1 = LayerManager.getLayer i
	if matchpattern x1.name pattern:"*___" do append LayArray x1.name
)


-- LayArray = for obj in LayArray where matchpattern obj ==  "*___*" collect obj
for obj in LayArray do print obj


for obj in LayArray do
(
	x1 = LayerManager.getLayerFromName obj
	x1.on = false
)


rollout LayerName "LayerName"
(
	edittext txt1 text:"NNLN"
	button myBtn "Select"

	on myBtn pressed do
	(
		for obj in LayArray do
		(
			x1 = LayerManager.getLayerFromName obj
			x1.on = false
		)

		for obj in LayArray where matchpattern obj pattern:("*"+txt1.text+"*") == true do
		(
			x1 = LayerManager.getLayerFromName obj
			x1.on = true
		)
	)

)

try (DestroyDialog LayerName) catch ()
CreateDialog LayerName