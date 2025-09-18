local Types = require(game.ReplicatedStorage.Shared.Types)
type Health = Types.Health
type Error = Types.Error
local Error : Error = require(game.ReplicatedStorage.Shared.class.Error.Error)
local Health : Health = {}
Health.__index = Health


function Health.New():Health
    local self :Health= setmetatable({},Health) :: Health
    self.health= 20
    self.maxHealth = 20
    self.isAlive = true
    return self
end

function Health:SetHealth(amount: number):Error?
    if not self.isAlive then return Error.New("target must be alive") end
    if amount <= 0 then 
        return Error.New("amount must be positive and higher than 0")
    end
    if amount > self.maxHealth then
        self.health = self.maxHealth
        return
    end
    self.health  = amount
end

function Health:AddHealth(amount:number):Error?
    if not self.isAlive then return Error.New("target must be alive") end
    if amount <= 0 then 
        return Error.New("amount must be positive and higher than 0")
    end
    if (self.health+amount) > self.maxHealth  then
        self.health = self.maxHealth
        return
    end

    self.health += amount
end


function Health:RemoveHealth(amount:number):Error?
    if not self.isAlive then return Error.New("target must be alive") end
    if amount <= 0 then 
        return Error.New("amount must be positive and higher than 0")
    end
    if (self.health - amount) <= 0 then
        self.health=0
        self.isAlive = false
        return
    end
    self.health -= amount
end


function Health:Revive():Error?
    if self.isAlive then return Error.New("target must be dead") end
    self.isAlive = true
    self.health = self.maxHealth
end

function Health:Kill():Error?
    if not self.isAlive then return Error.New("target must be alive") end
    self.health =0
    self.isAlive = false
end

function Health:SetMaxHealth(amount : number):Error?
    if amount <=0 then return Error.New("Max health must be at least 1 HP")end
    self.maxHealth = amount
end

function Health:AddMaxHealth(amount:number):Error?
    if amount <= 0 then 
        return Error.New("amount must be positive and higher than 0")
    end
    self.maxHealth += amount
end

function Health:RemoveMaxHealth(amount:number):Error?
    if amount <= 0 then 
        return Error.New("amount must be positive and higher than 0")
    end
    if (self.maxHealth- amount) <= 0 then return Error.New("Max health must be at least 1 HP")end
    self.maxHealth -= amount
end

function Health:Heal():Error?
    if not self.isAlive then return Error.New("target must be alive") end
    self.health = self.maxHealth
end


return Health