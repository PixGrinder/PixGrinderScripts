pda_array = #(0,1,"youpla", "crapuoi",$.name)
pda_stream = StringStream ""

for i = 1 to pda_array.count do 
(
	(print pda_array[i] to:pda_stream)
)

seek pda_stream 0

readValue pda_stream 



---------------------------------------------
-- Brouillon
---------------------------------------------

readDelimitedString pdai ";"

readLine pda_stream


readValue pda_stream

x = $.name

for obj in objects do 
(
		if obj.name == x do select obj
)

