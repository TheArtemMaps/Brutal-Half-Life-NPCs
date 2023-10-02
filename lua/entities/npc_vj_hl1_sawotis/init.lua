AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/hl1/sawotis.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 90
ENT.HullType = HULL_HUMAN
ENT.VJC_Data = {
    ThirdP_Offset = Vector(10, 0, -30), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(4, 0, 0), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"} -- NPCs with the same class with be allied to each other
ENT.FriendsWithAllPlayerAllies = true -- Should this SNPC be friends with all other player allies that are running on VJ Base?
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.Weapon_NoSpawnMenu = true -- If set to true, the NPC weapon setting in the spawnmenu will not be applied for this SNPC
ENT.DisableWeaponFiringGesture = true -- If set to true, it will disable the weapon firing gestures
ENT.MoveRandomlyWhenShooting = false -- Should it move randomly when shooting?
ENT.HasCallForHelpAnimation = false -- if true, it will play the call for help animation
ENT.AnimTbl_ShootWhileMovingRun = {ACT_RUN} -- Animations it will play when shooting while running | NOTE: Weapon may translate the animation that they see fit!
ENT.AnimTbl_ShootWhileMovingWalk = {ACT_RUN} -- Animations it will play when shooting while walking | NOTE: Weapon may translate the animation that they see fit!
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.FootStepTimeRun = 0.3 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.AnimTbl_TakingCover = {ACT_CROUCHIDLE} -- The animation it plays when hiding in a covered position, leave empty to let the base decide
ENT.AnimTbl_AlertFriendsOnDeath = {"vjseq_idle2"} -- Animations it plays when an ally dies that also has AlertFriendsOnDeath set to true
ENT.HasLostWeaponSightAnimation = true -- Set to true if you would like the SNPC to play a different animation when it has lost sight of the enemy and can't fire at it
ENT.BecomeEnemyToPlayer = true -- Should the friendly SNPC become enemy towards the player if it's damaged by a player?
ENT.HasItemDropsOnDeath = false -- Should it drop items on death?
ENT.HasOnPlayerSight = true -- Should do something when it sees the enemy? Example: Play a sound
ENT.CombatFaceEnemy = false -- If enemy is exists and is visible
ENT.HasMeleeAttackSounds = true -- If set to false, it won't play the melee attack sound
ENT.HasGrenadeAttack = true -- Should the SNPC have a grenade attack?
ENT.GrenadeAttackEntity = "obj_vj_hlr1_grenade" -- The entity that the SNPC throws | Half Life 2 Grenade: "npc_grenade_frag"
ENT.AnimTbl_GrenadeAttack = {ACT_SPECIAL_ATTACK2} -- Grenade Attack Animations
ENT.GrenadeAttackAttachment = "lhand" -- The attachment that the grenade will spawn at
ENT.TimeUntilGrenadeIsReleased = 1.3 -- Time until the grenade is released
ENT.NextThrowGrenadeTime = VJ_Set(10, 12) -- Time until it can throw a grenade again
ENT.ThrowGrenadeChance = 3 -- Chance that it will throw the grenade | Set to 1 to throw all the time
ENT.HasMeleeAttackMissSounds = true -- If set to false, it won't play the melee attack miss sound
ENT.AnimTbl_WeaponAttackSecondary = {ACT_SPECIAL_ATTACK1} -- Animations played when the SNPC fires a secondary weapon attack
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
		self.SoundTbl_Idle = {"vj_hlr/hl1_npc/otis/stupidmachines.wav","vj_hlr/hl1_npc/otis/mmmm.wav","vj_hlr/hl1_npc/otis/janitor.wav","vj_hlr/hl1_npc/otis/insurance.wav","vj_hlr/hl1_npc/otis/candy.wav","vj_hlr/hl1_npc/otis/chili.wav","vj_hlr/hl1_npc/otis/cousin.wav"}
	self.SoundTbl_IdleDialogue = {"vj_hlr/hl1_npc/otis/wuss.wav","vj_hlr/hl1_npc/otis/somethingmoves.wav","vj_hlr/hl1_npc/otis/quarter.wav","vj_hlr/hl1_npc/otis/aliencombat.wav","vj_hlr/hl1_npc/otis/ass.wav","vj_hlr/hl1_npc/otis/beer.wav","vj_hlr/hl1_npc/otis/bigboned.wav"}
	self.SoundTbl_IdleDialogueAnswer = {"vj_hlr/hl1_npc/otis/yup.wav","vj_hlr/hl1_npc/otis/youbet.wav","vj_hlr/hl1_npc/otis/yes.wav","vj_hlr/hl1_npc/otis/yessir.wav","vj_hlr/hl1_npc/otis/yeah.wav","vj_hlr/hl1_npc/otis/talkmuch.wav","vj_hlr/hl1_npc/otis/suppose.wav","vj_hlr/hl1_npc/otis/noway.wav","vj_hlr/hl1_npc/otis/nope.wav","vj_hlr/hl1_npc/otis/nosir.wav","vj_hlr/hl1_npc/otis/no.wav","vj_hlr/hl1_npc/otis/maybe.wav","vj_hlr/hl1_npc/otis/hell.wav","vj_hlr/hl1_npc/otis/doubt.wav","vj_hlr/hl1_npc/otis/dontask.wav","vj_hlr/hl1_npc/otis/dejavu.wav","vj_hlr/hl1_npc/otis/cantfigure.wav","vj_hlr/hl1_npc/otis/dontguess.wav"}
	self.SoundTbl_CombatIdle = {"vj_hlr/hl1_npc/otis/die.wav","vj_hlr/hl1_npc/otis/bridge.wav","vj_hlr/hl1_npc/otis/tooyoung.wav","vj_hlr/hl1_npc/otis/virgin.wav","vj_hlr/hl1_npc/otis/mom.wav","vj_hlr/hl1_npc/otis/mall.wav","vj_hlr/hl1_npc/otis/leftovers.wav","vj_hlr/hl1_npc/otis/getanyworse.wav","vj_hlr/hl1_npc/otis/job.wav"}
	self.SoundTbl_FollowPlayer = {"vj_hlr/hl1_npc/otis/yourback.wav","vj_hlr/hl1_npc/otis/youbet.wav","vj_hlr/hl1_npc/otis/yeah.wav","vj_hlr/hl1_npc/otis/together.wav","vj_hlr/hl1_npc/otis/teamup.wav","vj_hlr/hl1_npc/otis/rightdirection.wav","vj_hlr/hl1_npc/otis/of1a1_ot04.wav","vj_hlr/hl1_npc/otis/live.wav","vj_hlr/hl1_npc/otis/letsgo.wav","vj_hlr/hl1_npc/otis/joinyou.wav","vj_hlr/hl1_npc/otis/gladof.wav","vj_hlr/hl1_npc/otis/alright.wav","vj_hlr/hl1_npc/otis/diealone.wav"}
	self.SoundTbl_UnFollowPlayer = {"vj_hlr/hl1_npc/otis/standguard.wav","vj_hlr/hl1_npc/otis/slowingyoudown.wav","vj_hlr/hl1_npc/otis/seeya.wav","vj_hlr/hl1_npc/otis/ot_intro_seeya.wav","vj_hlr/hl1_npc/otis/of1a1_ot03.wav","vj_hlr/hl1_npc/otis/notalone.wav","vj_hlr/hl1_npc/otis/illwait.wav","vj_hlr/hl1_npc/otis/help.wav","vj_hlr/hl1_npc/otis/closet.wav","vj_hlr/hl1_npc/otis/go_on.wav"}
	self.SoundTbl_MedicReceiveHeal = {"vj_hlr/hl1_npc/otis/medic.wav"}
	self.SoundTbl_OnPlayerSight = {"vj_hlr/hl1_npc/otis/soldier.wav","vj_hlr/hl1_npc/otis/ot_intro_hello1.wav","vj_hlr/hl1_npc/otis/ot_intro_hello2.wav","vj_hlr/hl1_npc/otis/hiya.wav","vj_hlr/hl1_npc/otis/hello.wav","vj_hlr/hl1_npc/otis/hey.wav"}
	self.SoundTbl_Investigate = {"vj_hlr/hl1_npc/otis/soundsbad.wav","vj_hlr/hl1_npc/otis/noise.wav","vj_hlr/hl1_npc/otis/hearsomething.wav"}
	self.SoundTbl_BecomeEnemyToPlayer = {"vj_hlr/hl1_npc/otis/tomb.wav","vj_hlr/hl1_npc/otis/somuch.wav","vj_hlr/hl1_npc/otis/donthurtem.wav","vj_hlr/hl1_npc/otis/bring.wav","vj_hlr/hl1_npc/otis/bully.wav"}
	self.SoundTbl_OnKilledEnemy = {"vj_hlr/hl1_npc/otis/seethat.wav","vj_hlr/hl1_npc/otis/reputation.wav","vj_hlr/hl1_npc/otis/gotone.wav","vj_hlr/hl1_npc/otis/close.wav","vj_hlr/hl1_npc/otis/another.wav","vj_hlr/hl1_npc/otis/buttugly.wav","vj_hlr/hl1_npc/otis/firepl.wav"}
	self.SoundTbl_AllyDeath = {"vj_hlr/hl1_npc/otis/of1a5_ot01.wav"}
	self.SoundTbl_Pain = {"vj_hlr/hl1_npc/otis/scar.wav","vj_hlr/hl1_npc/otis/hitbad.wav","vj_hlr/hl1_npc/otis/imdead.wav","vj_hlr/hl1_npc/otis/imhit.wav"}
	self.SoundTbl_DamageByPlayer = {"vj_hlr/hl1_npc/otis/yourside.wav","vj_hlr/hl1_npc/otis/watchit.wav","vj_hlr/hl1_npc/otis/quitit.wav","vj_hlr/hl1_npc/otis/onry.wav","vj_hlr/hl1_npc/otis/dontmake.wav","vj_hlr/hl1_npc/otis/damn.wav","vj_hlr/hl1_npc/otis/chump.wav","vj_hlr/hl1_npc/otis/friends.wav"}
	self.SoundTbl_Death = {"vj_hlr/hl1_npc/barney/ba_die1.wav","vj_hlr/hl1_npc/barney/ba_die2.wav","vj_hlr/hl1_npc/barney/ba_die3.wav"}
		self.SoundTbl_FootStep = {
"commonbhl/npc_step1.wav",
"commonbhl/npc_step2.wav",
"commonbhl/npc_step3.wav",
"commonbhl/npc_step4.wav"
}

if GetConVar("russian_voice"):GetInt() == 1 then
	self.SoundTbl_Idle = {"rus/sound/otis/stupidmachines.wav","rus/sound/otis/mmmm.wav","rus/sound/otis/janitor.wav","rus/sound/otis/insurance.wav","rus/sound/otis/candy.wav","rus/sound/otis/chili.wav","rus/sound/otis/cousin.wav"}
	self.SoundTbl_IdleDialogue = {"rus/sound/otis/wuss.wav","rus/sound/otis/somethingmoves.wav","rus/sound/otis/quarter.wav","rus/sound/otis/aliencombat.wav","rus/sound/otis/ass.wav","rus/sound/otis/beer.wav","rus/sound/otis/bigboned.wav"}
	self.SoundTbl_IdleDialogueAnswer = {"rus/sound/otis/yup.wav","rus/sound/otis/youbet.wav","rus/sound/otis/yes.wav","rus/sound/otis/yessir.wav","rus/sound/otis/yeah.wav","rus/sound/otis/talkmuch.wav","rus/sound/otis/suppose.wav","rus/sound/otis/noway.wav","rus/sound/otis/nope.wav","rus/sound/otis/nosir.wav","rus/sound/otis/no.wav","rus/sound/otis/maybe.wav","rus/sound/otis/hell.wav","rus/sound/otis/doubt.wav","rus/sound/otis/dontask.wav","rus/sound/otis/dejavu.wav","rus/sound/otis/cantfigure.wav","rus/sound/otis/dontguess.wav"}
	self.SoundTbl_CombatIdle = {"rus/sound/otis/die.wav","rus/sound/otis/bridge.wav","rus/sound/otis/tooyoung.wav","rus/sound/otis/virgin.wav","rus/sound/otis/mom.wav","rus/sound/otis/mall.wav","rus/sound/otis/leftovers.wav","rus/sound/otis/getanyworse.wav","rus/sound/otis/job.wav"}
	self.SoundTbl_FollowPlayer = {"rus/sound/otis/yourback.wav","rus/sound/otis/youbet.wav","rus/sound/otis/yeah.wav","rus/sound/otis/together.wav","rus/sound/otis/teamup.wav","rus/sound/otis/rightdirection.wav","rus/sound/otis/of1a1_ot04.wav","rus/sound/otis/live.wav","rus/sound/otis/letsgo.wav","rus/sound/otis/joinyou.wav","rus/sound/otis/gladof.wav","rus/sound/otis/alright.wav","rus/sound/otis/diealone.wav"}
	self.SoundTbl_UnFollowPlayer = {"rus/sound/otis/standguard.wav","rus/sound/otis/slowingyoudown.wav","rus/sound/otis/seeya.wav","rus/sound/otis/ot_intro_seeya.wav","rus/sound/otis/of1a1_ot03.wav","rus/sound/otis/notalone.wav","rus/sound/otis/illwait.wav","rus/sound/otis/help.wav","rus/sound/otis/closet.wav","rus/sound/otis/go_on.wav"}
	self.SoundTbl_MedicReceiveHeal = {"rus/sound/otis/medic.wav"}
	self.SoundTbl_OnPlayerSight = {"rus/sound/otis/soldier.wav","rus/sound/otis/ot_intro_hello1.wav","rus/sound/otis/ot_intro_hello2.wav","rus/sound/otis/hiya.wav","rus/sound/otis/hello.wav","rus/sound/otis/hey.wav"}
	self.SoundTbl_Investigate = {"rus/sound/otis/soundsbad.wav","rus/sound/otis/noise.wav","rus/sound/otis/hearsomething.wav"}
	self.SoundTbl_BecomeEnemyToPlayer = {"rus/sound/otis/tomb.wav","rus/sound/otis/somuch.wav","rus/sound/otis/donthurtem.wav","rus/sound/otis/bring.wav","rus/sound/otis/bully.wav"}
	self.SoundTbl_OnKilledEnemy = {"rus/sound/otis/seethat.wav","rus/sound/otis/reputation.wav","rus/sound/otis/gotone.wav","rus/sound/otis/close.wav","rus/sound/otis/another.wav","rus/sound/otis/buttugly.wav","rus/sound/otis/firepl.wav"}
	self.SoundTbl_AllyDeath = {"rus/sound/otis/of1a5_ot01.wav"}
	self.SoundTbl_Pain = {"rus/sound/otis/scar.wav","rus/sound/otis/hitbad.wav","rus/sound/otis/imdead.wav","rus/sound/otis/imhit.wav"}
	self.SoundTbl_DamageByPlayer = {"rus/sound/otis/yourside.wav","rus/sound/otis/watchit.wav","rus/sound/otis/quitit.wav","rus/sound/otis/onry.wav","rus/sound/otis/dontmake.wav","rus/sound/otis/damn.wav","rus/sound/otis/chump.wav","rus/sound/otis/friends.wav"}
	self.SoundTbl_Death = {"vj_hlr/hl1_npc/barney/ba_die1.wav","vj_hlr/hl1_npc/barney/ba_die2.wav","vj_hlr/hl1_npc/barney/ba_die3.wav"}
	end	

	self.AnimTbl_Death = {ACT_DIEBACKWARD,ACT_DIEFORWARD,ACT_DIE_GUTSHOT,ACT_DIE_HEADSHOT,ACT_DIESIMPLE} -- Death Animations
	self:SetBodygroup(2, math.random(0, 2))
	self.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIE_GUTSHOT, ACT_DIE_HEADSHOT, ACT_DIESIMPLE} -- Death Animations
	
	self:Give("weapon_vj_hlrof_m249barn")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(13, 13, 76), Vector(-13, -13, 0))
	self:SetBodygroup(1, 0)
	self:SetWeaponState(VJ_WEP_STATE_HOLSTERED)
	if GetConVar("vj_hl1_explosives"):GetInt() == 1 then
		 self.HasGrenadeAttack = false
		 self.CanUseSecondaryOnWeaponAttack = false
	end	 
	if GetConVar("vj_hl1_explosives"):GetInt() == 0 then
	self.HasGrenadeAttack = true
	self.CanUseSecondaryOnWeaponAttack = true
	end
	if self:GetModel() == "models/hl1/barney.mdl" then // Already the default
		self.Security_Type = 0
	elseif self:GetModel() == "models/vj_hlr/opfor/otis.mdl" then
		self.Security_Type = 1
	elseif self:GetModel() == "models/vj_hlr/hla/barney.mdl" then
		self.Security_Type = 2
	end
	self:Security_CustomOnInitialize()
