local BaseClass = require(script.Parent.BaseClass)

local Ball = setmetatable({

},BaseClass)
Ball.__index = Ball


function Ball.new(config)
    local base = BaseClass.new(config)
    local self = setmetatable(base, Ball)

    self:SetSize(Vector2.new(50,50))
    return self
end

return Ball