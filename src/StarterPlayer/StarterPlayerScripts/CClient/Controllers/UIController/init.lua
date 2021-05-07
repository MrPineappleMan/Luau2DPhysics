local Knit = require(game:GetService("ReplicatedStorage").Knit)

local Players = game:GetService("Players")

local UIController = Knit.CreateController { Name = "UIController" }

local PhysicsController

local Roact
local e 

local Container


function UIController:KnitStart()
    Roact.mount(e(Container),Players.LocalPlayer.PlayerGui)

    PhysicsController:AddObject("Ball")
    PhysicsController:AddObject("Box")
end


function UIController:KnitInit()
    Roact = require(Knit.Shared.Utils.Roact)
    e = Roact.createElement

    Container = require(script.Components.Container)

    PhysicsController = require(Knit.Client.Controllers.PhysicsController)
end


return UIController