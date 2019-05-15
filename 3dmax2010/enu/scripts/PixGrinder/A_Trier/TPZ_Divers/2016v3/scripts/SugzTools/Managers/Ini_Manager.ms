/*##############################################################################
SugzTools INI Manager
Version 1.00
Script By Clément "Sugz" Plantec
plantec.clement@gmail.com

#Required Components:
SugzTools Manager

#Script infos:
Create or get back default settings

Use this script at your own risk !

Scripts notes:
###############################################################################*/


struct IniManagerStc
(
	/* Main UI  *********************************************************************************************************************************/
	fn MainUi = 
	(
		setIniSetting _sgz._ini "MainUi" "startup" "true"
		setIniSetting _sgz._ini "MainUi" "dockState" "1"
		setIniSetting _sgz._ini "MainUi" "dialogPos" ""
	),
	
	
	/* Common settings *********************************************************************************************************************************/
	fn Common = 
	(
		setIniSetting _sgz._ini "Common" "promptTime" "3"
	),
	
	
	
	/* Gfx Conflict Manager *********************************************************************************************************************************/
	fn GfxCM = 
	(
		setIniSetting _sgz._ini "GfxConflictManager" "svnFolder" ""
		setIniSetting _sgz._ini "GfxConflictManager" "xmlPath" ""
		setIniSetting _sgz._ini "GfxConflictManager" "userName" (toLower (sysInfo.username))
		setIniSetting _sgz._ini "GfxConflictManager" "dialogPos" ""
		setIniSetting _sgz._ini "GfxConflictManager" "update" "true"
		setIniSetting _sgz._ini "GfxConflictManager" "open" "true"
		setIniSetting _sgz._ini "GfxConflictManager" "postOpen" "true"
		setIniSetting _sgz._ini "GfxConflictManager" "newScene" "true"
		setIniSetting _sgz._ini "GfxConflictManager" "reset" "true"
		setIniSetting _sgz._ini "GfxConflictManager" "exitMax" "true"
		setIniSetting _sgz._ini "GfxConflictManager" "save" "true"
	),
	
	/* Call every function to fully create the INI *********************************************************************************************************************************/
	fn CreateIniFn = 
	(
		MainUi()
		Common()
		GfxCM()
	)
	
)
