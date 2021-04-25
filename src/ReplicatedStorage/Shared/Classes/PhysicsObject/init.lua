local Knit = require(game:GetService("ReplicatedStorage").Knit)

local HttpService = game:GetService("HttpService")
local PhysicsChecks = require(Knit.Shared.Utils.PhysicsChecks)

local PhysicsObject = {}
PhysicsObject.__index = PhysicsObject


function PhysicsObject.new(config)
    assert(config.Type,"Type is nil... You must specify what the object type is!")
    assert(PhysicsChecks[config.Type],string.format("%s is not a valid type!",tostring(config.Type)))
    local self = setmetatable({
        ["Type"] = config.Type,
        ["Id"] = HttpService:GenerateGUID(false),

        ["Position"] = config.Position or Vector2.new(),
        ["Velocity"] = config.Velocity or Vector2.new(),
        ["Acceleration"] = Vector2.new(0,-1),--// This is gravity, position subtracts 10% the height of the grid
        ["Size"] = config.Size or Vector2.new(1,1),
        ["Mass"] = 0,

    }, PhysicsObject)
    return self
end

function PhysicsObject:CheckAndResolveCollisionWith(otherObject)

end

function PhysicsObject:Destroy()
    
end


return PhysicsObject