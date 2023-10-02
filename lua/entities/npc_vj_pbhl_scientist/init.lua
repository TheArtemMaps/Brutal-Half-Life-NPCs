AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/hl1/scientist.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 50
ENT.HullType = HULL_HUMAN
ENT.VJC_Data = {
    ThirdP_Offset = Vector(10, 0, -30), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip02 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"} -- NPCs with the same class with be allied to each other
ENT.FriendsWithAllPlayerAllies = true -- Should this SNPC be friends with all other player allies that are running on VJ Base?
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_hlr_blood_red"}
ENT.CustomBlood_Decal = {"VJ_HLR_Blood_Red"} -- Decals to spawn when it's damaged
ENT.HasBloodPool = false -- Does it have a blood pool?
ENT.Behavior = VJ_BEHAVIOR_PASSIVE -- Doesn't attack anything
ENT.BecomeEnemyToPlayer = true -- Should the friendly SNPC become enemy towards the player if it's damaged by a player?
ENT.HasItemDropsOnDeath = false -- Should it drop items on death?
ENT.HasOnPlayerSight = true -- Should do something when it sees the enemy? Example: Play a sound
ENT.HasMeleeAttack = false -- Should the SNPC have a melee attack?
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
ENT.IsMedicSNPC = true -- Is this SNPC a medic? Does it heal other friendly friendly SNPCs, and players(If friendly)
ENT.Medic_DisableAnimation = true -- if true, it will disable the animation code
ENT.Medic_TimeUntilHeal = 4 -- Time until the ally receives health | Set to false to let the base decide the time
ENT.Medic_SpawnPropOnHeal = false -- Should it spawn a prop, such as small health vial at a attachment when healing an ally?
ENT.HasDeathAnimation = true -- Does it play an animation when it dies?
ENT.AnimTbl_Death = {ACT_DIEBACKWARD,ACT_DIEFORWARD,ACT_DIESIMPLE} -- Death Animations
ENT.DeathAnimationTime = false -- Time until the SNPC spawns its corpse and gets removed
ENT.CombatFaceEnemy = false -- If enemy is exists and is visible

	-- ====== Flinching Variables ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_SMALL_FLINCH} -- If it uses normal based animation, use this
ENT.HitGroupFlinching_Values = {{HitGroup = {HITGROUP_LEFTLEG}, Animation = {ACT_FLINCH_LEFTLEG}},{HitGroup = {HITGROUP_RIGHTLEG}, Animation = {ACT_FLINCH_RIGHTLEG}}}
	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
local sdTie = {"vj_hlr/hl1_npc/scientist/weartie.wav","vj_hlr/hl1_npc/scientist/ties.wav"}
local sdStep = {"commonbhl/npc_step1.wav","commonbhl/npc_step2.wav","commonbhl/npc_step3.wav","commonbhl/npc_step4.wav"}
local sdTierus = {"rus/sound/scientist/weartie.wav","rus/sound/scientist/ties.wav"}
ENT.SoundTbl_FootStep = sdStep

ENT.GeneralSoundPitch1 = 100

-- Custom
ENT.SCI_NextMouthMove = 0
ENT.SCI_NextMouthDistance = 0
ENT.SCI_Type = 0
	-- 0 = Regular Scientist and Dr. Rosenberg
	-- 1 = Cleansuit Scientist
	-- 2 = Dr. Keller
	-- 3 = Alpha Scientist
