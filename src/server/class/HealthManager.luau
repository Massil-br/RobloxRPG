local Types = require(game.ReplicatedStorage.Shared.Types)
local Error:Error = require(game.ReplicatedStorage.Shared.class.Error.Error)
local Health : Health = require(game.ReplicatedStorage.Shared.class.Player.Health)
type Health = Types.Health
type HealthManager = Types.HealthManager
type Error = Types.Error
local StoreName = "playersHealthStore"
local Save = require(script.Parent.Save)
local idNotFoundMsg = "UserId not found in playersHealth table"
local Load = require(script.Parent.Load)

local HealthManager:HealthManager = {} :: HealthManager
HealthManager.__index = HealthManager


function HealthManager.New():HealthManager
    local self :HealthManager= setmetatable({},HealthManager)::HealthManager
    self.playersHealth = {}

    return self
end

function HealthManager:GetHealth(userId:number):number|Error
    if not self.playersHealth[userId] then
        return Error.New(idNotFoundMsg)
    end
    return self.playersHealth[userId].health
end

function HealthManager:SetHealth(userId:number,amount :number):Error?
    if not self.playersHealth[userId] then
        return Error.New(idNotFoundMsg)
    end
    local err:Error = self.playersHealth[userId]:SetHealth(amount)
    if err then
        return err
    end
end

function HealthManager:AddHealth(userId:number,amount:number):Error?
    if not self.playersHealth[userId]then
        return Error.New(idNotFoundMsg)
    end
    local err :Error = self.playersHealth[userId]:AddHealth(amount)
    if err then
        return err
    end
end

function HealthManager:RemoveHealth(userId:number,amount:number):Error?
    if not self.playersHealth[userId] then
        return Error.New(idNotFoundMsg)
    end
    local err :Error = self.playersHealth[userId]:RemoveHealth(amount)
    if err then
        return err
    end
end

function HealthManager:Revive(userId:number):Error?
    if not self.playersHealth[userId] then
        return Error.New(idNotFoundMsg)
    end
    local err :Error = self.playersHealth[userId]:Revive()
    if err then return err end
end

function HealthManager:Kill(userId:number):Error?
    if not self.playersHealth[userId] then
        return Error.New(idNotFoundMsg)
    end
    local err : Error = self.playersHealth[userId]:Kill()
    if err then return err end
end

function HealthManager:SetMaxHealth(userId:number, amount:number):Error?
    if not self.playersHealth[userId] then
        return Error.new(idNotFoundMsg)
    end
    local err:Error = self.playersHealth[userId]:SetMaxHealth(amount)
    if err then return err end
end

function HealthManager:AddMaxHealth(userId:number,amount:number):Error?
    if not self.playersHealth[userId] then
        return Error.New(idNotFoundMsg)
    end
    local err:Error = self.playersHealth[userId]:AddMaxHealth(amount)
    if err then return err end
end

function HealthManager:RemoveMaxHealth(userId:number,amount:number):Error?
    if not self.playersHealth[userId] then
        return Error.New(idNotFoundMsg)
    end
    local err :Error = self.playersHealth[userId]:RemoveMaxHealth()
    if err then return err end
end

function HealthManager:Heal(userId:number):Error?
    if not self.playersHealth[userId] then
        return Error.New(idNotFoundMsg)
    end
    local err :Error = self.playersHealth[userId]:Heal()
    if err then return err end
end

function HealthManager:AddUser(userId:number):Error?
    if self.playersHealth[userId] then
        return Error.New("User already exists in playersHealth")
    end
    local health :Health= Health.New()
    self.playersHealth[userId] = health
end

function HealthManager:LoadPlayerData(userId:number):Error?
    Load:QueueSave(StoreName,userId,function(success,data)
        if success then
            if data then
                self.playersHealth[userId] = data
            else
                self.playersHealth[userId] = Health.New()
            end
        else
            return Error.New("Failed to load money for :"..userId)
        end
    end)

end

function HealthManager:LoadData():Error?
    for userId:number, health:Health in pairs(self.playersHealth) do
        Load:QueueSave(StoreName,userId,function(success,data)
            if success then
                if data then
                    self.playersHealth[userId] = data
                else
                    self.playersHealth[userId] = Health.New()
                end
            else
                Error.New("Failed to load Health for userId: "..userId)
            end
        end)
    end
end

function HealthManager:SaveData():Error?
    for userId, health in pairs(self.playersHealth)do
         Save:QueueSave(StoreName,userId,health)
    end
end

function HealthManager:SavePlayerData(userId:number):Error?
    if not self.playersHealth[userId] then
        return Error.New(idNotFoundMsg)
    end
    Save:QueueSave(StoreName,userId,self.playersHealth[userId])
end




return HealthManager