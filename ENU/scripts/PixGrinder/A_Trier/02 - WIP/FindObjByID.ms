-- Find obj by ID -- 

myID = 3
myAr = #()

for obj in geometry do
(

	x1 = for i = 1 to getnumfaces obj collect (polyop.getFaceMatID $ i)

	x1 = makeUniqueArray x1

	append myAr #(obj, x1)

	free x1
)


--for obj in myAr do format "%\r" obj

myResult = for obj in myAr collect obj[1]

print myResult

--(polyop.getFaceMatID $ 1)

/*

getFaceMatID <mesh> <face_index_integer>


*/