ENT.SCI_CurAnims = -1 -- 0 = Regular | 1 = Scared | 2 = Grabbed by barnacle
ENT.SCI_NextTieAnnoyanceT = 0
ENT.SCI_ControllerAnim = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	if self:GetModel() == "models/hl1/scientist.mdl" then
		self.SCI_Type = 0
	elseif self:GetModel() == "models/vj_hlr/opfor/cleansuit_scientist.mdl" then
		self.SCI_Type = 1
	elseif self:GetModel() == "models/vj_hlr/decay/wheelchair_sci.mdl" then
		self.SCI_Type = 2
	elseif self:GetModel() == "models/vj_hlr/hla/scientist.mdl" then
		self.SCI_Type = 3
	end
	self:SCI_CustomOnInitialize()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SCI_CustomOnInitialize()
	self.SoundTbl_Idle = {"vj_hlr/hl1_npc/scientist/administrator.wav","vj_hlr/hl1_npc/scientist/c1a0_sci_stall.wav","vj_hlr/hl1_npc/scientist/c1a1_sci_3scan.wav","vj_hlr/hl1_npc/scientist/c1a1_sci_2scan.wav","vj_hlr/hl1_npc/scientist/c1a1_sci_1scan.wav","vj_hlr/hl1_npc/scientist/c1a4_sci_trainend.wav","vj_hlr/hl1_npc/scientist/containfail.wav","vj_hlr/hl1_npc/scientist/cough.wav","vj_hlr/hl1_npc/scientist/fusionshunt.wav","vj_hlr/hl1_npc/scientist/hopenominal.wav","vj_hlr/hl1_npc/scientist/hideglasses.wav","vj_hlr/hl1_npc/scientist/howinteresting.wav","vj_hlr/hl1_npc/scientist/ipredictedthis.wav","vj_hlr/hl1_npc/scientist/needsleep.wav","vj_hlr/hl1_npc/scientist/neverseen.wav","vj_hlr/hl1_npc/scientist/nogrant.wav","vj_hlr/hl1_npc/scientist/organicmatter.wav","vj_hlr/hl1_npc/scientist/peculiarmarks.wav","vj_hlr/hl1_npc/scientist/peculiarodor.wav","vj_hlr/hl1_npc/scientist/reportflux.wav","vj_hlr/hl1_npc/scientist/runtest.wav","vj_hlr/hl1_npc/scientist/shutdownchart.wav","vj_hlr/hl1_npc/scientist/somethingfoul.wav","vj_hlr/hl1_npc/scientist/sneeze.wav","vj_hlr/hl1_npc/scientist/sniffle.wav","vj_hlr/hl1_npc/scientist/stench.wav","vj_hlr/hl1_npc/scientist/thatsodd.wav","vj_hlr/hl1_npc/scientist/thatsmell.wav","vj_hlr/hl1_npc/scientist/allnominal.wav","vj_hlr/hl1_npc/scientist/importantspecies.wav","vj_hlr/hl1_npc/scientist/yawn.wav","vj_hlr/hl1_npc/scientist/whoresponsible.wav","vj_hlr/hl1_npc/scientist/uselessphd.wav"}
	self.SoundTbl_IdleDialogue = {"vj_hlr/hl1_npc/scientist/alienappeal.wav","vj_hlr/hl1_npc/scientist/alientrick.wav","vj_hlr/hl1_npc/scientist/analysis.wav","vj_hlr/hl1_npc/scientist/announcer.wav","vj_hlr/hl1_npc/scientist/bloodsample.wav","vj_hlr/hl1_npc/scientist/beverage.wav","vj_hlr/hl1_npc/scientist/areyouthink.wav","vj_hlr/hl1_npc/scientist/catchone.wav","vj_hlr/hl1_npc/scientist/cascade.wav","vj_hlr/hl1_npc/scientist/everseen.wav","vj_hlr/hl1_npc/scientist/doyousmell.wav","vj_hlr/hl1_npc/scientist/donuteater.wav","vj_hlr/hl1_npc/scientist/dinner.wav","vj_hlr/hl1_npc/scientist/fascinating.wav","vj_hlr/hl1_npc/scientist/headcrab.wav","vj_hlr/hl1_npc/scientist/goodpaper.wav","vj_hlr/hl1_npc/scientist/improbable.wav","vj_hlr/hl1_npc/scientist/hungryyet.wav","vj_hlr/hl1_npc/scientist/koso.wav","vj_hlr/hl1_npc/scientist/lambdalab.wav","vj_hlr/hl1_npc/scientist/newsample.wav","vj_hlr/hl1_npc/scientist/nothostile.wav","vj_hlr/hl1_npc/scientist/perfectday.wav","vj_hlr/hl1_npc/scientist/recalculate.wav","vj_hlr/hl1_npc/scientist/purereadings.wav","vj_hlr/hl1_npc/scientist/rumourclean.wav","vj_hlr/hl1_npc/scientist/shakeunification.wav","vj_hlr/hl1_npc/scientist/seencup.wav","vj_hlr/hl1_npc/scientist/smellburn.wav","vj_hlr/hl1_npc/scientist/softethics.wav","vj_hlr/hl1_npc/scientist/stimulating.wav","vj_hlr/hl1_npc/scientist/simulation.wav","vj_hlr/hl1_npc/scientist/statusreport.wav","vj_hlr/hl1_npc/scientist/tunedtoday.wav","vj_hlr/hl1_npc/scientist/sunsets.wav","vj_hlr/hl1_npc/scientist/survival.wav","vj_hlr/hl1_npc/scientist/tunnelcalc.wav","vj_hlr/hl1_npc/scientist/delayagain.wav","vj_hlr/hl1_npc/scientist/safetyinnumbers.wav","vj_hlr/hl1_npc/scientist/chaostheory.wav","vj_hlr/hl1_npc/scientist/checkatten.wav","vj_hlr/hl1_npc/scientist/chimp.wav"}
	self.SoundTbl_IdleDialogueAnswer = {"vj_hlr/hl1_npc/scientist/yees.wav","vj_hlr/hl1_npc/scientist/yes3.wav","vj_hlr/hl1_npc/scientist/absolutely.wav","vj_hlr/hl1_npc/scientist/absolutelynot.wav","vj_hlr/hl1_npc/scientist/cantbeserious.wav","vj_hlr/hl1_npc/scientist/completelywrong.wav","vj_hlr/hl1_npc/scientist/correcttheory.wav","vj_hlr/hl1_npc/scientist/whocansay.wav","vj_hlr/hl1_npc/scientist/whyaskme.wav","vj_hlr/hl1_npc/scientist/stopasking.wav","vj_hlr/hl1_npc/scientist/theoretically.wav","vj_hlr/hl1_npc/scientist/shutup.wav","vj_hlr/hl1_npc/scientist/shutup2.wav","vj_hlr/hl1_npc/scientist/sci_bother.wav","vj_hlr/hl1_npc/scientist/perhaps.wav","vj_hlr/hl1_npc/scientist/positively.wav","vj_hlr/hl1_npc/scientist/repeat.wav","vj_hlr/hl1_npc/scientist/ridiculous.wav","vj_hlr/hl1_npc/scientist/right.wav","vj_hlr/hl1_npc/scientist/ofcourse.wav","vj_hlr/hl1_npc/scientist/ofcoursenot.wav","vj_hlr/hl1_npc/scientist/nodoubt.wav","vj_hlr/hl1_npc/scientist/noguess.wav","vj_hlr/hl1_npc/scientist/noidea.wav","vj_hlr/hl1_npc/scientist/noo.wav","vj_hlr/hl1_npc/scientist/notcertain.wav","vj_hlr/hl1_npc/scientist/notsure.wav","vj_hlr/hl1_npc/scientist/dontconcur.wav","vj_hlr/hl1_npc/scientist/dontknow.wav","vj_hlr/hl1_npc/scientist/ibelieveso.wav","vj_hlr/hl1_npc/scientist/idiotic.wav","vj_hlr/hl1_npc/scientist/idontthinkso.wav","vj_hlr/hl1_npc/scientist/imsure.wav","vj_hlr/hl1_npc/scientist/inconclusive.wav","vj_hlr/hl1_npc/scientist/justasked.wav"}
	self.SoundTbl_CombatIdle = {"vj_hlr/hl1_npc/scientist/scream01.wav","vj_hlr/hl1_npc/scientist/scream02.wav","vj_hlr/hl1_npc/scientist/scream03.wav","vj_hlr/hl1_npc/scientist/scream04.wav","vj_hlr/hl1_npc/scientist/scream05.wav","vj_hlr/hl1_npc/scientist/scream06.wav","vj_hlr/hl1_npc/scientist/scream07.wav","vj_hlr/hl1_npc/scientist/scream08.wav","vj_hlr/hl1_npc/scientist/scream09.wav","vj_hlr/hl1_npc/scientist/scream10.wav","vj_hlr/hl1_npc/scientist/scream11.wav","vj_hlr/hl1_npc/scientist/scream12.wav","vj_hlr/hl1_npc/scientist/scream13.wav","vj_hlr/hl1_npc/scientist/scream14.wav","vj_hlr/hl1_npc/scientist/scream15.wav","vj_hlr/hl1_npc/scientist/scream16.wav","vj_hlr/hl1_npc/scientist/scream17.wav","vj_hlr/hl1_npc/scientist/scream18.wav","vj_hlr/hl1_npc/scientist/scream19.wav","vj_hlr/hl1_npc/scientist/scream20.wav","vj_hlr/hl1_npc/scientist/scream22.wav","vj_hlr/hl1_npc/scientist/scream23.wav","vj_hlr/hl1_npc/scientist/scream24.wav","vj_hlr/hl1_npc/scientist/scream25.wav","vj_hlr/hl1_npc/scientist/sci_fear8.wav","vj_hlr/hl1_npc/scientist/sci_fear7.wav","vj_hlr/hl1_npc/scientist/sci_fear15.wav","vj_hlr/hl1_npc/scientist/sci_fear2.wav","vj_hlr/hl1_npc/scientist/sci_fear3.wav","vj_hlr/hl1_npc/scientist/sci_fear4.wav","vj_hlr/hl1_npc/scientist/sci_fear5.wav","vj_hlr/hl1_npc/scientist/sci_fear11.wav","vj_hlr/hl1_npc/scientist/sci_fear12.wav","vj_hlr/hl1_npc/scientist/sci_fear13.wav","vj_hlr/hl1_npc/scientist/sci_fear1.wav","vj_hlr/hl1_npc/scientist/rescueus.wav","vj_hlr/hl1_npc/scientist/nooo.wav","vj_hlr/hl1_npc/scientist/noplease.wav","vj_hlr/hl1_npc/scientist/madness.wav","vj_hlr/hl1_npc/scientist/gottogetout.wav","vj_hlr/hl1_npc/scientist/getoutofhere.wav","vj_hlr/hl1_npc/scientist/getoutalive.wav","vj_hlr/hl1_npc/scientist/evergetout.wav","vj_hlr/hl1_npc/scientist/dontwantdie.wav","vj_hlr/hl1_npc/scientist/b01_sci01_whereami.wav","vj_hlr/hl1_npc/scientist/cantbeworse.wav","vj_hlr/hl1_npc/scientist/canttakemore.wav"}
	self.SoundTbl_FollowPlayer = {"vj_hlr/hl1_npc/scientist/yes.wav","vj_hlr/hl1_npc/scientist/yes2.wav","vj_hlr/hl1_npc/scientist/yesletsgo.wav","vj_hlr/hl1_npc/scientist/yesok.wav","vj_hlr/hl1_npc/scientist/yesihope.wav","vj_hlr/hl1_npc/scientist/waithere.wav","vj_hlr/hl1_npc/scientist/rightwayout.wav","vj_hlr/hl1_npc/scientist/protectme.wav","vj_hlr/hl1_npc/scientist/okgetout.wav","vj_hlr/hl1_npc/scientist/okihope.wav","vj_hlr/hl1_npc/scientist/odorfromyou.wav","vj_hlr/hl1_npc/scientist/letsgo.wav","vj_hlr/hl1_npc/scientist/leadtheway.wav","vj_hlr/hl1_npc/scientist/icanhelp.wav","vj_hlr/hl1_npc/scientist/hopeyouknow.wav","vj_hlr/hl1_npc/scientist/fellowscientist.wav","vj_hlr/hl1_npc/scientist/excellentteam.wav","vj_hlr/hl1_npc/scientist/d01_sci14_right.wav","vj_hlr/hl1_npc/scientist/c1a0_sci_scanrpt.wav","vj_hlr/hl1_npc/scientist/alright.wav"}
	self.SoundTbl_UnFollowPlayer = {"vj_hlr/hl1_npc/scientist/whyleavehere.wav","vj_hlr/hl1_npc/scientist/slowingyou.wav","vj_hlr/hl1_npc/scientist/reconsider.wav","vj_hlr/hl1_npc/scientist/leavingme.wav","vj_hlr/hl1_npc/scientist/istay.wav","vj_hlr/hl1_npc/scientist/illwaithere.wav","vj_hlr/hl1_npc/scientist/illwait.wav","vj_hlr/hl1_npc/scientist/fine.wav","vj_hlr/hl1_npc/scientist/d01_sci14_right.wav","vj_hlr/hl1_npc/scientist/crowbar.wav","vj_hlr/hl1_npc/scientist/cantbeserious.wav","vj_hlr/hl1_npc/scientist/c1a3_sci_1man.wav","vj_hlr/hl1_npc/scientist/c1a1_sci_5scan.wav","vj_hlr/hl1_npc/scientist/asexpected.wav","vj_hlr/hl1_npc/scientist/beenaburden.wav"}
	self.SoundTbl_MoveOutOfPlayersWay = {"vj_hlr/hl1_npc/scientist/sorryimleaving.wav","vj_hlr/hl1_npc/scientist/excuse.wav"}
	self.SoundTbl_MedicBeforeHeal = {"vj_hlr/hl1_npc/scientist/youlookbad.wav","vj_hlr/hl1_npc/scientist/youlookbad2.wav","vj_hlr/hl1_npc/scientist/youneedmedic.wav","vj_hlr/hl1_npc/scientist/youwounded.wav","vj_hlr/hl1_npc/scientist/thiswillhelp.wav","vj_hlr/hl1_npc/scientist/letstrythis.wav","vj_hlr/hl1_npc/scientist/letmehelp.wav","vj_hlr/hl1_npc/scientist/holdstill.wav","vj_hlr/hl1_npc/scientist/heal1.wav","vj_hlr/hl1_npc/scientist/heal2.wav","vj_hlr/hl1_npc/scientist/heal3.wav","vj_hlr/hl1_npc/scientist/heal4.wav","vj_hlr/hl1_npc/scientist/heal5.wav"}
	self.SoundTbl_OnPlayerSight = {"vj_hlr/hl1_npc/scientist/undertest.wav","vj_hlr/hl1_npc/scientist/sci_somewhere.wav","vj_hlr/hl1_npc/scientist/saved.wav","vj_hlr/hl1_npc/scientist/newhevsuit.wav","vj_hlr/hl1_npc/scientist/keller.wav","vj_hlr/hl1_npc/scientist/inmesstoo.wav","vj_hlr/hl1_npc/scientist/hellothere.wav","vj_hlr/hl1_npc/scientist/hellofromlab.wav","vj_hlr/hl1_npc/scientist/hellofreeman.wav","vj_hlr/hl1_npc/scientist/hello.wav","vj_hlr/hl1_npc/scientist/greetings.wav","vj_hlr/hl1_npc/scientist/greetings2.wav","vj_hlr/hl1_npc/scientist/goodtoseeyou.wav","vj_hlr/hl1_npc/scientist/freemanalive.wav","vj_hlr/hl1_npc/scientist/freeman.wav","vj_hlr/hl1_npc/scientist/fix.wav","vj_hlr/hl1_npc/scientist/corporal.wav","vj_hlr/hl1_npc/scientist/c3a2_sci_1surv.wav","vj_hlr/hl1_npc/scientist/c2a4_sci_surgury.wav","vj_hlr/hl1_npc/scientist/c1a3_sci_thankgod.wav","vj_hlr/hl1_npc/scientist/c1a0_sci_itsyou.wav","vj_hlr/hl1_npc/scientist/c1a0_sci_gm1.wav","vj_hlr/hl1_npc/scientist/c1a0_sci_gm.wav","vj_hlr/hl1_npc/scientist/afellowsci.wav","vj_hlr/hl1_npc/scientist/ahfreeman.wav","vj_hlr/hl1_npc/scientist/c1a0_sci_bigday.wav","vj_hlr/hl1_npc/scientist/c1a0_sci_ctrl4a.wav"}
	self.SoundTbl_Investigate = {"vj_hlr/hl1_npc/scientist/whatissound.wav","vj_hlr/hl1_npc/scientist/overhere.wav","vj_hlr/hl1_npc/scientist/lowervoice.wav","vj_hlr/hl1_npc/scientist/ihearsomething.wav","vj_hlr/hl1_npc/scientist/hello2.wav","vj_hlr/hl1_npc/scientist/hearsomething.wav","vj_hlr/hl1_npc/scientist/didyouhear.wav","vj_hlr/hl1_npc/scientist/d01_sci10_interesting.wav","vj_hlr/hl1_npc/scientist/c3a2_sci_1glu.wav"}
	self.SoundTbl_Alert = {"vj_hlr/hl1_npc/scientist/startle1.wav","vj_hlr/hl1_npc/scientist/startle2.wav","vj_hlr/hl1_npc/scientist/startle3.wav","vj_hlr/hl1_npc/scientist/startle4.wav","vj_hlr/hl1_npc/scientist/startle5.wav","vj_hlr/hl1_npc/scientist/startle6.wav","vj_hlr/hl1_npc/scientist/startle7.wav","vj_hlr/hl1_npc/scientist/startle8.wav","vj_hlr/hl1_npc/scientist/startle9.wav","vj_hlr/hl1_npc/scientist/startle1.wav","vj_hlr/hl1_npc/scientist/startle2.wav","vj_hlr/hl1_npc/scientist/c1a3_sci_silo2a.wav"}
	self.SoundTbl_BecomeEnemyToPlayer = {"vj_hlr/hl1_npc/scientist/getalong.wav","vj_hlr/hl1_npc/scientist/advance.wav","vj_hlr/hl1_npc/scientist/c2a4_sci_alldie.wav"}
	self.SoundTbl_OnGrenadeSight = {"vj_hlr/hl1_npc/scientist/sci_fear6.wav","vj_hlr/hl1_npc/scientist/sci_fear14.wav","vj_hlr/hl1_npc/scientist/c1a2_sci_1zomb.wav"}
	self.SoundTbl_OnDangerSight = {"vj_hlr/hl1_npc/scientist/sci_fear6.wav","vj_hlr/hl1_npc/scientist/sci_fear14.wav"}
	self.SoundTbl_AllyDeath = {"vj_hlr/hl1_npc/scientist/whatnext.wav","vj_hlr/hl1_npc/scientist/luckwillchange.wav"}
	self.SoundTbl_Pain = {"vj_hlr/hl1_npc/scientist/sci_pain1.wav","vj_hlr/hl1_npc/scientist/sci_pain2.wav","vj_hlr/hl1_npc/scientist/sci_pain3.wav","vj_hlr/hl1_npc/scientist/sci_pain4.wav","vj_hlr/hl1_npc/scientist/sci_pain5.wav","vj_hlr/hl1_npc/scientist/sci_pain6.wav","vj_hlr/hl1_npc/scientist/sci_pain7.wav","vj_hlr/hl1_npc/scientist/sci_pain8.wav","vj_hlr/hl1_npc/scientist/sci_pain9.wav","vj_hlr/hl1_npc/scientist/sci_pain10.wav","vj_hlr/hl1_npc/scientist/sci_fear9.wav","vj_hlr/hl1_npc/scientist/sci_fear10.wav","vj_hlr/hl1_npc/scientist/c1a2_sci_dangling.wav","vj_hlr/hl1_npc/scientist/iwounded.wav","vj_hlr/hl1_npc/scientist/iwounded2.wav","vj_hlr/hl1_npc/scientist/iwoundedbad.wav"}
	self.SoundTbl_DamageByPlayer = {"vj_hlr/hl1_npc/scientist/youinsane.wav","vj_hlr/hl1_npc/scientist/whatyoudoing.wav","vj_hlr/hl1_npc/scientist/please.wav","vj_hlr/hl1_npc/scientist/c3a2_sci_fool.wav","vj_hlr/hl1_npc/scientist/c1a3_sci_team.wav","vj_hlr/hl1_npc/scientist/c1a0_sci_stayback.wav","vj_hlr/hl1_npc/scientist/c1a2_sci_3zomb.wav","vj_hlr/hl1_npc/scientist/c1a2_sci_5zomb.wav"}
	self.SoundTbl_Death = {"vj_hlr/hl1_npc/scientist/scream5.wav","vj_hlr/hl1_npc/scientist/scream21.wav","vj_hlr/hl1_npc/scientist/sci_die1.wav","vj_hlr/hl1_npc/scientist/sci_die2.wav","vj_hlr/hl1_npc/scientist/sci_die3.wav","vj_hlr/hl1_npc/scientist/sci_die4.wav","vj_hlr/hl1_npc/scientist/sci_dragoff.wav"}
	if GetConVar("russian_voice"):GetInt() == 1 then
	self.SoundTbl_Idle = {"rus/sound/scientist/administrator.wav","rus/sound/scientist/c1a0_sci_stall.wav","rus/sound/scientist/c1a1_sci_3scan.wav","rus/sound/scientist/c1a1_sci_2scan.wav","rus/sound/scientist/c1a1_sci_1scan.wav","rus/sound/scientist/c1a4_sci_trainend.wav","rus/sound/scientist/containfail.wav","rus/sound/scientist/cough.wav","rus/sound/scientist/fusionshunt.wav","rus/sound/scientist/hopenominal.wav","rus/sound/scientist/hideglasses.wav","rus/sound/scientist/howinteresting.wav","rus/sound/scientist/ipredictedthis.wav","rus/sound/scientist/needsleep.wav","rus/sound/scientist/neverseen.wav","rus/sound/scientist/nogrant.wav","rus/sound/scientist/organicmatter.wav","rus/sound/scientist/peculiarmarks.wav","rus/sound/scientist/peculiarodor.wav","rus/sound/scientist/reportflux.wav","rus/sound/scientist/runtest.wav","rus/sound/scientist/shutdownchart.wav","rus/sound/scientist/somethingfoul.wav","rus/sound/scientist/sneeze.wav","rus/sound/scientist/sniffle.wav","rus/sound/scientist/stench.wav","rus/sound/scientist/thatsodd.wav","rus/sound/scientist/thatsmell.wav","rus/sound/scientist/allnominal.wav","rus/sound/scientist/importantspecies.wav","rus/sound/scientist/yawn.wav","rus/sound/scientist/whoresponsible.wav","rus/sound/scientist/uselessphd.wav"}
	self.SoundTbl_IdleDialogue = {"rus/sound/scientist/alienappeal.wav","rus/sound/scientist/alientrick.wav","rus/sound/scientist/analysis.wav","rus/sound/scientist/announcer.wav","rus/sound/scientist/bloodsample.wav","rus/sound/scientist/beverage.wav","rus/sound/scientist/areyouthink.wav","rus/sound/scientist/catchone.wav","rus/sound/scientist/cascade.wav","rus/sound/scientist/everseen.wav","rus/sound/scientist/doyousmell.wav","rus/sound/scientist/donuteater.wav","rus/sound/scientist/dinner.wav","rus/sound/scientist/fascinating.wav","rus/sound/scientist/headcrab.wav","rus/sound/scientist/goodpaper.wav","rus/sound/scientist/improbable.wav","rus/sound/scientist/hungryyet.wav","rus/sound/scientist/koso.wav","rus/sound/scientist/lambdalab.wav","rus/sound/scientist/newsample.wav","rus/sound/scientist/nothostile.wav","rus/sound/scientist/perfectday.wav","rus/sound/scientist/recalculate.wav","rus/sound/scientist/purereadings.wav","rus/sound/scientist/rumourclean.wav","rus/sound/scientist/shakeunification.wav","rus/sound/scientist/seencup.wav","rus/sound/scientist/smellburn.wav","rus/sound/scientist/softethics.wav","rus/sound/scientist/stimulating.wav","rus/sound/scientist/simulation.wav","rus/sound/scientist/statusreport.wav","rus/sound/scientist/tunedtoday.wav","rus/sound/scientist/sunsets.wav","rus/sound/scientist/survival.wav","rus/sound/scientist/tunnelcalc.wav","rus/sound/scientist/delayagain.wav","rus/sound/scientist/safetyinnumbers.wav","rus/sound/scientist/chaostheory.wav","rus/sound/scientist/checkatten.wav","rus/sound/scientist/chimp.wav"}
	self.SoundTbl_IdleDialogueAnswer = {"rus/sound/scientist/yees.wav","rus/sound/scientist/yes3.wav","rus/sound/scientist/absolutely.wav","rus/sound/scientist/absolutelynot.wav","rus/sound/scientist/cantbeserious.wav","rus/sound/scientist/completelywrong.wav","rus/sound/scientist/correcttheory.wav","rus/sound/scientist/whocansay.wav","rus/sound/scientist/whyaskme.wav","rus/sound/scientist/stopasking.wav","rus/sound/scientist/theoretically.wav","rus/sound/scientist/shutup.wav","rus/sound/scientist/shutup2.wav","rus/sound/scientist/sci_bother.wav","rus/sound/scientist/perhaps.wav","rus/sound/scientist/positively.wav","rus/sound/scientist/repeat.wav","rus/sound/scientist/ridiculous.wav","rus/sound/scientist/right.wav","rus/sound/scientist/ofcourse.wav","rus/sound/scientist/ofcoursenot.wav","rus/sound/scientist/nodoubt.wav","rus/sound/scientist/noguess.wav","rus/sound/scientist/noidea.wav","rus/sound/scientist/noo.wav","rus/sound/scientist/notcertain.wav","rus/sound/scientist/notsure.wav","rus/sound/scientist/dontconcur.wav","rus/sound/scientist/dontknow.wav","rus/sound/scientist/ibelieveso.wav","rus/sound/scientist/idiotic.wav","rus/sound/scientist/idontthinkso.wav","rus/sound/scientist/imsure.wav","rus/sound/scientist/inconclusive.wav","rus/sound/scientist/justasked.wav"}
	self.SoundTbl_CombatIdle = {"rus/sound/scientist/scream01.wav","rus/sound/scientist/scream02.wav","rus/sound/scientist/scream03.wav","rus/sound/scientist/scream04.wav","rus/sound/scientist/scream05.wav","rus/sound/scientist/scream06.wav","rus/sound/scientist/scream07.wav","rus/sound/scientist/scream08.wav","rus/sound/scientist/scream09.wav","rus/sound/scientist/scream10.wav","rus/sound/scientist/scream11.wav","rus/sound/scientist/scream12.wav","rus/sound/scientist/scream13.wav","rus/sound/scientist/scream14.wav","rus/sound/scientist/scream15.wav","rus/sound/scientist/scream16.wav","rus/sound/scientist/scream17.wav","rus/sound/scientist/scream18.wav","rus/sound/scientist/scream19.wav","rus/sound/scientist/scream20.wav","rus/sound/scientist/scream22.wav","rus/sound/scientist/scream23.wav","rus/sound/scientist/scream24.wav","rus/sound/scientist/scream25.wav","rus/sound/scientist/sci_fear8.wav","rus/sound/scientist/sci_fear7.wav","rus/sound/scientist/sci_fear15.wav","rus/sound/scientist/sci_fear2.wav","rus/sound/scientist/sci_fear3.wav","rus/sound/scientist/sci_fear4.wav","rus/sound/scientist/sci_fear5.wav","rus/sound/scientist/sci_fear11.wav","rus/sound/scientist/sci_fear12.wav","rus/sound/scientist/sci_fear13.wav","rus/sound/scientist/sci_fear1.wav","rus/sound/scientist/rescueus.wav","rus/sound/scientist/nooo.wav","rus/sound/scientist/noplease.wav","rus/sound/scientist/madness.wav","rus/sound/scientist/gottogetout.wav","rus/sound/scientist/getoutofhere.wav","rus/sound/scientist/getoutalive.wav","rus/sound/scientist/evergetout.wav","rus/sound/scientist/dontwantdie.wav","rus/sound/scientist/b01_sci01_whereami.wav","rus/sound/scientist/cantbeworse.wav","rus/sound/scientist/canttakemore.wav"}
	self.SoundTbl_FollowPlayer = {"rus/sound/scientist/yes.wav","rus/sound/scientist/yes2.wav","rus/sound/scientist/yesletsgo.wav","rus/sound/scientist/yesok.wav","rus/sound/scientist/yesihope.wav","rus/sound/scientist/waithere.wav","rus/sound/scientist/rightwayout.wav","rus/sound/scientist/protectme.wav","rus/sound/scientist/okgetout.wav","rus/sound/scientist/okihope.wav","rus/sound/scientist/odorfromyou.wav","rus/sound/scientist/letsgo.wav","rus/sound/scientist/leadtheway.wav","rus/sound/scientist/icanhelp.wav","rus/sound/scientist/hopeyouknow.wav","rus/sound/scientist/fellowscientist.wav","rus/sound/scientist/excellentteam.wav","rus/sound/scientist/d01_sci14_right.wav","rus/sound/scientist/c1a0_sci_scanrpt.wav","rus/sound/scientist/alright.wav"}
	self.SoundTbl_UnFollowPlayer = {"rus/sound/scientist/whyleavehere.wav","rus/sound/scientist/slowingyou.wav","rus/sound/scientist/reconsider.wav","rus/sound/scientist/leavingme.wav","rus/sound/scientist/istay.wav","rus/sound/scientist/illwaithere.wav","rus/sound/scientist/illwait.wav","rus/sound/scientist/fine.wav","rus/sound/scientist/d01_sci14_right.wav","rus/sound/scientist/crowbar.wav","rus/sound/scientist/cantbeserious.wav","rus/sound/scientist/c1a3_sci_1man.wav","rus/sound/scientist/c1a1_sci_5scan.wav","rus/sound/scientist/asexpected.wav","rus/sound/scientist/beenaburden.wav"}
	self.SoundTbl_MoveOutOfPlayersWay = {"rus/sound/scientist/sorryimleaving.wav","rus/sound/scientist/excuse.wav"}
	self.SoundTbl_MedicBeforeHeal = {"rus/sound/scientist/youlookbad.wav","rus/sound/scientist/youlookbad2.wav","rus/sound/scientist/youneedmedic.wav","rus/sound/scientist/youwounded.wav","rus/sound/scientist/thiswillhelp.wav","rus/sound/scientist/letstrythis.wav","rus/sound/scientist/letmehelp.wav","rus/sound/scientist/holdstill.wav","rus/sound/scientist/heal1.wav","rus/sound/scientist/heal2.wav","rus/sound/scientist/heal3.wav","rus/sound/scientist/heal4.wav","rus/sound/scientist/heal5.wav"}
	self.SoundTbl_OnPlayerSight = {"rus/sound/scientist/undertest.wav","rus/sound/scientist/sci_somewhere.wav","rus/sound/scientist/saved.wav","rus/sound/scientist/newhevsuit.wav","rus/sound/scientist/keller.wav","rus/sound/scientist/inmesstoo.wav","rus/sound/scientist/hellothere.wav","rus/sound/scientist/hellofromlab.wav","rus/sound/scientist/hellofreeman.wav","rus/sound/scientist/hello.wav","rus/sound/scientist/greetings.wav","rus/sound/scientist/greetings2.wav","rus/sound/scientist/goodtoseeyou.wav","rus/sound/scientist/freemanalive.wav","rus/sound/scientist/freeman.wav","rus/sound/scientist/fix.wav","rus/sound/scientist/corporal.wav","rus/sound/scientist/c3a2_sci_1surv.wav","rus/sound/scientist/c2a4_sci_surgury.wav","rus/sound/scientist/c1a3_sci_thankgod.wav","rus/sound/scientist/c1a0_sci_itsyou.wav","rus/sound/scientist/c1a0_sci_gm1.wav","rus/sound/scientist/c1a0_sci_gm.wav","rus/sound/scientist/afellowsci.wav","rus/sound/scientist/ahfreeman.wav","rus/sound/scientist/c1a0_sci_bigday.wav","rus/sound/scientist/c1a0_sci_ctrl4a.wav"}
	self.SoundTbl_Investigate = {"rus/sound/scientist/whatissound.wav","rus/sound/scientist/overhere.wav","rus/sound/scientist/lowervoice.wav","rus/sound/scientist/ihearsomething.wav","rus/sound/scientist/hello2.wav","rus/sound/scientist/hearsomething.wav","rus/sound/scientist/didyouhear.wav","rus/sound/scientist/d01_sci10_interesting.wav","rus/sound/scientist/c3a2_sci_1glu.wav"}
	self.SoundTbl_Alert = {"rus/sound/scientist/startle1.wav","rus/sound/scientist/startle2.wav","rus/sound/scientist/startle3.wav","rus/sound/scientist/startle4.wav","rus/sound/scientist/startle5.wav","rus/sound/scientist/startle6.wav","rus/sound/scientist/startle7.wav","rus/sound/scientist/startle8.wav","rus/sound/scientist/startle9.wav","rus/sound/scientist/startle1.wav","rus/sound/scientist/startle2.wav","rus/sound/scientist/c1a3_sci_silo2a.wav"}
	self.SoundTbl_BecomeEnemyToPlayer = {"rus/sound/scientist/getalong.wav","rus/sound/scientist/advance.wav","rus/sound/scientist/c2a4_sci_alldie.wav"}
	self.SoundTbl_OnGrenadeSight = {"rus/sound/scientist/sci_fear6.wav","rus/sound/scientist/sci_fear14.wav","rus/sound/scientist/c1a2_sci_1zomb.wav"}
	self.SoundTbl_OnDangerSight = {"rus/sound/scientist/sci_fear6.wav","rus/sound/scientist/sci_fear14.wav"}
	self.SoundTbl_AllyDeath = {"rus/sound/scientist/whatnext.wav","rus/sound/scientist/luckwillchange.wav"}
	self.SoundTbl_Pain = {"rus/sound/scientist/sci_pain1.wav","rus/sound/scientist/sci_pain2.wav","rus/sound/scientist/sci_pain3.wav","rus/sound/scientist/sci_pain4.wav","rus/sound/scientist/sci_pain5.wav","rus/sound/scientist/sci_pain6.wav","rus/sound/scientist/sci_pain7.wav","rus/sound/scientist/sci_pain8.wav","rus/sound/scientist/sci_pain9.wav","rus/sound/scientist/sci_pain10.wav","rus/sound/scientist/sci_fear9.wav","rus/sound/scientist/sci_fear10.wav","rus/sound/scientist/c1a2_sci_dangling.wav","rus/sound/scientist/iwounded.wav","rus/sound/scientist/iwounded2.wav","rus/sound/scientist/iwoundedbad.wav"}
	self.SoundTbl_DamageByPlayer = {"rus/sound/scientist/youinsane.wav","rus/sound/scientist/whatyoudoing.wav","rus/sound/scientist/please.wav","rus/sound/scientist/c3a2_sci_fool.wav","rus/sound/scientist/c1a3_sci_team.wav","rus/sound/scientist/c1a0_sci_stayback.wav","rus/sound/scientist/c1a2_sci_3zomb.wav","rus/sound/scientist/c1a2_sci_5zomb.wav"}
	self.SoundTbl_Death = {"rus/sound/scientist/scream5.wav","rus/sound/scientist/scream21.wav","rus/sound/scientist/sci_die1.wav","rus/sound/scientist/sci_die2.wav","rus/sound/scientist/sci_die3.wav","rus/sound/scientist/sci_die4.wav","rus/sound/scientist/sci_dragoff.wav"}
	end
	self:SetBodygroup(10, 1)
	self:SetBodygroup(8, 1)
	local randBG = math.random(1, 4)
	self:SetBodygroup(0, randBG)
	if randBG == 3 && self.SCI_Type == 0 then
		self:SetSkin(1)
