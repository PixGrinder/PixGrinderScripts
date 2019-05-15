t1 = $Teapot01
t2 = $Teapot02

x1 = t1.position.controller[2] as string
x1 = substituteString x1 "SubAnim:" ""
x1=x1+" ()"

t2.position.controller.available.controller = execute x1
