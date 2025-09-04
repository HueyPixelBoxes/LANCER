local wt2 = {
	Brute_Trenchgun_Upgrade1 = "+2 Damage",
    Brute_Trenchgun_Upgrade2 = "Push",
}
for k,v in pairs(wt2) do Weapon_Texts[k] = v end

-- DRAKE: Brute_Trenchgun
Brute_Trenchgun = Skill:new	{
	Class = "Brute",
	Range = RANGE_PROJECTILE,
	PathSize = INT_MAX,
	Rarity = 3,
	Explo = "explopush1_",
	Icon = "weapons/brute_tankmech.png",
	Sound = "/general/combat/explode_small",
	Damage = 2,
	Push = 0,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	--UpgradeList = { "+ 2 Damage",  "Add Push"  },
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
	local front = p1 + DIR_VECTORS[dir] -- space for spawn rock
	local target = front

	while not Board:IsBlocked(target, PATH_PROJECTILE) do
		target = target + DIR_VECTORS[dir]
	end

	if not Board:IsValid(target) then
		target = target - DIR_VECTORS[dir]
	end


	local wall_spawn = SpaceDamage(front, 0)
	if Board:IsValid(front) and not Board:IsPawnSpace(front) then -- spawn rock if valid
		wall_spawn.sPawn = "Wall"
	end

	local damage = SpaceDamage(target, self.Damage)
	if self.Push == 1 then
		damage.iPush = dir
	end
	ret:AddProjectile(damage, self.ProjectileArt, FULL_DELAY)--"effects/shot_mechtank")
	ret:AddDamage(wall_spawn);
	return ret
end
-- +2 damage
Brute_Trenchgun_A = Brute_Trenchgun:new{
	Damage = 4
}
-- PushBack
Brute_Trenchgun_B = Brute_Trenchgun:new{
	Push = 1
}
Brute_Trenchgun_AB = Brute_Trenchgun:new{
	Damage = 4,
	Push = 1
}
