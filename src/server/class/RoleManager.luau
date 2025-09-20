local Role = require(game.ReplicatedStorage.Shared.class.Player.Role)
local Error = require(game.ReplicatedStorage.Shared.class.Error.Error)
local Load = require(script.Parent.Load)
local Save = require(script.Parent.Save)
local StoreName = "playersRoleStore"
local RoleManager = {}
RoleManager.__index = RoleManager

function RoleManager.New() 
    local self = setmetatable({},RoleManager)
    self.playersRole = {}
    return self
end

function RoleManager:AddUser(userId)
    if self.playersRole[userId] then
        return Error.New("User already exists in playersRole")
    end
    self.playersRole[userId]= Role.New()
end

function RoleManager:LoadPlayerData(userId:number)
    if not self.playersRole[userId] then
        self:AddUser(userId)
    end
    Load:QueueSave(StoreName,userId,function(success,data)
        if success then
            if data then
                self.playersRole[userId]=data
            else
                self.playersRole[userId] = Role.New()
            end
        else
            Error.New("Failed to load role for : "..userId)
        end
    end)
end

function RoleManager:LoadData()
    for userId in pairs(self.playersRole)do
        local err = self:LoadPlayerData(userId)
        if err then
            warn(err)
        end
    end
end

function RoleManager:SavePlayerData(userId:number)
    if not self.playersRole[userId] then
        self:AddUser(userId)
    end
    Save:QueueSave(StoreName,userId,self.playersRole[userId])
end

function RoleManager:SaveData()
    for userId in pairs(self.playersRole) do
        self:SavePlayerData(userId)
    end
end


function RoleManager:MakeAdmin(player:Player,target:Player)
    if not self.playersRole[player.UserId]then
        return Error.New("You must be a player to do this command, player not defined in playersrole")
    end
    if not self.playersRole[target.UserId] then
        return Error.New("The target must be a player, target not defined in playersRole")
    end
    if self.playersRole[player.UserId]:IsAdmin() then
        self.playersRole[target.UserId]:MakeAdmin()
        return
    end
    return Error.New("You don't have enough permissions to do this.")
end

function RoleManager:MakeDev(player:Player,target:Player)
    if not self.playersRole[player.UserId]then
        return Error.New("You must be a player to do this command, player not defined in playersrole")
    end
    if not self.playersRole[target.UserId] then
        return Error.New("The target must be a player, target not defined in playersRole")
    end
    if self.playersRole[player.UserId]:IsDev() then
        self.playersRole[target.UserId]:MakeDev()
        return
    end
    return Error.New("You don't have enough permissions to do this.")
end

function RoleManager:MakePlayer(player:Player,target:Player)
    if not self.playersRole[player.UserId]then
        return Error.New("You must be a player to do this command, player not defined in playersrole")
    end
    if not self.playersRole[target.UserId] then
        return Error.New("The target must be a player, target not defined in playersRole")
    end
    if self.playersRole[player.UserId]:IsDev()  and  not self.playersRole[target.UserId]:IsDev() then
        self.playersRole[target.UserId]:MakePlayer()
        return
    end
    return Error.New("You don't have enough permissions to do this.")
end

function RoleManager:IsPlayer(player:Player)
    if not self.playersRole[player.UserId] then
        return Error.New("player not defined in playersRole")
    end
    return self.playersRole[player.UserId]:IsPlayer()
end
function RoleManager:IsAdmin(player:Player)
    if not self.playersRole[player.UserId] then
        return Error.New("player not defined in playersRole")
    end
    return self.playersRole[player.UserId]:IsAdmin()
end
function RoleManager:IsDev(player:Player)
    if not self.playersRole[player.UserId] then
        return Error.New("player not defined in playersRole")
    end
    return self.playersRole[player.UserId]:IsDev()
end

local RoleInstance = RoleManager.New()

return RoleInstance