AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/hl1/islave.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 60
ENT.HullType = HULL_HUMAN
ENT.VJC_Data = {
	FirstP_Bone = "bip01 head", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(5, 0, 0), -- The offset for the controller when the camera is in first person
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

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1} -- Range Attack Animations
ENT.RangeDistance = 1020 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 100 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 3 -- How much time until it can use a range attack?
ENT.DisableDefaultRangeAttackCode = true -- When true, it won't spawn the range attack entity, allowing you to make your own

ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = "UseRangeDistance" -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = "UseRangeDistance" -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_Type = "OnlyRange" -- "Regular" = Default behavior | "OnlyRange" = Only does it if it's able to range attack
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {ACT_DIEBACKWARD,ACT_DIEFORWARD,ACT_DIESIMPLE} -- Death Animations
ENT.DeathAnimationTime = false -- Time until the SNPC spawns its corpse and gets removed
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_SMALL_FLINCH} -- If it uses normal based animation, use this
ENT.HitGroupFlinching_Values = {{HitGroup = {HITGROUP_LEFTARM}, Animation = {ACT_FLINCH_LEFTARM}},{HitGroup = {HITGROUP_RIGHTARM}, Animation = {ACT_FLINCH_RIGHTARM}},{HitGroup = {HITGROUP_LEFTLEG}, Animation = {ACT_FLINCH_LEFTLEG}},{HitGroup = {HITGROUP_RIGHTLEG}, Animation = {ACT_FLINCH_RIGHTLEG}}}
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_hlr/hl1_npc/aslave/vort_foot1.wav","vj_hlr/hl1_npc/aslave/vort_foot2.wav","vj_hlr/hl1_npc/aslave/vort_foot3.wav","vj_hlr/hl1_npc/aslave/vort_foot4.wav"}
ENT.SoundTbl_Idle = {"vj_hlr/hl1_npc/aslave/slv_idle1.wav","vj_hlr/hl1_npc/aslave/slv_idle2.wav","vj_hlr/hl1_npc/aslave/slv_idle3.wav","vj_hlr/hl1_npc/aslave/slv_idle4.wav","vj_hlr/hl1_npc/aslave/slv_idle5.wav","vj_hlr/hl1_npc/aslave/slv_idle6.wav","vj_hlr/hl1_npc/aslave/slv_idle7.wav","vj_hlr/hl1_npc/aslave/slv_idle8.wav","vj_hlr/hl1_npc/aslave/slv_idle9.wav","vj_hlr/hl1_npc/aslave/slv_idle10.wav"}
ENT.SoundTbl_IdleDialogue = {"vj_hlr/hl1_npc/aslave/slv_idle1.wav","vj_hlr/hl1_npc/aslave/slv_idle2.wav","vj_hlr/hl1_npc/aslave/slv_idle3.wav","vj_hlr/hl1_npc/aslave/slv_idle4.wav","vj_hlr/hl1_npc/aslave/slv_idle5.wav","vj_hlr/hl1_npc/aslave/slv_idle6.wav","vj_hlr/hl1_npc/aslave/slv_idle7.wav","vj_hlr/hl1_npc/aslave/slv_idle8.wav","vj_hlr/hl1_npc/aslave/slv_idle9.wav","vj_hlr/hl1_npc/aslave/slv_idle10.wav"}
ENT.SoundTbl_IdleDialogueAnswer = {"vj_hlr/hl1_npc/aslave/slv_idle1.wav","vj_hlr/hl1_npc/aslave/slv_idle2.wav","vj_hlr/hl1_npc/aslave/slv_idle3.wav","vj_hlr/hl1_npc/aslave/slv_idle4.wav","vj_hlr/hl1_npc/aslave/slv_idle5.wav","vj_hlr/hl1_npc/aslave/slv_idle6.wav","vj_hlr/hl1_npc/aslave/slv_idle7.wav","vj_hlr/hl1_npc/aslave/slv_idle8.wav","vj_hlr/hl1_npc/aslave/slv_idle9.wav","vj_hlr/hl1_npc/aslave/slv_idle10.wav"}
ENT.SoundTbl_Alert = {"vj_hlr/hl1_npc/aslave/slv_alert01.wav","vj_hlr/hl1_npc/aslave/slv_alert02.wav","vj_hlr/hl1_npc/aslave/slv_alert03.wav","vj_hlr/hl1_npc/aslave/slv_alert04.wav","vj_hlr/hl1_npc/aslave/slv_alert05.wav","vj_hlr/hl1_npc/aslave/slv_alert06.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_hlr/hl1_npc/zombie/claw_strike1.wav","vj_hlr/hl1_npc/zombie/claw_strike2.wav","vj_hlr/hl1_npc/zombie/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_hlr/hl1_npc/zombie/claw_miss1.wav","vj_hlr/hl1_npc/zombie/claw_miss2.wav"}
ENT.SoundTbl_BeforeRangeAttack = {"vj_hlr/fx/zap4.wav"}
ENT.SoundTbl_RangeAttack = {"vj_hlr/hl1_npc/hassault/hw_shoot1.wav"}
ENT.SoundTbl_Pain = {"vj_hlr/hl1_npc/aslave/slv_pain1.wav","vj_hlr/hl1_npc/aslave/slv_pain2.wav"}
ENT.SoundTbl_Death = {"vj_hlr/hl1_npc/aslave/slv_die1.wav","vj_hlr/hl1_npc/aslave/slv_die2.wav"}

