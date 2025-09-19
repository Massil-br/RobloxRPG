local DataStoreService = game:GetService("DataStoreService")

local Save = {}


Save.__index = Save


function Save.New()
    local self  = setmetatable({},Save)
    self.SaveQueue = {}
    self.processing = false
    return self
end

function Save:QueueSave(StoreName:string,userId:number,data)
    table.insert(self.SaveQueue,{storeName = StoreName,userId = userId,data = data})
end

function Save:ProcessQueue()
    if self.processing then return end
    self.processing = true
    while #self.SaveQueue >0 do
        local item = table.remove(self.SaveQueue,1)
        local store =  DataStoreService:GetDataStore(item.storeName)
        local success,err = pcall(function()
            store:SetAsync(tostring(item.userId),item.data)
        end)

        if not success then
            warn("Error while saving user"..item.userId.." : "..err)
            table.insert(self.SaveQueue,item)
        end
        task.wait(1/30)
    end
    self.processing = false
end

local SaveInstance = Save.New()

return SaveInstance