AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/hl1/akimbobarney.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
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
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.Weapon_NoSpawnMenu = true -- If set to true, the NPC weapon setting in the spawnmenu will not be applied for this SNPC
ENT.DisableWeaponFiringGesture = true -- If set to true, it will disable the weapon firing gestures
ENT.MoveRandomlyWhenShooting = false -- Should it move randomly when shooting?
ENT.AnimTbl_IdleStand = {ACT_IDLE}
ENT.HasCallForHelpAnimation = false -- if true, it will play the call for help animation
ENT.AnimTbl_ShootWhileMovingRun = {ACT_RUN} -- Animations it will play when shooting while running | NOTE: Weapon may translate the animation that they see fit!
ENT.AnimTbl_ShootWhileMovingWalk = {ACT_RUN} -- Animations it will play when shooting while walking | NOTE: Weapon may translate the animation that they see fit!
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.FootStepTimeRun = 0.30 -- Next foot step sound when it is running
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
ENT.AnimTbl_TakingCover = {ACT_COWER} -- The animation it plays when hiding in a covered position
ENT.AnimTbl_MoveToCover = {ACT_RUN_HURT} -- The animation it plays when moving to a covered position
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
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Security_CustomOnInitialize()
	self.SoundTbl_Idle = {"barn/whatisthat.wav","barn/somethingstinky.wav","barn/somethingdied.wav","barn/guyresponsible.wav","barn/coldone.wav","barn/ba_gethev.wav","barn/badfeeling.wav","barn/bigmess.wav","barn/bigplace.wav"}
	self.SoundTbl_IdleDialogue = {"barn/youeverseen.wav","barn/workingonstuff.wav","barn/whatsgoingon.wav","barn/thinking.wav","barn/survive.wav","barn/stench.wav","barn/somethingmoves.wav","barn/of1a5_ba01.wav","barn/nodrill.wav","barn/missingleg.wav","barn/luckwillturn.wav","barn/gladof38.wav","barn/gettingcloser.wav","barn/crewdied.wav","barn/ba_idle0.wav","barn/badarea.wav","barn/beertopside.wav"}
	self.SoundTbl_IdleDialogueAnswer = {"barn/yup.wav","barn/youtalkmuch.wav","barn/yougotit.wav","barn/youbet.wav","barn/yessir.wav","barn/soundsright.wav","barn/noway.wav","barn/nope.wav","barn/nosir.wav","barn/notelling.wav","barn/maybe.wav","barn/justdontknow.wav","barn/ireckon.wav","barn/iguess.wav","barn/icanhear.wav","barn/guyresponsible.wav","barn/dontreckon.wav","barn/dontguess.wav","barn/dontfigure.wav","barn/dontbuyit.wav","barn/dontbet.wav","barn/dontaskme.wav","barn/cantfigure.wav","barn/bequiet.wav","barn/ba_stare0.wav","barn/alreadyasked.wav"}
	self.SoundTbl_CombatIdle = {"barn/whatgood.wav","barn/targetpractice.wav","barn/easily.wav","barn/getanyworse.wav"}
	self.SoundTbl_FollowPlayer = {"barn/yougotit.wav","barn/wayout.wav","barn/teamup1.wav","barn/teamup2.wav","barn/rightway.wav","barn/letsgo.wav","barn/letsmoveit.wav","barn/imwithyou.wav","barn/gladtolendhand.wav","barn/dobettertogether.wav","barn/c1a2_ba_goforit.wav","barn/ba_ok1.wav","barn/ba_ok2.wav","barn/ba_ok3.wav","barn/ba_idle1.wav","barn/ba_ht06_11.wav"}
	self.SoundTbl_UnFollowPlayer = {"barn/waitin.wav","barn/stop2.wav","barn/standguard.wav","barn/slowingyoudown.wav","barn/seeya.wav","barn/iwaithere.wav","barn/illwait.wav","barn/helpothers.wav","barn/ba_wait1.wav","barn/ba_wait2.wav","barn/ba_wait3.wav","barn/ba_wait4.wav","barn/ba_security2_pass.wav","barn/aintgoin.wav","barn/ba_becareful1.wav"}
	self.SoundTbl_OnPlayerSight = {"barn/mrfreeman.wav","barn/howyoudoing.wav","barn/howdy.wav","barn/heybuddy.wav","barn/heyfella.wav","barn/hellonicesuit.wav","barn/ba_stare1.wav","barn/ba_later.wav","barn/ba_idle4.wav","barn/ba_idle3.wav","barn/ba_ok4.wav","barn/ba_ok5.wav","barn/ba_ht06_03.wav","barn/ba_ht06_03_alt.wav","barn/ba_hello0.wav","barn/ba_hello1.wav","barn/ba_hello2.wav","barn/ba_hello3.wav","barn/ba_hello4.wav","barn/ba_hello5.wav","barn/armedforces.wav"}
	self.SoundTbl_Investigate = {"barn/youhearthat.wav","barn/soundsbad.wav","barn/icanhear.wav","barn/hearsomething2.wav","barn/hearsomething.wav","barn/ambush.wav","barn/ba_generic0.wav"}
	self.SoundTbl_Alert = {"barn/ba_openfire.wav","barn/ba_attack1.wav","barn/aimforhead.wav"}
	self.SoundTbl_CallForHelp = {"barn/ba_needhelp0.wav","barn/ba_needhelp1.wav"}
	self.SoundTbl_BecomeEnemyToPlayer = {"barn/ba_uwish.wav","barn/ba_tomb.wav","barn/ba_somuch.wav","barn/ba_mad3.wav","barn/ba_iwish.wav","barn/ba_endline.wav","barn/aintscared.wav"}
	self.SoundTbl_Suppressing = {"barn/c1a4_ba_octo2.wav","barn/c1a4_ba_octo4.wav","barn/c1a4_ba_octo3.wav","barn/ba_generic1.wav","barn/ba_bring.wav","barn/ba_attacking1.wav"}
	self.SoundTbl_OnGrenadeSight = {"barn/standback.wav","barn/ba_heeey.wav"}
	self.SoundTbl_OnDangerSight = {"barn/standback.wav","barn/ba_heeey.wav"}
	self.SoundTbl_GrenadeAttack = {"barn/c1a4_ba_octo4.wav"}
	self.SoundTbl_OnKilledEnemy = {"barn/soundsbad.wav","barn/ba_seethat.wav","barn/ba_kill0.wav","barn/ba_gotone.wav","barn/ba_firepl.wav","barn/ba_buttugly.wav","barn/ba_another.wav","barn/ba_close.wav"}
	self.SoundTbl_AllyDeath = {"barn/die.wav"}
	self.SoundTbl_Pain = {"barn/imhit.wav","barn/hitbad.wav","barn/c1a2_ba_4zomb.wav","barn/ba_pain1.wav","barn/ba_pain2.wav","barn/ba_pain3.wav"}
	self.SoundTbl_DamageByPlayer = {"barn/donthurtem.wav","barn/ba_whoathere.wav","barn/ba_whatyou.wav","barn/ba_watchit.wav","barn/ba_shot1.wav","barn/ba_shot2.wav","barn/ba_shot3.wav","barn/ba_shot4.wav","barn/ba_shot5.wav","barn/ba_shot6.wav","barn/ba_shot7.wav","barn/ba_stepoff.wav","barn/ba_pissme.wav","barn/ba_mad1.wav","barn/ba_mad0.wav","barn/ba_friends.wav","barn/ba_dotoyou.wav","barn/ba_dontmake.wav","barn/ba_crazy.wav"}
	self.SoundTbl_Death = {"barn/ba_ht06_02_alt.wav","barn/ba_ht06_02.wav","barn/ba_die1.wav","barn/ba_die2.wav","barn/ba_die3.wav"}
