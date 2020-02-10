myTemp = for obj in (getClassInstances BitmapTexture) where (matchpattern (getfilenamefile obj.bitmap.filename) pattern:"*sealant*" == true) collect obj

meditMaterials[1] = myTemp[1]