AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/hl1/zombie.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 50
ENT.HullType = HULL_HUMAN
ENT.VJC_Data = {
    ThirdP_Offset = Vector(-5, 0, -15), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_yellow"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Yellow"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class with be allied to each other
ENT.CanEat = true -- Should it search and eat organic stuff when idle?

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 50 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 80 -- How far does the damage go?

ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.AnimTbl_Run = {ACT_WALK} -- Set the running animations | Put multiple to let the base pick a random animation when it moves
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
--ENT.DeathAnimationTime = 0.8 -- Time until the SNPC spawns its corpse and gets removed
	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS} -- If it uses normal based animation, use this
ENT.HitGroupFlinching_Values = {
	{HitGroup={HITGROUP_LEFTARM}, Animation={ACT_FLINCH_LEFTARM}},
	{HitGroup={HITGROUP_LEFTLEG}, Animation={ACT_FLINCH_LEFTLEG}},
	{HitGroup={HITGROUP_RIGHTARM}, Animation={ACT_FLINCH_RIGHTARM}},
	{HitGroup={HITGROUP_RIGHTLEG}, Animation={ACT_FLINCH_RIGHTLEG}}
}
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_hlr/pl_step1.wav","vj_hlr/pl_step2.wav","vj_hlr/pl_step3.wav","vj_hlr/pl_step4.wav"}
ENT.SoundTbl_Idle = {"vj_hlr/hl1_npc/zombie/zo_idle1.wav","vj_hlr/hl1_npc/zombie/zo_idle2.wav","vj_hlr/hl1_npc/zombie/zo_idle3.wav","vj_hlr/hl1_npc/zombie/zo_idle4.wav"}
ENT.SoundTbl_Alert = {"vj_hlr/hl1_npc/zombie/zo_alert10.wav","vj_hlr/hl1_npc/zombie/zo_alert20.wav","vj_hlr/hl1_npc/zombie/zo_alert30.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_hlr/hl1_npc/zombie/zo_attack1.wav","vj_hlr/hl1_npc/zombie/zo_attack2.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_hlr/hl1_npc/zombie/claw_strike1.wav","vj_hlr/hl1_npc/zombie/claw_strike2.wav","vj_hlr/hl1_npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_hlr/hl1_npc/zombie/claw_miss1.wav","vj_hlr/hl1_npc/zombie/claw_miss2.wav"}
ENT.SoundTbl_Pain = {"vj_hlr/hl1_npc/zombie/zo_pain1.wav","vj_hlr/hl1_npc/zombie/zo_pain2.wav"}
ENT.SoundTbl_Death = {"vj_hlr/hl1_npc/zombie/zo_pain1.wav","vj_hlr/hl1_npc/zombie/zo_pain2.wav"}

ENT.GeneralSoundPitch1 = 100

-- Custom
ENT.Zombie_Type = 0
	-- 0 = Default / Not Categorized
	-- 1 = Default Zombie Scientist
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
self.totalDamage = {}
	if self:GetModel() == "models/vj_hlr/hl1/zombie.mdl" then
		self.Zombie_Type = 1
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "step" then
		self:FootStepSoundCode()
	elseif key == "melee" then
		self:MeleeAttackCode()
	elseif key == "body" then
		VJ_EmitSound(self, "commonbhl/bodydrop"..math.random(3, 4)..".wav", 75, 100)
	end
end

