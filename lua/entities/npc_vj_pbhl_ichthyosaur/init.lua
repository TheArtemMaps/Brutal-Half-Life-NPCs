AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/hl1/icky.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 200
ENT.HullType = HULL_LARGE
ENT.TurningUseAllAxis = true -- If set to true, angles will not be restricted to y-axis, it will change all axes (plural axis)
ENT.MovementType = VJ_MOVETYPE_AQUATIC -- How does the SNPC move?
ENT.Aquatic_SwimmingSpeed_Calm = 80 -- The speed it should swim with, when it's wandering, moving slowly, etc. | Basically walking compared to ground SNPCs
ENT.Aquatic_SwimmingSpeed_Alerted = 500 -- The speed it should swim with, when it's chasing an enemy, moving away quickly, etc. | Basically running compared to ground SNPCs
ENT.Aquatic_AnimTbl_Calm = {ACT_WALK} -- Animations it plays when it's wandering around while idle
ENT.Aquatic_AnimTbl_Alerted = {ACT_RUN} -- Animations it plays when it's moving while alerted
ENT.VJC_Data = {
    ThirdP_Offset = Vector(-25, 0, 0), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(12, 0, 5), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = false, -- Should the bone shrink? Useful if the bone is obscuring the player's view
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_XEN"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_yellow"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Yellow"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDamage = 35
ENT.MeleeAttackDamageType = DMG_ALWAYSGIB -- Type of Damage
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1, ACT_MELEE_ATTACK2} -- Melee Attack Animations
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 50 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 120 -- How far does the damage go?
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {ACT_HOVER, ACT_DIEVIOLENT, ACT_DIESIMPLE} -- Death Animations
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_BIG_FLINCH} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {"vj_hlr/hl1_npc/ichy/ichy_idle1.wav","vj_hlr/hl1_npc/ichy/ichy_idle2.wav","vj_hlr/hl1_npc/ichy/ichy_idle3.wav","vj_hlr/hl1_npc/ichy/ichy_idle4.wav"}
ENT.SoundTbl_Alert = {"vj_hlr/hl1_npc/ichy/ichy_alert1.wav","vj_hlr/hl1_npc/ichy/ichy_alert2.wav","vj_hlr/hl1_npc/ichy/ichy_alert3.wav"}
ENT.SoundTbl_CombatIdle = {"vj_hlr/hl1_npc/ichy/ichy_alert1.wav","vj_hlr/hl1_npc/ichy/ichy_alert2.wav","vj_hlr/hl1_npc/ichy/ichy_alert3.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_hlr/hl1_npc/ichy/ichy_attack1.wav","vj_hlr/hl1_npc/ichy/ichy_attack2.wav"}
ENT.SoundTbl_MeleeAttack = {"vj_hlr/hl1_npc/ichy/ichy_bite1.wav","vj_hlr/hl1_npc/ichy/ichy_bite2.wav"}
ENT.SoundTbl_Pain = {"vj_hlr/hl1_npc/ichy/ichy_pain1.wav","vj_hlr/hl1_npc/ichy/ichy_pain2.wav","vj_hlr/hl1_npc/ichy/ichy_pain3.wav","vj_hlr/hl1_npc/ichy/ichy_pain5.wav"}
ENT.SoundTbl_Death = {"vj_hlr/hl1_npc/ichy/ichy_die1.wav","vj_hlr/hl1_npc/ichy/ichy_die2.wav","vj_hlr/hl1_npc/ichy/ichy_die3.wav","vj_hlr/hl1_npc/ichy/ichy_die4.wav"}

ENT.GeneralSoundPitch1 = 100

