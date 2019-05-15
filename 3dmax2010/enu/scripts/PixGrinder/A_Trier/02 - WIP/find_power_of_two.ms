global pda = getclassinstances bitmaptexture

for i = 1 to pda.count do 
(
	if pda[i].filename != undefined do try ( print (pda[i].filename +" - "+ ((pda[i].bitmap.width) as string)+" - "+ ((pda[i].bitmap.height) as string) )
) catch ()
) 


pda[40].filename

pda[40].bitmap.width