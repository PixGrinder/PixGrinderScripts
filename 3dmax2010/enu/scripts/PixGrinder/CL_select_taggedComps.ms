(
	select (for obj in objects where CustAttributes.count obj == 1 collect obj)
	for obj in selection do custAttributes.delete obj 1
)

for obj in selection format ("%, " obj.name)