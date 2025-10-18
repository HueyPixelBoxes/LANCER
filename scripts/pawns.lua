--IPS-N

BlackBeard = Pawn:new{
	Name = "Grapple Mech",
	Class = "Prime",
	Health = 3,
	MoveSpeed = 4,
	Image = "Blackbeard",
	ImageOffset = 3,
	SkillList = { "Prime_SwordGrapple" },
	SoundLocation = "/mech/prime/rock_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}
AddPawn("BlackBeard")

Drake = Pawn:new{
	Name = "Trench Mech",
	Class = "Brute",
	Health = 3,
	MoveSpeed = 3,
	Image = "MechElec",
    Armor = true,
	ImageOffset = 3,
	SkillList = { "Brute_Trenchgun" },
	SoundLocation = "/mech/prime/rock_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}
AddPawn("Drake")

Kidd = Pawn:new{
	Name = "Bunker Mech",
	Class = "Science",
	Health = 2,
	MoveSpeed = 4,
	Image = "MechElec",
	ImageOffset = 3,
	SkillList = { "Cleaner", "DeploySkill_ForgeSquad"},
	SoundLocation = "/mech/prime/rock_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true
}
AddPawn("Kidd")

ForgeSquad = Pawn:new {
	Name = "Subaltern Squad",
	Health = 1,
	Image = "SmallTank1",
	ImageOffset = 3,
	MoveSpeed = 3,
	SkillList = { "Deploy_ForgeShot" },
	SoundLocation = "/mech/brute/tank",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Corpse = false,
}
AddPawn("ForgeSquad")

ForgeSquad_A = ForgeSquad:new{ SkillList = {"Deploy_ForgeShot2"}}

ForgeSquad_B = ForgeSquad:new{ SkillList = {"Deploy_ForgeShot3"} }

ForgeSquad_AB = ForgeSquad:new{SkillList = {"Deploy_ForgeShot4"}}

-- DuskWing = Pawn:new{
-- 	Name = "Dusk Wing",
-- 	Class = "Science",
-- 	Health = 2,
-- 	MoveSpeed = 4,
-- 	Image = "MechElec",
-- 	ImageOffset = 3,
-- 	SkillList = { "SSC_Smoke_Immunity", "Rifle_SmokeSide"},
-- 	SoundLocation = "/mech/science/dark_mech/",
-- 	DefaultTeam = TEAM_PLAYER,
-- 	ImpactMaterial = IMPACT_METAL,
-- 	Massive = true
-- }
-- AddPawn("DuskWing")

-- Emperor = Pawn:new{
-- 	Name = "Emperor",
-- 	Class = "Ranged",
-- 	Health = 2,
-- 	MoveSpeed = 3,
-- 	Image = "MechElec",
-- 	ImageOffset = 3,
-- 	SkillList = { "Lightning_Bow" },
-- 	SoundLocation = "/mech/science/dark_mech/",
-- 	DefaultTeam = TEAM_PLAYER,
-- 	ImpactMaterial = IMPACT_METAL,
-- 	Massive = true
-- }
-- AddPawn("Emperor")

-- MourningCloak = Pawn:new{
-- 	Name = "Mourning Cloak",
-- 	Class = "Prime",
-- 	Health = 2,
-- 	MoveSpeed = 3,
-- 	Image = "MechElec",
-- 	ImageOffset = 3,
-- 	SkillList = { "Tele_Sword" },
-- 	SoundLocation = "/mech/prime/dark_mech/",
-- 	DefaultTeam = TEAM_PLAYER,
-- 	ImpactMaterial = IMPACT_METAL,
-- 	Massive = true
-- }
-- AddPawn("MourningCloak")