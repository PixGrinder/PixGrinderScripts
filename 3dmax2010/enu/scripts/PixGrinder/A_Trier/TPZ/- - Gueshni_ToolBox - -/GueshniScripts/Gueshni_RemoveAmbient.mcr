macroScript RemoveAmbient category:"- Gueshni -" Icon:#("g9_removeambient", 1) tooltip:"Remove Ambient"
 (
	 RemoveCanal

if (RemoveMapsChannel != null) then DestroyDialog RemoveMapsChannel

rollout RemoveMapsChannel "Remove Map Channel" width:162 height:150
(
	checkbox chk_Amb "Ambient" pos:[10,10] width:71 height:16 enabled:true checked:false
	checkbox chk_Dif "Diffuse" pos:[81,10] width:71 height:16 enabled:true checked:false
	checkbox chk_Spe "Spec Color" pos:[10,27] width:71 height:16 enabled:true checked:false
	checkbox chk_Lvl "Spec lvl" pos:[81,27] width:71 height:16 enabled:true checked:false
	checkbox chk_Glo "Glossiness" pos:[10,44] width:71 height:16 enabled:true checked:false
	checkbox chk_Sli "Self-illu" pos:[81,44] width:71 height:16 enabled:true checked:false
	checkbox chk_Opa "Opacity" pos:[10,61] width:71 height:16 enabled:true checked:false
	checkbox chk_Bum "Bump" pos:[81,61] width:71 height:16 enabled:true checked:false
	checkbox chk_Ref "Reflection" pos:[10,78] width:71 height:16 enabled:true checked:false
	checkbox chk_Rfr "Refraction" pos:[81,78] width:71 height:16 enabled:true checked:false
	checkbox chk_Dis "Displace" pos:[10,95] width:71 height:16 enabled:true checked:false

	button btn_Remove "Remove Maps" pos:[10,116] width:142 height:20
	
	on btn_Remove pressed do
		RemoveCanal chk_Amb.state chk_Dif.state chk_Spe.state chk_Lvl.state chk_Glo.state chk_Sli.state chk_Opa.state chk_Bum.state chk_Ref.state chk_Rfr.state chk_Dis.state
)
CreateDialog RemoveMapsChannel

fn RemoveCanal _Ambient _Diffus _SpecColor _SpecLVL _Gloss _SelfIllu _Opacity _Bump _Reflect _Refract _Displace=
(
	if selection.count == 0 then
		messageBox "Sélection vide"
	else
	(
		for obj in selection do
		(
			if classof obj.material == StandardMaterial then
			(
				if _Ambient do obj.material.ambientMap = undefined
				if _Diffus do obj.material.diffuseMap = undefined
				if _SpecColor do obj.material.specularMap = undefined
				if _SpecLVL do obj.material.specularLevelMap = undefined
				if _Gloss do obj.material.glossinessMap = undefined
				if _SelfIllu do obj.material.selfillumMap = undefined
				if _Opacity do obj.material.opacityMap = undefined
				if _Bump do obj.material.bumpMap = undefined
				if _Reflect do obj.material.reflectionMap = undefined
				if _Refract do obj.material.refractionMap = undefined
				if _Displace do obj.material.displacementMap = undefined
			)
			else if classof obj.material == MultiMaterial do
			(
				for i=1 to obj.material.count do
				(
					if classof obj.material[i] == StandardMaterial do
					(
						if _Ambient do obj.material[i].ambientMap = undefined
						if _Diffus do obj.material[i].diffuseMap = undefined
						if _SpecColor do obj.material[i].specularMap = undefined
						if _SpecLVL do obj.material[i].specularLevelMap = undefined
						if _Gloss do obj.material[i].glossinessMap = undefined
						if _SelfIllu do obj.material[i].selfillumMap = undefined
						if _Opacity do obj.material[i].opacityMap = undefined
						if _Bump do obj.material[i].bumpMap = undefined
						if _Reflect do obj.material[i].reflectionMap = undefined
						if _Refract do obj.material[i].refractionMap = undefined
						if _Displace do obj.material[i].displacementMap = undefined
					)
				)
			)
		)
	)
)
)