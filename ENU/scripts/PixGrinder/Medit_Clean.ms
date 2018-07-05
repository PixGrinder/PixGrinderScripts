-- Medit Clean -- 

for i = 1 to 24 do meditmaterials[i] = StandardMaterial diffuse:(color 128 128 128) SpecularLevel:50 Glossiness:20 name:("Mat_"+i as string)

MatEditor.Open()