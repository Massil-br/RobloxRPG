local Types = require(game.ReplicatedStorage.Shared.Types)
type Money = Types.Money
local Money = {}
Money.__index = Money

function  Money.New():Money
    local self :Money = setmetatable({},Money) :: Money
    self.money = 0
    return self
end

function Money:GetMoney() :number
    local self = self
    return self.money
end

function Money:SetMoney(amount:number)
    local self = self
    self.money = amount
end

function Money:AddMoney(amount:number)
    local self = self
    self.money += amount
end

function Money:RemoveMoney(amount:number)
    local self = self
    self.money -= amount
end
return Money