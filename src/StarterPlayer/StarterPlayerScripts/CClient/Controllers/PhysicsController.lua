local Knit = require(game:GetService("ReplicatedStorage").Knit)

local RunService = game:GetService("RunService")

local PhysicsObject
local Signal

local PhysicsController = Knit.CreateController { Name = "PhysicsController" }

PhysicsController.__objects = {}
PhysicsController.__variableObjects = {}
PhysicsController.__staticObjects = {}

function PhysicsController:Update(dt)
    self:__narrowCheck(dt)
    self:__updatePositions(dt)
end

function PhysicsController:AddObject(type: string)
    local newObj = PhysicsObject.new({
        ["Type"] = type,
    })

    self.__objects[newObj.Id] = newObj
    self.ObjectAdded:Fire(newObj)
end

function PhysicsController:__broadCheck()
    local potentialCollisions = {}
end

function PhysicsController:__narrowCheck(dt)
    --[[ Every other object after the first one is checking if it collides with the first one
        {
            [1] = {firstObj,otherObjToCheckAgainst,otherObjToCheckAgainst,otherObjToCheckAgainst},
            [2] = {firstObj,otherObjToCheckAgainst,otherObjToCheckAgainst,otherObjToCheckAgainst},
        }
    ]]
    for id,object in pairs(self.__objects) do --// This is naive method of collision detection, but this is good enough for my test
        for otherId,otherObj in pairs(self.__objects) do 
            object:CheckAndResolveCollisionWith(otherObj)
        end
    end
end

function PhysicsController:__updatePositions(dt)
    for id,object in pairs(self.__objects) do --// This is naive method of collision detection, but this is good enough for my test
        object:Step(dt)
    end
end

function PhysicsController:KnitStart()
    RunService.Heartbeat:Connect(function(dt)
        self:Update(dt)
    end)
end


function PhysicsController:KnitInit()
    PhysicsObject = require(Knit.Shared.Classes.PhysicsObject)
    Signal = require(Knit.Shared.Utils.Signal)

    self.ObjectAdded = Signal.new()
end


return PhysicsController