macroScript outliner_filter_Particles
            category:"Outliner"
            toolTip:"Filter: Particles"
            buttonText:"Filter: Particles"
            icon:#("Outliner_filters", 8) (
   global outliner;
   global outliner_status;
   
   on isEnabled do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled());
                   
   on isChecked do outliner_status != undefined AND \
                   outliner_status.windowOpen AND \
                   (outliner.getFilterEnabled()) AND outliner.getObjectFilter 8;
      
   on execute do (
      if (outliner != undefined  AND \
         outliner_status != undefined AND \
         outliner_status.windowOpen) do (
           local enabled = not (outliner.getObjectFilter 8);outliner.setObjectFilter 8 enabled;
      )
   )
)