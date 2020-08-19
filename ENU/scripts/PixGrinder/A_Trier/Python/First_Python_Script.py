
#This would be a comment in Python

""" 
This would be a multiline comment
in Python that spans several lines and
describes your code, your day, or anything you want it to
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

# add a modifier to a selection:

import MaxPlus

def addmodifier(nodes):
    for node in nodes:
        mod = MaxPlus.Factory.CreateObjectModifier(MaxPlus.ClassIds.Noisemodifier)
        for param in  mod.ParameterBlock:
            print param.Name
        mod.ParameterBlock.seed.Value = 12345
        node.AddModifier(mod)

if __name__ == '__main__':
    addmodifier(MaxPlus.SelectionManager.Nodes)

"""