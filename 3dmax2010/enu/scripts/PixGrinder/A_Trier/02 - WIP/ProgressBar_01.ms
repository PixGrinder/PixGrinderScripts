--define a rollout

rollout progressTest "Progress Test"

(

--button doit "Process Scene" -- button to start processing

progressbar doit_prog color:[255,0,235]  -- a red progress bar


--doit_prog.value = 0 -- when ready, reset the progress bar to 0%


)

createDialog progressTest 200 60 -- create a dialog to test

for i = 1  to 10 do ( 
	sleep 1 
	progressTest.doit_prog.value += 10
)

DestroyDialog progressTest