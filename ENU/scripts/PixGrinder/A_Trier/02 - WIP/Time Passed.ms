
t1 = getLocalTime()
sleep 10
t2=getLocalTime()
("Temps écoulé : "+(t2[5]-t1[5]) as string +" h : "+(t2[6]-t1[6]) as string +" mn : "+(abs(t2[7]-t1[7])) as string +" secs")