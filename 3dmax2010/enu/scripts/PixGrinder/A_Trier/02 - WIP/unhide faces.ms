-- unhide faces --
clearListener()
for obj in geometry do try (polyop.unHideAllFaces obj) catch ()
for obj in geometry do try (meshop.unHideAllFaces obj) catch ()


-- for obj in selection where classof obj == Editable_Poly do polyop.unHideAllFaces obj
