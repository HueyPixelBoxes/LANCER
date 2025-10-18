local description = "LANCER-inspired mech squads."

local mod = {
    id = "LANCER_Weapons",
    name = "LANCER Weapons",
    version = "0.1",
    modApiVersion = "2.9.2",
    gameVersion = "1.2.88",
    icon = "img/mod_icon.png",
    description = description,
}

-- load .lua files in the path --
function mod:init()
    --Add image and animation assets
    require(self.scriptPath .. "assets")
    --Add pawns
    require(self.scriptPath.."pawns")
    --Add weapons 
    require(self.scriptPath.."weapons/ips_n_blackbeard")
    require(self.scriptPath.."weapons/ips_n_drake")
    require(self.scriptPath.."weapons/ips_n_kidd")
    require(self.scriptPath.."weapons/ips_n_kidd_deploy")

    require(self.scriptPath.."passive/ssc_dusk_wing_passive")
    require(self.scriptPath.."weapons/ssc_duskwing")
    require(self.scriptPath.."weapons/ssc_emperor")
    require(self.scriptPath.."weapons/ssc_mourningcloak")
    --Shop
    modApi:addWeaponDrop("Prime_SwordGrapple")
	modApi:addWeaponDrop("Brute_Trenchgun")
	modApi:addWeaponDrop("Deploy_ForgeShot")
	modApi:addWeaponDrop("Cleaner")

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
        "IPS Northstar",
        "BlackBeard",
        "Drake",
        "Kidd"
    },
    "IPS Northstar",
    "A squad focus on building blockades to protect critical infrastructures and limited Vek's movements. Seasoned commanders will pay attention to mechs position to not lock themselves into a corner.",
    self.resourcePath.."img/squad_icon_ipsn.png")

    -- modApi:addSquad(
    -- {
    --     id = "LANCER_Weapons",
    --     "Dusk Wing",
    --     "Emperor",
    --     "Mourningcloak"
    -- },
    -- "SSC",
    -- "A squad focus on mobility and battlefield control, using smoke and teleportation to outmaneuver the Vek and strike at their weak points.",
    -- self.resourcePath.."img/squad_icon2_ssc.png"
    -- )
end

return mod
