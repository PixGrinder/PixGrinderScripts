-- Find obj by ID -- 
-- v0.2 --

myID = 6
myAr = #()

for obj in geometry do
(
	convertToPoly obj
	for i = 1 to getnumfaces obj do
	(
		if (polyop.getFaceMatID obj i) == myID then 
		(
			append myAr obj
			exit
		)
	)
)

select myAr


