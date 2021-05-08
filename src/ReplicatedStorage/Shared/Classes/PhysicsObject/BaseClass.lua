local Knit = require(game:GetService("ReplicatedStorage").Knit)

local HttpService = game:GetService("HttpService")
local PhysicsChecks = require(Knit.Shared.Utils.PhysicsChecks)

local Signal = require(Knit.Shared.Utils.Signal)

local PhysicsObject = {}
PhysicsObject.__index = PhysicsObject


function PhysicsObject.new(config)
    assert(config.Type,"Type is nil... You must specify what the object type is!")
    assert(PhysicsChecks[config.Type],string.format("%s is not a valid type!",tostring(config.Type)))
    local self = setmetatable({
        ["Type"] = config.Type,
        ["Id"] = HttpService:GenerateGUID(false),

        ["LastPosition"] = config.Position or Vector2.new(500,500),
        ["Position"] = config.Position or Vector2.new(500,500),
        ["Velocity"] = config.Velocity or Vector2.new(math.random(1,500),math.random(1,500)),
        ["Acceleration"] = Vector2.new(0,400),
        ["Size"] = config.Size or Vector2.new(500,500),
        ["Mass"] = 0,
        ["Stepped"] = Signal.new(),
    }, PhysicsObject)
    self:UpdateBounds()
    return self
end

function PhysicsObject:SetSize(newSize: Vector2)
    self.Size = newSize
    self:UpdateBounds()
end
    --[[
        [1] = Left
        [2] = Top
        [3] = Right
        [4] = Bottom
    ]]
function PhysicsObject:UpdateBounds()
    local radius = self.Size.X/2
    local position = self.Position
    local bounds = {}
    bounds[1] = position.X - radius
    bounds[2] = position.Y + radius
    bounds[3] = position.X + radius
    bounds[4] = position.Y - radius

    self.Bounds = bounds
end

function PhysicsObject:Step(dt)
    self.LastPosition = self.Position
    self.Velocity = self.Velocity + self.Acceleration * dt
    self.Position = self.Position + self.Velocity * dt
    self:UpdateBounds()
    self.Stepped:Fire()
end

function PhysicsObject:CheckAndResolveCollisionWith(otherObject)
    local check = PhysicsChecks:GetCheckFromTypes(self.Type, otherObject.Type)
    local resolve = PhysicsChecks:GetResolveFromTypes(self.Type, otherObject.Type)

    local collides,collisionInfo = check(self,otherObject)
    if collides then
        resolve(self,otherObject,collisionInfo)
    end 
end

function PhysicsObject:Destroy()
    
end


return PhysicsObject