local Ball = {}
local Box = {}

local Checks = {
    ["Ball"] = Ball,
    ["Box"] = Box,
}

function Ball:CheckCollisionWithBox(ballObj,boxObj)
    --// Note Position is relative to the bottom left position of the grid
    --[[
        [1] = Left
        [2] = Top
        [3] = Right
        [4] = Bottom
    ]]
    local ballBounds = ballObj.Bounds
    local boxBounds = boxObj.Bounds

    local sidesOfCollision = table.create(4)

    for index,ballBound in pairs(ballBounds) do
       if (index == 1) or (index == 4) then
            if ballBound < boxBounds[index] then
                table.insert(sidesOfCollision,index)
            end
        elseif (index == 2) or (index == 3) then
            if ballBound > boxBounds[index] then
                table.insert(sidesOfCollision,index)
            end
       end
    end
    --// Is out of...
    if #sidesOfCollision > 0 then
        Ball:ResolveWithBox(ballObj,boxObj,{
            ["Collisions"] = sidesOfCollision,
        })
    end
end

function Ball:ResolveWithBox(ballObj,boxObj,collisionInfo)
    for _,side in pairs(collisionInfo) do
        local velocity = ballObj.Velocity
        if (side == 1) or (side == 3) then
            ballObj.Velocity = Vector2.new(-velocity.X,velocity.Y)
        elseif  (side == 2) or (side == 4) then
            ballObj.Velocity = Vector2.new(velocity.X,-velocity.Y)
        end
    end
end

function Ball:CheckWithBall()
    
end

function Ball:ResolveWithBall()
    
end