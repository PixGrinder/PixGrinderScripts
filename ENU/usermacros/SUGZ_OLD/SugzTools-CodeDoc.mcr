macroScript CodeDoc
				category:"SugzTools"
				toolTip:"Code Documentation "
				Icon:#("SugzTools",8)
			(
				global _doc
				on execute do 
				(
					if _doc == undefined then fileIn "$userScripts\SugzTools\Scripts\Code_Documentation.ms"
					_doc.Run()
				)
				
			)
