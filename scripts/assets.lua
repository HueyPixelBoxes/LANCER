local resourcePath = mod_loader.mods[modApi.currentMod].resourcePath


local mechPath = resourcePath.."img/mechs/"
local weaponPath = resourcePath.."img/weapons"
--Mechs
local files = {
	"blackbeard.png",
	"blackbeard_a.png",
	"blackbeard_w.png",
	"blackbeard_w_broken.png",
	"blackbeard_broken.png",
	"blackbeard_ns.png",
	"blackbeard_h.png"
}
-- iterate our files and add the assets so the game can find them.
for _, file in ipairs(files) do
	modApi:appendAsset("img/units/player/lancer_"..file, mechPath .. file)
end
-- create animations for our mech with our imported files.
-- note how the animations starts searching from /img/
local a = ANIMS
a.Blackbeard =			a.MechUnit:new{Image = "units/player/lancer_blackbeard.png", PosX = -24, PosY = -12}
a.Blackbearda =			a.MechUnit:new{Image = "units/player/lancer_blackbeard_a.png", PosX = -25, PosY = -12, NumFrames = 4 }
a.Blackbeardw =			a.MechUnit:new{Image = "units/player/lancer_blackbeard_w.png", PosX = -21, PosY = -6 }
a.Blackbeard_broken =	a.MechUnit:new{Image = "units/player/lancer_blackbeard_broken.png", PosX = -16, PosY = -12}
a.Blackbeardw_broken =	a.MechUnit:new{Image = "units/player/lancer_blackbeard_w_broken.png", PosX = -17, PosY = -8}
a.Blackbeard_ns =		a.MechIcon:new{Image = "units/player/lancer_blackbeard_ns.png"}

ANIMS.smoke_remove = Animation:new{
    Image = "effects/smoke_appear.png",
    PosX = -23,
    PosY = 0,
    Time = 0.08,
    NumFrames = 6,
    Frames = { 5, 4, 3, 2, 1, 0 },
}

--deploy are in img/units/mission

--Weapons - the first path must have full path,included resPath part
modApi:appendAsset("img/weapons/assault_grapple.png", weaponPath.."/assault_grapple.png")
modApi:appendAsset("img/weapons/bunker_buster.png", weaponPath.."/bunker_buster.png")
modApi:appendAsset("img/weapons/whitewash_cleaner.png", weaponPath.."/whitewash_cleaner.png")
modApi:appendAsset("img/weapons/instant_barricade.png",weaponPath.."/instant_barricade.png")
modApi:appendAsset("img/weapons/subaltern_squad.png", weaponPath.."/subaltern_squad.png")