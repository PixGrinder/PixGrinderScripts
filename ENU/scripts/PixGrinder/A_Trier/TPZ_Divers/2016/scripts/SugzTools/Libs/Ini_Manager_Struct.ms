/*##############################################################################
SugzTools INI Manager
Version 0.04
Script By Clément "Sugz" Plantec
plantec.clement@gmail.com

Script infos:
Create or get back default settings

Use this script at your own risk !

Scripts notes:
###############################################################################*/


struct IniManagerStruct
(
	/* Main UI ############################################################################################*/
	fn MainUi = 
	(
		setIniSetting _sgz._ini "MainUi" "startup" "true"
		setIniSetting _sgz._ini "MainUi" "dockState" "1"
		setIniSetting _sgz._ini "MainUi" "dialogPos" ""
	),
	
	
	/* AutoSave ############################################################################################*/
	fn AutoSave = 
	(
		setIniSetting _sgz._ini "AutoSave" "toolbar" "false"
		setIniSetting _sgz._ini "AutoSave" "timer" "true"
		setIniSetting _sgz._ini "AutoSave" "enabled" "false"
		setIniSetting _sgz._ini "AutoSave" "overFile" "false"
		setIniSetting _sgz._ini "AutoSave" "incremental" "false"
		setIniSetting _sgz._ini "AutoSave" "sameFolder"  "false"
		setIniSetting _sgz._ini "AutoSave" "fileLinked"  "false"
		setIniSetting _sgz._ini "AutoSave" "number" "3"
		setIniSetting _sgz._ini "AutoSave" "interval" "5.0"
		setIniSetting _sgz._ini "AutoSave" "fileName" "AutoBackup"
		setIniSetting _sgz._ini "AutoSave" "folder" (symbolicPaths.getPathValue "$autoback")
		setIniSetting _sgz._ini "AutoSave" "normalColor" "(color 0 0 100)"
		setIniSetting _sgz._ini "AutoSave" "endColor" "(color 100 0 0)"
		setIniSetting _sgz._ini "AutoSave" "endColorVal" "100"
		setIniSetting _sgz._ini "AutoSave" "blinkSpeed" "2"
		setIniSetting _sgz._ini "AutoSave" "blink" "true"
		setIniSetting _sgz._ini "AutoSave" "messageTime" "3000"
	),
	
	/* Gfx Conflict Manager ############################################################################################*/
	fn GfxCM = 
	(
		setIniSetting _sgz._ini "GfxConflictManager" "svnFolder" ""
		setIniSetting _sgz._ini "GfxConflictManager" "xmlPath" ""
		setIniSetting _sgz._ini "GfxConflictManager" "dialogPos" ""
		setIniSetting _sgz._ini "GfxConflictManager" "update" "true"
		setIniSetting _sgz._ini "GfxConflictManager" "open" "true"
		setIniSetting _sgz._ini "GfxConflictManager" "postOpen" "true"
		setIniSetting _sgz._ini "GfxConflictManager" "newScene" "true"
		setIniSetting _sgz._ini "GfxConflictManager" "reset" "true"
		setIniSetting _sgz._ini "GfxConflictManager" "exitMax" "true"
		setIniSetting _sgz._ini "GfxConflictManager" "save" "true"
	),
	
	/* Call every function to fully create the INI ############################################################################################*/
	fn CreateIniFn = 
	(
		MainUi()
		AutoSave()
		GfxCM()
	)
	
)
