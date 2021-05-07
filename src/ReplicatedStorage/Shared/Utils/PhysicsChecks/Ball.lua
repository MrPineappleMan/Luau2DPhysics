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
        Ball.ResolveWithBox(ballObj,boxObj,sidesOfCollision)
    end
end

function Ball.ResolveWithBox(ballObj,boxObj,collisionInfo)
    print("RESOLVING!")
    warn(collisionInfo)
    for index = 1,4 do
        if collisionInfo[index] then
            local velocity = ballObj.Velocity
            if (index == 1) or (index == 3) then
                warn("Resolving with box: Left or Right")
                warn("____________")
                print(ballObj.Velocity)
                ballObj.Velocity = Vector2.new(-velocity.X,velocity.Y)
                print(ballObj.Velocity)
            elseif  (index == 2) or (index == 4) then
                warn("Resolving with box: Top or Bottom")
                ballObj.Velocity = Vector2.new(velocity.X,-velocity.Y)
            end
        end
    end
    ballObj.Position = ballObj.LastPosition
end


return Ball
