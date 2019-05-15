plugin material RfMaterial name:"rfMaterial"
   classID:#(0x5ab1c788, 0x3611fb18)
   extends:Standard replaceUI:false
( 
   parameters main rollout:params
   (
      CustomMap type:#textureMap ui:setMap
   )
   rollout params "Real Fusio Light Maps Parameters"
   (
      label mapName "Light Map: " across:2
      mapButton setMap "None" width:120
   )
)