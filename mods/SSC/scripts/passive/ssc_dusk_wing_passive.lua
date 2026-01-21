local mod = modApi:getCurrentMod()

SSC_Smoke_Immunity = PassiveSkill:new{
    Name = "Firmament Tear",
    Passive = "Smoke_Immune",
    Description = "Ignore Smoke effects",
    Icon = "weapons/whitewash_cleaner.png",
    Rarity = 2,
    PowerCost = 0,
    Upgrades = 0,
    TipImage = {
        Unit = Point(2,2),
        Smoke = Point(2,2),
    }
}

local defaults = {}

local function resetSmokeImmunity()
    for t, default_immunity in pairs(defaults) do
        _G[t].IgnoreSmoke = default_immunity
    end

    defaults = {}
end

local function applySmokeImmunity()
    if not IsPassiveSkill("Smoke_Immune") then -- if IsPassiveSkill is true, then Game must exist
        return
    end

    for i=0,2 do -- iterate player units
        local pawn = Game:GetPawn(i)
        if pawn then
            local t = pawn:GetType()
            if defaults[t] == nil then -- if not yet altered, store default
                defaults[t] = _G[t].IgnoreSmoke
                _G[t].IgnoreSmoke = true
            end
        end
    end
end

local function updateSmokeImmunity()
    resetSmokeImmunity()
    applySmokeImmunity()
end

local EVENT_onMissionChanged = function(mission, oldMission)
    updateSmokeImmunity()
end

local EVENT_onPawnKilled = function(mission, pawn)
    updateSmokeImmunity()
end

local EVENT_onPawnRevived = function(mission, pawn)
    updateSmokeImmunity()
end

modApi.events.onMissionChanged:subscribe(EVENT_onMissionChanged)
modapiext.events.onPawnKilled:subscribe(EVENT_onPawnKilled)
modapiext.events.onPawnRevived:subscribe(EVENT_onPawnRevived)