--IPS-N

BlackBeard = Pawn:new{
	Name = "Grapple Mech",
	Class = "Prime",
	Health = 3,
	MoveSpeed = 4,
	Image = "MechElec",
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