-- Custom
ENT.Icky_BlinkingT = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(40, 40 , 60), Vector(-40, -40, 0))
	self.totalDamage = {}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "mm_tasty" then
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
    -- Bleeding on low health
    if self:Health() <= (self:GetMaxHealth() / 2.2) then
        local vPoint = self:GetPos() + Vector(0, 0, 45)
        local canSpawnBlood = false

        if not self.Security_LastBloodSpawn or CurTime() - self.Security_LastBloodSpawn >= 2.5 then
            canSpawnBlood = true
        elseif self:Health() < 10 and not self.Security_LastBloodSpawn or CurTime() - self.Security_LastBloodSpawn >= 1 then
            canSpawnBlood = true
        end

        if canSpawnBlood then
            self.Security_LastBloodSpawn = CurTime()
            local effectdata = EffectData()
            effectdata:SetOrigin(vPoint)
            effectdata:SetNormal(-self:GetUp())
            effectdata:SetMagnitude(0.5)
            effectdata:SetRadius(100)
            effectdata:SetEntity(self)
            util.Effect("dynamic_blood_splatter_effect2", effectdata)
        end
    end

    -- Blinking system
    if not self.Dead and CurTime() > self.Icky_BlinkingT then
        self:SetSkin(4)
        timer.Simple(0.2, function()
            if IsValid(self) then
                self:SetSkin(3)
            end
        end)
        timer.Simple(0.3, function()
            if IsValid(self) then
                self:SetSkin(2)
            end
        end)
        timer.Simple(0.4, function()
            if IsValid(self) then
                self:SetSkin(3)
            end
        end)
        timer.Simple(0.5, function()
            if IsValid(self) then
                if IsValid(self:GetEnemy()) then
                    self:SetSkin(0)
                else
                    self:SetSkin(1)
                end
            end
        end)
        self.Icky_BlinkingT = CurTime() + math.Rand(2, 3.5)
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt)
	-- Increase its health when it deals damage (Up to 2x its max health)
		-- If the enemy is less health than its melee attack, then use the enemy's health as the addition
	self:SetHealth(math.Clamp(self:Health() + ((self.MeleeAttackDamage > hitEnt:Health() and hitEnt:Health()) or self.MeleeAttackDamage), self:Health(), self:GetMaxHealth()*2))
