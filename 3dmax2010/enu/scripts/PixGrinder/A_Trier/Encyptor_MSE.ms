pda = getFiles "E:\08 - MaxScript\04 -Install\Felipe_Scripts\3ds Max 2010\ui\macroscripts\*.*"

for i = 1 to pda.count do EncryptScript pda[i]