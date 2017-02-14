macroScript outliner_filter_Hidden
            category:"Outliner"
            toolTip:"Filter: Hidden"
            buttonText:"Filter: Hidden"
            icon:#("Outliner_filters", 11) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled());
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled()) AND outliner.getObjectFilter 11;
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           local enabled = not (outliner.getObjectFilter 11);outliner.setObjectFilter 11 enabled;
      )
   )
)