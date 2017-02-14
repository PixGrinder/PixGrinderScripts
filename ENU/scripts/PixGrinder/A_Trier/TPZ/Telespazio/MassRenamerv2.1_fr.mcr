-- MassRenamerv2.1_fr.mcr
-- By Bruno ISANA (bebetelanuite@yahoo.fr)
-- v 2.1
-- All right reserved
-- Freely distributable

macroScript MassRenamer
	category:"CustomTools"
	ButtonText:"MRenamer"
(

--INTERFACE========================================
Rollout Renommer "Mass Renamer v2.1"
(
Group ""
(
	Checkbox GiveObjectName2Mat "Donner le nom de l'objet au matériau" 
	Checkbox GiveMatName2Object "Donner le nom du materiau au(x) objet(s)"
	Checkbox EnterCustomName "Donner un nom" checked:true
	CheckBox ToMaterial "Mat." Pos:[120,66] --checked:true
	CheckBox ToObjects "Obj." pos:[173,66] Checked:True
	Edittext EditPrefix "Préfixe :"
	Edittext EditName "Nom :"
	Edittext EditSuffix "Suffixe :"
	Checkbox CheckIncrement "Incrémenter à partir de :" checked:false 
	spinner EditIncrementation "" pos:[154,153] width:70 type:#integer range:[1,1000,1] enabled:false
)--end group
Group ""
(
	Checkbox ReplacePartofName "Remplacer une partie du nom" checked:false
	Edittext ToReplace "Remplacer :" enabled:false
	Edittext ReplaceBy "Par :" enabled:false
)--end Group
Group ""
(
	Checkbox RemovePartofName "Supprimer une partie du nom" checked:false
	label TextToRemove "Texte à supprimer :" align:#left enabled:false
	Edittext PartToRemove "" enabled:false
	label RemoveLetters "Nombre de lettres à Supprimer :" align:#left enabled:false
	Spinner RemoveLetterFromBeginning "Au Début :" width:150 type:#integer range:[0,1000,0] enabled:false align:#right
	Spinner RemoveLetterFromEnd "A la Fin :" width:150 type:#integer range:[0,1000,0] enabled:false align:#right

)--end Group
Group ""
(
	Checkbox CheckObjectGroup "Appliquer aux objets dans les groupes." checked:false
	Checkbox CheckMatEditor "Ouvrir l'éditeur de materiaux" checked:false
	Button GiveName "APPLIQUER" width:210
	progressbar progress color:green

)--end group

Group "Objets non traités"
(	
	label InfoTitleIgnoredObj "Raisons :" align:#left
	label InfoIgnoredObj "Aucun Objets à lister" align:#left
	label InfoIgnoredObj2 "" align:#left
	label InfoIgnoredObj3 "" align:#left
	label IgnoredObjesp01 ""
	listbox IgnoredObjList "Objets non traités :"
	Button SelectSelectedIgnoredObj "Sélectionner l'Objet" align:#left width:105
	Button SelectIgnoredObj "Sélectionner Tous" align:#right pos:[124,791] width:100
)--end group

--Globals
Global ProgressIncrem = 0
Global ProgressInterval = ((100 as float)/(selection.count as float)) as float
Global NoPartFindObject = #()
Global NoPartFindObjectList = ""
Global NonComputedObjects = #()



--FUNCTIONS========================================

fn EnterCustomNameONOFF State =
(
	EditName.enabled = State
	ToMaterial.enabled = State
	ToObjects.enabled = State
	EditPrefix.enabled = state
	EditName.enabled = state
	EditSuffix.enabled = state
	CheckIncrement.enabled = State
	EditIncrementation.enabled = State
	--EraseFields.enabled = state
)--end fn

fn ReplacePartNameONOFF State =
(
	
	ToReplace.enabled = State
	ReplaceBy.enabled = State
)--end fn

fn RemovePartNameONOFF State =
(
	RemoveLetterFromBeginning.enabled = State
	RemoveLetterFromEnd.enabled = State
	TextToRemove.enabled = State
	RemoveLetters.enabled = State
	PartToRemove.enabled = State
)--end fn

fn progressbarvalue incr =
(
	Global ProgressIncrem = ProgressIncrem+(incr*ProgressInterval)
	Progress.value = ProgressIncrem

)--end fn

fn IgnoredObjfn num =
(
	if num == 1 do 
	(	
		IgnoredObjList.items = withoutMatObject
		MessageA = "- Ces objets n'ont pas de materiau appliqué." 
		MessageB = ""
		MessageC = ""
	)--end if
	
	if num == 2 do 
	(
		IgnoredObjList.items = NoPartFindObject
		MessageA = "- \""+ToReplace.text+"\" ne fait pas partie de leur nom."	
		MessageB = ""
		MessageC = ""
	)--end if
	
	if num == 3 do 
	(
		IgnoredObjList.items = NonComputedObjects
		NumErasedLetters = RemoveLetterFromBeginning.value+RemoveLetterFromEnd.value
		MessageA = "- \""+PartToRemove.text+"\" ne fait pas partie de leur nom."
		MessageB = "- Le texte à enlever est similaire au nom."
		MessageC = "- Nom inférieur ou égal à "+(NumErasedLetters as string)+" lettres."
	)--end if
	
	if num == 4 do 
	(
		IgnoredObjList.items = #()
		MessageA = "Aucun Objets à lister"
		MessageB = ""
		MessageC = ""
	)--end if

	if num != 4 do (MessageBox "Des objets non pas été traités. Voir la liste \"Objets non traités\".")
	
	InfoIgnoredObj.text = MessageA
	InfoIgnoredObj2.text = MessageB	
	InfoIgnoredObj3.text = MessageC
)--end fn


--ACTION===========================================

on GiveObjectName2Mat changed state do
(
	if EnterCustomName.state == false and GiveMatName2Object.state == False and ReplacePartofName.state == False and RemovePartofName.state == False then GiveObjectName2Mat.state = True
		
	GiveMatName2Object.state = false
	EnterCustomName.state = false
	ReplacePartofName.state = False
	RemovePartofName.state = False
	
	EnterCustomNameOnOff False
	ReplacePartNameONOFF False
	RemovePartNameONOFF False
	
)--end on

on GiveMatName2Object changed state do
(	
	if EnterCustomName.state == false and GiveObjectName2Mat.state == False and ReplacePartofName.state == False and RemovePartofName.state == False then GiveMatName2Object.state = True
	
	GiveObjectName2Mat.state = false
	EnterCustomName.state = false
	ReplacePartofName.state = False
	RemovePartofName.state = False
	
	EnterCustomNameOnOff False
	ReplacePartNameONOFF False
	RemovePartNameONOFF False
	
)--end on

On EnterCustomName changed state do
(	
	
	if GiveMatName2Object.state == false and GiveObjectName2Mat.state == False and ReplacePartofName.state == False and RemovePartofName.state == False  then EnterCustomName.state = True
		
	GiveMatName2Object.state = false
	GiveObjectName2Mat.state = false
	ReplacePartofName.state = False
	RemovePartofName.state = False
	
	EnterCustomNameOnOff True
	ReplacePartNameONOFF False
	RemovePartNameONOFF False
	
)--end on

On ToMaterial changed state do
(
	If ToObjects.state == false then ToMaterial.state = True
	ToObjects.state = False
)--end on 

On ToObjects changed state do
(
	If ToMaterial.state == False then ToObjects.State = True
	ToMaterial.state = False
)--end on

On checkIncrement changed state do
(
	If CheckIncrement.state == True then EditIncrementation.enabled = True else EditIncrementation.enabled = False
)--end on

on ReplacePartofName changed state do
(
	if GiveMatName2Object.state == False and GiveObjectName2Mat.state == False and EnterCustomName.state == False and RemovePartofName.state == False then ReplacePartofName.state = true 
	
	GiveMatName2Object.state = false
	GiveObjectName2Mat.state = false
	EnterCustomName.state = false
	RemovePartofName.state = False
	
	EnterCustomNameOnOff False
	ReplacePartNameONOFF True
	RemovePartNameONOFF False
	
)--end on

on RemovePartofName changed state do
(
	if GiveMatName2Object.state == False and GiveObjectName2Mat.state == False and EnterCustomName.state == False and ReplacePartofName.state == false then RemovePartofName.state = True 
	
	GiveMatName2Object.state = false
	GiveObjectName2Mat.state = false
	EnterCustomName.state = false
	ReplacePartofName.state = False
	
	EnterCustomNameOnOff False
	ReplacePartNameONOFF False
	RemovePartNameONOFF True
	
)--end on


On GiveName pressed do with undo label:"MassRenamer_Apply" on
(
	if selection.count == 0 do
	(
		messagebox "Sélectionnez un ou plusieurs objets."
	)
	if selection.count != 0 do
	(
		Global withoutMatObject = #()
		
		if CheckObjectGroup.state == false do
		(
			Global GroupMemberObject = #()
			Global CloseGroup = #()
			for obj in selection do if isgrouphead obj == true and isopengrouphead obj == false do append CloseGroup obj
			for obj in selection do if isgroupmember obj == true do append GroupMemberObject obj
			for obj in selection do if isgrouphead obj == true do setgroupopen obj true
			deselect GroupMemberObject
		)--end if
		
		if GiveObjectName2Mat.state == true do --======================================================================================================================================================
		(			
			
			For obj in selection do
			(
				if obj.material != undefined then
				(
					matname = obj.name
					obj.Material.name = matname
				)--end if
				else
				(
					append WithoutMatObject obj.name
				)--end else
				
				progressbarvalue 1
				
			)--end for
				
			--===================================== TRAITEMENT DU ARRAY WithoutMatObject POUR AFFICHAGE ==========================================================
			if WithoutMatObject.count != 0 do 
			(
				sort WithoutMatObject
				IgnoredObjfn 1
				
			)--end if
	
			Progress.value = 0
		
		)--end if
			
		if GiveMatName2Object.state == true do --======================================================================================================================================================
		(
			For obj in selection do
			(	
				if obj.material != undefined then
				(
					matname = obj.material.name
					obj.name = matname
				)--end if
				else
				(
					append WithoutMatObject obj.name
				)--end else

				progressbarvalue 1				
				
			)--end for
			
			Progress.value = 0
			--===================================== TRAITEMENT DU ARRAY WithoutMatObject POUR AFFICHAGE ==========================================================
			if WithoutMatObject.count != 0 then
			(
				sort WithoutMatObject
				IgnoredObjfn 1
			)--end if
			else (IgnoredObjFn 4)
			
		)--end if
			
		if EnterCustomName.state == true do --======================================================================================================================================================
		(
			If EditName.text == "" and EditPrefix.text == "" and EditSuffix.text == "" do
			(
				messagebox "Entrez un nom"
			)--end if
			
			If EditName.text != "" or EditPrefix.text != "" or EditSuffix.text != "" do
			(
				Global MatNewName = EditName.text
				Global Incrementvalue = (EditIncrementation.value-1)
				
				For i=1 to selection.count do
				(
					If selection[i].material != undefined then ObjMatName = Selection[i].material.name
					ObjName = Selection[i].name
					
					If i+Incrementvalue < 10 then zero = "0" else zero = ""
					
					-- If Mat checked ======================================================================================================================================================
					If ToMaterial.state == true do
					(
						if selection[i].material != undefined then
						(

							If EditPrefix.text != "" or EditSuffix.text != "" and EditName.text == "" do
							(
								Selection[i].material.name = (EditPrefix.text)+ObjMatName+(EditSuffix.text)
								Global PrefSuffText = Selection[i].material.name
							)--end if
							
							If EditName.text != "" do
							(
								Selection[i].material.name = (EditPrefix.text)+(EditName.text)+(EditSuffix.text)
								Global PrefSuffText = Selection[i].material.name
							)--end if
							
							If CheckIncrement.state == true then Selection[i].material.name = PrefSuffText+zero+((i+IncrementValue) as string)
							
						)--end if
						else
						(
							append WithoutMatObject selection[i].name
						)--end else
																	
					)--end if 
					
					
					-- If Obj checked ========================================================================================================================================================
					If ToObjects.state == true do
					(
						If EditPrefix.text != "" or EditSuffix.text != "" and EditName.text == "" do
						(
							Selection[i].name = (EditPrefix.text)+ObjName+(EditSuffix.text)
							Global PrefSuffText = Selection[i].name
						)--end if
						
						If EditName.text != "" do
						(
							Selection[i].name = (EditPrefix.text)+(EditName.text)+(EditSuffix.text)
							Global PrefSuffText = Selection[i].name
						)--end if
						
						If CheckIncrement.state == true then Selection[i].name = PrefSuffText+zero+((i+IncrementValue) as string)
					)--end if
					
					progressbarvalue 1
					
				)--end for
				
				Progress.value = 0
				
				--===================================== TRAITEMENT DU ARRAY WithoutMatObject POUR AFFICHAGE ==========================================================
				if WithoutMatObject.count != 0 then 
				(
					sort WithoutMatObject
					IgnoredObjfn 1

				)--end if
				else (IgnoredObjFn 4)
				
				)--end if EditName.text != Undefined
			
			if CheckMatEditor.state == true do (mateditor.open())
			
		)--end if EnterCustomName.state == true
	
	
		if ReplacePartofName.state == True do --===========================================================================================================================================IF
		(	
				NoPartFindObject = #()
				
				if ToReplace.text != "" and ReplaceBy.text !="" then --====================================================================================================================IF
				(
					For obj in selection do
					(
						PartofNamePos = FindString obj.name ToReplace.text

						if PartofNamePos != undefined then
						(
							Obj.name = Replace obj.name PartofNamePos ToReplace.text.count ReplaceBy.text
						)--end if
						else
						(
							append NoPartFindObject obj.name
						)--end else
					
						progressbarvalue 1
					
					)--end for
					
					Progress.value = 0						
		
				)--end if --===============================================================================================================================================================END IF
				else --====================================================================================================================================================================ELSE
				(
					
					if ToReplace.text == "" and ReplaceBy.text == "" then (messagebox "Aide :\nPour remplacer une partie du nom : \nEntrez la partie du nom à remplacer et le texte de remplacement")
					else 
					(
						if ToReplace.text == "" do (messagebox "Entrez une partie de nom à remplacer")
						if ReplaceBy.text == "" do (messagebox "Entrez un texte de remplacement")
	
					)--end else
					
				)--end else --=============================================================================================================================================================END ELSE
			
			
			if NoPartFindObject.count != 0 then 
			(
				sort NoPartFindObject
				IgnoredObjfn 2
					
			)--end if
			else (IgnoredObjFn 4)
			
		)--end if ReplacePartofName.state == true --===================================================================================================================================END IF

	
		if RemovePartofName.state == True do
		(	
			NonComputedObjects = #()
			
			For obj in selection do
			(
				Global ObjNameCountNumber = obj.name.count
				Global ObjName = obj.name
				Global RemoveLetterNumber = RemoveLetterFromBeginning.value+RemoveLetterFromEnd.value
				
				if PartToRemove.text != "" do
				(		
					Global PartofNamePos = FindString obj.name PartToRemove.text
					
					if PartofNamePos != undefined and PartToremove.text != ObjName do (
																							Obj.name = Replace obj.name PartofNamePos PartToRemove.text.count ""
																							)--end if
				)--end if
				
					If RemoveLetterNumber < ObjNameCountNumber do--then
					(
						if RemoveLetterFromBeginning.value != 0 do 
						(
							Obj.name = Replace obj.name 1 RemoveLetterFromBeginning.value ""
						)--end if 
					
						if RemoveLetterFromEnd.value != 0 do 
						(
							PartofNamePos = ((obj.name.count - RemoveLetterFromEnd.value)+1)
							Obj.name = Replace obj.name PartofNamePos RemoveLetterFromEnd.value ""
						)--end if
					)--end if
				
				--print RemoveLetterNumber
				--Print ObjNameCountNumber
				
				if PartofNamePos == undefined or RemoveLetterNumber >= ObjNameCountNumber or PartToRemove.text == ObjName do
				(
					append NonComputedObjects obj.name
				)--end if
									
				progressbarvalue 1
			
			)--end for
			
			Progress.value = 0

			if NonComputedObjects.count != 0 then (
													sort NonComputedObjects 
													IgnoredObjFn 3
													)--end if 
													else (IgnoredObjFn 4)

		)--end if
		
		if CheckObjectGroup.state == false do
		(
			selectmore GroupMemberObject
			for item in CloseGroup do setgroupopen item false
		)--end if
		
	)--end if selection.count != 0
)--end on

on SelectIgnoredObj pressed do with undo label:"MassRenamer_SelectAll" on
(
	IgnoredObjForSelection = #()
	for item in IgnoredObjList.items do 
	(
		for obj in objects do 
		(
			if obj.name == item do 
			(
				append IgnoredObjForSelection obj
			)--end if			
		)--end for
	)--end for
	select IgnoredObjForSelection
)--end on

on SelectSelectedIgnoredObj pressed do with undo label:"MassRenamer_SelectOne" on
(
	IgnoredObjForSelection = #()
	for obj in objects do 
	(
		if obj.name == IgnoredObjList.selected do 
		(
			append IgnoredObjForSelection obj
		)--end if			
	)--end for
	select IgnoredObjForSelection
)--end on
)--end rollout

Rollout aboutRenommer "About" rolledup:true
(
group ""
(
	Label copnom "MASS RENAMER v2.1"
)--end group
Group ""
(
	label cop01 "Made by"
	label cop02 "-- Bruno ISANA --"
	label cop03 "-- bebetelanuite@yahoo.fr --"
	label espcop1 " " height:1
	label cop04 "All Rights Reserved - Freely Distributable"
	label espcop " " height:2
)--end group

)--end rollout

ScriptRoll = newrolloutfloater "Mass Renamer v2.1" 250 875
addrollout AboutRenommer ScriptRoll
addrollout Renommer ScriptRoll

)--end macroscript
