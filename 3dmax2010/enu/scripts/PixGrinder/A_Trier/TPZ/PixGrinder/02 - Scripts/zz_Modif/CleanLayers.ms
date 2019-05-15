-- Clean Layers v 1.0 --


(

l_ar = #()

l0 = layermanager.getLayer 0
l0.current = true

for i = 1 to (layermanager.count-1) do (
	x = layermanager.getLayer i
	append l_ar x.name
)
for j = 1 to l_ar.count do layermanager.deleteLayerByName l_ar[j]


)