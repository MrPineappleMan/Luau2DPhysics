local HttpService = game:GetService("HttpService")

local PhysicsObject = {}
PhysicsObject.__index = PhysicsObject


function PhysicsObject.new()
    local self = setmetatable({
        ["Id"] = HttpService:GenerateGUID(false),
    }, PhysicsObject)
    return self
end


function PhysicsObject:Destroy()
    
end


return PhysicsObject