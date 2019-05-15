--$.material = meditMaterials[activeMeditSlot]

-- $.material = meditMaterials[23]


pda_val=100

addModifier $ (UVWMap() ) 
$.modifiers[#UVW_Mapping].maptype = 4
$.modifiers[#UVW_Mapping].length = pda_val
$.modifiers[#UVW_Mapping].width = pda_val
$.modifiers[#UVW_Mapping].height = pda_val
