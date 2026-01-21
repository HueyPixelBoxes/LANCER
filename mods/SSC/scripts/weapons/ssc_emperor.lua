Lightning_Bow = LineArtillery:new{
    Name = "Marathon Arc",
	Description = "Fire an arrow that absorb smoke tiles to amplify its damage and attack all units under it. Units in smoke are immune to damage.",
	Class = "Ranged",
	Range = RANGE_ARTILLERY,
	PathSize = INT_MAX,
	Rarity = 3,
	Explosion = "",
	Icon = "weapons/marathon_arc.png",
	Sound = "/general/combat/explode_small",
	UpShot = "effects/shotup_guided_missile.png",
	LaunchSound = "/weapons/electric_whip",
	Damage = 2,
	Shield = false,
	SecondStrike = false,
	PowerCost = 1, --AE Change
	Upgrades = 2,
	UpgradeList = { "Shield Ally", "+1 Min Damage"},
	UpgradeCost = {2,3},
	TipImage =  {
		Unit = Point(2,4),
		Enemy1 = Point(2,0),
		Enemy2 = Point(2,1),
		Enemy3 = Point(2,3),
		Friendly1 = Point(2,2),
		Smoke1 = Point(2,1),
		Smoke2 = Point(2,2),
		Target = Point(2,0)
	},
}

function Lightning_Bow:GetSkillEffect(p1, p2)-- Pass tiles if smoked or shielded deal damage to adjacent enemies
    local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local target = p1 + DIR_VECTORS[dir]
	local hash = function(point) return point.x + point.y*10 end
	local path = {}
	local min_damage = math.ceil(self.Damage /2)
	local start_damage = self.Damage

	repeat
		if Board:IsPawnSpace(target) and not Board:IsSmoke(target) then
			path[#path + 1] = hash(target)
		end
		if Board:IsSmoke(target) then
			local clear_smoke = SpaceDamage(target, 0)
			clear_smoke.iSmoke = EFFECT_REMOVE
			clear_smoke.sAnimation = "smoke_remove"
			ret:AddDamage(clear_smoke) -- remove smokes

			start_damage = start_damage + 1
			if self.Shield and Board:GetPawn(target) and Board:GetPawn(target):GetTeam() == TEAM_PLAYER then
				local shield_smoke = SpaceDamage(target, 0)
				shield_smoke.iShield = 1
				ret:AddDamage(shield_smoke)
			end
		end
		target = target + DIR_VECTORS[dir]
	until target == p2

	ret:AddBounce(p1, 1)
	local damage = SpaceDamage(p2, start_damage)
	damage.sAnimation = "ExploArt2"
	ret:AddArtillery(damage, self.UpShot, NO_DELAY)
	ret:AddDelay(0.9)
	ret:AddBounce(p2, 2)

	for i = #path, 1, -1 do
		local value = path[i]
		local current = Point(value%10, math.floor(value/10))
		start_damage = math.max(min_damage, start_damage - 1)
		damage = SpaceDamage(current, start_damage)
		ret:AddBounce(target, 1)
		ret:AddDamage(damage)
		ret:AddDelay(0.2)
	end
	return ret
end
--create shield for ally in smoked in the path and also shielded ally are not immune to damage
Lightning_Bow_A = Lightning_Bow:new{
	UpgradeDescription = "Shield ally in smoke.",
	Shield = true,
}
-- Lightning strike back and forth now
Lightning_Bow_B = Lightning_Bow:new{
	UpgradeDescription = "Increase minimum damage by 1.",
	Damage = 3,
}

Lightning_Bow_AB = Lightning_Bow:new{
	Shield = true,
	Damage = 3,
}