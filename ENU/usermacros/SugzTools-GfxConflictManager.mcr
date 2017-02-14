macroScript GfxConflictManager
			Category: "SugzTools"
			toolTip:"Notice open file as use or unuse"
			Icon:#("SugzTools",3)
			
		(
			global _sgz
			
			on execute do 
			(
				if _sgz != undefined then
				(
					if _sgz._gfxCm.isFileIsNotice 
						then _sgz._gfxCm.NoticeFileAsUnuse()
						else _sgz._gfxCm.NoticeFileAsUse()
				)
			)
			
			on isChecked return if _sgz != undefined 
				then _sgz._gfxCm.isFileIsNotice 
				else false

		)
