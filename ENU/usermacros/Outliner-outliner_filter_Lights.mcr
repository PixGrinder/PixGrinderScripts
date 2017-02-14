macroScript outliner_filter_Lights
            category:"Outliner"
            toolTip:"Filter: Lights"
            buttonText:"Filter: Lights"
            icon:#("Outliner_filters", 3) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled());
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled()) AND outliner.getObjectFilter 3;
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           local enabled = not (outliner.getObjectFilter 3);outliner.setObjectFilter 3 enabled;
      )
   )
)