AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/hl1/sawhgrunt.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 90
ENT.HullType = HULL_HUMAN
ENT.VJC_Data = {
    ThirdP_Offset = Vector(10, 0, -30), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(4, 0, 0), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_UNITED_STATES"} -- NPCs with the same class with be allied to each other
ENT.FriendsWithAllPlayerAllies = true -- Should this SNPC be friends with all other player allies that are running on VJ Base?
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
ENT.Weapon_NoSpawnMenu = true -- If set to true, the NPC weapon setting in the spawnmenu will not be applied for this SNPC
ENT.DisableWeaponFiringGesture = true -- If set to true, it will disable the weapon firing gestures
ENT.MoveRandomlyWhenShooting = false -- Should it move randomly when shooting?
ENT.HasCallForHelpAnimation = true -- if true, it will play the call for help animation
ENT.AnimTbl_ShootWhileMovingRun = {ACT_RUN} -- Animations it will play when shooting while running | NOTE: Weapon may translate the animation that they see fit!
ENT.AnimTbl_ShootWhileMovingWalk = {ACT_RUN} -- Animations it will play when shooting while walking | NOTE: Weapon may translate the animation that they see fit!
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Walk = {ACT_RANGE_ATTACK_SMG2}
ENT.AnimTbl_Run = {ACT_RANGE_ATTACK_SMG1_LOW}
ENT.AnimTbl_IdleStand = {ACT_RANGE_ATTACK_SMG1}
ENT.AnimTbl_ShootWhileMovingRun = {ACT_SPRINT} -- Animations it will play when shooting while running | NOTE: Weapon may translate the animation that they see fit!
ENT.AnimTbl_ShootWhileMovingWalk = {ACT_SPRINT} -- Animations it will play when shooting while walking | NOTE: Weapon may translate the animation that they see fit!
ENT.AnimTbl_CallForHelp = {ACT_SIGNAL1} -- Call For Help Animations
ENT.CallForBackUpOnDamageAnimation = {ACT_SIGNAL3} -- Animation used if the SNPC does the CallForBackUpOnDamage function
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.AnimTbl_TakingCover = {ACT_CROUCHIDLE} -- The animation it plays when hiding in a covered position, leave empty to let the base decide
ENT.AnimTbl_AlertFriendsOnDeath = {"vjseq_idle2"} -- Animations it plays when an ally dies that also has AlertFriendsOnDeath set to true
ENT.HasLostWeaponSightAnimation = true -- Set to true if you would like the SNPC to play a different animation when it has lost sight of the enemy and can't fire at it
ENT.BecomeEnemyToPlayer = true -- Should the friendly SNPC become enemy towards the player if it's damaged by a player?
ENT.HasItemDropsOnDeath = false -- Should it drop items on death?
ENT.HasOnPlayerSight = true -- Should do something when it sees the enemy? Example: Play a sound
ENT.CombatFaceEnemy = false -- If enemy is exists and is visible
ENT.HasMeleeAttackSounds = true -- If set to false, it won't play the melee attack sound
ENT.HasMeleeAttackMissSounds = true -- If set to false, it won't play the melee attack miss sound
ENT.HasGrenadeAttack = true -- Should the SNPC have a grenade attack?
ENT.GrenadeAttackEntity = "obj_vj_hlr1_grenade" -- The entity that the SNPC throws | Half Life 2 Grenade: "npc_grenade_frag"
ENT.AnimTbl_GrenadeAttack = {ACT_SPECIAL_ATTACK2} -- Grenade Attack Animations
ENT.GrenadeAttackAttachment = "lhand" -- The attachment that the grenade will spawn at
ENT.TimeUntilGrenadeIsReleased = 1.3 -- Time until the grenade is released
ENT.NextThrowGrenadeTime = VJ_Set(10, 12) -- Time until it can throw a grenade again
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ Melee Attack Variables ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDamage = 10
ENT.MeleeAttackDamageType = DMG_CLUB -- Type of Damage
ENT.HasMeleeAttackKnockBack = true -- Should knockback be applied on melee hit? | Use self:MeleeAttackKnockbackVelocity() to edit the velocity
	-- ====== Animation Variables ====== --
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.MeleeAttackAnimationFaceEnemy = true -- Should it face the enemy while playing the melee attack animation?
ENT.MeleeAttackAnimationDecreaseLengthAmount = 0 -- This will decrease the time until starts chasing again. Use it to fix animation pauses until it chases the enemy.
ENT.MeleeAttackAnimationAllowOtherTasks = false -- If set to true, the animation will not stop other tasks from playing, such as chasing | Useful for gesture attacks!
	-- ====== Distance Variables ====== --
ENT.MeleeAttackDistance = 30 -- How close does it have to be until it attacks?
ENT.MeleeAttackAngleRadius = 100 -- What is the attack angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
ENT.MeleeAttackDamageDistance = 80 -- How far does the damage go?
ENT.MeleeAttackDamageAngleRadius = 100 -- What is the damage angle radius? | 100 = In front of the SNPC | 180 = All around the SNPC
	-- ====== Timer Variables ====== --
	-- To use event-based attacks, set this to false:
ENT.TimeUntilMeleeAttackDamage = 0.6 -- This counted in seconds | This calculates the time until it hits something
ENT.NextMeleeAttackTime = 0 -- How much time until it can use a melee attack?
ENT.NextMeleeAttackTime_DoRand = false -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
	-- To let the base automatically detect the attack duration, set this to false:
ENT.NextAnyAttackTime_Melee = false -- How much time until it can use any attack again? | Counted in Seconds
ENT.NextAnyAttackTime_Melee_DoRand = false -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
ENT.MeleeAttackReps = 1 -- How many times does it run the melee attack code?
ENT.MeleeAttackExtraTimers = nil -- Extra melee attack timers, EX: {1, 1.4} | it will run the damage code after the given amount of seconds
ENT.StopMeleeAttackAfterFirstHit = false -- Should it stop the melee attack from running rest of timers when it hits an enemy?
	-- ====== Control Variables ====== --
ENT.DisableMeleeAttackAnimation = false -- if true, it will disable the animation code
ENT.DisableDefaultMeleeAttackCode = false -- When set to true, it will completely disable the melee attack code
ENT.DisableDefaultMeleeAttackDamageCode = false -- Disables the default melee attack damage code

	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_SMALL_FLINCH} -- If it uses normal based animation, use this