end
    if self:GetBodygroup(0) == 1 then
	self:SetBodygroup(9, 1)
end

	//self:GetPoseParameters(true)
	self.totalDamage = {}

	
	self.SCI_NextTieAnnoyanceT = CurTime() + math.Rand(10, 100)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply, controlEnt)
	self.SCI_ControllerAnim = 0
	self.SCI_NextTieAnnoyanceT = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)
	ply:ChatPrint("RELOAD: Toggle scared animations")
	ply:ChatPrint("LMOUSE: Play tie annoyance (if not scared & possible)")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, activator, caller, data)
	if key == "step" or key == "wheelchair" then
		self:FootStepSoundCode()
	elseif key == "tie" /*&& !self:BusyWithActivity()*/ then
		self:StopAllCommonSpeechSounds()
		local soundToPlay = sdTie
		if GetConVar("russian_voice"):GetInt() == 1 then
			soundToPlay = sdTierus
		end
		self:PlaySoundSystem("GeneralSpeech", soundToPlay)
	elseif key == "draw" then
		self:SetBodygroup(8, 0)
	elseif key == "holster" then
		self:SetBodygroup(8, 1)
	elseif key == "body" then
		VJ_EmitSound(self, "commonbhl/bodydrop"..math.random(3, 4)..".wav", 75, 100)
	-- keller
	elseif key == "keller_surprise" then
		self.SoundTbl_FootStep = sdStep
		self:StopAllCommonSpeechSounds()
		self:PlaySoundSystem("GeneralSpeech", "vj_hlr/hl1_npc/keller/dk_furher.wav")
	elseif key == "keller_die" then
		self.HasDeathAnimation = false
		self.DeathCorpseApplyForce = false
		local dmg = DamageInfo()
		dmg:SetDamage(self:Health())
		dmg:SetDamageType(bit.band(DMG_GENERIC, DMG_PREVENT_PHYSICS_FORCE))
		dmg:SetAttacker(self)
		dmg:SetInflictor(self)
		self:TakeDamageInfo(dmg)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMedic_BeforeHeal()
	-- Healing routine
	timer.Simple(1.5, function() if IsValid(self) then self:SetBodygroup(8, 0) end end)
	self:VJ_ACT_PLAYACTIVITY("ACT_ARM", true, false, false, 0, {OnFinish=function(interrupted, anim)
		if interrupted then return end
		self:VJ_ACT_PLAYACTIVITY("give_shot", true, false, false, 0, {OnFinish=function(interrupted2, anim2)
			if interrupted2 then return end
			self:VJ_ACT_PLAYACTIVITY("ACT_DISARM", true, false)
		end})
	end})
