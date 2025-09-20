local RoleManager = require(script.Parent.Parent.class.RoleManager)
local Players = game:GetService("Players")
local err = {}

Players.PlayerAdded:Connect(function(player)
    err = RoleManager:AddUser(player.UserId)
    if err then
        warn(err:GetMessage())
    end
    err = RoleManager:LoadPlayerData(player.UserId)
    if err then
        warn(err:GetMessage())
    end
end)

task.spawn(function()
    task.wait(60)
    while true do
        err = RoleManager:SaveData()
        if err then
            warn(err:GetMessage())
        end
    end
end)

game:BindToClose(function()
    err = RoleManager:SaveData()
    if err then
        warn(err:GetMessage())
    end
end)

print("[Server] Role script initialized")