end
---------------------------------------------------------------------------------------------------------------------------------------------
local colorYellow = VJ_Color2Byte(Color(255, 221, 35))
--
function ENT:SetUpGibesOnDeath(dmginfo, hitgroup)
	self.HasDeathSounds = false
	if self.HasGibDeathParticles then
		local effectData = EffectData()
		effectData:SetOrigin(self:GetPos() + self:OBBCenter())
		effectData:SetColor(colorYellow)
		effectData:SetScale(140)
		util.Effect("VJ_Blood1", effectData)
		effectData:SetScale(8)
		effectData:SetFlags(3)
		effectData:SetColor(1)
		util.Effect("bloodspray", effectData)
		util.Effect("bloodspray", effectData)
	end
	        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs19.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(3, 1)
		        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs19.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(2, 1)
		        self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib4.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:SetBodygroup(1, 1)
	    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib3.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})   
	self:SetBodygroup(0, 1)
	self:SetBodygroup(4, 1)
	        
        self:SetBodygroup(7, 1)
		        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs20.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
				self:CreateGibEntity("obj_vj_gib", "models/gib/agibs20.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(5, 1)
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(1,0,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(2,0,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(3,0,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(4,0,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,1,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,2,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,3,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,4,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,5,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(1,1,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(1,2,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(2,1,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(2,2,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(3,2,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib7.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(2,3,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib8.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(1,3,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib9.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(3,1,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib10.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	return true, {DeathAnim=true,AllowCorpse=true} -- Return to true if it gibbed!
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
-- Define a table of collision sound file names
local collisionSounds = {
    "gore/gibsplat.wav",
    "gore/bodysplat.wav"
}

-- Randomly select a sound from the table
local randomSound = collisionSounds[math.random(1, #collisionSounds)]

	VJ_EmitSound(self, randomSound, 90, 100)
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibs = {"models/vj_hlr/gibs/agib1.mdl", "models/vj_hlr/gibs/agib2.mdl", "models/vj_hlr/gibs/agib3.mdl", "models/vj_hlr/gibs/agib4.mdl", "models/vj_hlr/gibs/agib1.mdl", "models/vj_hlr/gibs/agib2.mdl", "models/vj_hlr/gibs/agib3.mdl", "models/vj_hlr/gibs/agib4.mdl"}
--
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	corpseEnt:SetSkin(2)
	VJ_HLR_ApplyCorpseEffects(self, corpseEnt, nil, {ExtraGibs = gibs})
end

function ENT:CustomOnTakeDamage_OnBleed(dmginfo, hitgroup, ply, pos, dir)


    local damageForce = dmginfo:GetDamageForce():Length()
    self.totalDamage[hitgroup] = (self.totalDamage[hitgroup] or 0) + damageForce

    if hitgroup == HITGROUP_LEFTLEG and self.totalDamage[hitgroup] > 35000 then
        if self:GetBodygroup(5) == 1 then
            return
        end
        -- Code for left leg hitgroup
        local effectData = EffectData()
        effectData:SetOrigin(self:GetPos() + self:OBBCenter())
        effectData:SetColor(colorYellow)
        effectData:SetScale(120)
        util.Effect("VJ_Blood1", effectData)
        effectData:SetScale(8)
        effectData:SetFlags(3)
        effectData:SetColor(0)
        util.Effect("bloodspray", effectData)
        util.Effect("bloodspray", effectData)
        VJ_EmitSound(self, "gore/amputation_light" .. math.random(1, 2) .. ".wav", 75, 100)
        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs20.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(5, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_RIGHTLEG and self.totalDamage[hitgroup] > 35000 then
        if self:GetBodygroup(7) == 1 then
            return
        end
        -- Code for right leg hitgroup
        local effectData = EffectData()
        effectData:SetOrigin(self:GetPos() + self:OBBCenter())
        effectData:SetColor(colorYellow)
        effectData:SetScale(120)
        util.Effect("VJ_Blood1", effectData)
        effectData:SetScale(8)
        effectData:SetFlags(3)
        effectData:SetColor(0)
        util.Effect("bloodspray", effectData)
        util.Effect("bloodspray", effectData)
        VJ_EmitSound(self, "gore/amputation_light" .. math.random(1, 2) .. ".wav", 75, 100)
        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs20.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(7, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
elseif hitgroup == HITGROUP_HEAD and self.totalDamage[hitgroup] > 1000 then
    -- Code for head hitgroup
    local effectData = EffectData()
    effectData:SetOrigin(self:GetPos() + self:OBBCenter())
    effectData:SetColor(colorYellow)
    effectData:SetScale(120)
    util.Effect("VJ_Blood1", effectData)
    effectData:SetScale(8)
    effectData:SetFlags(3)
    effectData:SetColor(0)
    util.Effect("bloodspray", effectData)
    util.Effect("bloodspray", effectData)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    VJ_EmitSound(self, "gore/amputation_light" .. math.random(1, 2) .. ".wav", 75, 100)
    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib3.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})   
	self:SetBodygroup(0, 1)
    elseif hitgroup == HITGROUP_STOMACH and self.totalDamage[hitgroup] > 20000 then
        if self:GetBodygroup(1) == 1 then
            return
        end
        -- Code for stomach hitgroup
        local effectData = EffectData()
        effectData:SetOrigin(self:GetPos() + self:OBBCenter())
        effectData:SetColor(colorYellow)
        effectData:SetScale(120)
        util.Effect("VJ_Blood1", effectData)
        effectData:SetScale(8)
        effectData:SetFlags(3)
        effectData:SetColor(0) 
        util.Effect("bloodspray", effectData)
        util.Effect("bloodspray", effectData)
        VJ_EmitSound(self, "gore/amputation_light" .. math.random(1, 2) .. ".wav", 75, 100)
        self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib4.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:SetBodygroup(1, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_LEFTARM and self.totalDamage[hitgroup] > 35000 then
        if self:GetBodygroup(2) == 1 then
            return
        end
        -- Code for left arm hitgroup
        local effectData = EffectData()
        effectData:SetOrigin(self:GetPos() + self:OBBCenter())
        effectData:SetColor(colorYellow)
        effectData:SetScale(120)
        util.Effect("VJ_Blood1", effectData)
        effectData:SetScale(8)
        effectData:SetFlags(3)
        effectData:SetColor(0)
        util.Effect("bloodspray", effectData)
        util.Effect("bloodspray", effectData)
        VJ_EmitSound(self, "gore/amputation_light" .. math.random(1, 2) .. ".wav", 75, 100)
        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs19.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(2, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_RIGHTARM and self.totalDamage[hitgroup] > 35000 then
        if self:GetBodygroup(3) == 1 then
            return
        end
        -- Code for right arm hitgroup
        local effectData = EffectData()
        effectData:SetOrigin(self:GetPos() + self:OBBCenter())
        effectData:SetColor(colorYellow)
        effectData:SetScale(120)
        util.Effect("VJ_Blood1", effectData)
        effectData:SetScale(8)
        effectData:SetFlags(3)
        effectData:SetColor(0)
        util.Effect("bloodspray", effectData)
        util.Effect("bloodspray", effectData)
        VJ_EmitSound(self, "gore/amputation_light" .. math.random(1, 2) .. ".wav", 75, 100)
        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs19.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(3, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
        end		
    end