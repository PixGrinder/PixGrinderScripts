macroScript Test_classof
category:"GoZ"
tooltip:"GoZ test1 classof"
(
--			for modifier in m_node.modifiers while (modifier!=m_modifier) do ()

	max modify mode
	local node = $
	local selObj = modPanel.getCurrentObject()
format "modPanel.getCurrentObject() isKindOf GeometryClass == %" (isKindOf selObj GeometryClass)
	
format "class of node : % \n" (classof node)
format "class of node.baseObject : % \n" (classof node.baseObject)
format "class of node.mesh : % \n" (classof node.mesh)
format "class of cur modifier : % \n" (classof selObj)
-- format "class of modifier.mesh : % \n" (classof selObj.mesh) -> TriMesh sur le baseObject

    -- Test sur EditPoly
	if (isKindOf selObj Edit_Poly) then
	(
		print "modifier is Edit_Poly -> test interface:"
		local var = selObj.GetNumVertices()
		format "   % vertices \n" var
	)
	
	print " -- Node Properties"
format "classof node = %" (classof node)
showProperties node
	--print " -- Node Methods"
--showMethods node

	if (selObj != undefined) then (
		print " -- Modifier Properties"
		format "classof modPanel.getCurrentObject() = %" (classof selObj)
		showProperties selObj
		--print " -- Modifier Methods"
		--showMethods selObj
	) else (
		print " -- BaseObject Properties"
		format "classof node.baseObject = %" (classof node.baseObject)
		showProperties node.baseObject
		print " -- BaseObject Methods"
		showMethods node.baseObject
	)
	
	print " -- Mesh Properties"
	format "classof node.mesh = %" (classof node.mesh)
	showProperties node.mesh
	--print " -- Node Methods"
--showMethods node.mesh

    
)
