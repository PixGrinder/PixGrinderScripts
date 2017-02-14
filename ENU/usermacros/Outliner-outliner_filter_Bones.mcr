macroScript outliner_filter_Bones
            category:"Outliner"
            toolTip:"Filter: Bones"
            buttonText:"Filter: Bones"
            icon:#("Outliner_filters", 7) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled());
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled()) AND outliner.getObjectFilter 7;
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           local enabled = not (outliner.getObjectFilter 7);outliner.setObjectFilter 7 enabled;
      )
   )
)