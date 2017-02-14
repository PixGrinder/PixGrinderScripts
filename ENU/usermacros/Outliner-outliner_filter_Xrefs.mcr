macroScript outliner_filter_Xrefs
            category:"Outliner"
            toolTip:"Filter: Xrefs"
            buttonText:"Filter: Xrefs"
            icon:#("Outliner_filters", 9) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled());
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled()) AND outliner.getObjectFilter 9;
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           local enabled = not (outliner.getObjectFilter 9);outliner.setObjectFilter 9 enabled;
      )
   )
)