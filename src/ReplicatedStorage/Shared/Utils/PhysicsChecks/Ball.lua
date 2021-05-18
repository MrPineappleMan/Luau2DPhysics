local Knit = require(game:GetService("ReplicatedStorage").Knit)

local linalg = require(Knit.Shared.Utils.linalg) 

local Ball = {}

function Ball.CheckCollisionWithBox(ballObj,boxObj)
    --// Note Position is relative to the bottom left position of the grid
    --[[
        [1] = Left
        [2] = Top
        [3] = Right
        [4] = Bottom
    ]]
    local ballBounds = ballObj.Bounds
    local boxBounds = boxObj.Bounds
    local isCollision = false
    local sidesOfCollision = table.create(4)
    for index = 1,4 do
       if (index == 1) or (index == 4) then
            if ballBounds[index] <= boxBounds[index] then
                sidesOfCollision[index] = true
                isCollision = true
            end
        elseif (index == 2) or (index == 3) then
            if ballBounds[index] >= boxBounds[index] then
                sidesOfCollision[index] = true
                isCollision = true
            end
       end
    end
    --// Is out of...
    if isCollision then
        return isCollision, sidesOfCollision
    end
end

function Ball.ResolveWithBox(ballObj,boxObj,collisionInfo)
    for index = 1,4 do
        if collisionInfo[index] then
            local velocity = ballObj.Velocity
            if (index == 1) or (index == 3) then
                ballObj.Velocity = Vector2.new(-velocity.X,velocity.Y)
            elseif  (index == 2) or (index == 4) then
                ballObj.Velocity = Vector2.new(velocity.X,-velocity.Y)
            end
        end
    end
    ballObj.Position = ballObj.LastPosition
end

local function v(vector2: Vector2)
    return linalg.vector.new({vector2.X,vector2.Y})
end

local function dot(v1,v2)
    return v1:Dot(v2)
end

local function getResolvedVelocity(v1,v2,m1,m2,p1,p2)
    return v1 - (2 * m2 / (m1 + m2)) * dot(v1 - v2, p1 - p2) / ((p1-p2).Magnitude^2) * (p1 - p2)
end

function Ball.CheckCollisionWithBall(ball,otherBall)
    local r1 = ball.Size.X/2
    local r2 = otherBall.Size.X/2
    
    if (ball.Position - otherBall.Position).Magnitude < (r1 + r2) then
        warn("Ball has hit another ball!")
        return true
    end
    return false
end

function Ball.ResolveWithBall(ball, otherBall,config)
    local v1 = ball.Velocity
    local m1 = ball.Mass
    local p1 = ball.Position
    
    local v2 = otherBall.Velocity 
    local m2 = otherBall.Mass
    local p2 = otherBall.Position

    local newV1 = getResolvedVelocity(v1,v2,m1,m2,p1,p2)
    local newV2 =  getResolvedVelocity(v2,v1,m2,m1,p2,p1)
    warn(v1.Magnitude + v2.Magnitude)
    ball.Velocity = newV1
    otherBall.Velocity = newV2

    ball.Position = ball.LastPosition
    otherBall.Position = otherBall.LastPosition
    print(newV1.Magnitude + newV2.Magnitude)
end

return Ball
