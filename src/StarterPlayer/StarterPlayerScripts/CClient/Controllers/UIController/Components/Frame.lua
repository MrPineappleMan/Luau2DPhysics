local Knit = require(game:GetService("ReplicatedStorage").Knit)
local Roact = require(Knit.Shared.Utils.Roact)
local Frame = Roact.Component:extend("Frame")
local Theme = require(Knit.Client.Controllers.UIController.Theme)

local e = Roact.createElement

local defaultProperties = {
    ["BorderSizePixel"] = 0,
}

function Frame:render()
    local props = self.props   

    local processedProps = {}
    
    for propertyName,val in pairs(props) do
        if propertyName == "BackgroundTheme" then
            local themeColor = Theme[val]
            processedProps.BackgroundColor3 = themeColor
        elseif propertyName == "BorderTheme" then
            local themeColor = Theme[val]
            processedProps.BorderColor3 = themeColor
        else
            processedProps[propertyName] = val
        end
    end

    for name,val in pairs(defaultProperties) do
        if not processedProps[name] then
            processedProps[name] = val
        end
    end

    return e("Frame", processedProps)
end

return Frame