ENT.FootStepSoundLevel = 60

ENT.GeneralSoundPitch1 = 100
ENT.RangeAttackPitch = VJ_Set(130, 160)

-- CustomBlood_Decal
ENT.Vort_RunAway = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize()
	if GetConVar("vj_hlr_hd"):GetInt() == 1 && VJ.HLR_HD_INSTALLED && self:GetClass() == "npc_vj_hlr1_alienslave" then
		self.Model = "models/vj_hlr/hl_hd/islave.mdl"
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(20, 20, 65), Vector(-20, -20, 0))
	self.totalDamage = {}
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
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "step" then
		self:FootStepSoundCode()
	elseif key == "right" or key == "left" then
		self:MeleeAttackCode()
	elseif key == "shoot" then
		self:RangeAttackCode()
	elseif key == "body" then
		VJ_EmitSound(self, "commonbhl/bodydrop"..math.random(3, 4)..".wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Vort_DoElecEffect(sp, hp, hn, a, t)
	local elec = EffectData()
	elec:SetStart(sp)
	elec:SetOrigin(hp)
	elec:SetNormal(hn)
	elec:SetEntity(self)
	elec:SetAttachment(a)
	elec:SetScale(2.2 - t)
	util.Effect("VJ_HLR_Electric_Charge", elec)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRangeAttack_AfterStartTimer()
	if self.CurrentBeforeRangeAttackSound then self.CurrentBeforeRangeAttackSound:ChangePitch(90 + 90, 1.2) end
	local myPos = self:GetPos()
	-- Tsakh --------------------------
	local tsakhSpawn = myPos + self:GetUp()*45 + self:GetRight()*20
	local tsakhLocations = {
		myPos + self:GetRight()*math.Rand(150, 500) + self:GetUp()*-200,
		myPos + self:GetRight()*math.Rand(150, 500) + self:GetUp()*-200 + self:GetForward()*-math.Rand(150, 500),
		myPos + self:GetRight()*math.Rand(150, 500) + self:GetUp()*-200 + self:GetForward()*math.Rand(150, 500),
		myPos + self:GetRight()*math.Rand(1, 150) + self:GetUp()*200 + self:GetForward()*math.Rand(-100, 100),
	}
	for i = 1, 4 do
		local randt = math.Rand(0, 0.6)
		timer.Simple(randt,function()
			if IsValid(self) then
				local tr = util.TraceLine({
					start = tsakhSpawn,
					endpos = tsakhLocations[i],
					filter = self
				})
				if tr.Hit == true then self:Vort_DoElecEffect(tr.StartPos, tr.HitPos, tr.HitNormal, 1, randt) end
			end
		end)
	end
	-- Ach --------------------------
	local achSpawn = myPos + self:GetUp()*45 + self:GetRight()*-20
	local achLocations = {
		myPos + self:GetRight()*-math.Rand(150, 500) + self:GetUp()*-200,
		myPos + self:GetRight()*-math.Rand(150, 500) + self:GetUp()*-200 + self:GetForward()*-math.Rand(150, 500),
		myPos + self:GetRight()*-math.Rand(150, 500) + self:GetUp()*-200 + self:GetForward()*math.Rand(150, 500),
		myPos + self:GetRight()*-math.Rand(1, 150) + self:GetUp()*200 + self:GetForward()*math.Rand(-100, 100),
	}
	for i = 1, 4 do
		local randt = math.Rand(0, 0.6)
		timer.Simple(randt,function()
			if IsValid(self) then
				local tr = util.TraceLine({
					start = achSpawn,
					endpos = achLocations[i],
					filter = self
				})
				if tr.Hit == true then self:Vort_DoElecEffect(tr.StartPos, tr.HitPos, tr.HitNormal, 1, randt) end
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()
	local startpos = self:GetPos() + self:GetUp()*45 + self:GetForward()*40
	local tr = util.TraceLine({
		start = startpos,
		endpos = self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(),
		filter = self
	})
	local hitpos = tr.HitPos
	
	local elec = EffectData()
	elec:SetStart(startpos)
	elec:SetOrigin(hitpos)
	elec:SetEntity(self)
	elec:SetAttachment(1)
	util.Effect("VJ_HLR_Electric",elec)
	
	elec = EffectData()
	elec:SetStart(startpos)
	elec:SetOrigin(hitpos)
	elec:SetEntity(self)
	elec:SetAttachment(2)
	util.Effect("VJ_HLR_Electric",elec)
	
	util.VJ_SphereDamage(self, self, hitpos, 30, 20, DMG_SHOCK, true, false, {Force=90})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnSchedule()
	if !self.Dead && self.Vort_RunAway == true && !self:IsBusy() && !self.VJ_IsBeingControlled then
		self.Vort_RunAway = false
		self:VJ_TASK_COVER_FROM_ENEMY("TASK_RUN_PATH",function(x) x.RunCode_OnFail = function() self.NextDoAnyAttackT = 0 end end)
		self.NextDoAnyAttackT = CurTime() + 5
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
	if (self.NextDoAnyAttackT + 2) > CurTime() then return end
	self.Vort_RunAway = true
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
        self:SetBodygroup(3, 1)
	        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs16.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(2, 1)
	        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs18.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:SetBodygroup(6, 1)
		self:SetBodygroup(1, 1)
		self:SetBodygroup(5, 1)
		self:SetBodygroup(4, 1)
		self:SetBodygroup(0, 1)
	self:CreateGibEntity("obj_vj_gib", "models/gib/agibs17.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})	
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib1.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})	
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib2.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,20)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})	
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib3.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,30)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})	
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib4.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,35)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})	
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib5.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,50)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})	
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib6.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,55)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})	
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib7.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})	
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib8.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,45)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})	
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib9.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,25)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})	
	self:CreateGibEntity("obj_vj_gib", "models/gib/agibs15.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})   
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/agib10.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})	
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/islavegib.mdl",{BloodType="Yellow",BloodDecal="VJ_HLR_Blood_Yellow",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})	
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
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local extraGibs = {"models/vj_hlr/gibs/islavegib.mdl"}
--
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	VJ_HLR_ApplyCorpseEffects(self, corpseEnt, nil, {ExtraGibs = extraGibs})
end

