local BaseClass = require(script.Parent.BaseClass)

local BoxContainer = setmetatable({

},BaseClass)
BoxContainer.__index = BoxContainer

    --[[
        [1] = Left
        [2] = Top
        [3] = Right
        [4] = Bottom
    ]]
function BoxContainer.new(config)
    local base = BaseClass.new(config)
    local self = setmetatable(base, BoxContainer)

    self.IsStatic = true
    return self
end

return BoxContainer