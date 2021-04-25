local Knit = require(game:GetService("ReplicatedStorage").Knit)

local PhysicsController = Knit.CreateController { Name = "PhysicsController" }

PhysicsController.__objects = {}
PhysicsController.__variableObjects = {}
PhysicsController.__staticObjects = {}

function PhysicsController:Update(dt)
    
end

function PhysicsController:__checkForCollisions()
    for _,object in pairs(self.__active) do
        
    end
end

function PhysicsController:__broadCheck()
    
end

function PhysicsController:__narrowCheck()
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

function PhysicsController:__updateContraints()
    
end

function PhysicsController:__updatePositions()
    
end

function PhysicsController:KnitStart()
    
end


function PhysicsController:KnitInit()
    
end


return PhysicsController