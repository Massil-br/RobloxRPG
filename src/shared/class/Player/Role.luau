

local Role = {}
Role.__index = Role

function Role.New()
    local self = setmetatable({},Role)
    self.role = "player"
    return self
end

function Role:SetRole(roleName:string)
    self.role = roleName
end

function Role:MakeAdmin()
    self.role = "admin"
end
function Role:MakeDev()
    self.role = "dev"
end
function Role:MakePlayer()
    self.role = "player"
end

function Role:IsPlayer()
    if self.role == "player" or self.role == "admin" or self.role == "dev" then
        return true
    end
    return false
end

function Role:IsAdmin()
    if self.role == "admin" or self.role == "dev" then
        return true
    end
    return false
end

function Role:IsDev()
    if self.role =="dev"then
        return true
    end
    return false
end

return Role
