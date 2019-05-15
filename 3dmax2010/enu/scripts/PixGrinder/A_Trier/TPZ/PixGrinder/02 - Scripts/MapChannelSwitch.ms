pda = getCurrentSelection()

for i = 1 to pda.count do
(
	select pda[i]
	ChannelInfo.CopyChannel pda[i] 3 3
	ChannelInfo.PasteChannel pda[i] 3 1
	collapseStack pda[i]
)