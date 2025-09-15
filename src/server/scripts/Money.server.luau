local MoneyManager = require(script.Parent.Parent.class.MoneyManager).New()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local  Types = require(ReplicatedStorage.Shared.Types)
type Error = Types.Error
local err :Error= {}
Players.PlayerAdded:Connect(function(player)
    err = MoneyManager:AddUser(player.UserId)
    if err then
        warn(err.GetMessage())
    end
    err = MoneyManager:LoadData()
    if err then
        warn(err.GetMessage())
    end
end)


Players.PlayerRemoving:Connect(function(player)
    err = MoneyManager:SaveData()
    if err then
        warn(err.GetMessage())
    end
end)

game:BindToClose(function()
    err = MoneyManager:SaveData()
    if err then
        warn(err.GetMessage())
    end
end)

print("[Server] Money script initialized.")


