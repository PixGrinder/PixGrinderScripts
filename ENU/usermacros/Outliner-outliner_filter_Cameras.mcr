macroScript outliner_filter_Cameras
            category:"Outliner"
            toolTip:"Filter: Cameras"
            buttonText:"Filter: Cameras"
            icon:#("Outliner_filters", 4) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled());
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled()) AND outliner.getObjectFilter 4;
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           local enabled = not (outliner.getObjectFilter 4);outliner.setObjectFilter 4 enabled;
      )
   )
)