end


---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply, controlEnt)
	function controlEnt:CustomOnKeyPressed(key)
		if key == KEY_LALT && self.VJCE_NPC:GetActivity() != ACT_DISARM && self.VJCE_NPC:GetActivity() != ACT_ARM then
			if self.VJCE_NPC:GetWeaponState() == VJ_WEP_STATE_HOLSTERED then
				self.VJCE_NPC:Security_UnHolsterGun()
			elseif self.VJCE_NPC:GetWeaponState() == VJ_WEP_STATE_READY then
				self.VJCE_NPC:Security_HolsterGun()
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)
	ply:ChatPrint("LALT: Holster / Unholster M249 SAW")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	//print(key)
	if key == "shoot" then
		local wep = self:GetActiveWeapon()
		if IsValid(wep) then
			wep:NPCShoot_Primary()
		end
	elseif key == "step" then
	self:FootStepSoundCode()		
	elseif key == "body" then
		VJ_EmitSound(self, "commonbhl/bodydrop"..math.random(3, 4)..".wav", 75, 100)
		elseif key == "holstersound" then
	VJ_EmitSound(self, "items/gunpickup3.wav", 75, 100)
	elseif key == "draw1" then 
	VJ_EmitSound(self, "items/gunpickup1.wav", 75, 100)
	elseif key == "draw2" then
	VJ_EmitSound(self, "items/clipinsert1.wav", 75, 100)	
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self.Security_Type != 2 then -- If it's regular or Otis...
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
		
			-- If Otis is bleeding then inform the player that Otis have 1 minute to live	
	if self.IsFollowing == true and self.Security_Bleeding == true and not self.hasPrintedMessage then
    Entity( 1 ):ChatPrint("Otis is bleeding, find a medic ASAP! You have 1 minute...")
    self.hasPrintedMessage = true
            self.lifespan = 60
            timer.Create("Countdown_" .. self:EntIndex(), 1, 0, function()
                if self.lifespan then
                    self.lifespan = self.lifespan - 1
                    if self.lifespan <= 15 && self.IsFollowing == true && self.Security_Bleeding == true then
                        BroadcastLua("chat.AddText(Color(255, 0, 0), 'Otis will die in " .. self.lifespan .. " seconds! Find a medic ASAP!')")
                    end
                    
                    if self.lifespan <= 0 && self.Security_Bleeding == true then
                        self:TakeDamage(self:Health(), self, self)
                        timer.Remove("Countdown_" .. self:EntIndex())
                    end
                end
            end)
        end
				
				-- Bleeding on low health
		if self.Security_CanHurtWalk and self:Health() <= (self:GetMaxHealth() / 2.2) then
			local vPoint = self:GetPos() + Vector(0, 0, 45)
			if self.Security_UsingHurtWalk == true then
				if not self.Security_LastBloodSpawn or CurTime() - self.Security_LastBloodSpawn >= 2.5 then
					self.Security_LastBloodSpawn = CurTime()
            local effectdata = EffectData()
            effectdata:SetOrigin( vPoint )
            effectdata:SetNormal( -self:GetUp() )
            effectdata:SetMagnitude( 0.5 )
            effectdata:SetRadius( 100 )
            effectdata:SetEntity( self )
			util.Effect("dynamic_blood_splatter_effect2", effectdata)
			self.Security_Bleeding = true
			-- bleed faster if health is lower than 10
			elseif self.Security_CanHurtWalk and self:Health() < 10 then
			if self.Security_UsingHurtWalk == true then
				if not self.Security_LastBloodSpawn or CurTime() - self.Security_LastBloodSpawn >= 1 then
					self.Security_LastBloodSpawn = CurTime()
            local effectdata = EffectData()
            effectdata:SetOrigin( vPoint )
            effectdata:SetNormal( -self:GetUp() )
            effectdata:SetMagnitude( 0.5 )
            effectdata:SetRadius( 100 )
            effectdata:SetEntity( self )
			util.Effect("dynamic_blood_splatter_effect2", effectdata)
			self.Security_Bleeding = true
			self.TurboBleeding = true
				end
			end
		end
		end
		end
		
					local soundList = {
"vj_hlr/hl1_npc/otis/scar.wav",
"vj_hlr/hl1_npc/otis/hitbad.wav",
"vj_hlr/hl1_npc/otis/imdead.wav",
"vj_hlr/hl1_npc/otis/imhit.wav"
	}
	
		local soundListrus = {
"rus/sound/otis/scar.wav",
"rus/sound/otis/hitbad.wav",
"rus/sound/otis/imdead.wav",
"rus/sound/otis/imhit.wav"
}
    local randomIndex = math.random(1, #soundList)
    local soundToPlay = soundList[randomIndex]
	    local randomIndexrus = math.random(1, #soundListrus)
    local soundToPlayrus = soundListrus[randomIndexrus]		
		-- Ouch sound when low health
if self.Security_UsingHurtWalk == true then
    if self.Dead then -- If dead, stop playing the sound
        return
    end

    local soundToPlay

    if GetConVar("russian_voice"):GetInt() == 1 then -- If russian voices are enabled, then switch to russian voices.
        soundToPlay = soundListrus
    else
        soundToPlay = soundList
    end

    if not self.Security_LastOuch or CurTime() - self.Security_LastOuch >= 3 then
        self.Security_LastOuch = CurTime()
        self:PlaySoundSystem("GeneralSpeech", soundToPlay)
		end
		if self.TurboBleeding then -- Fast bleeding? Then let the sounds play faster too!
		if not self.Security_LastOuch or CurTime() - self.Security_LastOuch >= 1.8 then
        self.Security_LastOuch = CurTime()
        self:PlaySoundSystem("GeneralSpeech", soundToPlay)
		end
    end
end
		
		-- Hurt Walking
	if self.Security_CanHurtWalk && self:Health() <= (self:GetMaxHealth() / 2.2) then
		if !self.Security_UsingHurtWalk then
			self.AnimTbl_Walk = {ACT_WALK_HURT}
			self.AnimTbl_Run = {ACT_RUN_HURT}
			self.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED}
			self.AnimTbl_ShootWhileMovingWalk = {ACT_WALK_HURT}
			self.AnimTbl_ShootWhileMovingRun = {ACT_RUN_HURT}
			self.Security_UsingHurtWalk = true
		end
	elseif self.Security_UsingHurtWalk then
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}
		self.AnimTbl_IdleStand = {ACT_IDLE}
		self.AnimTbl_ShootWhileMovingWalk = {ACT_WALK}
		self.AnimTbl_ShootWhileMovingRun = {ACT_RUN}
		self.Security_UsingHurtWalk = false
		self.Security_Bleeding = false
	end
		-- For guarding
		if self.IsGuard == true && self:GetWeaponState() == VJ_WEP_STATE_HOLSTERED && !IsValid(self:GetEnemy()) then
			if self.Security_SwitchedIdle == false then
				self.Security_SwitchedIdle = true
				self.AnimTbl_IdleStand = {ACT_GET_DOWN_STAND, ACT_GET_UP_STAND}
			end
		elseif self.Security_SwitchedIdle == true then
			self.Security_SwitchedIdle = false
			self.AnimTbl_IdleStand = {ACT_IDLE}
		end
	elseif IsValid(self:GetActiveWeapon()) then -- Alpha Security Guard can't reload!
		self:GetActiveWeapon():SetClip1(999)
	end
