CreateConVar("dynamic_blood_splatter_impact_fx", "1", FCVAR_ARCHIVE)
CreateConVar("dynamic_blood_splatter_decal_scale", "1", FCVAR_ARCHIVE)
CreateConVar("dynamic_blood_splatter_aliendecal_scale", "1.25", FCVAR_ARCHIVE)
CreateConVar("dynamic_blood_splatter_vj_decal_scale", "1", FCVAR_ARCHIVE)
CreateConVar("dynamic_blood_splatter_drip_scale", "0.75", FCVAR_ARCHIVE)
CreateConVar("dynamic_blood_splatter_drop_chance", "5", FCVAR_ARCHIVE)
CreateConVar("dynamic_blood_splatter_back_chance", "6", FCVAR_ARCHIVE)
CreateConVar("dynamic_blood_splatter_sound", "1", FCVAR_ARCHIVE)
CreateConVar("dynamic_blood_splatter_particle_impact_fx", "0", FCVAR_ARCHIVE)
CreateConVar("dynamic_blood_splatter_sensitivity", "100", FCVAR_ARCHIVE)
CreateConVar("dynamic_blood_splatter_effect_count", "5", FCVAR_ARCHIVE)
CreateConVar("dynamic_blood_splatter_force_mult", "1.25", FCVAR_ARCHIVE)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Use default blood stains as materials for the effect, and decals.
local blood_materials = {}
for i = 1,8 do
    local imat = Material("decals/blood"..i)
    table.insert(blood_materials, imat)
end

-- Use default alien blood stains as materials for the effect, and decals.
local alienblood_materials = {}
for i = 1,6 do
    local imat = Material("decals/yblood"..i)
    table.insert(alienblood_materials, imat)
end

-- Random decal lenght and width:
local decal_randscale = {min=0.55,max=1.25}

-- Default HL2 impact effects:
local blood_impact_fx = {
    [BLOOD_COLOR_RED] = "blood_impact_red_01",
    [BLOOD_COLOR_ANTLION] = "blood_impact_antlion_01",
    [BLOOD_COLOR_ANTLION_WORKER] = "blood_impact_antlion_worker_01",
    [BLOOD_COLOR_GREEN] = "blood_impact_green_01",
    [BLOOD_COLOR_ZOMBIE] = "blood_impact_zombie_01",
    [BLOOD_COLOR_YELLOW] = "blood_impact_yellow_01",
}

-- VJ Base stuff:
local vj_blood_materials = {}
local BLOOD_COLOR_VJ = 7

