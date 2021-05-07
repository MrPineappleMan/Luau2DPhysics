local Knit = require(game:GetService("ReplicatedStorage").Knit)
local Roact = require(Knit.Shared.Utils.Roact)

local Frame = require(script.Parent.Frame)

local Ball = Roact.Component:extend( "Ball" )

local e = Roact.createElement

function Ball:init()
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

function Ball:render()
    local state = self.state
    local pos = state.PhysicsObject.Position
    local sizeX = state.PhysicsObject.Size.X
    return e(Frame, {
        ["BackgroundTheme"] = "ThemeWhite",
        ["Size"] = UDim2.fromOffset(sizeX,sizeX),
        ["Position"] = UDim2.fromOffset(pos.X,pos.Y),
        ["AnchorPoint"] = Vector2.new(0.5,0.5),
        ["SizeConstraint"] = Enum.SizeConstraint.RelativeYY,
        ["ZIndex"] = 2,
    },{
        e("UICorner",{["CornerRadius"] = UDim.new(1, 0)})
    })
end

return Ball