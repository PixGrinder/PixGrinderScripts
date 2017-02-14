-- Clean Layers v 2.0 --
-- added : nested layers support

(
	l_ar = #()

	l0 = layermanager.getLayer 0
	l0.current = true

	for i = 1 to (layermanager.count-1) do 
	(
		x = layermanager.getLayer i
		append l_ar x.name
	)
	
	for i = 1 to l_ar.count do
	(
		LayerManager.deleteLayerHierarchy l_ar[i] forceDelete:false
	)
)


-----------------------