end

function ENT:CustomOnMedic_OnReset()
	timer.Simple(0.5, function() if IsValid(self) then self:SetBodygroup(8, 1) end end)
end

--[[function ENT:CustomOnRemove()
hook.Remove( "EntityFireBullets", "BulletFiredHook" )
	timer.Remove( "SoundTimer" )
	timer.Remove( "SoundTimer2" )
 end--]]
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	if self.VJ_IsBeingControlled then return end
	if self.SCI_Type != 2 && self.SCI_Type != 3 then
		if math.random(1, 2) == 1 && (ent.VJTag_ID_Headcrab or ent:GetClass() == "npc_headcrab" or ent:GetClass() == "npc_headcrab_black" or ent:GetClass() == "npc_headcrab_fast") then
			self:PlaySoundSystem("Alert", {"vj_hlr/hl1_npc/scientist/seeheadcrab.wav"})
			self.NextAlertSoundT = CurTime() + math.Rand(self.NextSoundTime_Alert.a, self.NextSoundTime_Alert.b)
		end
		if ent:GetPos():Distance(self:GetPos()) >= 300 && math.random(1, 2) == 1 then
			self:VJ_ACT_PLAYACTIVITY({"vjseq_eye_wipe", "vjseq_fear1", "vjseq_fear2"}, true, false, true)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	-- NPC Controller behavior setting
	if self.VJ_IsBeingControlled && self.VJ_TheController:KeyDown(IN_RELOAD) then
		if self.SCI_ControllerAnim == 0 then
			self.SCI_ControllerAnim = 1
			self.VJ_TheController:ChatPrint("I am scared!")
		else
			self.SCI_ControllerAnim = 0
			self.VJ_TheController:ChatPrint("Calming down...")
		end
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
			self.TurboBleeding = true
				end
			end
		end
	
			local soundList = {
"vj_hlr/hl1_npc/scientist/sci_pain1.wav","vj_hlr/hl1_npc/scientist/sci_pain2.wav","vj_hlr/hl1_npc/scientist/sci_pain3.wav","vj_hlr/hl1_npc/scientist/sci_pain4.wav","vj_hlr/hl1_npc/scientist/sci_pain5.wav","vj_hlr/hl1_npc/scientist/sci_pain6.wav","vj_hlr/hl1_npc/scientist/sci_pain7.wav","vj_hlr/hl1_npc/scientist/sci_pain8.wav","vj_hlr/hl1_npc/scientist/sci_pain9.wav","vj_hlr/hl1_npc/scientist/sci_pain10.wav","vj_hlr/hl1_npc/scientist/sci_fear9.wav","vj_hlr/hl1_npc/scientist/sci_fear10.wav","vj_hlr/hl1_npc/scientist/c1a2_sci_dangling.wav","vj_hlr/hl1_npc/scientist/iwounded.wav","vj_hlr/hl1_npc/scientist/iwounded2.wav","vj_hlr/hl1_npc/scientist/iwoundedbad.wav"
	}
	
		local soundListrus = {
"rus/sound/scientist/sci_pain1.wav","rus/sound/scientist/sci_pain2.wav","rus/sound/scientist/sci_pain3.wav","rus/sound/scientist/sci_pain4.wav","rus/sound/scientist/sci_pain5.wav","rus/sound/scientist/sci_pain6.wav","rus/sound/scientist/sci_pain7.wav","rus/sound/scientist/sci_pain8.wav","rus/sound/scientist/sci_pain9.wav","rus/sound/scientist/sci_pain10.wav","rus/sound/scientist/sci_fear9.wav","rus/sound/scientist/sci_fear10.wav","rus/sound/scientist/c1a2_sci_dangling.wav","rus/sound/scientist/iwounded.wav","rus/sound/scientist/iwounded2.wav","rus/sound/scientist/iwoundedbad.wav"
}
    local randomIndex = math.random(1, #soundList)
    local soundToPlay = soundList[randomIndex]
	    local randomIndexrus = math.random(1, #soundListrus)
    local soundToPlayrus = soundListrus[randomIndexrus]		
		-- Ouch sound when low health
if self:Health() <= (self:GetMaxHealth() / 2.2) then
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
		if not self.Security_LastOuch or CurTime() - self.Security_LastOuch >= 1.5 then
        self.Security_LastOuch = CurTime()
        self:PlaySoundSystem("GeneralSpeech", soundToPlay)
		end
    end
end

	-- self.SCI_CurAnims --> 0 = Regular | 1 = Scared | 2 = Grabbed by barnacle
	if self:IsEFlagSet(EFL_IS_BEING_LIFTED_BY_BARNACLE) then
		if self.SCI_CurAnims != 2 then
			self.SCI_CurAnims = 2
			self.AnimTbl_ScaredBehaviorStand = {ACT_BARNACLE_PULL}
			self.AnimTbl_IdleStand = {ACT_BARNACLE_PULL}
			self:SelectSchedule() -- Make sure to update the idle anims because AI is suspended when EFL_IS_BEING_LIFTED_BY_BARNACLE
		end
	elseif self.SCI_Type != 3 && ((!self.VJ_IsBeingControlled && IsValid(self:GetEnemy())) or (self.VJ_IsBeingControlled && self.SCI_ControllerAnim == 1)) then
		if self.SCI_CurAnims != 1 then
			self.SCI_CurAnims = 1
			self.AnimTbl_ScaredBehaviorStand = {ACT_CROUCHIDLE}
			self.AnimTbl_IdleStand = {ACT_CROUCHIDLE}
			if self.SCI_Type != 2 then
				self.AnimTbl_Walk = {ACT_WALK_SCARED}
			end
			self.AnimTbl_Run = {ACT_RUN_SCARED}
		end
	elseif (!self.VJ_IsBeingControlled) or (self.VJ_IsBeingControlled && self.SCI_ControllerAnim == 0) then
		if self.SCI_CurAnims != 0 then
			self.SCI_CurAnims = 0
			/*if self.SCI_Type == 0 && math.random(1,25) == 1 then
				self.AnimTbl_IdleStand = {ACT_VM_IDLE_1}
			else
				self.AnimTbl_IdleStand = {ACT_IDLE}
			end*/
			self.AnimTbl_IdleStand = {ACT_IDLE}
			self.AnimTbl_Walk = {ACT_WALK}
			self.AnimTbl_Run = {ACT_RUN}
		end
		-- Tie annoyance
		if CurTime() > self.SCI_NextTieAnnoyanceT && !self:BusyWithActivity() && ((!self.VJ_IsBeingControlled) or (self.VJ_IsBeingControlled && self.VJ_TheController:KeyDown(IN_ATTACK))) then
			if math.random(1, (self.VJ_IsBeingControlled and 1) or 2) == 1 && self:GetClass() != "npc_vj_hlrbs_rosenberg" then
				self:VJ_ACT_PLAYACTIVITY(ACT_VM_IDLE_1, true, false)
			end
			self.SCI_NextTieAnnoyanceT = CurTime() + ((self.VJ_IsBeingControlled and 4) or math.Rand(15, 100))
		end
	end
	

--[[local lastSoundTime = 0
local soundList = {
"vj_hlr/hl1_npc/scientist/scream01.wav","vj_hlr/hl1_npc/scientist/scream02.wav","vj_hlr/hl1_npc/scientist/scream03.wav","vj_hlr/hl1_npc/scientist/scream04.wav","vj_hlr/hl1_npc/scientist/scream05.wav","vj_hlr/hl1_npc/scientist/scream06.wav","vj_hlr/hl1_npc/scientist/scream07.wav","vj_hlr/hl1_npc/scientist/scream08.wav","vj_hlr/hl1_npc/scientist/scream09.wav","vj_hlr/hl1_npc/scientist/scream10.wav","vj_hlr/hl1_npc/scientist/scream11.wav","vj_hlr/hl1_npc/scientist/scream12.wav","vj_hlr/hl1_npc/scientist/scream13.wav","vj_hlr/hl1_npc/scientist/scream14.wav","vj_hlr/hl1_npc/scientist/scream15.wav","vj_hlr/hl1_npc/scientist/scream16.wav","vj_hlr/hl1_npc/scientist/scream17.wav","vj_hlr/hl1_npc/scientist/scream18.wav","vj_hlr/hl1_npc/scientist/scream19.wav","vj_hlr/hl1_npc/scientist/scream20.wav","vj_hlr/hl1_npc/scientist/scream22.wav","vj_hlr/hl1_npc/scientist/scream23.wav","vj_hlr/hl1_npc/scientist/scream24.wav","vj_hlr/hl1_npc/scientist/scream25.wav","vj_hlr/hl1_npc/scientist/sci_fear8.wav","vj_hlr/hl1_npc/scientist/sci_fear7.wav","vj_hlr/hl1_npc/scientist/sci_fear15.wav","vj_hlr/hl1_npc/scientist/sci_fear2.wav","vj_hlr/hl1_npc/scientist/sci_fear3.wav","vj_hlr/hl1_npc/scientist/sci_fear4.wav","vj_hlr/hl1_npc/scientist/sci_fear5.wav","vj_hlr/hl1_npc/scientist/sci_fear11.wav","vj_hlr/hl1_npc/scientist/sci_fear12.wav","vj_hlr/hl1_npc/scientist/sci_fear13.wav","vj_hlr/hl1_npc/scientist/sci_fear1.wav","vj_hlr/hl1_npc/scientist/rescueus.wav","vj_hlr/hl1_npc/scientist/nooo.wav","vj_hlr/hl1_npc/scientist/noplease.wav","vj_hlr/hl1_npc/scientist/madness.wav","vj_hlr/hl1_npc/scientist/gottogetout.wav","vj_hlr/hl1_npc/scientist/getoutofhere.wav","vj_hlr/hl1_npc/scientist/getoutalive.wav","vj_hlr/hl1_npc/scientist/evergetout.wav","vj_hlr/hl1_npc/scientist/dontwantdie.wav","vj_hlr/hl1_npc/scientist/b01_sci01_whereami.wav","vj_hlr/hl1_npc/scientist/cantbeworse.wav","vj_hlr/hl1_npc/scientist/canttakemore.wav"
}

local soundListrus = {
"rus/sound/scientist/scream01.wav","rus/sound/scientist/scream02.wav","rus/sound/scientist/scream03.wav","rus/sound/scientist/scream04.wav","rus/sound/scientist/scream05.wav","rus/sound/scientist/scream06.wav","rus/sound/scientist/scream07.wav","rus/sound/scientist/scream08.wav","rus/sound/scientist/scream09.wav","rus/sound/scientist/scream10.wav","rus/sound/scientist/scream11.wav","rus/sound/scientist/scream12.wav","rus/sound/scientist/scream13.wav","rus/sound/scientist/scream14.wav","rus/sound/scientist/scream15.wav","rus/sound/scientist/scream16.wav","rus/sound/scientist/scream17.wav","rus/sound/scientist/scream18.wav","rus/sound/scientist/scream19.wav","rus/sound/scientist/scream20.wav","rus/sound/scientist/scream22.wav","rus/sound/scientist/scream23.wav","rus/sound/scientist/scream24.wav","rus/sound/scientist/scream25.wav","rus/sound/scientist/sci_fear8.wav","rus/sound/scientist/sci_fear7.wav","rus/sound/scientist/sci_fear15.wav","rus/sound/scientist/sci_fear2.wav","rus/sound/scientist/sci_fear3.wav","rus/sound/scientist/sci_fear4.wav","rus/sound/scientist/sci_fear5.wav","rus/sound/scientist/sci_fear11.wav","rus/sound/scientist/sci_fear12.wav","rus/sound/scientist/sci_fear13.wav","rus/sound/scientist/sci_fear1.wav","rus/sound/scientist/rescueus.wav","rus/sound/scientist/nooo.wav","rus/sound/scientist/noplease.wav","rus/sound/scientist/madness.wav","rus/sound/scientist/gottogetout.wav","rus/sound/scientist/getoutofhere.wav","rus/sound/scientist/getoutalive.wav","rus/sound/scientist/evergetout.wav","rus/sound/scientist/dontwantdie.wav","rus/sound/scientist/b01_sci01_whereami.wav","rus/sound/scientist/cantbeworse.wav","rus/sound/scientist/canttakemore.wav"
}
hook.Add("EntityFireBullets", "BulletFiredHook", function(ent, data)
if self.SCI_CurAnims == 1 then
return
end
    if ent:IsPlayer() or ent:IsNPC() then
        self.AnimTbl_Walk = {ACT_WALK_SCARED}
        self.AnimTbl_Run = {ACT_RUN_SCARED}
        self.AnimTbl_IdleStand = {ACT_CROUCHIDLE}
        local currentTime = CurTime()
        if currentTime - lastSoundTime >= 0.5 then
            timer.Create("SoundTimer", 0.5, 1, function()
                local randomSound = soundList[math.random(1, #soundList)]
                self:PlaySoundSystem("GeneralSpeech", randomSound)
                lastSoundTime = CurTime()
            end)
        end
		if GetConVar("russian_voice"):GetInt() == 1 then
		        local currentTime = CurTime()
        if currentTime - lastSoundTime >= 0.5 then
            timer.Create("SoundTimer2", 0.5, 1, function()
                local randomSoundrus = soundListrus[math.random(1, #soundListrus)]
                self:PlaySoundSystem("GeneralSpeech", randomSoundrus)
                lastSoundTime = CurTime()
            end)
        end
		end

        timer.Simple(5, function()
            if IsValid(self) then
                self.AnimTbl_Walk = {ACT_WALK}
                self.AnimTbl_Run = {ACT_RUN}
                self.AnimTbl_IdleStand = {ACT_IDLE}
            end
        end)
    end
end)--]] -- I need a better way to do this...




	
	-- Is the wheel chair gone? Then kill Dr. Keller!
	if self.SCI_Type == 2 && self:GetBodygroup(0) == 1 then
		self.HasDeathAnimation = false
		self:TakeDamage(self:Health(), self, self)
	end
	
	-- Mouth animation when talking
	if CurTime() < self.SCI_NextMouthMove then
		if self.SCI_NextMouthDistance == 0 then
			self.SCI_NextMouthDistance = math.random(10,70)
		else
			self.SCI_NextMouthDistance = 0
		end
		self:SetPoseParameter("m", self.SCI_NextMouthDistance)
	else
		self:SetPoseParameter("m", 0)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnPlayCreateSound(sdData, sdFile)
	self.SCI_NextMouthMove = CurTime() + SoundDuration(sdFile)
end
---------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------
local colorRed = VJ_Color2Byte(Color(130, 19, 10))
--
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	self.HasDeathSounds = false
	if self.HasGibDeathParticles == true then
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
		bloodeffect:SetColor(VJ_Color2Byte(Color(130,19,10)))
		bloodeffect:SetScale(120)
		util.Effect("VJ_Blood1",bloodeffect)
		
		local bloodspray = EffectData()
		bloodspray:SetOrigin(self:GetPos())
		bloodspray:SetScale(8)
		bloodspray:SetFlags(3)
		bloodspray:SetColor(0)
		util.Effect("bloodspray",bloodspray)
		util.Effect("bloodspray",bloodspray)
	end
	if self:GetBodygroup(0) == 1 then
			self:SetBodygroup(9, 0)
		        self:SetBodygroup(5, 1)
		self:SetBodygroup(10, 3)
		        self:SetBodygroup(4, 1)
		self:SetBodygroup(10, 0)
		self:SetBodygroup(3, 1)
		self:SetBodygroup(7, 1)
        self:SetBodygroup(6, 1)
		self:SetBodygroup(2, 1)
		self:SetBodygroup(9, 0)
		self:SetBodygroup(0, 0)
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
	self:CreateGibEntity("obj_vj_gib", "models/gib/scigib3.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gib/scigib3.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gib/scigib2.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gib/scigib2.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gibs/humans/brain_gib.mdl", {BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gore/head7.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "commonbhl/glass3.wav"}})   	
	return true, {DeathAnim=true,AllowCorpse=true}
	end
	if self:GetBodygroup(0) == 2 then
				self:SetBodygroup(9, 0)
		        self:SetBodygroup(5, 1)
		self:SetBodygroup(10, 3)
		        self:SetBodygroup(4, 1)
		self:SetBodygroup(10, 0)
		self:SetBodygroup(3, 1)
		self:SetBodygroup(7, 1)
        self:SetBodygroup(6, 1)
		self:SetBodygroup(2, 1)
		self:SetBodygroup(9, 0)
		self:SetBodygroup(0, 0)
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
	self:CreateGibEntity("obj_vj_gib", "models/gib/scigib3.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gib/scigib3.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gib/scigib2.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gib/scigib2.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gibs/humans/brain_gib.mdl", {BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	
	return true, {DeathAnim=true,AllowCorpse=true}
	end
	
	if self:GetBodygroup(0) == 3 then
				self:SetBodygroup(9, 0)
		        self:SetBodygroup(5, 1)
		self:SetBodygroup(10, 3)
		        self:SetBodygroup(4, 1)
		self:SetBodygroup(10, 0)
		self:SetBodygroup(3, 1)
		self:SetBodygroup(7, 1)
        self:SetBodygroup(6, 1)
		self:SetBodygroup(2, 1)
		self:SetBodygroup(9, 0)
		self:SetBodygroup(0, 0)
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
	self:CreateGibEntity("obj_vj_gib", "models/gib/scigib3.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gib/scigib3.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gib/scigib2.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gib/scigib2.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gibs/humans/brain_gib.mdl", {BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	
	return true, {DeathAnim=true,AllowCorpse=true}
	end
	if self:GetBodygroup(0) == 4 then
				self:SetBodygroup(9, 0)
		        self:SetBodygroup(5, 1)
		self:SetBodygroup(10, 3)
		        self:SetBodygroup(4, 1)
		self:SetBodygroup(10, 0)
		self:SetBodygroup(3, 1)
		self:SetBodygroup(7, 1)
        self:SetBodygroup(6, 1)
		self:SetBodygroup(2, 1)
		self:SetBodygroup(9, 0)
		self:SetBodygroup(0, 0)
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
	self:CreateGibEntity("obj_vj_gib", "models/gib/scigib3.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gib/scigib3.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gib/scigib2.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gib/scigib2.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	self:CreateGibEntity("obj_vj_gib", "models/gibs/humans/brain_gib.mdl", {BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
	
	return true, {DeathAnim=true,AllowCorpse=true}
	end
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
	if self.SCI_Type == 2 then
		VJ_EmitSound(self, "vj_hlr/hl1_weapon/explosion/debris3.wav", 150, 100)
		VJ_EmitSound(self, "vj_hlr/hl1_npc/rgrunt/rb_gib.wav", 65, 100)
	end
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomDeathAnimationCode(dmginfo, hitgroup)
	if self.SCI_Type == 3 then return end
	if hitgroup == HITGROUP_HEAD then
		self.AnimTbl_Death = {ACT_DIE_HEADSHOT}
	elseif hitgroup == HITGROUP_STOMACH && self.SCI_Type != 2 then
		self.AnimTbl_Death = {ACT_DIE_GUTSHOT}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	VJ_HLR_ApplyCorpseEffects(self, corpseEnt)
	--hook.Remove( "EntityFireBullets", "BulletFiredHook" )
	--timer.Remove( "SoundTimer" )
	--timer.Remove( "SoundTimer2" )
end

function ENT:CustomOnTakeDamage_OnBleed(dmginfo, hitgroup, ply, pos, dir)


    local damageForce = dmginfo:GetDamageForce():Length()
    self.totalDamage[hitgroup] = (self.totalDamage[hitgroup] or 0) + damageForce

    if hitgroup == HITGROUP_LEFTLEG and self.totalDamage[hitgroup] > 5000 then
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
        self:CreateGibEntity("obj_vj_gib", "models/gib/scigib2.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(6, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_RIGHTLEG and self.totalDamage[hitgroup] > 5000 then
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
        self:CreateGibEntity("obj_vj_gib", "models/gib/scigib2.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(7, 1)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
elseif hitgroup == HITGROUP_HEAD and dmginfo:GetDamageForce():Length() > 800 then
        if self:GetBodygroup(1) == 11 then
            return
        end
		        if self:GetBodygroup(1) == 10 then
            return
        end
		        if self:GetBodygroup(1) == 9 then
            return
        end
		        if self:GetBodygroup(1) == 12 then
            return
        end
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
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    VJ_EmitSound(self, "gore/amputation_light" .. math.random(1, 2) .. ".wav", 75, 100)
    self:CreateGibEntity("obj_vj_gib", "models/gibs/humans/brain_gib.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})   
    if self:GetBodygroup(0) == 4 then
        self:SetBodygroup(1, 12)
		self:SetBodygroup(0, 0)
    elseif self:GetBodygroup(0) == 3 then
	self:SetBodygroup(1, 11)
    self:SetBodygroup(0, 0)
	    elseif self:GetBodygroup(0) == 2 then
	self:SetBodygroup(1, 10)
    self:SetBodygroup(0, 0)
	    elseif self:GetBodygroup(0) == 1 then
	self:SetBodygroup(9, 0)	
	self:SetBodygroup(1, 9) 
    self:SetBodygroup(0, 0)	
end
end

if hitgroup == HITGROUP_HEAD and self:GetBodygroup(0) == 1 then
-- Glasses
self:SetBodygroup(9, 0)
self:CreateGibEntity("obj_vj_gib", "models/gore/head7.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "commonbhl/glass3.wav"}})   	
end

	--[[if hitgroup == HITGROUP_HEAD and self.totalDamage[hitgroup] > 650 then
	-- Dismember whole heads code
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
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    VJ_EmitSound(self, "gore/amputation_light" .. math.random(1, 2) .. ".wav", 75, 100)
	    if self:GetBodygroup(0) == 4 then
self:SetBodygroup(2, 1)
	self:SetBodygroup(0, 0)
	self:CreateGibEntity("obj_vj_gib", "models/gore/head10.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})   
    elseif self:GetBodygroup(0) == 3 then
self:SetBodygroup(2, 1)
	self:SetBodygroup(0, 0)
	self:CreateGibEntity("obj_vj_gib", "models/gore/head9.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})   
	    elseif self:GetBodygroup(0) == 2 then
self:SetBodygroup(2, 1)
	self:SetBodygroup(0, 0)
	self:CreateGibEntity("obj_vj_gib", "models/gore/head8.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})   
	    elseif self:GetBodygroup(0) == 1 then
	self:SetBodygroup(2, 1)
	self:SetBodygroup(0, 0)
	self:SetBodygroup(9, 0)	
	self:CreateGibEntity("obj_vj_gib", "models/gore/head6.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
self:CreateGibEntity("obj_vj_gib", "models/gore/head7.mdl", { BloodDecal = "", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "commonbhl/glass3.wav"}})   	
end
end--]]
    if hitgroup == HITGROUP_STOMACH and self.totalDamage[hitgroup] > 5000 then
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
    elseif hitgroup == HITGROUP_LEFTARM and self.totalDamage[hitgroup] > 5000 then
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
        self:CreateGibEntity("obj_vj_gib", "models/gib/scigib3.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(4, 1)
		self:SetBodygroup(10, 2)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
    elseif hitgroup == HITGROUP_RIGHTARM and self.totalDamage[hitgroup] > 5000 then
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
        self:CreateGibEntity("obj_vj_gib", "models/gib/scigib3.mdl", { BloodDecal = "VJ_HLR_Blood_Red", Pos = self:LocalToWorld(Vector(0, 0, 15)),CollideSound={ "gore/flesh" .. math.random(1, 3) .. ".wav"}})
        self:SetBodygroup(5, 1)
		self:SetBodygroup(10, 3)
        local attacker = dmginfo:GetAttacker()
        self:TakeDamage(self:Health(), attacker, attacker)
        end		
    end