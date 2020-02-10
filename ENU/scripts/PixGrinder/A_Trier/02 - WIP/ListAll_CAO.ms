myFile = openFile @"d:\CAO.txt" mode:"r+"
for obj in helpers do format "%;%\r" obj.name obj.layer.name to:myFile
close myFile



