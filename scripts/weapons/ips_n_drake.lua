
-- DRAKE: Brute_Trenchgun
Brute_Trenchgun = Skill:new	{
	Name = "Bunker Buster",
	Description = "Fire a pushing projectile that deals damage then erect a wall behind the Mech.",
	Class = "Brute",
	Range = RANGE_PROJECTILE,
	PathSize = INT_MAX,
	Rarity = 3,
	Explo = "explopush1_",
	Icon = "weapons/bunker_buster.png",
	Sound = "/general/combat/explode_small",
	Damage = 1,
	ShieldBack = false,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+ 2 Damage",  "Shield Ally Behind"  },
	UpgradeCost = {3,2},
	ProjectileArt = "effects/shot_mechtank",
	LaunchSound = "/weapons/modified_cannons",
	ImpactSound = "/impact/generic/explosion",
	ZoneTargeting = ZONE_DIR,
	TipImage = StandardTips.Ranged,
}
function Brute_Trenchgun:GetTargetArea(point)
	return Board:GetSimpleReachable(point, self.PathSize, self.CornersAllowed)
end
function Brute_Trenchgun:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local back = p1 - DIR_VECTORS[dir] -- space for spawn rock
	local target = p1 +  DIR_VECTORS[dir]

	while not Board:IsBlocked(target, PATH_PROJECTILE) do
		target = target + DIR_VECTORS[dir]
	end

	if not Board:IsValid(target) then
		target = target - DIR_VECTORS[dir]
	end


	local wall_spawn = SpaceDamage(back, 0)
	if Board:IsValid(back) and not Board:IsPawnSpace(back) then -- spawn rock if valid
		wall_spawn.sPawn = "Wall"
	elseif Board:IsPawnTeam(back,TEAM_PLAYER) and self.ShieldBack then -- shield ally if true
		wall_spawn.iShield = 1
	end

	local damage = SpaceDamage(target, self.Damage)
	damage.iPush = dir

	ret:AddProjectile(damage, self.ProjectileArt, FULL_DELAY)--"effects/shot_mechtank")
	ret:AddDamage(wall_spawn);
	return ret
end
-- +2 damage
Brute_Trenchgun_A = Brute_Trenchgun:new{
	UpgradeDescription = "Increases damage by 2.",
	Damage = 3
}
-- PushBack
Brute_Trenchgun_B = Brute_Trenchgun:new{
	UpgradeDescription = "If an ally is behind, give them shield",
	ShieldBack= true,
	TipImage = {
		Unit = Point(2,2),
		Friendly = Point(2,3),
		Target = Point(2,0),
	}
}
Brute_Trenchgun_AB = Brute_Trenchgun:new{
	Damage = 3,
	ShieldBack = true,
	TipImage = {
		Unit = Point(2,2),
		Friendly = Point(2,3),
		Enemy = Point(2,0),
		Target = Point(2,0),
	}
}