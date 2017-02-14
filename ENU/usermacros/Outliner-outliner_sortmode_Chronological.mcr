macroScript outliner_sortmode_Chronological
            category:"Outliner"
            toolTip:"SortMode: Chronological"
            buttonText:"SortMode: Chronological"
            icon:#("Outliner_sortmodes", 2) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   true;
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getSortMode()) == "Chronological";
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           outliner.switchSortMode "Chronological"
      )
   )
)