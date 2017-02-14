

p=pickobject prompt:"Pick surface to move to."

for s in selection do
(
r=ray s.pos (s.dir*[0,0,-1])
if (i=(intersectray p r))==undefined then
(
r.dir*=[0,0,-1]
i=(intersectray p r)	
)
if i!=undefined then
(
s.pos=i.pos	 -- move to surface
--	 s.dir=i.dir	 -- match face normal
)
)

ray $.pos ($.dir*[0,0,-1])

$.center= [5596.73,-76.5587,275.466]

p

s = $

s


mouse.pos

pda_tipot = mapScreenToWorldRay $Teapot01.center --mouse.pos
pda_box = mapScreenToWorldRay $Box01.center

pda.pos

intersectRay $Box01 pda


