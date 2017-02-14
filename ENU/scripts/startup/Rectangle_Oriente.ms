/* RECTANGLE ORIENTE 
Par Mr. Boumba 
Le 31 Octobre 2004 
*/ 
plugin shape Oriented_Rect 
name:"Rect_Orient" 
classID:#(0x41d209ac, 0x3133dc19) 
extends:rectangle version:1 
category:"Splines" 
( 
tool create 
   ( 
   local startPoint , startpoint2, vec1, L 
  
   on mousePoint click do 
   case click of 
      ( 
      1: startPoint = nodeTM.translation = gridPoint 
      3: #stop 
      ) 
       
   on mouseMove click do 
   case click of 
      ( 
      2: ( 
         L = sqrt (gridDist.x^2 + gridDist.y^2) 
         delegate.length= L 
         delegate.width = 10E-10 
         local beta = acos ( (- gridDist.y/L) * (gridDist.x / abs gridDist.x) ) 
         nodeTM.rotation = eulertoquat (eulerangles 0 0 beta) 
         startpoint2 = nodeTM.translation = startpoint + gridDist/2 
         startpoint2.z = nodeTM.translation.z = startPoint.z 
         vec1 = griddist 
         ) 
      3: ( 
         local mywidth 
         if shiftkey then mywidth = L else mywidth = sqrt (gridDist.x^2 + gridDist.y^2) 
         delegate.width= mywidth 
         local vec2 = normalize (cross vec1 [0,0,1]) 
         local sens = (dot griddist vec2) / abs (dot griddist vec2) 
         nodeTM.translation = startpoint2 +  (0.5*mywidth * vec2 * sens) 
         ) 
      ) 
   ) 
) 
