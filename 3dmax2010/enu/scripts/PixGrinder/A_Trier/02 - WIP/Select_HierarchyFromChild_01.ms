
if $.parent != undefined do (
	append pda_ar $
	append pda_ar $.parent

	select pda_ar
)


-- brouillon
-------------

$.parent


while $.parent != undefined do select $.parent
pda_ar=#()
append pda_ar $
while $.children != undefined do append pda_ar $.children
select pda_ar



select $.children[1]