self.SoundTbl_FootStep = {
"commonbhl/npc_step1.wav",
"commonbhl/npc_step2.wav",
"commonbhl/npc_step3.wav",
"commonbhl/npc_step4.wav"
}
self.hasPrintedMessage = false
	if GetConVar("russian_voice"):GetInt() == 1 then
	self.SoundTbl_Idle = {"rus/sound/barney/whatisthat.wav","rus/sound/barney/somethingstinky.wav","rus/sound/barney/somethingdied.wav","rus/sound/barney/guyresponsible.wav","rus/sound/barney/coldone.wav","rus/sound/barney/ba_gethev.wav","rus/sound/barney/badfeeling.wav","rus/sound/barney/bigmess.wav","rus/sound/barney/bigplace.wav"}
	self.SoundTbl_IdleDialogue = {"rus/sound/barney/youeverseen.wav","rus/sound/barney/workingonstuff.wav","rus/sound/barney/whatsgoingon.wav","rus/sound/barney/thinking.wav","rus/sound/barney/survive.wav","rus/sound/barney/stench.wav","rus/sound/barney/somethingmoves.wav","rus/sound/barney/of1a5_ba01.wav","rus/sound/barney/nodrill.wav","rus/sound/barney/missingleg.wav","rus/sound/barney/luckwillturn.wav","rus/sound/barney/gladof38.wav","rus/sound/barney/gettingcloser.wav","rus/sound/barney/crewdied.wav","rus/sound/barney/ba_idle0.wav","rus/sound/barney/badarea.wav","rus/sound/barney/beertopside.wav"}
	self.SoundTbl_IdleDialogueAnswer = {"rus/sound/barney/yup.wav","rus/sound/barney/youtalkmuch.wav","rus/sound/barney/yougotit.wav","rus/sound/barney/youbet.wav","rus/sound/barney/yessir.wav","rus/sound/barney/soundsright.wav","rus/sound/barney/noway.wav","rus/sound/barney/nope.wav","rus/sound/barney/nosir.wav","rus/sound/barney/notelling.wav","rus/sound/barney/maybe.wav","rus/sound/barney/justdontknow.wav","rus/sound/barney/ireckon.wav","rus/sound/barney/iguess.wav","rus/sound/barney/icanhear.wav","rus/sound/barney/guyresponsible.wav","rus/sound/barney/dontreckon.wav","rus/sound/barney/dontguess.wav","rus/sound/barney/dontfigure.wav","rus/sound/barney/dontbuyit.wav","rus/sound/barney/dontbet.wav","rus/sound/barney/dontaskme.wav","rus/sound/barney/cantfigure.wav","rus/sound/barney/bequiet.wav","rus/sound/barney/ba_stare0.wav","rus/sound/barney/alreadyasked.wav"}
	self.SoundTbl_CombatIdle = {"rus/sound/barney/whatgood.wav","rus/sound/barney/targetpractice.wav","rus/sound/barney/easily.wav","rus/sound/barney/getanyworse.wav"}
	self.SoundTbl_FollowPlayer = {"rus/sound/barney/yougotit.wav","rus/sound/barney/wayout.wav","rus/sound/barney/teamup1.wav","rus/sound/barney/teamup2.wav","rus/sound/barney/rightway.wav","rus/sound/barney/letsgo.wav","rus/sound/barney/letsmoveit.wav","rus/sound/barney/imwithyou.wav","rus/sound/barney/gladtolendhand.wav","rus/sound/barney/dobettertogether.wav","rus/sound/barney/c1a2_ba_goforit.wav","rus/sound/barney/ba_ok1.wav","rus/sound/barney/ba_ok2.wav","rus/sound/barney/ba_ok3.wav","rus/sound/barney/ba_idle1.wav","rus/sound/barney/ba_ht06_11.wav"}
	self.SoundTbl_UnFollowPlayer = {"rus/sound/barney/waitin.wav","rus/sound/barney/stop2.wav","rus/sound/barney/standguard.wav","rus/sound/barney/slowingyoudown.wav","rus/sound/barney/seeya.wav","rus/sound/barney/iwaithere.wav","rus/sound/barney/illwait.wav","rus/sound/barney/helpothers.wav","rus/sound/barney/ba_wait1.wav","rus/sound/barney/ba_wait2.wav","rus/sound/barney/ba_wait3.wav","rus/sound/barney/ba_wait4.wav","rus/sound/barney/ba_security2_pass.wav","rus/sound/barney/aintgoin.wav","rus/sound/barney/ba_becareful1.wav"}
	self.SoundTbl_OnPlayerSight = {"rus/sound/barney/mrfreeman.wav","rus/sound/barney/howyoudoing.wav","rus/sound/barney/howdy.wav","rus/sound/barney/heybuddy.wav","rus/sound/barney/heyfella.wav","rus/sound/barney/hellonicesuit.wav","rus/sound/barney/ba_stare1.wav","rus/sound/barney/ba_later.wav","rus/sound/barney/ba_idle4.wav","rus/sound/barney/ba_idle3.wav","rus/sound/barney/ba_ok4.wav","rus/sound/barney/ba_ok5.wav","rus/sound/barney/ba_ht06_03.wav","rus/sound/barney/ba_ht06_03_alt.wav","rus/sound/barney/ba_hello0.wav","rus/sound/barney/ba_hello1.wav","rus/sound/barney/ba_hello2.wav","rus/sound/barney/ba_hello3.wav","rus/sound/barney/ba_hello4.wav","rus/sound/barney/ba_hello5.wav","rus/sound/barney/armedforces.wav"}
	self.SoundTbl_Investigate = {"rus/sound/barney/youhearthat.wav","rus/sound/barney/soundsbad.wav","rus/sound/barney/icanhear.wav","rus/sound/barney/hearsomething2.wav","rus/sound/barney/hearsomething.wav","rus/sound/barney/ambush.wav","rus/sound/barney/ba_generic0.wav"}
	self.SoundTbl_Alert = {"rus/sound/barney/ba_openfire.wav","rus/sound/barney/ba_attack1.wav","rus/sound/barney/aimforhead.wav"}
	self.SoundTbl_CallForHelp = {"rus/sound/barney/ba_needhelp0.wav","rus/sound/barney/ba_needhelp1.wav"}
	self.SoundTbl_BecomeEnemyToPlayer = {"rus/sound/barney/ba_uwish.wav","rus/sound/barney/ba_tomb.wav","rus/sound/barney/ba_somuch.wav","rus/sound/barney/ba_mad3.wav","rus/sound/barney/ba_iwish.wav","rus/sound/barney/ba_endline.wav","rus/sound/barney/aintscared.wav"}
	self.SoundTbl_Suppressing = {"rus/sound/barney/c1a4_ba_octo2.wav","rus/sound/barney/c1a4_ba_octo4.wav","rus/sound/barney/c1a4_ba_octo3.wav","rus/sound/barney/ba_generic1.wav","rus/sound/barney/ba_bring.wav","rus/sound/barney/ba_attacking1.wav"}
	self.SoundTbl_OnGrenadeSight = {"rus/sound/barney/standback.wav","rus/sound/barney/ba_heeey.wav"}
	self.SoundTbl_OnDangerSight = {"rus/sound/barney/standback.wav","rus/sound/barney/ba_heeey.wav"}
	self.SoundTbl_OnKilledEnemy = {"rus/sound/barney/soundsbad.wav","rus/sound/barney/ba_seethat.wav","rus/sound/barney/ba_kill0.wav","rus/sound/barney/ba_gotone.wav","rus/sound/barney/ba_firepl.wav","rus/sound/barney/ba_buttugly.wav","rus/sound/barney/ba_another.wav","rus/sound/barney/ba_close.wav"}
	self.SoundTbl_AllyDeath = {"rus/sound/barney/die.wav"}
	self.SoundTbl_GrenadeAttack = {"rus/sound/barney/c1a4_ba_octo4.wav"}
	self.SoundTbl_Pain = {"rus/sound/barney/imhit.wav","rus/sound/barney/hitbad.wav","rus/sound/barney/c1a2_ba_4zomb.wav","rus/sound/barney/ba_pain1.wav","rus/sound/barney/ba_pain2.wav","rus/sound/barney/ba_pain3.wav"}
	self.SoundTbl_DamageByPlayer = {"rus/sound/barney/donthurtem.wav","rus/sound/barney/ba_whoathere.wav","rus/sound/barney/ba_whatyou.wav","rus/sound/barney/ba_watchit.wav","rus/sound/barney/ba_shot1.wav","rus/sound/barney/ba_shot2.wav","rus/sound/barney/ba_shot3.wav","rus/sound/barney/ba_shot4.wav","rus/sound/barney/ba_shot5.wav","rus/sound/barney/ba_shot6.wav","rus/sound/barney/ba_shot7.wav","rus/sound/barney/ba_stepoff.wav","rus/sound/barney/ba_pissme.wav","rus/sound/barney/ba_mad1.wav","rus/sound/barney/ba_mad0.wav","rus/sound/barney/ba_friends.wav","rus/sound/barney/ba_dotoyou.wav","rus/sound/barney/ba_dontmake.wav","rus/sound/barney/ba_crazy.wav"}
	self.SoundTbl_Death = {"rus/sound/barney/ba_ht06_02_alt.wav","rus/sound/barney/ba_die1.wav","rus/sound/barney/ba_die2.wav","rus/sound/barney/ba_die3.wav"}	
	end	

