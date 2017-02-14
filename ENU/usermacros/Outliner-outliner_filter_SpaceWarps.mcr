macroScript outliner_filter_SpaceWarps
            category:"Outliner"
            toolTip:"Filter: SpaceWarps"
            buttonText:"Filter: SpaceWarps"
            icon:#("Outliner_filters", 6) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled());
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled()) AND outliner.getObjectFilter 6;
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           local enabled = not (outliner.getObjectFilter 6);outliner.setObjectFilter 6 enabled;
      )
   )
)