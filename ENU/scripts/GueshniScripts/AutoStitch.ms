 (
	 on execute do
	(
		edgelist = (polyop.getedgeselection $) as array
vertlist = (polyop.getvertselection $) as array
seuil = 1
	Edgs = #() -------- Remplisage de la liste des arêtes à traiter.
	for e in edgelist do
	(		
		pts = #()
	
		v_couple = (polyop.getedgeverts $ e) as array
		
			local A = polyop.getvert $ v_couple[1]
			local B = polyop.getvert $ v_couple[2]
			
			local rateMax = 0
			for v in vertlist do
			(
			C = polyop.getvert $ v
			
				if length ((C-A)+(C-B)) < length (B-A) then
				(
				goodFlag = true
				local anglecos = dot (normalize(C-A))(normalize(B-A))
				local rate = (length (C-A)/ length(B-A)) * anglecos
				H = A + rate*(B-A)
				if distance H C > seuil then  goodFlag = false
				if rate<0.001 and rate >0.999 then goodFlag = false
				if goodflag = true then (append Pts C ; append Pts rate)			
				)
			) -- end for v
	if pts.count != 0 then append edgs #(e,pts)
	) -- end for e

--------------------------------------

for e in edgs do
(

local eNum = e[1]
local Vrts = #()
local Rate = #()

	for i = 1 to e[2].count-1 by 2 do
	(
	Append Vrts e[2][i]
	Append Rate e[2][i+1]
	) -- end for i
	
	
	While Vrts.count != 0 do
	(
	if rate.count == 1 then rMax = rate[1] else rMax = aMax rate
	if rate.count == 1 then ind=1 else ind = finditem rate rMax 
	Vt = Vrts[ind]
	
	V = polyop.divideedge $ eNum rMax
	polyop.setvert $ V Vt
	deleteItem rate ind
	deleteItem Vrts ind
	
	for i = 1 to rate.count do rate[i] = (rate[i]/rMAx)
	
	)

) -- end for e

gc()

	)
)