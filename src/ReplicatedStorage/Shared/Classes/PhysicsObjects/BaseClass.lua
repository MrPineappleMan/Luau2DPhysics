local Knit = require(game:GetService("ReplicatedStorage").Knit)

local HttpService = game:GetService("HttpService")
local PhysicsChecks = require(Knit.Shared.Utils.PhysicsChecks)

local Signal = require(Knit.Shared.Utils.Signal)

local BaseClass = {}
BaseClass.__index = BaseClass


function BaseClass.new(config)
    assert(config.Type,"Type is nil... You must specify what the object type is!")
    assert(PhysicsChecks[config.Type],string.format("%s is not a valid type!",tostring(config.Type)))
    local self = setmetatable({
        ["Type"] = config.Type,
        ["Id"] = HttpService:GenerateGUID(false),

        ["Position"] = config.Position or Vector2.new(),
        ["Velocity"] = config.Velocity or Vector2.new(0.1,0.05),
        ["Acceleration"] = Vector2.new(0,0.1),--// This is gravity, position subtracts 10% the height of the grid
        ["Size"] = config.Size or Vector2.new(0.1,0.1),
        ["Mass"] = 0,
        ["Stepped"] = Signal.new(),
    }, BaseClass)
    return self
end

function BaseClass:Step(dt)
    self.Velocity = self.Velocity + self.Acceleration * dt
    self.Position = self.Position + self.Velocity * dt
    self.Stepped:Fire()
end

function BaseClass:CheckAndResolveCollisionWith(otherObject)
    
end

function BaseClass:Destroy()
    
end


return BaseClass