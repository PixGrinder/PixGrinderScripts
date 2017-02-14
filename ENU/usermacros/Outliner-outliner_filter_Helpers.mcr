macroScript outliner_filter_Helpers
            category:"Outliner"
            toolTip:"Filter: Helpers"
            buttonText:"Filter: Helpers"
            icon:#("Outliner_filters", 5) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled());
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled()) AND outliner.getObjectFilter 5;
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           local enabled = not (outliner.getObjectFilter 5);outliner.setObjectFilter 5 enabled;
      )
   )
)