self.SoundTbl_MeleeAttack = {"npc/zombie/claw_strike1.wav","npc/zombie/claw_strike2.wav","npc/zombie/claw_strike3.wav"}
self.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav","npc/zombie/claw_miss2.wav"}
	self.AnimTbl_Death = {ACT_DIEBACKWARD, ACT_DIEFORWARD, ACT_DIE_GUTSHOT, ACT_DIE_HEADSHOT, ACT_DIESIMPLE} -- Death Animations
	
	self:Give("weapon_vj_hlr1_dualglockbarn")
end

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(13, 13, 76), Vector(-13, -13, 0))
	self:SetBodygroup(0, 4)
	self:SetBodygroup(1, 3)
	local iBodygroupRNGZero = math.random( 0 , 1 )
    self:SetBodygroup( 8 , iBodygroupRNGZero )
	self.totalDamage = {}
	self:SetWeaponState(VJ_WEP_STATE_HOLSTERED)
	if GetConVar("vj_hl1_explosives"):GetInt() == 1 then
		 self.HasGrenadeAttack = false
	end	 
	if GetConVar("vj_hl1_explosives"):GetInt() == 0 then
	self.HasGrenadeAttack = true
	end
	if self:GetModel() == "models/hl1/pythonrus/sound/barneyey.mdl" then // Already the default
		self.Security_Type = 0
	elseif self:GetModel() == "models/vj_hlr/opfor/otis.mdl" then
		self.Security_Type = 1
	elseif self:GetModel() == "models/vj_hlr/hla/rus/sound/barneyey.mdl" then
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
	ply:ChatPrint("LALT: Holster / Unholster Dual Glock 17")
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
	end
