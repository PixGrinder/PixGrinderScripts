x1 = for obj in objects where (obj.wirecolor == (color 87 225 87) or obj.material != undefined) collect obj
for obj in x1 do obj.isHidden = on