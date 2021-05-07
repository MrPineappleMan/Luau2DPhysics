local BaseClass = require(script.Parent.BaseClass)

local Box = setmetatable({

},BaseClass)
Box.__index = Box

    --[[
        [1] = Left
        [2] = Top
        [3] = Right
        [4] = Bottom
    ]]
function Box.new(config)
    local base = BaseClass.new(config)
    local self = setmetatable(base, Box)
    self.IsStatic = true
    return self
end

return Box