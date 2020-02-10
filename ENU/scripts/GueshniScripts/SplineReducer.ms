 (
fn loc1 f t=
(
return (normalize (t-f))
)
fn getangle v1 v2=
(
return (acos (dot (normalize v1) (normalize v2)))
)

fn splinelength s=
(
local n=numknots s
local s1=0.0
for i=1 to (n-1) do
(
s1+=(distance (getknotpoint s 1 i) (getknotpoint s 1 (i+1)))
)
return s1
)
-------------------------------------------------------------
	try(destroyDialog r44)catch()
rollout r44 "Spline Reduction"
(
---------------------------------------------
local o1
local o2
local tt=false
---------------------------------------------
fn isSpline o=
(
return ((classof o==line)or(classof o==splineshape)and(numSplines o==1))
)
---------------------------------------------
Pickbutton p1 "Pick Spline" filter:isSpline toolTip:"Pick An Editable Spline Or Line" message:"Pick An Editable Spline Or Line"
Checkbox cc2 "Show Vertex Tic For Copy" checked:on
Checkbox cc4 "Show Vertex Tic For Original"
Checkbox cc3 "Hide Original"
slider sl1 "Iteration (By Sliding)" type:#integer range:[0,1,0]
spinner s22 "Iteration (By Spinning)" type:#integer range:[0,1,0]
spinner ss33 "Threshold" range:[0,1000,0]
spinner ss44 "Copy Offset(X)" range:[-10000,10000,1]
spinner ss55 "Copy Offset(Y)" range:[-10000,10000,0]
spinner ss66 "Copy Offset(Z)" range:[-10000,10000,0]
Checkbox cc1 "Make Copy" checked:on
button b "Accept" toolTip:"Click To Accept Changes"
label l1 ""
label l2 ""
--button b1 "Show Vertex Tic"
---------------------------------------------
on ss44 changed v do
(
try
(
o2.pos.x=o1.pos.x+v
)
catch()
)
---------------------------------------------
on ss55 changed v do
(
try
(
o2.pos.y=o1.pos.y+v
)
catch()
)
---------------------------------------------
on ss66 changed v do
(
try
(
o2.pos.z=o1.pos.z+v
)
catch()
)
---------------------------------------------
on cc4 changed v do
(
try(o1.vertexTicks=v) catch()
)
---------------------------------------------
/*
on b1 pressed do
(
try
(
for o in selection do
(
o.vertexTicks=not(o.vertexTicks)
)
)
catch()
)
*/
---------------------------------------------
on r44 close do
(
try(unhide o1) catch()
if(tt==false) do
(
try
(
delete o2
)
catch()
)
)
---------------------------------------------
on cc2 changed v do
(
try
(
o2.vertexTicks=v
)
catch()
)
---------------------------------------------
on cc3 changed v do
(
try
(
o1.isNodeHidden=v
)
catch()
)
---------------------------------------------
on b pressed do
(
try(unhide o1) catch()
if(cc1.state==false) do 
(
try (delete o1) catch()
)
o2=undefined
o1=undefined
tt=true
destroydialog r44
createdialog r44 width:350
)
---------------------------------------------
on p1 picked ob do
(
tt=false
o1=ob
o1.wirecolor=blue
sl1.range.y=numknots o1
s22.range.y=numknots o1
)
---------------------------------------------
on sl1 changed v do
(
s22.value=v
l1.text="100% Reduced"
if((v>0)and(o1!=undefined)and(o1.isdeleted==false)) do
(
try(delete o2) catch()
o2=copy o1
o2.vertexTicks=cc2.state
o2.pos.x+=ss44.value
o2.pos.y+=ss55.value
o2.pos.z+=ss66.value
o2.wirecolor=black
for i=1 to v do
(
local d=ss33.value
local n=numknots o2
if(n>2) do
(
local s_arr=#()
for i=2 to (n-1) do
(
local v=getknotpoint o2 1 i
local v1=getknotpoint o2 1 (i-1)
local v2=getknotpoint o2 1 (i+1)
local a1=getangle (loc1 v v2) (loc1 v v1)
local l1=distance v v1
local l2=distance v v2
local l=l1+l2
local s=(180-a1)*l
append s_arr s
)
local mins=amin s_arr
for i=2 to (n-1) do
(
s=s_arr[i-1]
if((abs (s-mins))>d) then () else
(
try(deleteKnot o2 1 i) catch()
updateshape o2
)
)
local nn11=numknots o1
local nn22=numknots o2
local perc=(nn22)/(nn11+0.0)
perc*=100
perc=perc as integer
l1.text=(perc as string)+"% Vertices Remaining"
try(l2.text=(((numknots o1)-(numknots o2)) as string)+" Vertices Removed") catch()
)
)

)
)
--------------------------------------------------
on s22 changed v do
(
sl1.value=v
l1.text="100% Reduced"
if((v>0)and(o1!=undefined)and(o1.isdeleted==false)) do
(
try(delete o2) catch()
o2=copy o1
o2.vertexTicks=cc2.state
o2.pos.x+=ss44.value
o2.pos.y+=ss55.value
o2.pos.z+=ss66.value
o2.wirecolor=black
for i=1 to v do
(
local d=ss33.value
local n=numknots o2
if(n>2) do
(
local s_arr=#()
for i=2 to (n-1) do
(
local v=getknotpoint o2 1 i
local v1=getknotpoint o2 1 (i-1)
local v2=getknotpoint o2 1 (i+1)
local a1=getangle (loc1 v v2) (loc1 v v1)
local l1=distance v v1
local l2=distance v v2
local l=l1+l2
local s=(180-a1)*l
append s_arr s
)
local mins=amin s_arr
for i=2 to (n-1) do
(
s=s_arr[i-1]
if((abs (s-mins))>d) then () else
(
try(deleteKnot o2 1 i) catch()
updateshape o2
)
)
local nn11=numknots o1
local nn22=numknots o2
local perc=(nn22)/(nn11+0.0)
perc*=100
perc=perc as integer
l1.text=(perc as string)+"% Vertices Remaining"
try(l2.text=(((numknots o1)-(numknots o2)) as string)+" Vertices Removed") catch()
)
)

)
)
--------------------------------------------------
)
createdialog r44  width:350 pos:[140,210] -- bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)
)