function ENT:CustomOnTakeDamage_OnBleed(dmginfo, hitgroup, ply, pos, dir)


    local damageForce = dmginfo:GetDamageForce():Length()
    self.totalDamage[hitgroup] = (self.totalDamage[hitgroup] or 0) + damageForce

    if hitgroup == HITGROUP_LEFTLEG and self.totalDamage[hitgroup] > 9500 then
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
        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs17.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(4, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_RIGHTLEG and self.totalDamage[hitgroup] > 9500 then
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
        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs17.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(5, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
elseif hitgroup == HITGROUP_HEAD and self.totalDamage[hitgroup] > 8000 then
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
    self:CreateGibEntity("obj_vj_gib", "models/gib/agibs15.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})   
	self:SetBodygroup(0, 1)
    elseif hitgroup == HITGROUP_STOMACH and self.totalDamage[hitgroup] > 9500 then
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
        self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/agib1.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:SetBodygroup(1, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_GENERIC and self.totalDamage[hitgroup] > 9500 then
        if self:GetBodygroup(6) == 1 then
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
        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs18.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:SetBodygroup(6, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)		
    elseif hitgroup == HITGROUP_LEFTARM and self.totalDamage[hitgroup] > 9500 then
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
        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs16.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(2, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_RIGHTARM and self.totalDamage[hitgroup] > 9500 then
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
        self:CreateGibEntity("obj_vj_gib", "models/gib/agibs16.mdl", { BloodDecal = "VJ_HLR_Blood_Yellow", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(3, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
        end		
    end