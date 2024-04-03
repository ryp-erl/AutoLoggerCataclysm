AutoLoggerCataclysm = AutoLoggerCataclysm or
    LibStub("AceAddon-3.0"):NewAddon("AutoLoggerCataclysm", "AceConsole-3.0", "AceEvent-3.0")

AutoLoggerCataclysm.name = "AutoLoggerCataclysm"
AutoLoggerCataclysm.version = "1.0.0-beta.1"

AutoLoggerCataclysm.raids = {
    -- Baradin Hold
    [757] = true,
    -- Blackwing Descent
    [669] = true,
    -- The Bastion of Twilight
    [671] = true,
    -- Throne of the Four Winds
    [754] = true,
    -- Firelands
    [720] = true,
    -- Dragon Soul
    [967] = true,
}
--[[
    Initializing the addon using Ace3.
    It includes options, commands, saved variables and basic events to register to.
--]]

function AutoLoggerCataclysm:OnInitialize()
end

function AutoLoggerCataclysm:OnEnable()
    self:RegisterEvent("UPDATE_INSTANCE_INFO")
    AutoLoggerCataclysm:CheckInstanceAndLog()
end

function AutoLoggerCataclysm:OnDisable()
end

--[[
    Events
--]]

function AutoLoggerCataclysm:UPDATE_INSTANCE_INFO()
    AutoLoggerCataclysm:CheckInstanceAndLog()
end

--[[
    Core functions
--]]

function AutoLoggerCataclysm:CheckInstanceAndLog()
    local name, _, _, _, _, _, _, instanceID, instanceGroupSize, _ = GetInstanceInfo()
    if AutoLoggerCataclysm.raids[tonumber(instanceID)] then
        if not LoggingCombat() then
            LoggingCombat(true)
            self:Print("Combat logging |cff33ff00activated|r for " .. name .. " (" .. instanceGroupSize .. ").")
        end
    else
        if LoggingCombat() then
            self:Print("Combat logging |cffff0000deactivated|r (not in a WotLK raid).")
            LoggingCombat(false)
        end
    end
end
