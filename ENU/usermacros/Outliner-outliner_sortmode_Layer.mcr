macroScript outliner_sortmode_Layer
            category:"Outliner"
            toolTip:"SortMode: Layer"
            buttonText:"SortMode: Layer"
            icon:#("Outliner_sortmodes", 3) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   true;
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getSortMode()) == "Layer";
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           outliner.switchSortMode "Layer"
      )
   )
)