local Knit = require(game:GetService("ReplicatedStorage").Knit)
local Roact = require(Knit.Shared.Utils.Roact)

local PhysicsController = require(Knit.Client.Controllers.PhysicsController)

local Container = Roact.Component:extend( "Container" )

local e = Roact.createElement

function Container:init()
    self:setState({
        ["Children"] = self.props.Children or {}
    })
    PhysicsController.ObjectAdded:Connect(function(obj)
        local newChild = e(require(script.Parent[obj.Type]),{["PhysicsObject"] = obj})

        self:setState(function(prevState)
            return {
                ["Children"] = table.insert(prevState.Children,newChild)
            }
        end)
    end)
end

function Container:render()
    return e("ScreenGui", {
        ["Name"] = "PhysicsContainer"
    },self.state.Children)
end

return Container