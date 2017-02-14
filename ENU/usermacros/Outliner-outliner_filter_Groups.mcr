macroScript outliner_filter_Groups
            category:"Outliner"
            toolTip:"Filter: Groups"
            buttonText:"Filter: Groups"
            icon:#("Outliner_filters", 10) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled());
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled()) AND outliner.getObjectFilter 10;
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           local enabled = not (outliner.getObjectFilter 10);outliner.setObjectFilter 10 enabled;
      )
   )
)