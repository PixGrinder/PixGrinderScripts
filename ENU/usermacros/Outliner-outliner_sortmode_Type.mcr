macroScript outliner_sortmode_Type
            category:"Outliner"
            toolTip:"SortMode: Type"
            buttonText:"SortMode: Type"
            icon:#("Outliner_sortmodes", 5) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   true;
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getSortMode()) == "Type";
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           outliner.switchSortMode "Type"
      )
   )
)