-- Sounds:
local blood_drop_sounds = {
    "enh_blood_splatter_drips/drip_01.wav",
    "enh_blood_splatter_drips/drip_02.wav",
    "enh_blood_splatter_drips/drip_03.wav",
    "enh_blood_splatter_drips/drip_04.wav",
    "enh_blood_splatter_drips/drip_05.wav",
    "enh_blood_splatter_drips/drip_06.wav",
    "enh_blood_splatter_drips/drip_07.wav",
    "enh_blood_splatter_drips/drip_08.wav",
}

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Init( data )
    local pos = data:GetOrigin()
    local magnitude = data:GetMagnitude()
    local ent = data:GetEntity()
    local blood_color = ent:GetBloodColor()
    local damage = data:GetRadius()
    local physdamage = magnitude < 1

    local vj_blood_particle = ent:GetNWString( "DynamicBloodSplatter_VJ_CustomBlood_Particle", false )
    local blood_particle = vj_blood_particle or blood_impact_fx[blood_color]

    -- Default blood particle effect:
    if GetConVar("dynamic_blood_splatter_impact_fx"):GetBool() then
        if blood_particle then ParticleEffect(blood_particle, pos, AngleRand()) end
    end
    
    -- Decide blood materials to use:
    local blood_mats
    local vj_blood_decal = ent:GetNWString( "DynamicBloodSplatter_VJ_CustomBlood_Decal", false )
    if blood_color == BLOOD_COLOR_RED then
        blood_mats = table.Copy(blood_materials)
    elseif blood_color == BLOOD_COLOR_ANTLION or
    blood_color == BLOOD_COLOR_ANTLION_WORKER or
    blood_color == BLOOD_COLOR_GREEN or
    blood_color == BLOOD_COLOR_ZOMBIE or
    blood_color == BLOOD_COLOR_YELLOW then
        blood_mats = table.Copy(alienblood_materials)
    elseif vj_blood_decal then
        if vj_blood_decal then
            -- Make new VJ decal materials as they are discovered:
            local decal_mat_name = util.DecalMaterial(vj_blood_decal)

            if !vj_blood_materials[vj_blood_decal] then vj_blood_materials[vj_blood_decal] = {} end

            if !vj_blood_materials[vj_blood_decal][decal_mat_name] then
                local imat = Material(decal_mat_name)
                vj_blood_materials[vj_blood_decal][decal_mat_name] = imat
            end

            blood_mats = table.Copy(vj_blood_materials[vj_blood_decal])
        end
    end

    -- If we have blood materials:
    if blood_mats then
        local emitter = ParticleEmitter(pos, false)
        for i = 1, Lerp( math.Clamp(damage / GetConVar("dynamic_blood_splatter_sensitivity"):GetInt(), 0, 1), 1, GetConVar("dynamic_blood_splatter_effect_count"):GetInt() ) do
            -- Chance for additional splatter effect going in the opposite direction:
            local splash_back = GetConVar("dynamic_blood_splatter_back_chance"):GetInt()
            if splash_back != 0 then
                splash_back = magnitude>0.9 && math.random( 1, splash_back )==1
            else
                splash_back = false
            end

            -- Chance for additional splatter effect that drops to the floor under the target:
            local drip = GetConVar("dynamic_blood_splatter_drop_chance"):GetInt()
            if drip != 0 then
                drip = math.random( 1, drip )==1
            else
                drip = false
            end

            local particle_scale = GetConVar("dynamic_blood_splatter_drip_scale"):GetFloat()

            for i = 1, 3 do
                if i==1 or (drip && i==2) or (splash_back && i==3) then
                    local force = (i==2 && VectorRand(-35,35)) or (i==3 && -65*magnitude) or (150*magnitude)
                    if !physdamage then force = force*GetConVar("dynamic_blood_splatter_force_mult"):GetFloat() end

                    -- The blood that exits the body:
                    for i2 = 1, 5*magnitude do
                        local blood_material = table.Random(blood_mats)
                        local length = math.Rand(20, 60)

                        local particle = emitter:Add( blood_material, pos )
                        particle:SetDieTime( 1.8 )
                        particle:SetStartSize( math.Rand(1.9, 3.8)*particle_scale )
                        particle:SetEndSize(0)
                        particle:SetStartLength( length*particle_scale*0.45 )
                        particle:SetEndLength( length*particle_scale )
                        particle:SetGravity( Vector(0,0,-500) )
                        particle:SetVelocity( data:GetNormal()*force + VectorRand(-force*0.35, force*0.35) )
                        particle:SetCollide( true )

                        -- First particle should make a decal:
                        if i2==1 then
                            particle:SetCollideCallback( function( _, collidepos, normal )
                                local decal_scale = ( blood_color==BLOOD_COLOR_VJ && GetConVar("dynamic_blood_splatter_vj_decal_scale"):GetFloat() ) or
                                ( blood_color==BLOOD_COLOR_RED && GetConVar("dynamic_blood_splatter_decal_scale"):GetFloat() ) or
                                GetConVar("dynamic_blood_splatter_aliendecal_scale"):GetFloat()

                                util.DecalEx(
                                    blood_material,
                                    Entity(0),
                                    collidepos,
                                    normal,
                                    Color(255, 255, 255),
                                    math.Rand(decal_randscale.min, decal_randscale.max)*decal_scale,
                                    math.Rand(decal_randscale.min, decal_randscale.max)*decal_scale
                                )

                                if GetConVar("dynamic_blood_splatter_particle_impact_fx"):GetBool() && blood_particle then ParticleEffect(blood_particle, collidepos, AngleRand()) end

                                if GetConVar("dynamic_blood_splatter_sound"):GetBool() then sound.Play(table.Random(blood_drop_sounds), collidepos, 77, math.random(95, 120), 0.7) end
                            end)
                        end
                    end
                end
            end
        end
        emitter:Finish()
    end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function EFFECT:Think() return false end
function EFFECT:Render() end