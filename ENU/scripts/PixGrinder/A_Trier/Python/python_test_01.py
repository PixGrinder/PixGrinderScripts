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



# Vu avec Guillaume #
#----------------------
for id in dir(MaxPlus.SuperClassIds):
    print id, getattr(MaxPlus.SuperClassIds, id)


"""

from MaxPlus import SuperClassIds
from MaxPlus import SelectionManager

def scene_objects():
   def list_children(node):
      list = []
      for c in node.Children:
         list.append(c)
         list = list + list_children(c)
      return list
   return list_children(MaxPlus.Core.GetRootNode())

for o in scene_objects():
   obj = o.GetObject()
   if obj.GetSuperClassID() == SuperClassIds.Light:
      SelectionManager.SelectNode(o, False)



from MaxPlus import SelectionManager 
SelectionManager.SelectNode(o, False) 
où "o" est ton node (les éléments de MaxPlus.Core.GetRootNode())


en gros, tu iter sur tous les nodes
pour chaque node, tu récupère le nom. ça te permet de faire une équivalence "nom de l'objet 3D" <-> node dans python
ensuite tu manipules le node
 
nodes = {}
for node in MaxPlus.Core.GetRootNode().Children: 
  nodes[node.GetObject().getName()] = node
SelectionManager.SelectNode(nodes["Box001"], False)  

un truc dans ce gout ça doit marcher






"""