ENT.HitGroupFlinching_Values = {{HitGroup = {HITGROUP_LEFTARM}, Animation = {ACT_FLINCH_LEFTARM}},{HitGroup = {HITGROUP_RIGHTARM}, Animation = {ACT_FLINCH_RIGHTARM}},{HitGroup = {HITGROUP_LEFTLEG}, Animation = {ACT_FLINCH_LEFTLEG}},{HitGroup = {HITGROUP_RIGHTLEG}, Animation = {ACT_FLINCH_RIGHTLEG}}}
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.GeneralSoundPitch1 = 100

-- Custom
ENT.Security_NextMouthMove = 0
ENT.Security_NextMouthDistance = 0
ENT.Security_SwitchedIdle = false
ENT.Security_Type = 0
	-- 0 = Security Guard (MP5)
	-- 1 = Otis
	-- 2 = Alpha Security Guard
ENT.Security_CanHurtWalk = true -- Set to false to disable hurt-walking.
ENT.NoWeapon_UseScaredBehavior = true -- Should it use the scared behavior when it sees an enemy and doesn't have a weapon?
ENT.AnimTbl_ScaredBehaviorStand = {ACT_COWER}-- Animations it will play while scared and standing | Replaces the idle stand animation | DEFAULT: {ACT_COWER}
ENT.AnimTbl_ScaredBehaviorMovement = nil -- Animations it will play while scared and moving | Leave empty for the base to decide the animation
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Security_CustomOnInitialize()
	self.SoundTbl_Idle = {"vj_hlr/hl1_npc/hgrunt/gr_alert1.wav","vj_hlr/hl1_npc/hgrunt/gr_idle1.wav","vj_hlr/hl1_npc/hgrunt/gr_idle2.wav","vj_hlr/hl1_npc/hgrunt/gr_idle3.wav"}
	self.SoundTbl_IdleDialogue = {"vj_hlr/hl1_npc/hgrunt/gr_question1.wav","vj_hlr/hl1_npc/hgrunt/gr_question2.wav","vj_hlr/hl1_npc/hgrunt/gr_question3.wav","vj_hlr/hl1_npc/hgrunt/gr_question4.wav","vj_hlr/hl1_npc/hgrunt/gr_question5.wav","vj_hlr/hl1_npc/hgrunt/gr_question6.wav","vj_hlr/hl1_npc/hgrunt/gr_question7.wav","vj_hlr/hl1_npc/hgrunt/gr_question8.wav","vj_hlr/hl1_npc/hgrunt/gr_question9.wav","vj_hlr/hl1_npc/hgrunt/gr_question10.wav","vj_hlr/hl1_npc/hgrunt/gr_question11.wav","vj_hlr/hl1_npc/hgrunt/gr_question12.wav","vj_hlr/hl1_npc/hgrunt/gr_check1.wav","vj_hlr/hl1_npc/hgrunt/gr_check2.wav","vj_hlr/hl1_npc/hgrunt/gr_check3.wav","vj_hlr/hl1_npc/hgrunt/gr_check4.wav","vj_hlr/hl1_npc/hgrunt/gr_check5.wav","vj_hlr/hl1_npc/hgrunt/gr_check6.wav","vj_hlr/hl1_npc/hgrunt/gr_check7.wav","vj_hlr/hl1_npc/hgrunt/gr_check8.wav",}
	self.SoundTbl_IdleDialogueAnswer = {"vj_hlr/hl1_npc/hgrunt/gr_clear1.wav","vj_hlr/hl1_npc/hgrunt/gr_clear2.wav","vj_hlr/hl1_npc/hgrunt/gr_clear3.wav","vj_hlr/hl1_npc/hgrunt/gr_clear4.wav","vj_hlr/hl1_npc/hgrunt/gr_clear5.wav","vj_hlr/hl1_npc/hgrunt/gr_clear6.wav","vj_hlr/hl1_npc/hgrunt/gr_clear7.wav","vj_hlr/hl1_npc/hgrunt/gr_clear8.wav","vj_hlr/hl1_npc/hgrunt/gr_clear9.wav","vj_hlr/hl1_npc/hgrunt/gr_clear10.wav","vj_hlr/hl1_npc/hgrunt/gr_clear11.wav","vj_hlr/hl1_npc/hgrunt/gr_clear12.wav","vj_hlr/hl1_npc/hgrunt/gr_answer1.wav","vj_hlr/hl1_npc/hgrunt/gr_answer2.wav","vj_hlr/hl1_npc/hgrunt/gr_answer3.wav","vj_hlr/hl1_npc/hgrunt/gr_answer4.wav","vj_hlr/hl1_npc/hgrunt/gr_answer5.wav","vj_hlr/hl1_npc/hgrunt/gr_answer6.wav","vj_hlr/hl1_npc/hgrunt/gr_answer7.wav"}
	self.SoundTbl_CombatIdle = {"vj_hlr/hl1_npc/hgrunt/gr_taunt1.wav","vj_hlr/hl1_npc/hgrunt/gr_taunt2.wav","vj_hlr/hl1_npc/hgrunt/gr_taunt3.wav","vj_hlr/hl1_npc/hgrunt/gr_taunt4.wav","vj_hlr/hl1_npc/hgrunt/gr_taunt5.wav","vj_hlr/hl1_npc/hgrunt/gr_combat1.wav","vj_hlr/hl1_npc/hgrunt/gr_combat2.wav","vj_hlr/hl1_npc/hgrunt/gr_combat3.wav","vj_hlr/hl1_npc/hgrunt/gr_combat4.wav"}
	self.SoundTbl_OnReceiveOrder = {"vj_hlr/hl1_npc/hgrunt/gr_answer1.wav","vj_hlr/hl1_npc/hgrunt/gr_answer2.wav","vj_hlr/hl1_npc/hgrunt/gr_answer3.wav","vj_hlr/hl1_npc/hgrunt/gr_answer5.wav","vj_hlr/hl1_npc/hgrunt/gr_answer7.wav"}
	self.SoundTbl_Investigate = {"vj_hlr/hl1_npc/hgrunt/gr_investigate.wav"}
	self.SoundTbl_Alert = {"vj_hlr/hl1_npc/hgrunt/gr_alert3.wav","vj_hlr/hl1_npc/hgrunt/gr_alert4.wav","vj_hlr/hl1_npc/hgrunt/gr_alert6.wav","vj_hlr/hl1_npc/hgrunt/gr_alert7.wav","vj_hlr/hl1_npc/hgrunt/gr_alert8.wav"}
	self.SoundTbl_CallForHelp = {"vj_hlr/hl1_npc/hgrunt/gr_taunt6.wav","vj_hlr/hl1_npc/hgrunt/gr_cover2.wav","vj_hlr/hl1_npc/hgrunt/gr_cover3.wav","vj_hlr/hl1_npc/hgrunt/gr_cover4.wav","vj_hlr/hl1_npc/hgrunt/gr_cover7.wav"}
	self.SoundTbl_WeaponReload = {"vj_hlr/hl1_npc/hgrunt/gr_cover1.wav","vj_hlr/hl1_npc/hgrunt/gr_cover2.wav","vj_hlr/hl1_npc/hgrunt/gr_cover3.wav","vj_hlr/hl1_npc/hgrunt/gr_cover4.wav","vj_hlr/hl1_npc/hgrunt/gr_cover5.wav","vj_hlr/hl1_npc/hgrunt/gr_cover6.wav","vj_hlr/hl1_npc/hgrunt/gr_cover7.wav","vj_hlr/hl1_npc/hgrunt/gr_cover8.wav","vj_hlr/hl1_npc/hgrunt/gr_cover9.wav"}
	self.SoundTbl_GrenadeAttack = {"vj_hlr/hl1_npc/hgrunt/gr_throw1.wav","vj_hlr/hl1_npc/hgrunt/gr_throw2.wav","vj_hlr/hl1_npc/hgrunt/gr_throw3.wav","vj_hlr/hl1_npc/hgrunt/gr_throw4.wav"}
	self.SoundTbl_OnGrenadeSight = {"vj_hlr/hl1_npc/hgrunt/gr_cover1.wav","vj_hlr/hl1_npc/hgrunt/gr_cover7.wav","vj_hlr/hl1_npc/hgrunt/gr_grenadealert1.wav","vj_hlr/hl1_npc/hgrunt/gr_grenadealert2.wav","vj_hlr/hl1_npc/hgrunt/gr_grenadealert3.wav","vj_hlr/hl1_npc/hgrunt/gr_grenadealert4.wav","vj_hlr/hl1_npc/hgrunt/gr_grenadealert5.wav","vj_hlr/hl1_npc/hgrunt/gr_grenadealert6.wav"}
	self.SoundTbl_OnDangerSight = {"vj_hlr/hl1_npc/hgrunt/gr_cover1.wav","vj_hlr/hl1_npc/hgrunt/gr_cover7.wav","vj_hlr/hl1_npc/hgrunt/gr_grenadealert2.wav","vj_hlr/hl1_npc/hgrunt/gr_grenadealert3.wav","vj_hlr/hl1_npc/hgrunt/gr_grenadealert4.wav","vj_hlr/hl1_npc/hgrunt/gr_grenadealert5.wav","vj_hlr/hl1_npc/hgrunt/gr_grenadealert6.wav"}
	self.SoundTbl_AllyDeath = {"vj_hlr/hl1_npc/hgrunt/gr_allydeath.wav","vj_hlr/hl1_npc/hgrunt/gr_cover2.wav","vj_hlr/hl1_npc/hgrunt/gr_cover3.wav","vj_hlr/hl1_npc/hgrunt/gr_cover4.wav","vj_hlr/hl1_npc/hgrunt/gr_cover7.wav"}
	self:SetBodygroup( 2 , 0 )
        -- Randomize the bodygroups in subgroup 1
        local iBodygroupRNGZero = math.random( 1 , 3 )
        self:SetBodygroup( 1 , iBodygroupRNGZero )
        if iBodygroupRNGZero == 3 then
		self:SetSkin(1)
	end
