-- KIDD: Cleaner + Wall_Tank
Cleaner = Skill:new{
	Name = "Whitewash Cleaner",
	Description = "Remove Fire and A.C.I.D from ally and push nearby units aways",
	Class = "Science",
	Icon = "weapons/whitewash_cleaner.png",
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
	UpgradeList = { "Ally gain Boost", "Heal allies" },
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

	for i = DIR_START,DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		local spaceDamage = SpaceDamage(curr, 0, i)
		spaceDamage.sAnimation = "airpush_"..i
		ret:AddDamage(spaceDamage)
		ret:AddBounce(curr,-1)
	end

	if Board:IsPawnTeam(p2,TEAM_PLAYER) then
		damage = SpaceDamage(p2, self.Amount)
		damage.iFire = EFFECT_REMOVE
		damage.iAcid = EFFECT_REMOVE
		if self.Boost then
			ret:AddScript(string.format("Board:GetPawn(%s):SetBoosted(true)", p2:GetString()))
		end
	end
	ret:AddDamage(damage)
	return ret
end
-- Ally gain Boost
Cleaner_A = Cleaner:new{
	UpgradeDescription = "Targeted ally gain Boost",
	Boost = true
}
-- Heal allies
Cleaner_B = Cleaner:new{
	UpgradeDescription = "Heal targeted ally by 1",
	Amount = -1
}
Cleaner_AB = Cleaner:new{
	Boost = true,
	Amount = -1
}