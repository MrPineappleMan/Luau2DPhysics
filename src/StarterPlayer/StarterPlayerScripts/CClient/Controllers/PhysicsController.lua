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

--// Unfinished collission checking...
function PhysicsController:__broadCheck()
    local potentialCollisions = {}
end


--// Right now because there are only two bodies, we use the naive method
function PhysicsController:__narrowCheck(dt) 
    for id,object in pairs(self.__objects) do --// This is naive method of collision detection, but this is good enough for my test
        for otherId,otherObj in pairs(self.__objects) do 
            if (not object.IsStatic) and (object ~= otherObj) then
                object:CheckAndResolveCollisionWith(otherObj)
            end
        end
    end
end

function PhysicsController:__updatePositions(dt)
    for id,object in pairs(self.__objects) do
        if (not object.IsStatic) then
            object:Step(dt)
        end
    end
end

function PhysicsController:KnitStart()
    --// Arbitrarily wait...
    wait(10)
    RunService.Heartbeat:Connect(function(dt)
        self:Update(dt)
        self.Stepped:Fire()
    end)
end


function PhysicsController:KnitInit()
    PhysicsObject = require(Knit.Shared.Classes.PhysicsObject)
    Signal = require(Knit.Shared.Utils.Signal)

    self.ObjectAdded = Signal.new()
    self.Stepped = Signal.new()
end


return PhysicsController