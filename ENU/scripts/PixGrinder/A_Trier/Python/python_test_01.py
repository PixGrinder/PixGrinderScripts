import MaxPlus

# for node in MaxPlus.SelectionManager.Nodes:
"""
myTab = []
for obj in MaxPlus.SelectionManager.Nodes :
	myTab.append(obj)

for obj in myTab :
	print obj.Name



import MaxPlus
MaxPlus.Inode.Select ('ATA_53-70_Radome_sub1', True)
"""


"""
import MaxPlus

def getselectednodenames():
    for node in MaxPlus.SelectionManager.Nodes:
        print node.Name

def getscenenodenames():
    for node in MaxPlus.Core.GetRootNode().Children:
        print node.Name

if __name__ == '__main__':
    getselectednodenames()
    getscenenodenames()

 """



import MaxPlus

def getGeo():
    for node in MaxPlus.Core.GetRootNode().Children:
        x1 = node.Object.GetClassName()
        print x1, repr(node.Object)
        print isinstance(node, MaxPlus.PolyObject)
        #help(node.Object)

if __name__ == '__main__':
    getGeo()
    x2 = MaxPlus.Core.GetCurrentTime() #Current time in the Timeline
    print x2

for node in MaxPlus.Core.GetRootNode().Children:
    x1 = node.Object


for obj in dir(MaxPlus):
	print obj




for node in MaxPlus.Core.GetRootNode().Children:
    obj = node.GetObject()
    x1 = obj.GetSuperClassID()
    print x1
    #if x1 == MaxPlus.SuperClassIds.GeomObject:
    print (node.Name, x1)



obj = o.GetObject()
if obj.GetSuperClassID() == SuperClassIds.GeomObject