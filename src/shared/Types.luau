

export type Money = {
    money: number,
    New:()->(Money),
    GetMoney : (self: Money)->(number),
    SetMoney : (self: Money, amount: number)->(),
    RemoveMoney : (self: Money, amount: number)->(),
    AddMoney : (self: Money, amount: number)->(),
}

export type MoneyManager = {
    playersMoney : {[number]: Money},
    New :()->(MoneyManager),
    AddUser:(self:MoneyManager, userId:number) ->(),
    GetMoney :(self:MoneyManager,userId:number)->(number|Error),
    AddMoney : (self:MoneyManager,userId:number, amount: number)->(Error?),
    SetMoney : (self:MoneyManager, userId:number, amount:number)->(Error?),
    RemoveMoney : (self:MoneyManager, userId:number,amount:number)->(Error?),
    LoadData : (self:MoneyManager)->(Error?),
    SaveData : (self:MoneyManager)->(Error?),
    SavePlayerData:(self:MoneyManager, userId:number)->(Error?)
}


export type Error = {
    message :string,
    New:(message:string)->(Error),
    GetMessage:()->(string)
}


export type Health = {
    health : number,
    maxHealth: number,
    isAlive : boolean,
    New :()->(Health),
    SetHealth:(amount:number)->(Error?),
    AddHealth:(amount:number)->(Error?),
    RemoveHealth:(amount:number)->(Error?),
    Revive:()->(Error?),
    Kill:()->(Error?),
    SetMaxHealth:(amount:number)->(Error?),
    AddMaxHealth:(amount:number)->(Error?),
    RemoveMaxHealth:(amount:number)->(Error?),
    Heal:(amount:number)->(Error?),
    
}

return {}