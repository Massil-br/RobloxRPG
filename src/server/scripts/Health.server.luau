local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Types = require(ReplicatedStorage.Shared.Types)
type Error = Types.Error
local err : Error = {}
local HealthManager:Types.HealthManager = require(script.Parent.Parent.class.HealthManager).New()
local Players = game:GetService("Players")


Players.PlayerAdded:Connect(function(player)
    err = HealthManager:AddUser(player.UserId)
    if err then
        warn(err:GetMessage())
    end
    err = HealthManager:LoadPlayerData(player.UserId)
    if err then
        warn(err:GetMessage())
    end
end)


task.spawn(function()
    while true do
        task.wait(60)
        err =HealthManager:SaveData()
        if err then
            warn(err:GetMessage())
        end
    end
end)

game:BindToClose(function()
    err = HealthManager:SaveData()
    if err then
        warn(err:GetMessage())
    end
end)

print("[Server] Health script initialized.")