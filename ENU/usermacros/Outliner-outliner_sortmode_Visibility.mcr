macroScript outliner_sortmode_Visibility
            category:"Outliner"
            toolTip:"SortMode: Visibility"
            buttonText:"SortMode: Visibility"
            icon:#("Outliner_sortmodes", 6) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   true;
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getSortMode()) == "Visibility";
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           outliner.switchSortMode "Visibility"
      )
   )
)