local Knit = require(game:GetService("ReplicatedStorage").Knit)
local Roact = require(Knit.Shared.Utils.Roact)

local Frame = require(script.Parent.Frame)

local Ball = Roact.Component:extend( "Ball" )

local e = Roact.createElement

function Ball:init()
    local props = self.props 
    self:setState({
        ["Position"] = props.PhysicsObject.Position,
        ["PhysicsObject"] = props.PhysicsObject,
    })
    props.PhysicsObject.Stepped:Connect(function()
        self:setState({
            ["Position"] = props.PhysicsObject.Position,
            ["PhysicsObject"] = props.PhysicsObject,
        })
    end)
end

function Ball:render()
    local state = self.state

    return e(Frame, {
        ["BackgroundTheme"] = "ThemeBlack",
        ["Size"] = UDim2.fromScale(0.1,0.1),
        ["Position"] = state.Position,
    },{
        e("UICorner",{["CornerRadius"] = UDim.new(1, 0)})
    })
end

return Ball