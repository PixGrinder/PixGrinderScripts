-- FreehandSpline15-AsMCR-v0_12.mcr
--
-- 09.01.2k, swami*, a.k.a. "codeWarrior()", swami@cfl.rr.com
-- Written for MAX r3.1
--
-- Original script by Bobo.
-- Modified by swami* to convert from a UtilityScript to a MacroScript.
-- Updated to R4.x, 12.01.01 (search "--s*" for changes).
--
macroScript FreehandSpline
	category:"Bobo_s Tools"
	buttontext:"fhs"
	toolTip:"Freehand Spline"
(
--s*:Updated to R4.x...
global num_splines
global fh_float, about_roll, main_roll
-- end update.

try (closeRolloutFloater fh_float) catch()	-- If fh_float already open, then close.
fh_float = NewRolloutFloater "Freehand Spline" 200 415

old_pos 
new_spline = undefined

rollout about_roll "About"
(
group "About..."
(
label ffsa_01 "FreehandSpline"
label ffsa_02 "Version 1.5 - 02/18/99"
label ffsa_03 "by Borislav Petrov"
label ffsa_04 "(c) Bobo's Rendert**ls"
label ffsa_05 "http://gfxcentral.com/bobo/"
label ffsa_06 ""
label ffsa_07 "Converted to MacroScript"
label ffsa_07b "and updated to R4.x"
label ffsa_08 "by swami*"
label ffsa_09 "swami@cfl.rr.com"
label ffsa_10 "09.01.2k"
label ffsa_11 "12.01.01"
label ffsa_12 ""
label ffsa_13 "Notes:" align:#left
label ffsa_14 "- Mouse 'Smart Move' must" align:#left
label ffsa_15 "be DISABLED via ControlPanel." align:#left offset:[0,-3]
label ffsa_16 "- See Listener for important" align:#left
label ffsa_17 "usage info!..." align:#left offset:[0,-3]
)
)

rollout main_roll "Main"
(
group "Spline Drawing:"
(
spinner min_segment "Min.Seg. Length" range:[0,1000,10] type:#float fieldwidth:45
button start_draw "START DRAWING" width:140 height:30
checkbutton user_color "Use Custom Color" checked:true width:94 height:20 across:2 align:#left
colorpicker wire_color "" color:[0,30,100] align:#right

spinner interpolation "Interpolation Steps" range:[0,10,6] type:#integer fieldwidth:32

checkbutton curve_mode "Curve Segs" checked:true  width:68 align:#left across:2 highlightcolor:([255,200,200] as color)
checkbutton line_mode "Line Segs" checked:false  width:68 align:#right highlightcolor:([200,255,200] as color)

checkbutton bezier_mode "Bezier Verts" checked:true  width:68 align:#left across:2 highlightcolor:([255,200,200] as color)
checkbutton smooth_mode "Smooth Verts" checked:false  width:68 align:#right  highlightcolor:([200,255,200] as color)

)


on curve_mode changed state do
(
line_mode.checked = not state
)

on line_mode changed state do
(
curve_mode.checked = not state
)

on smooth_mode changed state do
(
bezier_mode.checked = not state
)

on bezier_mode changed state do
(
smooth_mode.checked = not state
)

on interpolation changed val do
(

if new_spline != undefined then new_spline.steps = val
)


group "Renderable Spline"
(
checkbutton renderable_yes "Renderable Spline" checked:true  width:140 align:#center
spinner spline_thickness "Spline Thickness" range:[0,1000,1] type:#float fieldwidth:45

)

group "Extrude Options"
(
spinner extrude_amount "Extrude Amount" range:[0,1000,10] type:#float fieldwidth:45
)

button reset_properties "Reset To Defaults" width:140 aling:#center

on reset_properties pressed do
(
q = querybox "FREEHAND SPLINE:\nReset All Values\nTo Defaults?"
if q then
	(
	min_segment.value = 10
	user_color.checked = true 
	wire_color.color = color 0 30 100
	curve_mode.checked = true
	line_mode.checked = false
	smooth_mode.checked = false
	bezier_mode.checked = true	
	interpolation.value = 6
	renderable_yes.checked = true 
	spline_thickness.value = 1
	extrude_amount.value = 10
	
	)
)

fn get_mouse_pos pen_pos old_pen_pos =
(

if old_pos == undefined then old_pos = old_pen_pos
delta_dist = sqrt(((pen_pos.x-old_pos.x)^2) + ((pen_pos.y-old_pos.y)^2) + ((pen_pos.z-old_pos.z)^2))
if delta_dist > min_segment.value  then 
	(
	if curve_mode.checked then 
		(
			addKnot new_spline num_splines #smooth #curve pen_pos
		)
		else
		(
			addKnot new_spline num_splines #smooth #line pen_pos
		)
		
	old_pos = pen_pos
	updateShape new_spline
	)
)--end fn


fn draw_new_line old_pen_pos =
(
draw_pick = pickpoint mouseMoveCallback:#(get_mouse_pos,old_pen_pos) terminators:#("e"," ","d","c","m","p","l","k")
draw_it_again = 0

if draw_pick[2] == "m" then 
	(
	draw_it_again = 0
	close new_spline num_splines
	deleteknot new_spline num_splines 1
	if num_splines > 1 then deleteknot new_spline num_splines 1	
	updateshape new_spline	

	dont_mesh = false
	for s = 1 to num_splines do 
		(
		if not (isClosed new_spline s) then dont_mesh = true 
		)
	q = true	
	if dont_mesh then
	(
	q = querybox "FREEHAND SPLINE:\nThere are OPEN SPLINES\nin the current Shape.\nDo you really want to Mesh?"
	)
	
	if q then 
	(
	addmodifier new_spline (normalModifier ())
	txt = "FREEHAND SPLINE: Meshed Spline " + new_spline.name
	format "\n%\n" txt
	)
	else
	(
	txt = "FREEHAND SPLINE: Closed Spline - NOT MESHED " + new_spline.name
	format "\n%\n" txt
	)

	draw_it_again = 0

	)

if draw_pick[2] == " " then 
	(
	
	draw_it_again = 0
	close new_spline num_splines
	deleteknot new_spline num_splines 1
	if num_splines > 1 then deleteknot new_spline num_splines 1	
	updateshape new_spline	
	txt = "FREEHAND SPLINE: Closed Spline " + new_spline.name
	format "\n%\n" txt
	)		
	
if draw_pick[2]	 == "e" then
	(
	close new_spline num_splines
	deleteknot new_spline num_splines 1
	if num_splines > 1 then deleteknot new_spline num_splines 1	
	updateshape new_spline	

	draw_it_again = 0
	addmodifier new_spline (extrude amount:extrude_amount.value)
	txt = "FREEHAND SPLINE: Closed and Extruded Spline " + new_spline.name + " with Extrusion "+extrude_amount.value as string
	format "\n%\n" txt
	)
	
if draw_pick[2]	 == "d" then
	(
	deleteknot new_spline num_splines 1
	if num_splines > 1 then deleteknot new_spline num_splines 1	
	updateshape new_spline	

	draw_it_again = 1	
	txt = "FREEHAND SPLINE: Pen Up... Click again in a viewport to continue drawing..."
	format "\n%\n" txt
	)
	
if draw_pick[2]	 == "c" then
	(
	draw_it_again = 1
	close new_spline num_splines
	deleteknot new_spline num_splines 1
	if num_splines > 1 then deleteknot new_spline num_splines 1	
	updateshape new_spline	
	txt = "FREEHAND SPLINE: Close Spline and Pen Up... Click again in a viewport to continue drawing..."
	format "\n%\n" txt
	)	
	
if draw_pick[2]	 == "p" then
	(
	draw_it_again = 2
	updateshape new_spline	
	txt = "FREEHAND SPLINE: Drawing Paused... Click again in a viewport to continue last spline.."
	format "\n%\n" txt
	)	

if draw_pick[2]	 == "l" then
	(
	line_mode.checked = true
	curve_mode.checked = false
	draw_it_again = 2
	updateshape new_spline	
	txt = "FREEHAND SPLINE: LINEAR Segment Mode ... Click again in a viewport to continue last spline.."
	format "\n%\n" txt
	)	

if draw_pick[2]	 == "k" then
	(
	line_mode.checked = false
	curve_mode.checked = true
	draw_it_again = 2
	updateshape new_spline	
	txt = "FREEHAND SPLINE: CURVE Segment Mode ... Click again in a viewport to continue last spline.."
	format "\n%\n" txt
	)	

	max views redraw
	
draw_it_again	
)

on start_draw pressed do
(

undo on
(
txt = "FREEHAND SPLINE: Click in a Viewport to start drawing..."
format "%\n" txt


new_spline = SplineShape ()
new_spline.name = uniquename "FHS_Shape"
if user_color.checked then new_spline.wirecolor = wire_color.color

--s*
--new_spline.renderable = renderable_yes.checked
new_spline.baseObject.renderable = renderable_yes.checked

new_spline.thickness = spline_thickness.value
new_spline.steps = interpolation.value
old_pos = undefined
draw_again = 1
while draw_again != 0 do
(
old_pen_pos = pickpoint ()
if old_pen_pos == #rightclick then 
	(
	delete new_spline
	new_spline = undefined
	exit
	)
if draw_again != 2 then addNewSpline new_spline
num_splines = numSplines new_spline
if num_splines == 1 and draw_again != 2 then new_spline.pos = old_pen_pos
if draw_again != 2 then
(
	if curve_mode.checked then 
		(
		addKnot new_spline num_splines #smooth #curve old_pen_pos
		addKnot new_spline num_splines #smooth #curve old_pen_pos
		)
		else
		(
		addKnot new_spline num_splines #smooth #line old_pen_pos
		addKnot new_spline num_splines #smooth #line old_pen_pos
		)
)
updateShape new_spline
txt = "FREEHAND SPLINE: Move mouse to draw a spline. Segment Length:"+min_segment.value as string
format "%\n" txt
txt = "COMMANDS: [p]=PenUp-Pause [d]=PenUp-NewSpline [c]=Close&PenUp [l]=Lines [k]=Curves"
format "%\n" txt
txt = "          [Space]=Close&End [e]=CloseLast&Extrude [m]=Mesh&End  [Right-Click]=End"
format "%\n" txt
draw_again = draw_new_line old_pen_pos
)

txt = "FREEHAND SPLINE: End of Drawing."
format "%\n" txt
if new_spline != undefined then 
	(
	if bezier_mode.checked then
		(
		for i = 1 to num_splines do
			(
			for j = 1 to (numknots new_spline i) do
				(
				setKnotType new_spline i j #bezier
				)
			)
		)
	select new_spline
	)
)--end undo	
)--end on

on freehand_spline open do
(
txt = "Initializing FREEHAND SPLINE..."
format "\n%\n" txt

max_ver2 = true
check_color = color 255 255 255
check_color *=128
if check_color.r > 255 then max_ver2 = false
if max_ver2 then 
	(
	start_draw.enabled = false
	start_draw.text = "MAX 2.5 REQUIRED!"
	txt = "MAX R2.0 Detected! Utility DISABLED. MAX R2.5 Required!"
	format "%\n" txt
	)
	else
	(
	txt = "MAX R2.5 Detected..."
	format "%\n" txt	
	)
	
	try
	(
	ini_file = openfile (scriptspath + "fhspline.ini")
	str = readline ini_file
	min_segment.value = str as float
	str = readline ini_file
	if str == "true" then user_color.checked = true else user_color.checked = false
	str = readline ini_file
	if str == "true" then curve_mode.checked = true else curve_mode.checked = false
	str = readline ini_file
	if str == "true" then line_mode.checked = true else line_mode.checked = false
	
	str = readline ini_file
	interpolation.value = str as float
	str = readline ini_file
	if str == "true" then renderable_yes.checked = true else renderable_yes.checked = false
	str = readline ini_file
	spline_thickness.value = str as float
	str = readline ini_file
	extrude_amount.value = str as float
	str = readline ini_file
	if str == "true" then smooth_mode.checked = true else smooth_mode.checked = false
	str = readline ini_file
	if str == "true" then bezier_mode.checked = true else bezier_mode.checked = false	
	close ini_file
	txt = "INI file loaded."
	format "%\n" txt	

	)
	catch
	(
	txt = "INI file corrupted or missing. Using defaults."
	format "%\n" txt	
	)
	
	txt = "Ready."
	format "%\n" txt	
	
)

on freehand_spline close do
(
	save_file_path = scriptspath + "fhspline.ini"
	ini_file = createfile save_file_path
	format "%\n" (min_segment.value as string) to:ini_file
	format "%\n" (user_color.checked as string) to:ini_file
	format "%\n" (curve_mode.checked as string) to:ini_file	
	format "%\n" (line_mode.checked as string) to:ini_file	
	format "%\n" (interpolation.value as string) to:ini_file
	format "%\n" (renderable_yes.checked as string) to:ini_file
	format "%\n" (spline_thickness.value as string) to:ini_file
	format "%\n" (extrude_amount.value as string) to:ini_file
	format "%\n" (smooth_mode.checked as string) to:ini_file	
	format "%\n" (bezier_mode.checked as string) to:ini_file		
	close ini_file

	txt = "FREEHAND SPLINE Session Closed."
	format "%\n" txt
)
)
addRollout about_roll fh_float rolledUp:true
addRollout main_roll fh_float rolledUp:false
)