function ENT:CustomOnThink()
				-- Bleeding on low health
		if self:Health() <= (self:GetMaxHealth() / 2.2) then
			local vPoint = self:GetPos() + Vector(0, 0, 45)
				if not self.Security_LastBloodSpawn or CurTime() - self.Security_LastBloodSpawn >= 2.5 then
					self.Security_LastBloodSpawn = CurTime()
            local effectdata = EffectData()
            effectdata:SetOrigin( vPoint )
            effectdata:SetNormal( -self:GetUp() )
            effectdata:SetMagnitude( 0.5 )
            effectdata:SetRadius( 100 )
            effectdata:SetEntity( self )
			util.Effect("dynamic_blood_splatter_effect2", effectdata)
			-- bleed faster if health is lower than 10
			elseif self:Health() < 10 then
				if not self.Security_LastBloodSpawn or CurTime() - self.Security_LastBloodSpawn >= 1 then
					self.Security_LastBloodSpawn = CurTime()
            local effectdata = EffectData()
            effectdata:SetOrigin( vPoint )
            effectdata:SetNormal( -self:GetUp() )
            effectdata:SetMagnitude( 0.5 )
            effectdata:SetRadius( 100 )
            effectdata:SetEntity( self )
			util.Effect("dynamic_blood_splatter_effect2", effectdata)
				end
			end
		end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	if math.random(1, 2) == 1 then
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.MeleeAttackDamage = 10
	else
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
		self.MeleeAttackDamage = 25
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnFlinch_BeforeFlinch(dmginfo, hitgroup)
	if dmginfo:GetDamage() > 30 then
		self.FlinchChance = 8
		self.AnimTbl_Flinch = {ACT_BIG_FLINCH}
	else
		self.FlinchChance = 16
		self.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS}
	end
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
		effectData:SetScale(120)
		util.Effect("VJ_Blood1", effectData)
		effectData:SetScale(8)
		effectData:SetFlags(3)
		effectData:SetColor(1)
		util.Effect("bloodspray", effectData)
		util.Effect("bloodspray", effectData)
	end
	        self:SetBodygroup(4, 1)
			        self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/zombiegib.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(5, 1)
		    self:CreateGibEntity("obj_vj_gib", "models/gib/agibs1.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})   
	self:SetBodygroup(0, 1)
	        self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib4.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
		self:SetBodygroup(1, 1)
		        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs2.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(2, 1)
		        
        self:SetBodygroup(3, 1)
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,30)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,35)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,50)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,55)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib7.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib8.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,45)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib9.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,25)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib10.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/zombiegib.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	if self.Zombie_Type == 1 then
		self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/zombiegib.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	end
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
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	if hitgroup == HITGROUP_HEAD then
		self.AnimTbl_Death = {ACT_DIE_GUTSHOT, ACT_DIE_HEADSHOT}
	else
		self.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIESIMPLE}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local extraGibs = {"models/vj_hlr/gibs/zombiegib.mdl"}
--
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	VJ_HLR_ApplyCorpseEffects(self, corpseEnt, nil, {ExtraGibs = self.Zombie_Type == 1 and extraGibs or nil})
end


function ENT:CustomOnTakeDamage_OnBleed(dmginfo, hitgroup, ply, pos, dir)
    local damageForce = dmginfo:GetDamageForce():Length()
    self.totalDamage[hitgroup] = (self.totalDamage[hitgroup] or 0) + damageForce

    if hitgroup == HITGROUP_LEFTLEG and self.totalDamage[hitgroup] > 5500 then
        if self:GetBodygroup(4) == 1 then
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
        self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/zombiegib.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(4, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_RIGHTLEG and self.totalDamage[hitgroup] > 5500 then
        if self:GetBodygroup(5) == 1 then
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
        self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/zombiegib.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(5, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
elseif hitgroup == HITGROUP_HEAD and dmginfo:GetDamageForce():Length() > 800 then
        if self:GetBodygroup(0) == 1 then
            return
        end
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
    self:CreateGibEntity("obj_vj_gib", "models/gib/agibs1.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})   
	self:SetBodygroup(0, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_STOMACH and self.totalDamage[hitgroup] > 5500 then
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
    elseif hitgroup == HITGROUP_LEFTARM and self.totalDamage[hitgroup] > 5500 then
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
        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs2.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(2, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_RIGHTARM and self.totalDamage[hitgroup] > 5500 then
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
        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs2.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(3, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
        end		
    end