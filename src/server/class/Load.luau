local DataStoreService = game:GetService("DataStoreService")
local Load = {}
Load.__index = Load

function Load.New()
    local self = setmetatable({},Load)
    self.loadQueue = {}
    self.processing = false
    return self
end

function Load:QueueSave(StoreName:string,key:number,callback)
    table.insert(self.loadQueue,{storeName = StoreName,key = key,callback = callback})
end

function Load:ProcessQueue()
    if self.processing then return end
    self.processing = true
    while #self.loadQueue>0 do
        local req = table.remove(self.loadQueue, 1)
        local store = DataStoreService:GetDataStore(req.storeName)
        local success, data = pcall(function()
            return store:GetAsync(tostring(req.key))
        end)
        if not success then
            warn("Error while loading Datastore for "..req.key.. " DataStore : "..req.storeName)
            data = nil
        end

        if req.callback then
            req.callback(success,data)
        end
        task.wait(1/30)
    end
    self.processing = false
end


local LoadInstance = Load.New()
return LoadInstance
