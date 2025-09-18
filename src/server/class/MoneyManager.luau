local Types = require(game.ReplicatedStorage.Shared.Types)
local ErrorModule = require(game.ReplicatedStorage.Shared.class.Error.Error)
local MoneyModule = require(game.ReplicatedStorage.Shared.class.Money.Money)
type MoneyManager = Types.MoneyManager
type Money = Types.Money
type Error = Types.Error
local DataStoreService = game:GetService("DataStoreService")
local playersMoneyStore = DataStoreService:GetDataStore("playersMoneyStore")

local MoneyManager = {}
MoneyManager.__index = MoneyManager

function MoneyManager.New():MoneyManager
    local self:MoneyManager = setmetatable({},MoneyManager)::MoneyManager
    self.playersMoney = {}
    return self
end

function MoneyManager:GetMoney(userId:number):number|Error
    local self = self
    if not self.playersMoney[userId] then 
        return ErrorModule.New("UserIdNotfound in playersMoney table")
    end
    return self.playersMoney[userId].money
end

function MoneyManager:SetMoney(userId:number,amount:number):Error?
    local self = self
    if not  self.playersMoney[userId]  then
        return ErrorModule.New("UserIdNotfound in playersMoney table")
    end
    if  amount <= 0 then
        return ErrorModule.New("amount must be 0 or higher")
    end
    self.playersMoney[userId]:SetMoney(amount)
end

function MoneyManager:AddMoney(userId:number, amount:number):Error?
    local self = self
    if not self.playersMoney[userId]then
        return ErrorModule.New("UserId not found in playersMoney table")
    end
    if  amount <= 0 then
        return ErrorModule.New("amount must be 0 or higher")
    end
    self.playersMoney[userId]:AddMoney(amount)
end

function MoneyManager:RemoveMoney(userId:number,amount:number):Error?
    local self = self
    if not self.playersMoney[userId]then
        return ErrorModule.New("UserId not found in playersMoney table")
    end
    if amount <= 0 then
        return ErrorModule.New("amount must be 0 or higher")
    end
    self.playersMoney[userId]:RemoveMoney(amount)
end

function MoneyManager:AddUser(userId:number):Error?
    local self = self
    if self.playersMoney[userId] then
        return ErrorModule.New("User already exists in playersMoney")
    end
    local money = MoneyModule.New()
    self.playersMoney[userId] = money
end

function MoneyManager:LoadPlayerData(userId:number):Error?

    if not self.playersMoney[userId] then
        self:AddUser(userId)
    end

    local success, data = pcall(function()
        playersMoneyStore:GetAsync(tostring(userId))
    end)

    if success then
        if data then
            self.playersMoney[userId]:SetMoney(data)
        else
            self.playersMoney[userId]:SetMoney(0)
        end
    else
        return ErrorModule.New("Failed to load money for :"..userId)
    end
end

function MoneyManager:LoadData():Error?
    local self = self
    for userId, money in pairs(self.playersMoney) do
        local success, data = pcall(function()
            playersMoneyStore:GetAsync(tostring(userId))
        end)
        if success then
            if data then
                money:SetMoney(data)
            else
                money:SetMoney(0)
            end
        else
            return ErrorModule.New("Failed to load money for userId: "..userId)
        end
    end
end

function MoneyManager:SaveData():Error?
    local self = self
    for userId, money:Money in pairs(self.playersMoney)do
        local success,err = pcall(function()
            playersMoneyStore:SetAsync(tostring(userId),money.money)
        end)
        if not success then
            return ErrorModule.New("Failed to save money for: " .. userId.." Error: "..err)
        end
    end
end

function MoneyManager:SavePlayerData( userId:number):Error?
    local self = self
    if not self.playersMoney[userId] then
        return ErrorModule.New("UserId not found in playersMoney")
    end
    local success, err = pcall(function()
        local money:Money = self.playersMoney[userId]
        playersMoneyStore:SetAsync(tostring(userId),money)
    end)
    if not success then
        return ErrorModule.New("Failed to save money for :" .. userId .. " Error : " .. err)
    end
end
return MoneyManager