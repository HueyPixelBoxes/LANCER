local description = "SSC squad."

local mod = {
    id = "horus",
    name = "HORUS",
    version = "1",
    modApiVersion = "2.9.2",
    icon = "img/mod_icon.png",
    description = description,
}

function mod:loadScript(path)
	return require(self.scriptPath..path)
end
-- load .lua files in the path --
function mod:init()
    --Add image and animation assets
    require(self.scriptPath .. "assets")
    --Add pawns
    require(self.scriptPath .. "pawns")
    --Add weapons
    require(self.scriptPath .. "passive/ssc_dusk_wing_passive")
    require(self.scriptPath .. "weapons/ssc_duskwing")
    require(self.scriptPath .. "weapons/ssc_emperor")
    require(self.scriptPath .. "weapons/ssc_mourningcloak")
    --Shop
    modApi:addWeaponDrop("SSC_Smoke_Immunity")
    modApi:addWeaponDrop("Rifle_SmokeSide")
    modApi:addWeaponDrop("Lightning_Bow")
    modApi:addWeaponDrop("Tele_Sword")
end

--for what happened when mod are loaded--
function mod:load(options, version)
    modApi:addSquad(
    {
        id = "LANCER_Weapons",
        "SSC",
        "Dusk Wing",
        "Emperor",
        "Mourningcloak"
    },
    "SSC",
    "A squad focus on mobility and battlefield control, using smoke and teleportation to outmaneuver the Vek and strike at their weak points.",
    self.resourcePath.."img/squad_icon_ipsn.png"
    )
end

return mod
