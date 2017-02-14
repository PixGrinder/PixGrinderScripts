global myValue = 0.2
pda = #()
for obj in geometry do
(
	if ((distance obj.max obj.min) < myValue) == true do appendifunique pda obj
)

select pda


