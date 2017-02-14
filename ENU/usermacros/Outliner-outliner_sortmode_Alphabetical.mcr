macroScript outliner_sortmode_Alphabetical
            category:"Outliner"
            toolTip:"SortMode: Alphabetical"
            buttonText:"SortMode: Alphabetical"
            icon:#("Outliner_sortmodes", 1) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   true;
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getSortMode()) == "Alphabetical";
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           outliner.switchSortMode "Alphabetical"
      )
   )
)