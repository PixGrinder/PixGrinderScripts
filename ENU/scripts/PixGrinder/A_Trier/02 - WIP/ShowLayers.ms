
layermanager.count

for i = 1 to (layermanager.count-1) do
(
	x = layermanager.getlayer i
	x.on = true
)


for i = 1 to (layermanager.count-1) do
(
	x = layermanager.getlayer i
	x.on = false
)