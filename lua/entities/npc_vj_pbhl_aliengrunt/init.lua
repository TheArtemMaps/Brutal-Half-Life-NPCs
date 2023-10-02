AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/hl1/agrunt.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 120
ENT.HullType = HULL_HUMAN
ENT.VJC_Data = {
	FirstP_Bone = "bip01 head", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(12, 0, 5), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = false, -- Should the bone shrink? Useful if the bone is obscuring the player's view
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_XEN"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_yellow"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Yellow"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?

ENT.MeleeAttackDamage = 20
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDistance = 40 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 70 -- How far does the damage go?
ENT.CanEat = true
ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.RangeAttackEntityToSpawn = "obj_vj_hlr1_hornet" -- The entity that is spawned when range attacking
ENT.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1} -- Range Attack Animations
ENT.RangeDistance = 1100 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 200 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 0 -- How much time until it can use a range attack?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "hornet" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true

ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = "UseRangeDistance" -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = "UseRangeDistance" -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_Type = "Regular" -- "Regular" = Default behavior | "OnlyRange" = Only does it if it's able to range attack
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_SMALL_FLINCH} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_hlr/hl1_npc/player/pl_ladder1.wav","vj_hlr/hl1_npc/player/pl_ladder2.wav","vj_hlr/hl1_npc/player/pl_ladder3.wav","vj_hlr/hl1_npc/player/pl_ladder4.wav"}
ENT.SoundTbl_Idle = {"vj_hlr/hl1_npc/agrunt/ag_idle1.wav","vj_hlr/hl1_npc/agrunt/ag_idle2.wav","vj_hlr/hl1_npc/agrunt/ag_idle3.wav","vj_hlr/hl1_npc/agrunt/ag_idle4.wav","vj_hlr/hl1_npc/agrunt/ag_idle5.wav"}
ENT.SoundTbl_Alert = {"vj_hlr/hl1_npc/agrunt/ag_alert1.wav","vj_hlr/hl1_npc/agrunt/ag_alert2.wav","vj_hlr/hl1_npc/agrunt/ag_alert3.wav","vj_hlr/hl1_npc/agrunt/ag_alert4.wav","vj_hlr/hl1_npc/agrunt/ag_alert5.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_hlr/hl1_npc/zombie/claw_strike1.wav","vj_hlr/hl1_npc/zombie/claw_strike2.wav","vj_hlr/hl1_npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_hlr/hl1_npc/zombie/claw_miss1.wav","vj_hlr/hl1_npc/zombie/claw_miss2.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"vj_hlr/hl1_npc/agrunt/ag_attack1.wav","vj_hlr/hl1_npc/agrunt/ag_attack2.wav","vj_hlr/hl1_npc/agrunt/ag_attack3.wav"}
ENT.SoundTbl_BeforeRangeAttack = {"vj_hlr/hl1_npc/agrunt/ag_attack1.wav","vj_hlr/hl1_npc/agrunt/ag_attack2.wav","vj_hlr/hl1_npc/agrunt/ag_attack3.wav"}
//ENT.SoundTbl_RangeAttack = {"vj_hlr/hl1_npc/agrunt/ag_fire1.wav","vj_hlr/hl1_npc/agrunt/ag_fire2.wav","vj_hlr/hl1_npc/agrunt/ag_fire3.wav"} -- Done by events instead because we need it as EmitSound since it plays too many of them at the same time!
ENT.SoundTbl_Pain = {"vj_hlr/hl1_npc/agrunt/ag_pain1.wav","vj_hlr/hl1_npc/agrunt/ag_pain2.wav","vj_hlr/hl1_npc/agrunt/ag_pain3.wav","vj_hlr/hl1_npc/agrunt/ag_pain4.wav","vj_hlr/hl1_npc/agrunt/ag_pain5.wav"}
ENT.SoundTbl_Death = {"vj_hlr/hl1_npc/agrunt/ag_die1.wav","vj_hlr/hl1_npc/agrunt/ag_die2.wav","vj_hlr/hl1_npc/agrunt/ag_die3.wav","vj_hlr/hl1_npc/agrunt/ag_die4.wav","vj_hlr/hl1_npc/agrunt/ag_die5.wav"}

ENT.GeneralSoundPitch1 = 100
ENT.FootStepPitch = VJ_Set(70, 70)

-- Custom
ENT.AGrunt_Type = 0
	-- 0 = Original / Default
	-- 1 = Alpha
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize()
	if GetConVar("vj_hlr_hd"):GetInt() == 1 && VJ.HLR_HD_INSTALLED && self:GetClass() == "npc_vj_hlr1_aliengrunt" then
		self.Model = "models/vj_hlr/hl_hd/agrunt.mdl"
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
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(25, 25, 85), Vector(-25, -25, 0))
	self:SetBodygroup(0, 6)
	self:SetBodygroup(8, 1)
	self.totalDamage = {}
	if self.AGrunt_Type == 1 then --Alpha
		self.AnimTbl_Death = {ACT_DIESIMPLE}
	else -- Default
		self.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIESIMPLE}
		self.HitGroupFlinching_Values = {{HitGroup = {HITGROUP_LEFTARM}, Animation = {ACT_FLINCH_LEFTARM}}, {HitGroup = {HITGROUP_RIGHTARM}, Animation = {ACT_FLINCH_RIGHTARM}}, {HitGroup = {HITGROUP_LEFTLEG}, Animation = {ACT_FLINCH_LEFTLEG}}, {HitGroup = {HITGROUP_RIGHTLEG}, Animation = {ACT_FLINCH_RIGHTLEG}}}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "event_emit Step" then
		self:FootStepSoundCode()
	elseif key == "event_mattack" then
		self:MeleeAttackCode()
	elseif key == "event_rattack" then
		self:RangeAttackCode()
		self:PlaySoundSystem("RangeAttack", "vj_hlr/".. (self.AGrunt_Type == 1 and "hla_npc" or "hl1_npc") .."/agrunt/ag_fire"..math.random(1, 3)..".wav", VJ_EmitSound)
	elseif key == "body" then
		VJ_EmitSound(self, "commonbhl/bodydrop"..math.random(3, 4)..".wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode_AfterProjectileSpawn(projectile)
	-- Only default Alien Grunt has a muzzle flash!
	if self.AGrunt_Type == 0 then
		-- ParticleEffect("vj_hl_muz7",self:GetAttachment(self:LookupAttachment("hornet")).Pos, self:GetForward():Angle(), self) -- Unimplemented sprite function, needs fixed
		
		local att = self:GetAttachment(self:LookupAttachment("hornet"))
		local muzzleFlash = ents.Create("env_sprite")
		muzzleFlash:SetKeyValue("model", "vj_hl/sprites/muz4.vmt")
		muzzleFlash:SetKeyValue("scale", tostring(math.Rand(0.5, 0.65)))
		muzzleFlash:SetKeyValue("rendermode", "3")
		muzzleFlash:SetKeyValue("renderfx", "14")
		muzzleFlash:SetKeyValue("renderamt", "255")
		muzzleFlash:SetKeyValue("rendercolor", "255 255 255")
		muzzleFlash:SetKeyValue("spawnflags", "0")
		muzzleFlash:SetParent(self)
		muzzleFlash:SetOwner(self)
		muzzleFlash:SetPos(att.Pos + att.Ang:Forward() * 15)
		muzzleFlash:SetAngles(Angle(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100)))
		muzzleFlash:Spawn()
		muzzleFlash:Fire("Kill","",0.08)
		self:DeleteOnRemove(muzzleFlash)
	end
	
	local ene = self:GetEnemy()
	if IsValid(ene) then
		projectile.Track_Enemy = ene
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vec = Vector(0, 0, 0)
--
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if hitgroup == HITGROUP_GEAR then
		dmginfo:SetDamage(0)
		
		if dmginfo:GetDamagePosition() != vec then
			local rico = EffectData()
			rico:SetOrigin(dmginfo:GetDamagePosition())
			rico:SetScale(4) -- Size
			rico:SetMagnitude(2) -- Effect type | 1 = Animated | 2 = Basic
			util.Effect("VJ_HLR_Rico", rico)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnFlinch_BeforeFlinch(dmginfo, hitgroup)
	if dmginfo:GetDamage() > 30 then
		self.AnimTbl_Flinch = {ACT_BIG_FLINCH}
	else
		self.AnimTbl_Flinch = {ACT_SMALL_FLINCH}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
	-- Chance of dropping an actual hornet gun that the play can pick up
	if math.random(1, 50) == 1 then
		self:SetBodygroup(1, 1)
		local gun = ents.Create("weapon_hornetgun")
		gun:SetPos(self:GetAttachment(self:LookupAttachment("hornet")).Pos)
		gun:SetAngles(self:GetAngles())
		gun:Spawn()
		gun:Activate()
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
	self:SetBodygroup(3, 1)
	self:SetBodygroup(7, 1)
	self:SetBodygroup(2, 1)
	self:SetBodygroup(0, 7)
	self:SetBodygroup(6, 1)
	self:SetBodygroup(5, 1)
	self:CreateGibEntity("obj_vj_gib", "models/gib/agibs24.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gib/agibs25.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gib/agibs23.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gib/agibs22.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,30)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,35)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,10)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,50)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,50)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,55)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib7.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib8.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,45)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib9.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,25)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib10.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agrunt_gib.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,65)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
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
		self.AnimTbl_Death = {ACT_DIE_HEADSHOT}
	elseif hitgroup == HITGROUP_STOMACH then
		self.AnimTbl_Death = {ACT_DIE_GUTSHOT}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local extraGibs = {"models/vj_hlr/gibs/agrunt_gib.mdl","models/vj_hlr/gibs/agib1.mdl","models/vj_hlr/gibs/agib2.mdl","models/vj_hlr/gibs/agib3.mdl","models/vj_hlr/gibs/agib4.mdl"}
--
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	VJ_HLR_ApplyCorpseEffects(self, corpseEnt, nil, {ExtraGibs = extraGibs})
end

function ENT:CustomOnTakeDamage_OnBleed(dmginfo, hitgroup, ply, pos, dir)


    local damageForce = dmginfo:GetDamageForce():Length()
    self.totalDamage[hitgroup] = (self.totalDamage[hitgroup] or 0) + damageForce

    if hitgroup == HITGROUP_LEFTLEG and self.totalDamage[hitgroup] > 9500 then
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
        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs24.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(5, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_RIGHTLEG and self.totalDamage[hitgroup] > 9500 then
        if self:GetBodygroup(6) == 1 then
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
        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs24.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(6, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
elseif hitgroup == HITGROUP_HEAD and self.totalDamage[hitgroup] > 1000 then
        if self:GetBodygroup(0) == 7 then
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
    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib3.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})   
	self:SetBodygroup(0, 7)
    elseif hitgroup == HITGROUP_STOMACH and self.totalDamage[hitgroup] > 9500 then
        if self:GetBodygroup(2) == 1 then
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
        self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib1.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:SetBodygroup(2, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_GENERIC and self.totalDamage[hitgroup] > 9500 then
        if self:GetBodygroup(7) == 1 then
            return
        end
        -- Code for generic hitgroup (small arm)
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
        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs25.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:SetBodygroup(7, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)		
    elseif hitgroup == HITGROUP_LEFTARM and self.totalDamage[hitgroup] > 5500 then
        if self:GetBodygroup(3) == 1 then
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
        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs22.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(3, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_RIGHTARM and self.totalDamage[hitgroup] > 5500 then
        if self:GetBodygroup(4) == 1 then
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
        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs23.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
		self:CreateGibEntity("obj_vj_gib", "models/gib/agibs22.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(4, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
        end		
    end