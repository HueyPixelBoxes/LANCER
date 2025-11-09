local resourcePath = mod_loader.mods[modApi.currentMod].resourcePath


local mechPath = resourcePath .. "img/mechs/"
local weaponPath = resourcePath .. "img/weapons"
--Mechs
local files = {
	"blackbeard.png",
	"blackbeard_a.png",
	"blackbeard_w.png",
	"blackbeard_w_broken.png",
	"blackbeard_broken.png",
	"blackbeard_ns.png",
	"blackbeard_h.png",

	"kidd.png",
	"kidd_a.png",
	"kidd_w.png",
	"kidd_w_broken.png",
	"kidd_broken.png",
	"kidd_ns.png",
	"kidd_h.png",

	"drake.png",
	"drake_a.png",
	"drake_w.png",
	"drake_w_broken.png",
	"drake_broken.png",
	"drake_ns.png",
	"drake_h.png",

	"subaltern_squad_a.png",
	"subaltern_squad_d.png",
	"subaltern_squad.png",
}
-- iterate our files and add the assets so the game can find them.
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/lancer_" .. file, mechPath .. file)
end
-- create animations for our mech with our imported files.
-- note how the animations starts searching from /img/
local a = ANIMS
a.Blackbeard = a.MechUnit:new { Image = "units/player/lancer_blackbeard.png", PosX = -25, PosY = -12 }
a.Blackbearda = a.MechUnit:new { Image = "units/player/lancer_blackbeard_a.png", PosX = -25, PosY = -12, NumFrames = 4 }
a.Blackbeardw = a.MechUnit:new { Image = "units/player/lancer_blackbeard_w.png", PosX = -25, PosY = -12 }
a.Blackbeard_broken = a.MechUnit:new { Image = "units/player/lancer_blackbeard_broken.png", PosX = -16, PosY = -12 }
a.Blackbeardw_broken = a.MechUnit:new { Image = "units/player/lancer_blackbeard_w_broken.png", PosX = -17, PosY = -8 }
a.Blackbeard_ns = a.MechIcon:new { Image = "units/player/lancer_blackbeard_ns.png" }

a.Kidd = a.MechUnit:new { Image = "units/player/lancer_kidd.png", PosX = -25, PosY = -12 }
a.Kidda = a.MechUnit:new { Image = "units/player/lancer_kidd_a.png", PosX = -25, PosY = -10, NumFrames = 4 }
a.Kiddw = a.MechUnit:new { Image = "units/player/lancer_kidd_w.png", PosX = -20, PosY = 5 }
a.Kidd_broken = a.MechUnit:new { Image = "units/player/lancer_kidd_broken.png", PosX = -27, PosY = -5 }
a.Kiddw_broken = a.MechUnit:new { Image = "units/player/lancer_kidd_w_broken.png", PosX = -17, PosY = -8 }
a.Kidd_ns = a.MechIcon:new { Image = "units/player/lancer_kidd_ns.png" }

a.Drake = a.MechUnit:new { Image = "units/player/lancer_drake.png", PosX = -25, PosY = -12 }
a.Drakea = a.MechUnit:new { Image = "units/player/lancer_drake_a.png", PosX = -25, PosY = -10, NumFrames = 4 }
a.Drakew = a.MechUnit:new { Image = "units/player/lancer_drake_w.png", PosX = -20, PosY = -2 }
a.Drake_broken = a.MechUnit:new { Image = "units/player/lancer_drake_broken.png", PosX = -20, PosY = -10 }
a.Drakew_broken = a.MechUnit:new { Image = "units/player/lancer_drake_w_broken.png", PosX = -20, PosY = 0 }
a.Drake_ns = a.MechIcon:new { Image = "units/player/lancer_drake_ns.png" }

a.Subaltern_squad = a.MechUnit:new { Image = "units/player/lancer_subaltern_squad.png", PosX = -13, PosY = 2 }
a.Subaltern_squada = a.MechUnit:new { Image = "units/player/lancer_subaltern_squad_a.png", PosX = -13, PosY = 2, NumFrames = 2 }
a.Subaltern_squadd = a.MechUnit:new { Image = "units/player/lancer_subaltern_squad_d.png", PosX = -13, PosY = 2, NumFrames = 11, Time = 0.125, Loop = false }

ANIMS.smoke_remove = Animation:new {
	Image = "effects/smoke_appear.png",
	PosX = -23,
	PosY = 0,
	Time = 0.08,
	NumFrames = 6,
	Frames = { 5, 4, 3, 2, 1, 0 },
}

--deploy are in img/units/mission

--Weapons - the first path must have full path,included resPath part
modApi:appendAsset("img/weapons/assault_grapple.png", weaponPath .. "/assault_grapple.png")
modApi:appendAsset("img/weapons/bunker_buster.png", weaponPath .. "/bunker_buster.png")
modApi:appendAsset("img/weapons/whitewash_cleaner.png", weaponPath .. "/whitewash_cleaner.png")
modApi:appendAsset("img/weapons/instant_barricade.png", weaponPath .. "/instant_barricade.png")
modApi:appendAsset("img/weapons/subaltern_squad.png", weaponPath .. "/subaltern_squad.png")
