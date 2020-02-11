-- Objects_History.ms --


fn pda_HistoryWriter ev nd =
(
	for obj in selection do	setUserPropBuffer obj ("LastChange = "+ localTime)
)



myCB = NodeEventCallback mouseUp:true geometryChanged:pda_HistoryWriter --enabled:on

-- myCB = NodeEventCallback enabled:on topologyChanged:pda_HistoryWriter()

-- callbackItem = NodeEventCallback modelStructured:pda_HistoryWriter

--callbacks.addScript #postNodeGeneralPropChanged "pda_HistoryWriter()" id:#pda_history

myCB = undefined
gc light:true



/*

<callbackItem>NodeEventCallback [mouseUp:<bool>] [delay:<integer>] [enabled:<bool>] [callbackBegin:<fn>] [all:<fn>] [added:<fn>] [deleted:<fn>] 
[linkChanged:<fn>] [layerChanged:<fn>][groupChanged:<fn>] [hierarchyOtherEvent:<fn>] [modelStructured:<fn>] [geometryChanged:<fn>] [topologyChanged:<fn>] 
[mappingChanged:<fn>] [extentionChannelChanged:<fn>] [modelOtherEvent:<fn>] [materialStructured:<fn>] [materialOtherEvent:<fn>] [controllerStructured:<fn>] 
[controllerOtherEvent:<fn>] [nameChanged:<fn>] [wireColorChanged:<fn>] [renderPropertiesChanged:<fn>] [displayPropertiesChanged:<fn>] [userPropertiesChanged:<fn>] 
[propertiesOtherEvent:<fn>] [subobjectSelectionChanged:<fn>] [selectionChanged:<fn>] [hideChanged:<fn>] [freezeChanged:<fn>] [displayOtherEvent:<fn>] [callbackEnd:<fn>] 	




Callbacks
--------------


callbacks.addScript #preRender "setUpRenderGeom()" id:#jbwRender






modelStructured:



User defined object properties
-------------------------------

https://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_AF1F51D4_449B_4C4D_9F58_85DB145BC0B9_htm

setUserProp <node> <key_string> <value> 

setUserProp selection[1] "Last Change" localTime


Datas to record
---------------
sysInfo.username

localTime


*/