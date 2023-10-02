if CLIENT then return end

print("Executing Brutal Half-Life auto replace script...")

-- https://developer.valvesoftware.com/wiki/Half-Life.fgd
-- https://developer.valvesoftware.com/wiki/Half_Life_2.fgd

local replaceTbl_Entities = {
		-- Half-Life 1 --
	["monster_alien_grunt"] = "npc_vj_pbhl_aliengrunt",
	["monster_alien_slave"] = "npc_vj_pbhl_alienslave",
	["monster_bullchicken"] = "npc_vj_pbhl_bullsquid",
	["monster_human_assassin"] = "npc_vj_pbhl_assassin_female",
	["monster_babycrab"] = "npc_vj_pbhl_headcrab_baby",
	["monster_human_grunt"] = {"npc_vj_pbhl_hgrunt","npc_vj_hl1_rpghgrunt","npc_vj_pbhl_sawhgrunt"},
	["monster_houndeye"] = "npc_vj_pbhl_houndeye",
	["monster_scientist"] = "npc_vj_pbhl_scientist",
	["monster_zombie"] = "npc_vj_pbhl_zombie",
	["monster_headcrab"] = "npc_vj_pbhl_headcrab",
	["monster_alien_controller"] = "npc_vj_pbhl_aliencontroller",
	["monster_barney"] = {"npc_vj_hl1_akimbobarney","npc_vj_hl1_deaglebarney","npc_vj_hl1_mp5barney","npc_vj_hl1_mp5otis","npc_vj_hl1_pythonbarney","npc_vj_hl1_pythonotis","npc_vj_hl1_rpgbarney","npc_vj_hl1_rpgotis","npc_vj_hl1_sawbarney","npc_vj_hl1_sawotis","npc_vj_hl1_shotgunbarney","npc_vj_hl1_shotgunotis", "npc_vj_hl1_sniperbarney", "npc_vj_hl1_sniperotis"},
	["monster_barnacle"] = "npc_vj_pbhl_barnacle",
	["monster_ichthyosaur"] = "npc_vj_pbhl_ichthyosaur",
	["monster_sitting_scientist"] = "npc_vj_pbhl_scientist",
}



local function isTable(value)
    return type(value) == "table"
end

hook.Add("OnEntityCreated", "VJ_BHL_AutoReplace_EntCreate", function(ent)
    local class = ent:GetClass()
    local rEnt = replaceTbl_Entities[class]
    if rEnt then
        -- Make sure the game is loaded
        if game and game.GetGlobalState then
            gStatePrecriminal = game.GetGlobalState("gordon_precriminal") == 1
        end
        -- Check if it's HL1 & HL2 and stop if it's not supposed to continue
        local isHL1 = string.StartWith(class, "monster_")
        if isHL1 then
            if GetConVar("vj_bhl_autoreplace_hl1"):GetInt() == 0 then
                return
            end
        end
        timer.Simple(0.01, function()
            if IsValid(ent) then
                local worldName = ent.GetName and ent:GetName() or nil
                local newClass = isTable(rEnt) and table.Random(rEnt) or rEnt
                local newEnt = ents.Create(newClass)
                if not IsValid(newEnt) then
                    MsgN("Entity [" .. newClass .. "] not valid (missing pack?), keeping original entity")
                    return
                end

                newEnt:SetPos(ent:GetPos() + Vector(0, 0, (class == "monster_barnacle" and -1) or 4))
                newEnt:SetAngles(ent:GetAngles())
                if IsValid(ent:GetParent()) then
                    newEnt:SetParent(ent:GetParent())
                end
                if worldName and worldName ~= "" then
                    newEnt:SetName(worldName)
                end
                newEnt:Spawn()
                newEnt:Activate()
                if worldName and worldName ~= "" then
                    newEnt.DisableWandering = true
                end
                local wep = ent.GetActiveWeapon and ent:GetActiveWeapon() or false
                if IsValid(wep) then
                    local foundWep = wep.IsVJBaseWeapon and wep:GetClass() or nil
                    if foundWep then
                        newEnt:Give(foundWep)
                    end
                end
                local ene = ent.GetEnemy and ent:GetEnemy() or false
                if IsValid(ene) then
                    newEnt:SetEnemy(ene)
                end
                for key, val in pairs(ent:GetSaveTable()) do
                    key = tostring(key)
                    if key == "health" then
                        newEnt:SetHealth(val)
                    elseif key == "max_health" then
                        newEnt:SetMaxHealth(val)
                    elseif key == "m_vecLastPosition" then
                        if val ~= defPos then
                            newEnt:SetLastPosition(val)
                            newEnt:VJ_TASK_GOTO_LASTPOS("TASK_WALK_PATH")
                        end
                    elseif key == "m_bShouldPatrol" and val == false then
                        newEnt.DisableWandering = true
                    end
                end
                newEnt:SetKeyValue("spawnflags", ent:GetSpawnFlags())
                if ent:HasSpawnFlags(SF_CITIZEN_NOT_COMMANDABLE) then
                    newEnt.FollowPlayer = false
                end
                if gStatePrecriminal == true then
                    newEnt.DisableWandering = true
                    newEnt.DisableFindEnemy = true
                    newEnt.DisableMakingSelfEnemyToNPCs = true
                    newEnt.FriendsWithAllPlayerAllies = true
                    newEnt.FollowPlayer = false
                    newEnt.Behavior = VJ_BEHAVIOR_PASSIVE
                    newEnt.VJ_AutoScript_OldClass = newEnt.VJ_NPC_Class
                    newEnt.VJ_NPC_Class = {"CLASS_PLAYER_ALLY", "CLASS_COMBINE"}
                    newEnt.VJ_AutoScript_Reset = true
                end
                undo.ReplaceEntity(ent, newEnt)
                ent:Remove()
            end
        end)
    end
end)

hook.Add("Think", "VJ_BHL_AutoReplace_Think", function()
    if game and game.GetGlobalState then
        gStatePrecriminal = game.GetGlobalState("gordon_precriminal") == 1
        gStateAntlionFri = game.GetGlobalState("antlion_allied") == 1
    end
    for _, v in ipairs(ents.GetAll()) do
        if v:IsNPC() then
            if not gStatePrecriminal and v.VJ_AutoScript_Reset then
                v.VJ_NPC_Class = v.VJ_AutoScript_OldClass
                v.VJ_AutoScript_Reset = false
            end
            if gStateAntlionFri and v.VJ_HLR_Antlion then
                table.insert(v.VJ_NPC_Class, "CLASS_PLAYER_ALLY")
                v.PlayerFriendly = true
                v.FriendsWithAllPlayerAllies = true
            end
        end
    end
end)
