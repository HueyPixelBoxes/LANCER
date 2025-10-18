Rifle_SmokeSide = Skill:new{
    Name = "Veil Rifle",
	Description = "Fire a phasing projectile that create smoke nearby phased units, stopping at terrain & buiding.",
	Class = "Science",
	Range = RANGE_PROJECTILE,
	PathSize = INT_MAX,
	Rarity = 3,
	Icon = "weapons/veil_rifle.png",
	Sound = "/general/combat/explode_small",
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "Unlimited Phase",  "Add Push" },
	UpgradeCost = {2,2},
	Smoke = 1,
	Damage = 0,
	Push = false,
	IgnoreMountain = false,
	LaserAnimation = "ExploAir1",
	LaserArt = "effects/laser1",
	LaunchSound = "/weapons/burst_beam",
	TipImage = {
		Unit = Point(2,3),
		Enemy1 = Point(2,2),
		Enemy2 = Point(2,0),
		Target = Point(2,2),
		Mountain = Point(2,1),
	}
}

function Rifle_SmokeSide:GetTargetArea(point)
   local ret = PointList()
	for dir = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[dir]
		if not self.IgnoreMountain then
			while Board:GetTerrain(curr) ~= TERRAIN_MOUNTAIN and not Board:IsBuilding(curr) and Board:IsValid(curr) do
				ret:push_back(curr)
				curr = curr + DIR_VECTORS[dir]
			end
		else
			while Board:IsValid(curr) do
				ret:push_back(curr)
				curr = curr + DIR_VECTORS[dir]
			end
		end
	end
	return ret
end

function Rifle_SmokeSide:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local point = p1 + DIR_VECTORS[direction]
	while Board:IsValid(point) do
		if Board:IsPawnSpace(point) or Board:IsBuilding(point) or Board:GetTerrain(point) == TERRAIN_MOUNTAIN then
			local left = point - DIR_VECTORS[(direction - 1) % 4]
			local right = point - DIR_VECTORS[(direction + 1) % 4]
			local left_damage = SpaceDamage(left,0)
			local right_damage = SpaceDamage(right,0)
			left_damage.iSmoke = self.Smoke
			right_damage.iSmoke = self.Smoke
			ret:AddDamage(left_damage)
			ret:AddDamage(right_damage)
			if self.Push then
				local center_damage = SpaceDamage(point,0)
				center_damage.iPush = direction
				ret:AddDamage(center_damage)
			end
		end
		-- if it's the end of the line (ha), add the laser art -- not pretty
		if Board:IsBuilding(point) or Board:GetTerrain(point) == TERRAIN_MOUNTAIN or not Board:IsValid(point + DIR_VECTORS[direction]) then
			if not self.IgnoreMountain  then
				local dam = SpaceDamage(point, 0)
				ret:AddProjectile(p1,dam,self.LaserArt,FULL_DELAY)
				break
			end
		end
		point = point + DIR_VECTORS[direction]
	end
    return ret
end

Rifle_SmokeSide_A = Rifle_SmokeSide:new{
	IgnoreMountain = true,
	UpgradeDescription = "Laser phase through mountains and buildings.",
}
Rifle_SmokeSide_B = Rifle_SmokeSide:new{
	Push = true,
	UpgradeDescription = "Push all units in the path",
}
Rifle_SmokeSide_AB = Rifle_SmokeSide:new{
	IgnoreMountain = true,
	Push = true,
}
