macroScript outliner_filter_Shapes
            category:"Outliner"
            toolTip:"Filter: Shapes"
            buttonText:"Filter: Shapes"
            icon:#("Outliner_filters", 2) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled());
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled()) AND outliner.getObjectFilter 2;
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           local enabled = not (outliner.getObjectFilter 2);outliner.setObjectFilter 2 enabled;
      )
   )
)