-- UniversalWeld -- 
-- v1.0 -- 


-- function to weld shape vertex without threshold
fn fuseWeld obj = 
(
	splineOps.fuse obj
	splineOps.weld obj
)

clearListener() -- Clear Listener


case ((classof selection[1]) as string) of
(
"SplineShape":fuseWeld selection[1]
"line":fuseWeld selection[1]
"Editable_Poly":polyop.collapseVerts selection[1] (polyop.getVertSelection selection[1])
"Editable_mesh":meshops.collapse selection[1]
"UndefinedClass":format "Nothing selected\r"
default:format "none of the above\r"
)

if selection.count != 0 then update selection[1]