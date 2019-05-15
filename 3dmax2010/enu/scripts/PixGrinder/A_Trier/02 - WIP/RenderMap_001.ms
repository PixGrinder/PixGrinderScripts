global pdapath = "d:\alphas\\"


b1 = $Teapot01.material.DiffuseMap--.bitmap
pda_name=filenamefrompath b1.bitmap.filename
pda_name = replace pda_name (pda_name.count-3) 4 "_alpha.jpg"
pda_name = pdapath + pda_name
x = b1.bitmap.width
y = b1.bitmap.height
b1.rgbOutput=1
b2 = renderMap b1 size:[x,y] display:true

-- save


---------------------------------------------------------------------------

pda_test=bitmaptexture
pda_test.bitmap

b1.bitmap

display b1.bitmap

---------------------------------------------------------------------------








x=$.material.DiffuseMap.bitmap.width
y=$.material.DiffuseMap.bitmap.height

pda = renderMap $.material.DiffuseMap filename:"D:\\test.png" size:[x,y] display:true

pda1 = getChanel 

save pda

meditmaterials[2].DiffuseMap.bitmap.channels

t1 = getChannelAsMask meditmaterials[2].DiffuseMap.bitmap #mask 


getChannel meditmaterials[2].DiffuseMap.bitmap [10,10] #mask


getpixel 



visual

pda = $.material.DiffuseMap.mask


pda = $.material.DiffuseMap.bitmap

getbitmapinfo pda 

pda.bitmapflag

pda.hasalpha


append pda.channels #mask

pda.channels

bitmap 

pda.hasalpha

getChannelAsMask pda layer:1




render camera01 to b1 

display b1


fn mycomp 








x = b1.width
y = b1.height
b2 = bitmap x y color:red hdr:false
getbitmapinfo b2
pasteBitmap b1 b2 ( box2 0 0 x y ) [0,0] maskColor:alpha type:#composite 
display b2



display b1

display b2

display b3

meditmaterials[1] = b1



freeSceneBitmaps()






