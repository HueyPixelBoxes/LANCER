local description = "LANCER-inspired mech squads."

local mod = {
    id = "Con_Gen_LANCERWeapons",
    name = "LANCER Weapons",
    version = "0.1",
    modApiVersion = "2.9.2",
    gameVersion = "1.2.88",
    icon = "img/mod_icon.png",
    description = description,
}

-- load .lua files in the path --
function mod:init()
    require(self.scriptPath.."pawns")
    require(self.scriptPath.."weapons/ips_n_blackbeard")
    require(self.scriptPath.."weapons/ips_n_drake")
    require(self.scriptPath.."weapons/ips_n_kidd")
    require(self.scriptPath.."weapons/ips_n_kidd_deploy")
end

--for what happened when mod are loaded--
function mod:load(options, version)
    modApi:addSquad({"IPS_N Squad","BlackBeard","Drake","Kidd"},"IPS_N Squad","IPS-Northstar mechs.",self.resourcePath.."/mod_icon.png")
end

return mod
