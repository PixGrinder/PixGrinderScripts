(
local pda ="d:"

pda = getOpenFileName caption:"Select the file to encrypt"  \
--filename:<seed_filename_string> \
types:"MaxScript(*.ms)|*.ms|MacroScript(*.mcr)|*.mcr|" \
--[ historyCategory:<string> ]


encryptScript  pda version:0
)


---------------------------------


