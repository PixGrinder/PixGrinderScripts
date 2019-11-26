import bpy
bpy.ops.mesh.primitive_cube_add(size=7, enter_editmode=False, location=(0, 0, 0))
bpy.ops.transform.rotate(value=-0.261911, orient_axis='Z')
bpy.ops.transform.translate(value = (10, 10, 10))