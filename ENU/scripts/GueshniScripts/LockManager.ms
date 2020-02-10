
rollout a "Locks Manager"
(
	button AllBTN "ALL" width:80 height:45 pos:[5,5]
	button NoneBTN "None" width:80 pos:[5,55]
	
	button PosBTN "POS" width:60 pos:[95,5]
		button noPOSBTN "X"  width:20 pos:[155,5]
	button RotBTN "ROT" width:60 pos:[95,30]
		button noROTBTN "X"  width:20 pos:[155,30]
	button SclBTN "SCL" width:60 pos:[95,55]
		button noSClBTN "X"  width:20 pos:[155,55]
	
	on AllBTN pressed do
	(
		sel = selection as array
		
		for  o in sel do
		(
			setTransformLockFlags o #all 
		)
		
	)
	
	on NoneBTN pressed do
	(
		sel = selection as array
		
		for  o in sel do
		(
			setTransformLockFlags o #none
		)
	)
	
	on PosBTN pressed do
	(
		sel = selection as array
		
		for  o in sel do
		(
			LKS = (getTransformLockFlags o )  

			appendifunique LKS 1
			appendifunique LKS 2
			appendifunique LKS 3
				
			setTransformLockFlags o LKS
		)
		
	)
	
	on noPOSBTN pressed do
	(
		sel = selection as array
		
		for  o in sel do
		(
			LKS = (getTransformLockFlags o )  

			ID1 = findItem LKS 1
			if ID1!=0 then ( deleteItem  LKS ID1 )
			
			ID2 = findItem LKS 2
			if ID2!=0 then ( deleteItem  LKS ID2 )
			
			ID3 = findItem LKS 3
			if ID3!=0 then ( deleteItem  LKS ID3 )

				
			setTransformLockFlags o LKS
		)
	)
	
	on RotBTN pressed do
	(
		sel = selection as array
		
		for  o in sel do
		(
			LKS = (getTransformLockFlags o )  

			appendifunique LKS 4
			appendifunique LKS 5
			appendifunique LKS 6
				
			setTransformLockFlags o LKS
		)
		
	)
	
	on noROTBTN pressed do
	(
		sel = selection as array
		
		for  o in sel do
		(
			LKS = (getTransformLockFlags o )  

			ID1 = findItem LKS 4
			if ID1!=0 then ( deleteItem  LKS ID1 )
			
			ID2 = findItem LKS 5
			if ID2!=0 then ( deleteItem  LKS ID2 )
			
			ID3 = findItem LKS 6
			if ID3!=0 then ( deleteItem  LKS ID3 )

				
			setTransformLockFlags o LKS
		)
	)
	
	on SclBTN pressed do
	(
		sel = selection as array
		
		for  o in sel do
		(
			LKS = (getTransformLockFlags o )  

			appendifunique LKS 7
			appendifunique LKS 8
			appendifunique LKS 9
				
			setTransformLockFlags o LKS
		)
		
	)
	
	on noSCLBTN pressed do
	(
		sel = selection as array
		
		for  o in sel do
		(
			LKS = (getTransformLockFlags o )  

			ID1 = findItem LKS 7
			if ID1!=0 then ( deleteItem  LKS ID1 )
			
			ID2 = findItem LKS 8
			if ID2!=0 then ( deleteItem  LKS ID2 )
			
			ID3 = findItem LKS 9
			if ID3!=0 then ( deleteItem  LKS ID3 )

				
			setTransformLockFlags o LKS
		)
	)
	
) 
createdialog a 185 80 pos:[140,210] -- bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)
