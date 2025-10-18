-- Mourning cloak Variable sword teleport to it moves and attacks & push one target, create smoke in adjacent tile if tele into smoke
-- upgrade make sword deal double to target without adjacent living things, push adjacent tile on teleporting

Tele_Sword = Skill:new{
    Name = "Variable Sword",
	Description = "Teleport in movement range and attack a target, pushing it. Create smoke in adjacent tiles if teleporting into smoke.",
	Class = "Prime",
	Range = 1,
	PathSize = 1,
	Rarity = 3,
	Icon = "weapons/var_sword.png",
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "Add Push",  "+ 2 Damage" },
	UpgradeCost = {2,3},
	Damage = 1,
	TwoClick = true,
    PushAdjacent = false,
	LaunchSound = "/weapons/sword",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Target = Point(2,1),
		Second_Click = Point(2,2),
	}
}

function Tele_Sword:GetTargetArea(point)
	local ret = PointList()
	local tele_range = Pawn:GetBaseMove()

	local corner = point - Point(tele_range, tele_range)
	local p = Point(corner)
	for i = 0, ((tele_range*2+1)*(tele_range*2+1)) do
		local diff = point - p
		local dist = math.abs(diff.x) + math.abs(diff.y)
		if Board:IsValid(p) and not Board:IsBlocked(p, PATH_PROJECTILE) and dist <= tele_range then
			ret:push_back(p)
		end
		p = p + VEC_RIGHT
		if math.abs(p.x - corner.x) == (tele_range*2+1) then
			p.x = p.x - (tele_range*2+1)
			p = p + VEC_DOWN
		end
	end

	return ret
end

function  Tele_Sword:GetSecondTargetArea(p1,p2)
	local ret = PointList()
		for dir = DIR_START, DIR_END do
			local curr = p2 + DIR_VECTORS[dir]
			ret:push_back(curr)
		end
	return ret
end

function Tele_Sword:GetSkillEffect(p1, p2)
    local ret = SkillEffect()
	ret:AddDamage(SpaceDamage(p2, 0)) -- add target space to effect even if no attack
    return ret
end

function Tele_Sword:GetFinalEffect(p1,p2,p3) -- normal melee, spear animation
	local ret = SkillEffect()
	local direction = GetDirection(p3 - p2)
	local damage = SpaceDamage(p3, self.Damage, direction)
	damage.sAnimation = "explospear1".."_"..direction
	ret:AddTeleport(p1,p2,0) -- just teleport to unoccupied space
	if self.PushAdjacent then
		for dir = DIR_START, DIR_END do
			if p1 + DIR_VECTORS[dir] ~= p3 then -- skip adjacent spaces to prevent accidental knock into mech
				local push = SpaceDamage(p1 + DIR_VECTORS[dir], 0, dir)
				push.sAnimation = "airpush_"..dir
				ret:AddDamage(push) -- add smoke to adjacent space
			end
		end
	end

	ret:AddDelay(0.6)
	ret:AddSound(self.LaunchSound)

	if Board:IsSmoke(p2) then
		for dir = DIR_START, DIR_END do
			local smoke_spread = SpaceDamage(p2 + DIR_VECTORS[dir], 0)
			smoke_spread.iSmoke = EFFECT_CREATE
			ret:AddDamage(smoke_spread) -- add smoke to adjacent space
		end
		local smoke_clear = SpaceDamage(p2, 0)
		smoke_clear.iSmoke = EFFECT_REMOVE
		smoke_clear.sAnimation = "smoke_remove"
		ret:AddDamage(smoke_clear) -- clear smoke in p2
	end
	ret:AddMelee(p3 - DIR_VECTORS[direction], damage)
	return ret
end


Tele_Sword_A = Tele_Sword:new{
    UpgradeDescription = "Push adjacent tiles when teleporting.",
    PushAdjacent = true,
}

Tele_Sword_B = Tele_Sword:new{
    UpgradeDescription = "Deal double damage to target not adjacent to Veks.",
	Damage = 3,
}
Tele_Sword_AB = Tele_Sword:new{
    PushAdjacent = true,
	Damage = 3,
}