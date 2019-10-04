-- Get Controllers -- 

fn getControllers obj ctrls:#() =
(
    for item in refs.dependsOn obj do   
    (
        if isController item AND item.keyable do
            append ctrls item

        getControllers item ctrls:ctrls
    )
    ctrls
)

clearListener()
x1 = getControllers $

for anim in x1 do
(
	print ((numkeys anim) as string)
)


--numKeys x1[23]


/*
-- for obj in x1 do print obj
-- show $.track
-- x1 = snapshotAsMesh $
v1 = getPointControllers selection[1]
v2 = for obj in v1 where obj != undefined collect obj
v2.count

for obj in v1 do print obj


x2 = v2[34]

x2.keys

*/