end
function ENT:CustomOnTakeDamage_AfterDamage(dmgInfo, hitgroup)
if dmgInfo:IsExplosionDamage() then
        local animations = {"cower", "kicked"}
        local randomAnimation = animations[math.random(1, #animations)]
self:VJ_ACT_PLAYACTIVITY(randomAnimation, true, false, true)
end
end

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnPlayCreateSound(sdData, sdFile)
	self.Security_NextMouthMove = CurTime() + SoundDuration(sdFile)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	if self.VJ_IsBeingControlled then return end
	
	if math.random(1, 2) == 1 then
		if self.Security_Type == 0 then
			if ent:GetClass() == "npc_vj_hlr1_bullsquid" then
				self:PlaySoundSystem("Alert", {"barn/c1a4_ba_octo1.wav"})
				self.NextAlertSoundT = CurTime() + math.Rand(self.NextSoundTime_Alert.a, self.NextSoundTime_Alert.b)
			elseif ent.IsVJBaseSNPC_Creature == true then
				self:PlaySoundSystem("Alert", {"barn/diebloodsucker.wav"})
				self.NextAlertSoundT = CurTime() + math.Rand(self.NextSoundTime_Alert.a, self.NextSoundTime_Alert.b)
			end
		elseif self.Security_Type == 1 && ent.IsVJBaseSNPC_Creature == true then
			self:PlaySoundSystem("Alert", {"vj_hlr/hl1_npc/otis/aliens.wav"})
			self.NextAlertSoundT = CurTime() + math.Rand(self.NextSoundTime_Alert.a, self.NextSoundTime_Alert.b)
		end
	end
	
	if self:GetWeaponState() == VJ_WEP_STATE_HOLSTERED then
		self:Security_UnHolsterGun()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Security_HolsterGun()
	if self:GetBodygroup(1) != 0 then self:VJ_ACT_PLAYACTIVITY(ACT_DISARM, true, false, true) end
	self:SetWeaponState(VJ_WEP_STATE_HOLSTERED)
	self.AnimTbl_Walk = {ACT_WALK}
	self.AnimTbl_Run = {ACT_RUN}
	self.AnimTbl_IdleStand = {ACT_IDLE}
if self.Security_UsingHurtWalk == true then
    self.AnimTbl_Walk = {ACT_WALK_HURT}
    self.AnimTbl_Run = {ACT_RUN_HURT}
	self.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED}
    self.AnimTbl_ShootWhileMovingWalk = {ACT_WALK_HURT}
    self.AnimTbl_ShootWhileMovingRun = {ACT_RUN_HURT}
end
	
	timer.Simple(self.Security_Type == 2 and 1 or 1.5, function()
		if IsValid(self) && self:GetWeaponState() == VJ_WEP_STATE_HOLSTERED then
			self:SetBodygroup(1, 0)
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Security_UnHolsterGun()
	self:StopMoving()
	self:VJ_ACT_PLAYACTIVITY(ACT_ARM, true, false, true)
	self:SetWeaponState()
	self.AnimTbl_Walk = {ACT_RANGE_ATTACK_SMG2}
	self.AnimTbl_Run = {ACT_RANGE_ATTACK_SMG1_LOW}
	self.AnimTbl_IdleStand = {ACT_RANGE_ATTACK_SMG1}
	if self.Security_UsingHurtWalk == true then
    self.AnimTbl_Walk = {ACT_WALK_HURT}
    self.AnimTbl_Run = {ACT_RUN_HURT}
	self.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED}
    self.AnimTbl_ShootWhileMovingWalk = {ACT_WALK_HURT}
    self.AnimTbl_ShootWhileMovingRun = {ACT_RUN_HURT}
end
	timer.Simple(0.55, function() if IsValid(self) then self:SetBodygroup(1, 1) end end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	if self.VJ_IsBeingControlled or self.Dead or self:BusyWithActivity() then return end
	
	if IsValid(self:GetEnemy()) then -- If enemy is seen then make sure gun is NOT holstered
		if self:GetWeaponState() == VJ_WEP_STATE_HOLSTERED then
			self:Security_UnHolsterGun()
		end
	elseif self:GetWeaponState() == VJ_WEP_STATE_READY && (CurTime() - self.EnemyData.TimeSet) > 5 then
		self:Security_HolsterGun()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vec = Vector(0, 0, 0)
--
function ENT:CustomOnTakeDamage_BeforeImmuneChecks(dmginfo, hitgroup)
	-- Make a metal effect when the helmet is hit!
	self.Bleeds = true
	if self.Security_Type == 1 then return end -- Only types that do have a helmet
	if hitgroup == HITGROUP_GEAR && dmginfo:GetDamagePosition() != vec then
		self.Bleeds = false			-- disable bleeding temporarily when shot at the helmet
		local rico = EffectData()
		rico:SetOrigin(dmginfo:GetDamagePosition())
		rico:SetScale(4) -- Size
		rico:SetMagnitude(math.random(1, 2)) -- Effect type | 1 = Animated | 2 = Basic
		util.Effect("VJ_HLR_Rico",rico)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local colorRed = VJ_Color2Byte(Color(130, 19, 10))
--
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
	
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh1.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh2.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh3.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh4.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_b_bone.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,50))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_b_gib.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/gib/hgibs" .. math.random(2, 3) .. ".mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_hmeat.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_lung.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_skull.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,60))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_legbone.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,15))})
	return true -- Return to true if it gibbed!
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
	VJ_EmitSound(self, "vj_gib/default_gib_splat.wav", 90, 100)
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	self:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
	self:DropWeaponOnDeathCode(dmginfo, hitgroup)
	if IsValid(self:GetActiveWeapon()) then self:GetActiveWeapon():Remove() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
	self:SetBodygroup(1, 2)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	VJ_HLR_ApplyCorpseEffects(self, corpseEnt)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDropWeapon_AfterWeaponSpawned(dmginfo, hitgroup, wepEnt)
	wepEnt.WorldModel_Invisible = false
	wepEnt:SetNW2Bool("VJ_WorldModel_Invisible", false)
end