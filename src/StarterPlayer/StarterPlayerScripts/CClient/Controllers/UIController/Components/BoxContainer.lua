local Knit = require(game:GetService("ReplicatedStorage").Knit)
local Roact = require(Knit.Shared.Utils.Roact)

local Frame = require(script.Parent.Frame)

local Box = Roact.Component:extend( "Box" )

local e = Roact.createElement

function Box:init()
    local props = self.props 
    self:setState({
        ["PhysicsObject"] = props.PhysicsObject,
    })
    props.PhysicsObject.Stepped:Connect(function()
        self:setState({
            ["PhysicsObject"] = props.PhysicsObject,
        })
    end)
end

function Box:render()
    local state = self.state
    local posX = state.PhysicsObject.Position.X
    local sizeX = state.PhysicsObject.Size.X

    return e(Frame, {
        ["BackgroundTheme"] = "ThemeBlack",
        ["BorderTheme"] = "ThemeWhite",
        ["BorderSizePixel"] = 5,
        ["Size"] = UDim2.fromOffset(sizeX,sizeX),
        ["Position"] = UDim2.fromOffset(posX,posX),
        ["AnchorPoint"] = Vector2.new(0.5,0.5),
        ["SizeConstraint"] = Enum.SizeConstraint.RelativeYY,
    })
end

return Box