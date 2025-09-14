local Types = require(game.ReplicatedStorage.Shared.Types)
type Error = Types.Error

local Error = {}

Error.__index = Error

function Error.New(message:string):Error
    local self :Error= setmetatable({},Error)::Error
    self.message = message
    return self
end

function Error:GetMessage():string
    self = self
    return self.message
end

return Error