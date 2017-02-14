macroScript outliner_sortmode_Material
            category:"Outliner"
            toolTip:"SortMode: Material"
            buttonText:"SortMode: Material"
            icon:#("Outliner_sortmodes", 4) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   true;
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getSortMode()) == "Material";
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           outliner.switchSortMode "Material"
      )
   )
)