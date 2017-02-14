-- Align Object Pivot to normal : 
-------------------------------------



-- pistes & recherches :
---------------------------


-- utiliser un mouse tool - voir doc : 
-----------------------------------------
mousetool


-- recuperer la normale d'une face sur un objet en mode Poly : 
----------------------------------------------------------------------
polyop.getFaceNormal $ 225


-- from cg talk : to use in a mouse tool function : 
---------------------------------------

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
s.pos=i.pos -- move to surface
-- s.dir=i.dir -- match face normal
)
)