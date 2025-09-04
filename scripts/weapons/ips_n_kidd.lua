local wt2 = {
	Cleaner_Upgrade1 = "Ally Gain Boost",
    Cleaner_Upgrade2 = "Repair Allies",
}
for k,v in pairs(wt2) do Weapon_Texts[k] = v end

-- KIDD: Cleaner + Wall_Tank
Cleaner = Skill:new{
	Class = "Science",
	Icon = "weapons/science_smokedefense.png",
	Rarity = 2,
	Explosion = "",
	LaunchSound = "/weapons/wind",
	Range = 1, -- Tooltip?
	Boost = false,
	PathSize = 1,
	Damage = 0,
	PowerCost = 0,
	Amount = 0, -- Heal amount
	Upgrades = 2,
	--UpgradeList = { "Ally gain Boost", "Heal allies" },
	UpgradeCost = { 2, 1},
	TipImage = {
		Unit = Point(2,2),
		Friendly = Point(2,1),
		Target = Point(2,1),
		Fire = Point(2,1)
	}
}

function Cleaner:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, 0)
	local dir = GetDirection(p2 - p1)

	if Board:IsPawnTeam(p2,TEAM_PLAYER) then
		damage.iFire = EFFECT_REMOVE
		damage.iAcid = EFFECT_REMOVE
		damage = SpaceDamage(p2, self.Amount)
		if self.Boost then
			ret:AddScript(string.format("Board:GetPawn(%s):SetBoosted(true)", p2:GetString()))
		end
	end
	damage.iPush = dir
	damage.sAnimation = "airpush_"..dir
	ret:AddDamage(damage)
	return ret
end
-- Ally gain Boost
Cleaner_A = Cleaner:new{
	Boost = true
}
-- Heal allies
Cleaner_B = Cleaner:new{
	Amount = -1
}
Cleaner_AB = Cleaner:new{
	Boost = true,
	Amount = -1
}

