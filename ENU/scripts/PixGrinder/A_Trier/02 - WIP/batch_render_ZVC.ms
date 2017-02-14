pda_zvc=#()

for i=1 to cameras.count do if findstring cameras[i].name "ZVC" != undefined do if findstring cameras[i].name "tgt" == undefined do append pda_zvc cameras[i]

makedir @"d:\\test\\zvc\\"

for i=1 to pda_zvc.count do (
	pda_output="d:\\test\\zvc\\"+pda_zvc[i].name+"_.jpg"
	render frame:902 camera:pda_zvc[i] outputsize:[720,404] renderhiddenobjects:false outputfile:pda_output vfb:false progressbar:true antiAliasing:false quiet:true shadows:false 
)