self.SoundTbl_Pain = {
	"vj_hlr/hl1_npc/hgrunt/gr_pain1.wav",
	"vj_hlr/hl1_npc/hgrunt/gr_pain2.wav",
	"vj_hlr/hl1_npc/hgrunt/gr_pain3.wav",
	"vj_hlr/hl1_npc/hgrunt/gr_pain4.wav",
	"vj_hlr/hl1_npc/hgrunt/gr_pain5.wav"
}

		self.SoundTbl_FootStep = {
"commonbhl/npc_step1.wav",
"commonbhl/npc_step2.wav",
"commonbhl/npc_step3.wav",
"commonbhl/npc_step4.wav"
}

self.SoundTbl_Death = {
	"vj_hlr/hl1_npc/hgrunt/gr_die1.wav",
	"vj_hlr/hl1_npc/hgrunt/gr_die2.wav",
	"vj_hlr/hl1_npc/hgrunt/gr_die3.wav"
}

self.SoundTbl_MeleeAttack = {"npc/zombie/claw_strike1.wav","npc/zombie/claw_strike2.wav","npc/zombie/claw_strike3.wav"}
self.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav","npc/zombie/claw_miss2.wav"}
	self.AnimTbl_Death = {ACT_DIEBACKWARD,ACT_DIEFORWARD,ACT_DIE_GUTSHOT,ACT_DIE_HEADSHOT,ACT_DIESIMPLE} -- Death Animations
	
	self:Give("weapon_vj_hlrof_m249barn")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
    self:SetCollisionBounds(Vector(13, 13, 76), Vector(-13, -13, 0))
    self:SetBodygroup(2, 1)
    self:SetWeaponState(VJ_WEP_STATE_READY)

    if self:GetModel() == "models/hl1/barney.mdl" then -- Already the default
        self.Security_Type = 0
    elseif self:GetModel() == "models/vj_hlr/opfor/otis.mdl" then
        self.Security_Type = 1
    elseif self:GetModel() == "models/vj_hlr/hla/barney.mdl" then
        self.Security_Type = 2
    end
    self:Security_CustomOnInitialize()
