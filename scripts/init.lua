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
    --Shop
    modApi:addWeaponDrop("Prime_SwordGrapple")
	modApi:addWeaponDrop("Brute_Trenchgun")
	modApi:addWeaponDrop("Deploy_ForgeShot")
	modApi:addWeaponDrop("Cleaner")
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
    "A squad of mechanized chassis that focus on building blockades to protect critical infrastructures and limited Vek's movements. Seasoned commanders will pay attention to mechs position to not lock themselves into a corner.",
    self.resourcePath.."img/squad_icon.png")
end

return mod
