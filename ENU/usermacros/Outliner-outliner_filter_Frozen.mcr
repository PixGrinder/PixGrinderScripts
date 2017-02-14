macroScript outliner_filter_Frozen
            category:"Outliner"
            toolTip:"Filter: Frozen"
            buttonText:"Filter: Frozen"
            icon:#("Outliner_filters", 12) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled());
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled()) AND outliner.getObjectFilter 12;
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           local enabled = not (outliner.getObjectFilter 12);outliner.setObjectFilter 12 enabled;
      )
   )
)