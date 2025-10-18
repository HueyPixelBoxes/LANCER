
--Unupgraded version of the forge skill
Deploy_ForgeShot = Skill:new{
	Name = "Instant Barricade",
	Description = "Place a wall in nearby unoccupied tiles.",
	Rarity = 0,
	Damage = 0,
	Range = 1, -- Tooltip?
	PathSize = 1,
	Smoke = 0,
	Class = "Unique",
	Icon = "weapons/instant_barricade.png",
	LaunchSound = "/weapons/stock_cannons",
	ImpactSound = "/impact/generic/explosion",
	TipImage = {
		Unit = Point(2,1),
		Target = Point(2,2),
		CustomPawn = "ForgeSquad"
	}
}

function Deploy_ForgeShot:GetTargetArea(point)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		local target = point + DIR_VECTORS[dir]
			if not Board:IsBlocked(target, PATH_PROJECTILE) then
				ret:push_back(target)
			end
	end
	return ret
end

function Deploy_ForgeShot:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	local damage = SpaceDamage(p2, 0)
	local smoke = SpaceDamage(p1 - DIR_VECTORS[direction],0)
	damage.sPawn = "Wall"
	smoke.iSmoke = self.Smoke
	ret:AddDamage(damage)
	ret:AddDamage(smoke)
	return ret
end

-- Upgrade 1 for Tank A - Smoke behind
Deploy_ForgeShot2 = Deploy_ForgeShot:new{Smoke = 1}

-- Upgrade 2 for Tank B - Laucnh rock
Deploy_ForgeShot3 = Skill:new{
	Name = "Instant Barricade",
	Description = "Launch a wall in unoccupied tiles.",
	Rarity = 0,
	Damage = 0,
	Range = RANGE_ARTILLERY, -- Tooltip?
	BounceAmount = 3,
	Class = "Unique",
	Icon = "weapons/instant_barricade.png",
	LaunchSound = "/weapons/boulder_throw",
	ImpactSound = "/impact/dynamic/rock",
	TipImage = {
		Unit = Point(2,1),
		Target = Point(2,3),
		CustomPawn = "ForgeSquad"
	}
}

function Deploy_ForgeShot3:GetTargetArea(point)
  local ret = PointList()
  for dir = DIR_START, DIR_END do --dir is basically an integer that ranges from 0 to 3 but this is more explicit
	local curr = Point(point + DIR_VECTORS[dir])
	for i = 1, 7 do --start at 2 if you don't want to have adjacent tiles like artillery
		curr = point + DIR_VECTORS[dir]*i
		if not Board:IsBlocked(curr, PATH_PROJECTILE) and Board:IsValid(curr) then --is the tile inoccupied?
			ret:push_back(curr)
		end
	end
  end
  return ret
end

function Deploy_ForgeShot3:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)

	local smoke = SpaceDamage(p1 - DIR_VECTORS[direction] ,0)
	local damage = SpaceDamage(p2, 0)
	if Board:IsValid(p2) and not Board:IsBlocked(p2,PATH_PROJECTILE) then
		damage.sPawn = "RockThrown"
		smoke.iSmoke  = self.Smoke
	end

	ret:AddBounce(p1, 1)
	ret:AddArtillery(damage,"effects/shotdown_rock.png")
	ret:AddBounce(p2, self.BounceAmount)
	ret:AddBoardShake(0.15)

	ret:AddDamage(smoke)
	return ret
end

-- Upgrade 3 for Tank AB - Smoke behind and Launch rock
Deploy_ForgeShot4 = Deploy_ForgeShot3:new{ Smoke = 1}

-- Skill that deploy the tank
DeploySkill_ForgeSquad = Deployable:new{
	Name = "Forge Tank",
	Description = "Deploy tank that place Rock Wall in unoccupied space",
	ImpactSound = "/impact/generic/mech",
	Icon = "weapons/subaltern_squad.png",
	Rarity = 2,
	Deployed = "ForgeSquad",
	Projectile = "effects/shotup_tank.png",
	Cost = "med",
	Limited = 1,
	Range = 1, -- Tooltip?
	PathSize = 1,
	PowerCost = 1,
	UpgradeList = { "Smoke Behind", "Launch Rock" },
	Upgrades = 2,
	UpgradeCost = {1,2},
	LaunchSound = "/weapons/deploy_tank",
	TipImage = {
		Unit = Point(2,3),
		Target = Point(2,1),
		Second_Origin = Point(2,1),
		Second_Target = Point(3,1),
	},
}
--Smoke
DeploySkill_ForgeSquad_A = DeploySkill_ForgeSquad:new{
	UpgradeDescription = "Tile behind you gains Smoke.",
	Deployed = "ForgeSquad_A",
}
--Launch
DeploySkill_ForgeSquad_B = DeploySkill_ForgeSquad:new{
	UpgradeDescription = "The Forge Tank instead launch a rock to distant tiles.",
	Deployed = "ForgeSquad_B",
	TipImage = {
		Unit = Point(1,3),
		Target = Point(1,1),
		Second_Origin = Point(1,1),
		Second_Target = Point(2,1),
	},
}
DeploySkill_ForgeSquad_AB = DeploySkill_ForgeSquad:new{
	Deployed = "ForgeSquad_AB",
	TipImage = {
		Unit = Point(1,3),
		Target = Point(1,1),
		Second_Origin = Point(1,1),
		Second_Target = Point(2,1),
	},
}