end

function ENT:CustomOnWeaponReload()
-- Drop the mag when reloading
self:CreateGibEntity("obj_vj_gib", "models/mags/glockmag.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "weapons2/magbounce.wav"}})
self:CreateGibEntity("obj_vj_gib", "models/mags/glockmag.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "weapons2/magbounce.wav"}})
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
		
		
	-- If Barney is bleeding then inform the player that Barney have 1 minute to live	
	if self.IsFollowing and self.Security_Bleeding == true and not self.hasPrintedMessage then
    Entity( 1 ):ChatPrint("Barney is bleeding, find a medic ASAP! You have 1 minute...")
    self.hasPrintedMessage = true
            self.lifespan = 60
            timer.Create("Countdown_" .. self:EntIndex(), 1, 0, function()
                if self.lifespan then
                    self.lifespan = self.lifespan - 1
                    if self.lifespan <= 15 && self.IsFollowing && self.Security_Bleeding == true then
                        BroadcastLua("chat.AddText(Color(255, 0, 0), 'Barney will die in " .. self.lifespan .. " seconds! Find a medic ASAP!')")
                    end
                    
                    if self.lifespan <= 0 && self.IsFollowing && self.Security_Bleeding == true then
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
	"barn/imhit.wav",
	"barn/hitbad.wav",
	"barn/imdead.wav",
	"barn/c1a2_ba_4zomb.wav",
	"barn/ba_pain1.wav",
	"barn/ba_pain2.wav",
	"barn/ba_pain3.wav"
	}
	
		local soundListrus = {
    "rus/sound/barney/imhit.wav",
    "rus/sound/barney/hitbad.wav",
	"rus/sound/barney/imdead.wav",
    "rus/sound/barney/c1a2_ba_4zomb.wav",
    "rus/sound/barney/ba_pain1.wav",
    "rus/sound/barney/ba_pain2.wav",
    "rus/sound/barney/ba_pain3.wav"
}
    local randomIndex = math.random(1, #soundList)
    local soundToPlay = soundList[randomIndex]
	    local randomIndexrus = math.random(1, #soundListrus)
    local soundToPlayrus = soundListrus[randomIndexrus]		
		-- Ouch sound when low health
if self.Security_UsingHurtWalk then
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
            self:SetSkin(2)
            self.Security_UsingHurtWalk = true
            end
    elseif self.Security_UsingHurtWalk then
        self.AnimTbl_Walk = {ACT_WALK}
        self.AnimTbl_Run = {ACT_RUN}
        self.AnimTbl_IdleStand = {ACT_IDLE}
        self.AnimTbl_ShootWhileMovingWalk = {ACT_WALK}
        self.AnimTbl_ShootWhileMovingRun = {ACT_RUN}
		self:SetSkin(0)
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
				self:PlaySoundSystem("Alert", {"rus/sound/barney/c1a4_ba_octo1.wav"})
				self.NextAlertSoundT = CurTime() + math.Rand(self.NextSoundTime_Alert.a, self.NextSoundTime_Alert.b)
			elseif ent.IsVJBaseSNPC_Creature == true then
				self:PlaySoundSystem("Alert", {"rus/sound/barney/diebloodsucker.wav"})
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
        if self:GetBodygroup(8) == 1 then
            return -- Stop the code if the helmet bodygroup is 8 and 1
        end
    -- Make a metal effect when the helmet is hit!
    self.Bleeds = true
    if self.Security_Type == 1 then return end -- Only types that do have a helmet
    if hitgroup == HITGROUP_GEAR then
        -- Check if the helmet bodygroup is already disabled

        self.Bleeds = false -- Disable bleeding temporarily when shot at the helmet

        -- Rest of the code for hitting the helmet...
        local rico = EffectData()
        rico:SetOrigin(dmginfo:GetDamagePosition())
        rico:SetScale(4) -- Size
        rico:SetMagnitude(math.random(1, 2)) -- Effect type | 1 = Animated | 2 = Basic
        util.Effect("VJ_HLR_Rico", rico)
        
        if dmginfo:GetDamage() >= 10 then
            self:CreateGibEntity("obj_vj_gib", "models/bshift/items/helmet.mdl", {BloodDecal = "", Pos = self:LocalToWorld(Vector(0, 0, 0)), CollideSound = {"gore/ricmet2.wav"}})
            self:SetBodygroup(8, 1)
        end
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
	            self:SetBodygroup(6, 1)
				            self:SetBodygroup(7, 1)
							            self:SetBodygroup(0, 1)
										            self:SetBodygroup(3, 1)
													           self:SetBodygroup(4, 1)
															               self:SetBodygroup(5, 1)
																		               self:SetBodygroup(2, 1)
																					               self:SetBodygroup(0, 3)
																								               self:SetBodygroup(8, 1)
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh1.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh2.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh3.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh4.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_b_bone.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,50)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_b_gib.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/gib/hgibs" .. math.random(2, 3) .. ".mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_hmeat.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_lung.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_skull.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,60)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/bshift/items/helmet.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,0)),CollideSound={"gore/ricmet2.wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gibs/humans/brain_gib.mdl", {BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gore/bargib1.mdl", {BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gore/bargib1.mdl", {BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/gore/ba_leg.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib","models/gore/ba_leg.mdl",{BloodDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
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
	self:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
	self:DropWeaponOnDeathCode(dmginfo, hitgroup)
	if IsValid(self:GetActiveWeapon()) then self:GetActiveWeapon():Remove() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo, hitgroup)
    local pos = self:GetPos()
    local norm = self:GetAngles():Up()
    local ignore = {self, self:GetOwner()}
    local mask = MASK_SHOT_HULL

    local rtr = util.TraceLine({
        start = pos,
        endpos = pos + norm * 40,
        filter = ignore,
        mask = mask
    })

    local ang -- Declare the 'ang' variable

    if IsValid(rtr.Entity) and rtr.Entity == self then
        local bone = rtr.PhysicsBone
        pos = rtr.HitPos
        ang = Angle(-28, 0, 0) + rtr.Normal:Angle()
        ang:RotateAroundAxis(ang:Right(), -90)
        pos = pos - (ang:Forward() * 10)
    else
        ang = self:GetAngles() -- Use the entity's existing angles as fallback
    end

    local knife = ents.Create("prop_physics")
    knife:SetModel("models/vj_hlr/weapons/w_9mmhandgun.mdl")
    knife:SetPos(pos)
    knife:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
    knife:SetAngles(ang)
    knife.CanPickup = false
    knife:Spawn()

    self:SetBodygroup(1, 2)
	if ( self:IsOnFire() ) then
	self:SetSkin(1)
end
end

function ENT:CustomOnWeaponAttack()
local wep = self:GetActiveWeapon()
	local att = self:GetAttachment(3)
	local ene = self:GetEnemy()
	if wep:Clip2() > 0 then
	return 
	end
	if self:IsValid() && IsValid(self:GetEnemy()) then
		self:FireBullets({
			Attacker = self,
			Dir = (ene:GetPos() + ene:OBBCenter() - att.Pos):Angle():Forward(),
			Spread = Vector(0.1,0.1,0),
			TracerName = "VJ_HLR_Tracer",
			AmmoType = "Pistol",
			Distance = 2048,
			Src = att.Pos,
			HullSize = 1,
			Damage = 4,
			Force = 5,
			Num = 1
		})
	end
		local muz = ents.Create("env_sprite")
		muz:SetKeyValue("model","vj_hl/sprites/muzzleflash2.vmt")
		muz:SetKeyValue("scale",""..math.Rand(0.3, 0.5))
		muz:SetKeyValue("GlowProxySize","2.0") -- Size of the glow to be rendered for visibility testing.
		muz:SetKeyValue("HDRColorScale","1.0")
		muz:SetKeyValue("renderfx","14")
		muz:SetKeyValue("rendermode","3") -- Set the render mode to "3" (Glow)
		muz:SetKeyValue("renderamt","255") -- Transparency
		muz:SetKeyValue("disablereceiveshadows","0") -- Disable receiving shadows
		muz:SetKeyValue("framerate","10.0") -- Rate at which the sprite should animate, if at all.
		muz:SetKeyValue("spawnflags","0")
		muz:SetParent(self)
		muz:Fire("SetParentAttachment","lhand")
		muz:SetAngles(Angle(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100)))
		muz:Spawn()
		muz:Activate()
		muz:Fire("Kill","",0.08)

		local flash = ents.Create("light_dynamic")
		flash:SetKeyValue("brightness", 8)
		flash:SetKeyValue("distance", 300)
		flash:SetLocalPos(att.Pos)
		flash:SetLocalAngles(self:GetAngles())
		flash:Fire("Color","255 60 9 255")
		flash:Spawn()
		flash:Activate()
		flash:Fire("TurnOn", "", 0)
		flash:Fire("Kill", "", 0.07)
		self:DeleteOnRemove(flash)
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

function ENT:CustomOnTakeDamage_OnBleed(dmginfo, hitgroup, ply, pos, dir)
	if GetConVar("enable_dismemberment"):GetInt() == 0 then
return end



    local damageForce = dmginfo:GetDamageForce():Length()
    self.totalDamage[hitgroup] = (self.totalDamage[hitgroup] or 0) + damageForce

    if hitgroup == HITGROUP_LEFTLEG and self.totalDamage[hitgroup] > 9500 then
        if self:GetBodygroup(6) == 1 then
            return
        end
        -- Code for left leg hitgroup
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
        VJ_EmitSound(self, "gore/amputation_light" .. math.random(1, 2) .. ".wav", 75, 100)
        self:CreateGibEntity("obj_vj_gib", "models/gore/ba_leg.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(6, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_RIGHTLEG and self.totalDamage[hitgroup] > 9500 then
        if self:GetBodygroup(7) == 1 then
            return
        end
        -- Code for right leg hitgroup
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
        VJ_EmitSound(self, "gore/amputation_light" .. math.random(1, 2) .. ".wav", 75, 100)
        self:CreateGibEntity("obj_vj_gib", "models/gore/ba_leg.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(7, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_HEAD and dmginfo:GetDamageForce():Length() > 800 then
        -- Code for head hitgroup
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
        VJ_EmitSound(self, "gore/amputation_light" .. math.random(1, 2) .. ".wav", 75, 100)
        self:CreateGibEntity("obj_vj_gib", "models/gibs/humans/brain_gib.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(0, 5)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_STOMACH and self.totalDamage[hitgroup] > 9500 then
        if self:GetBodygroup(3) == 1 then
            return
        end
        -- Code for stomach hitgroup
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
        VJ_EmitSound(self, "gore/amputation_light" .. math.random(1, 2) .. ".wav", 75, 100)
        self:CreateGibEntity("obj_vj_gib", "models/gib/hgibs" .. math.random(2, 3) .. ".mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 40)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(3, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_LEFTARM and self.totalDamage[hitgroup] > 9500 then
        if self:GetBodygroup(4) == 1 then
            return
        end
        -- Code for left arm hitgroup
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
        VJ_EmitSound(self, "gore/amputation_light" .. math.random(1, 2) .. ".wav", 75, 100)
        self:CreateGibEntity("obj_vj_gib", "models/gore/bargib1.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(4, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_RIGHTARM and self.totalDamage[hitgroup] > 9500 then
        if self:GetBodygroup(5) == 1 then
            return
        end
        -- Code for right arm hitgroup
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
        VJ_EmitSound(self, "gore/amputation_light" .. math.random(1, 2) .. ".wav", 75, 100)
        self:CreateGibEntity("obj_vj_gib", "models/gore/bargib1.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(5, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
        end		
    end
