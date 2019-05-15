obj=1
pda_test = #()
for obj in geometry do appendIfUnique pda_test (classOf obj.material)
pda_test