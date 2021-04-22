-- Utils
-- Username
-- January 16, 2021



local Utils = {}

function Utils:Init()
    setmetatable(Utils,{
        __index = function(tbl,index)
            local mod = script:FindFirstChild(index)
            if mod then
                Utils[index] = require(mod)
                return Utils[index]
            else
                warn("Indexed Nil: "..tostring(index))
                return 
            end
        end
    })    
end



return Utils