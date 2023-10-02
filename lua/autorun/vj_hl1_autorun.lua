/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Half-Life 1"
local AddonName = "MP5 Barney SNPC"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_hl1_autorun.lua"
-------------------------------------------------------
BHL = istable( BHL ) and BHL or {}

BHL.VERSION = 3.3
BHL.VERSION_GITHUB = 0
BHL.VERSION_TYPE = ".GIT"
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--local vCat = "Half-Life 1" Obsolete
	local vCat2 = "Brutal Half-Life"
	--VJ.AddCategoryInfo(vCat, {Icon = "temka/icons/hl1.png"}) Obsolete
	VJ.AddCategoryInfo(vCat2, {Icon = "temka/icons/bhl.png"})
	VJ.AddNPC("MP5 Barney","npc_vj_hl1_mp5barney",vCat2)
	VJ.AddNPC("Shotgun Barney","npc_vj_hl1_shotgunbarney",vCat2)
	VJ.AddNPC("M249 SAW Barney","npc_vj_hl1_sawbarney",vCat2)
	VJ.AddNPC("Python Barney","npc_vj_hl1_pythonbarney",vCat2)
	VJ.AddNPC("MP5 Otis","npc_vj_hl1_mp5otis",vCat2)
	VJ.AddNPC("Python Otis","npc_vj_hl1_pythonotis",vCat2)
	VJ.AddNPC("M249 SAW Otis","npc_vj_hl1_sawotis",vCat2)
	VJ.AddNPC("Shotgun Otis","npc_vj_hl1_shotgunotis",vCat2)
	VJ.AddNPC("RPG Barney","npc_vj_hl1_rpgbarney",vCat2)
	VJ.AddNPC("RPG Otis","npc_vj_hl1_rpgotis",vCat2)
	VJ.AddNPC("Deagle Barney","npc_vj_hl1_deaglebarney",vCat2)
	VJ.AddNPC("Dual Pistol Barney","npc_vj_hl1_akimbobarney",vCat2)
	VJ.AddNPC("M40A1 Barney","npc_vj_hl1_sniperbarney",vCat2)
	VJ.AddNPC("M40A1 Otis","npc_vj_hl1_sniperotis",vCat2)
	VJ.AddNPC("RPG Human Grunt","npc_vj_hl1_rpghgrunt",vCat2) --Bonus :)
	-- Project Brutal Half-Life
	VJ.AddNPC("Houndeye","npc_vj_pbhl_houndeye",vCat2)
	VJ.AddNPC("Bullsquid","npc_vj_pbhl_bullsquid",vCat2)
	VJ.AddNPC("Ichthyosaur","npc_vj_pbhl_ichthyosaur",vCat2)
	VJ.AddNPC("Alien Controller","npc_vj_pbhl_aliencontroller",vCat2)
	VJ.AddNPC("Alien Grunt","npc_vj_pbhl_aliengrunt",vCat2)
	VJ.AddNPC("Female Assasin","npc_vj_pbhl_assassin_female",vCat2)
	VJ.AddNPC("Headcrab","npc_vj_pbhl_headcrab",vCat2)
	VJ.AddNPC("Human Grunt","npc_vj_pbhl_hgrunt",vCat2)
	VJ.AddNPC("Scientist","npc_vj_pbhl_scientist",vCat2)
	VJ.AddNPC("Zombie","npc_vj_pbhl_zombie",vCat2)
	VJ.AddNPC("Alien Slave", "npc_vj_pbhl_alienslave", vCat2)
	VJ.AddNPC("Barnacle", "npc_vj_pbhl_barnacle", vCat2)
	VJ.AddNPC("M249 SAW Human Grunt", "npc_vj_pbhl_sawhgrunt", vCat2)
	VJ.AddConVar("vj_hl1_explosives", 1, {FCVAR_ARCHIVE})
	VJ.AddConVar("enable_dismemberment", 1, {FCVAR_ARCHIVE})
	VJ.AddConVar("russian_voice", 0, {FCVAR_ARCHIVE})
	VJ.AddConVar("vj_bhl_autoreplace_hl1", 0, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
	--VJ.AddConVar("vj_pbhl_corpsedismemberment", 0, {FCVAR_ARCHIVE}) --TODO uncomment this if needed (experimental, not finished)
	
if CLIENT then
    hook.Add("PopulateToolMenu", "VJ_ADDTOMENU_HALFLIFE1", function()
        spawnmenu.AddToolMenuOption("DrVrej", "SNPC Configures", "Half-Life 1", "Half-Life 1", "", "", function(Panel)
            Panel:AddControl("Button", { Text = "#vjbase.menu.general.reset.everything", Command = "vj_hl1_explosives 0\nenable_dismemberment 1\nrussian_voice 0\nvj_bhl_autoreplace_hl1 0" })
            Panel:AddControl("Checkbox", { Label = "Disable explosives usage for both Barneys", Command = "vj_hl1_explosives" })
            Panel:ControlHelp("Disable explosives usage for both Barneys. (Grenades and grenade launcher) Warning: only applies to newly created SNPCs!")
            Panel:AddControl("Checkbox", { Label = "Toggle dismemberment system for Barneys", Command = "enable_dismemberment" })
            Panel:ControlHelp("Disables or enables the dismemberment system for Barneys. Enabled by default. Unmark the checkbox to disable. Warning: only applies to newly created SNPCs!")
            Panel:AddControl("Checkbox", { Label = "Включить или отключить русскую озвучку", Command = "russian_voice" })
            Panel:ControlHelp("Включает или отключает русскую озвучку. Выключено по умолчанию. Внимание! Применяется только на новых созданных НПС!")
			--Panel:AddControl("Checkbox", { Label = "Toggle corpse dismemberment", Command = "vj_pbhl_corpsedismemberment" }) --uncomment this if needed (experimental, not finished)
            --Panel:ControlHelp("Toggle corpse dismemberment by disabling ragdoll on death and keeping static corpse (It's the only way)")
            Panel:AddControl("Label", { Text = "Auto Replace script replaces HL1 NPCs with the Brutal Half-Life NPCs! (Including Barneys and Otis's with weapons)" })
            Panel:AddControl("Checkbox", { Label = "Enable Auto Replacement Script", Command = "vj_bhl_autoreplace_hl1" })
            Panel:AddControl("Button", { Text = "Check for updates", Command =  BHL.CheckUpdates() }) 
		end)
    end)
end


-- If enabled during startup, then just run it!
if GetConVar("vj_bhl_autoreplace_hl1"):GetInt() == 1 then
	include("bhl/autoreplace.lua")
end
-- Detect changes to the convar...
cvars.AddChangeCallback("vj_bhl_autoreplace_hl1", function(convar_name, value_old, value_new)
    if value_new == "1" then
		include("autorun/bhl/autoreplace.lua")
	else
		hook.Remove("OnEntityCreated", "VJ_BHL_AutoReplace_EntCreate")
		hook.Remove("Think", "VJ_BHL_AutoReplace_Think")
	end
end)

function BHL:GetVersion()
	return BHL.VERSION
end

function BHL:CheckUpdates()
	http.Fetch("https://raw.githubusercontent.com/TheArtemMaps/Brutal-Half-Life-NPCs/main/lua/autorun/vj_hl1_autorun.lua", function(contents,size) 
		local Entry = string.match( contents, "BHL.VERSION%s=%s%d+" )

		if Entry then
			BHL.VERSION_GITHUB = tonumber( string.match( Entry , "%d+" ) ) or 0
		end

		if BHL.VERSION_GITHUB == 0 then
			print("[Brutal Half-Life NPCs] latest version could not be detected, You have Version: "..BHL:GetVersion())
		else
			if BHL:GetVersion() >= BHL.VERSION_GITHUB then
				print("[Brutal Half-Life NPCs] is up to date, Version: "..BHL:GetVersion())
			else
				print("[Brutal Half-Life NPCs] a newer version is available! Version: "..BHL.VERSION_GITHUB..", You have Version: "..BHL:GetVersion())
				print("[Brutal Half-Life NPCs] get the latest version at https://github.com/Blu-x92/BHL_base")

				if CLIENT then 
					timer.Simple(18, function() 
						chat.AddText( Color( 255, 0, 0 ), "[Brutal Half-Life NPCs] a newer version is available!" )
					end)
				end
			end
		end
	end)
end

hook.Add( "InitPostEntity", "!!!bhlcheckupdates", function()
	timer.Simple(20, function() BHL.CheckUpdates() end)
end )
-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if CLIENT then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if CLIENT then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end

				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end
