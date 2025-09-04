local wt2 = {
	Prime_SwordGrapple_Upgrade1 = "+2 Tiles",
    Prime_SwordGrapple_Upgrade2 = "Buildings Immune",
}
for k,v in pairs(wt2) do Weapon_Texts[k] = v end

-- BLACKBEARD: Prime_Swordgrab
Prime_SwordGrapple = Skill:new{
	Class = "Prime",
	Icon = "weapons/brute_grapple.png",
	Rarity = 3,
	Explosion = "",
	LaunchSound = "/weapons/grapple",
	ImpactSound = "/weapons/sword",
	Range = RANGE_PROJECTILE,--TOOLTIP info
	ZoneTargeting = ZONE_DIR,
	BuildingDamage = true,
	Cleave = false,
	Damage = 2,
	PowerCost = 1,
	Upgrades = 2,
	UpgradeList = { "Extend tiles",  "Grid immune"  },
	UpgradeCost = { 2, 1},
    --display image tips by position them in grids--
    --X-Y coordinate are flip with outmost are 0 while intersect at 4, unit stand at middle grapple in vek then grapple toward mountains, 2nd origin is unit 2nd position--
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,0),
		Target = Point(2,0)
	}
}

function Prime_SwordGrapple:GetTargetArea(point)-- point is origin ?
	local ret = PointList() --list of valid target tile--
	for dir = DIR_START, DIR_END do --in 4 direction, each get a point in  that dir
		local this_path = {} -- list valid tile
		local target = point + DIR_VECTORS[dir] --target is point + direction 

		while not Board:IsBlocked(target, PATH_PROJECTILE) do 
			-- example, in a 8 tile line, you in tile 2 and a mountains tile 6. you get 3 target into this_path[]
			this_path[#this_path+1] = target -- #this_path is length of the array, append target tile into the array
			target = target + DIR_VECTORS[dir] --move up the target farther from origin
		end
		if Board:IsValid(target) and target:Manhattan(point) > 1 then
			--if the next target inside board and distance is more than 1 tile, add it
			-- Manhattan distance or taxicav distance calculate by |x1-x2| + |y1-y2|
			this_path[#this_path+1] = target
			for i,v in ipairs(this_path) do
				ret:push_back(v) -- add vtile value to ret
			end
		end
	end
	return ret
end
--Combine grapple from Brute_Grapple + Prime_Punchmech--
function Prime_SwordGrapple:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = p1 + DIR_VECTORS[direction]

	if not Board:IsValid(target) then
		return ret
	end

	local sword_t = target
	local sword_damage = SpaceDamage(sword_t, self.Damage)
	--go through path until blocked, change sword animation if not hitting building
	while not Board:IsBlocked(target, PATH_PROJECTILE) do
		target = target + DIR_VECTORS[direction]
	end
	-- grid immune
	if not self.BuildingDamage and Board:IsBuilding(target) then
		sword_damage.iDamage = DAMAGE_ZERO
	end

	--Grapple Part
	local grapple_damage = SpaceDamage(target)
	grapple_damage.bHidePath = true
	ret:AddProjectile(grapple_damage,"effects/shot_grapple")
	ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), FULL_DELAY)
	sword_t = target

	-- Cleave attacks, 2 tiles beside
	if self.Cleave then
		local left, right
		left = target - DIR_VECTORS[(direction - 1) % 4]
		right = target - DIR_VECTORS[(direction + 1) % 4]
		local left_damage = SpaceDamage(left, self.Damage)
		local right_damage = SpaceDamage(right, self.Damage)

		if not self.BuildingDamage and Board:IsBuilding(left) then
			left_damage.iDamage = DAMAGE_ZERO
		end
		if not self.BuildingDamage and Board:IsBuilding(right) then
			right_damage.iDamage = DAMAGE_ZERO
		end

		ret:AddDamage(left_damage)
		ret:AddDamage(right_damage)
	end

	sword_damage.loc = sword_t
	sword_damage.sAnimation = not self.Cleave and "explopunch1_"..direction or "explosword_"..direction -- sword animation if cleave
	-- Sword Part p2 - DIR_VECTORS[direction], 
	ret:AddDamage(sword_damage)
	return ret
end
--Extend attack to 2 tile adjacent to enemies--
Prime_SwordGrapple_A = Prime_SwordGrapple:new{
	Cleave = true,
	TipImage = {
		Unit = Point(2,2),
		Target = Point(2,0),
		EnemyL = Point(1,1),
		EnemyC = Point(2,0),
		EnemyR = Point(3,1),
	}
}
--Add Grid immune--
Prime_SwordGrapple_B = Prime_SwordGrapple:new{
	BuildingDamage = false,
	TipImage = {
		Unit = Point(2,2),
		Target = Point(2,0),
		Building = Point(2,0)
	}
}
Prime_SwordGrapple_AB = Prime_SwordGrapple:new{
	Cleave = true,
	BuildingDamage = false,
	TipImage = {
		Unit = Point(2,2),
		Target = Point(2,0),
		EnemyL = Point(1,0),
		Building = Point(2,0),
		EnemyR = Point(3,0)
	}
}
