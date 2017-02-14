macroScript outliner_filter_Geometry
            category:"Outliner"
            toolTip:"Filter: Geometry"
            buttonText:"Filter: Geometry"
            icon:#("Outliner_filters", 1) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled());
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled()) AND outliner.getObjectFilter 1;
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           local enabled = not (outliner.getObjectFilter 1);outliner.setObjectFilter 1 enabled;
      )
   )
)