end

function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "step" then
		self:FootStepSoundCode()
    elseif key == "shoot" then
        local wep = self:GetActiveWeapon()
        if IsValid(wep) then
            wep:NPCShoot_Primary()
        end
    elseif key == "body" then
        VJ_EmitSound(self, "commonbhl/bodydrop" .. math.random(3, 4) .. ".wav", 75, 100)
		elseif key == "holstersound" then
	VJ_EmitSound(self, "items/gunpickup3.wav", 75, 100)
	elseif key == "draw1" then 
	VJ_EmitSound(self, "items/gunpickup1.wav", 75, 100)
	elseif key == "draw2" then
	VJ_EmitSound(self, "items/clipinsert1.wav", 75, 100)	
    end
end

function ENT:CustomOnThink()
    if self.Security_Type ~= 2 then -- If it's regular or Otis...
        -- Mouth movement
        if CurTime() < self.Security_NextMouthMove then
            if self.Security_NextMouthDistance == 0 then
                self.Security_NextMouthDistance = math.random(10, 70)
            else
                self.Security_NextMouthDistance = 0
            end
            self:SetPoseParameter("m", self.Security_NextMouthDistance)
        else
            self:SetPoseParameter("m", 0)
        end
		
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

        -- Hurt Walking
        if self.Security_CanHurtWalk and self:Health() <= (self:GetMaxHealth() / 2.2) then
            if not self.Security_UsingHurtWalk then
                self.AnimTbl_Walk = {ACT_WALK_HURT}
                self.AnimTbl_Run = {ACT_RUN_HURT}
                self.AnimTbl_ShootWhileMovingWalk = {ACT_WALK_HURT}
                self.AnimTbl_ShootWhileMovingRun = {ACT_RUN_HURT}
                self.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED}
                self.Security_UsingHurtWalk = true
            end
        elseif self.Security_UsingHurtWalk then
            self.AnimTbl_Walk = {ACT_WALK}
            self.AnimTbl_Run = {ACT_RUN}
            self.AnimTbl_IdleStand = {ACT_IDLE}
            self.AnimTbl_ShootWhileMovingWalk = {ACT_WALK}
            self.AnimTbl_ShootWhileMovingRun = {ACT_RUN}
            self.Security_UsingHurtWalk = false
        end
    end
end

function ENT:CustomOnTakeDamage_AfterDamage(dmgInfo, hitgroup)
    if dmgInfo:IsExplosionDamage() then
        local animations = { "cower", "kicked" }
        local randomAnimation = animations[math.random(1, #animations)]
        self:VJ_ACT_PLAYACTIVITY(randomAnimation, true, false, true)
    end
end

function ENT:OnPlayCreateSound(sdData, sdFile)
    self.Security_NextMouthMove = CurTime() + SoundDuration(sdFile)
end

function ENT:CustomOnAlert(ent)
    if self.VJ_IsBeingControlled then return end

    if math.random(1, 2) == 1 then
        if self.Security_Type == 0 then
            if ent:GetClass() == "npc_vj_hlr1_bullsquid" then
                self:PlaySoundSystem("Alert", { "vj_hlr/hl1_npc/hgrunt/gr_alert1.wav" })
                self.NextAlertSoundT = CurTime() + math.Rand(self.NextSoundTime_Alert.a, self.NextSoundTime_Alert.b)
            elseif ent.IsVJBaseSNPC_Creature == true then
                self:PlaySoundSystem("Alert", { "vj_hlr/hl1_npc/hgrunt/gr_alert1.wav" })
                self.NextAlertSoundT = CurTime() + math.Rand(self.NextSoundTime_Alert.a, self.NextSoundTime_Alert.b)
            end
        elseif self.Security_Type == 1 and ent.IsVJBaseSNPC_Creature == true then
            self:PlaySoundSystem("Alert", { "rpggrunt/alien!.wav" })
            self.NextAlertSoundT = CurTime() + math.Rand(self.NextSoundTime_Alert.a, self.NextSoundTime_Alert.b)
        end
    end
end

local vec = Vector(0, 0, 0)

function ENT:CustomOnTakeDamage_BeforeImmuneChecks(dmginfo, hitgroup)
    -- Make a metal effect when the helmet is hit!
    self.Bleeds = true
    if self.Security_Type == 1 then return end -- Only types that do have a helmet
    if hitgroup == HITGROUP_GEAR and dmginfo:GetDamagePosition() ~= vec then
        self.Bleeds = false -- disable bleeding temporarily when shot at the helmet
        local rico = EffectData()
        rico:SetOrigin(dmginfo:GetDamagePosition())
        rico:SetScale(4) -- Size
        rico:SetMagnitude(math.random(1, 2)) -- Effect type | 1 = Animated | 2 = Basic
        util.Effect("VJ_HLR_Rico", rico)
    end
end

local colorRed = VJ_Color2Byte(Color(130, 19, 10))

function ENT:SetUpGibesOnDeath(dmginfo, hitgroup)
    self.HasDeathSounds = false
    if self.HasGibDeathParticles == true then
        local effectData = EffectData()
        effectData:SetOrigin(self:GetPos() + self:OBBCenter())
        effectData:SetColor(colorRed)
        effectData:SetScale(120)
        util.Effect("VJ_Blood1", effectData)
        effectData:SetScale(8)
        effectData:SetFlags(3)
        effectData:SetColor(0)
        util.Effect("bloodspray", effectData)
        util.Effect("bloodspray", effectData)
    end

    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/flesh1.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 40)) })
    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/flesh2.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 40)) })
    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/flesh3.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 40)) })
    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/flesh4.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 40)) })
    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_b_bone.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 50)) })
    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_b_gib.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 40)) })
    self:CreateGibEntity("obj_vj_gib", "models/gib/hgibs" .. math.random(2, 3) .. ".mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 40)) })
    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_hmeat.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 45)) })
    self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/gib_hgrunt.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,15))})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_lung.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 45)) })
    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_skull.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 60)) })
    self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/hgib_legbone.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)) })
    return true -- Return to true if it gibbed!
end

function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
    VJ_EmitSound(self, "vj_gib/default_gib_splat.wav", 90, 100)
    return false
end

function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
    self:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
    self:DropWeaponOnDeathCode(dmginfo, hitgroup)
    if IsValid(self:GetActiveWeapon()) then self:GetActiveWeapon():Remove() end
end

function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
    self:SetBodygroup(2, 1)
end

function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
    VJ_HLR_ApplyCorpseEffects(self, corpseEnt)
end

function ENT:CustomOnDropWeapon_AfterWeaponSpawned(dmginfo, hitgroup, wepEnt)
    wepEnt.WorldModel_Invisible = false
    wepEnt:SetNW2Bool("VJ_WorldModel_Invisible", false)
end
